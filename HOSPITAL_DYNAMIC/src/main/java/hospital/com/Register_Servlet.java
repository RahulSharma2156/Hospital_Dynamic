package hospital.com;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/Register_Servlet")
public class Register_Servlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        String fullName = request.getParameter("full_name");
        String staffCode = request.getParameter("staff_code");
        String role = request.getParameter("role");
        String email = request.getParameter("email");
        String deptStr = request.getParameter("department_id");
        String password = request.getParameter("password");

        int deptId = 1;
        try {
            if (deptStr != null && !deptStr.isEmpty()) {
                deptId = Integer.parseInt(deptStr);
            }
        } catch (NumberFormatException e) {
            deptId = 1;
        }

        try (Connection conn = DBConnection.getConnection()) {
            if (conn == null) {
                response.sendRedirect("register.jsp?error=dberror");
                return;
            }

            // 1. Check if Staff Code or Email already exists
            String checkSql = "SELECT id FROM staff_users WHERE staff_code = ? OR email = ?";
            PreparedStatement checkStmt = conn.prepareStatement(checkSql);
            checkStmt.setString(1, staffCode);
            checkStmt.setString(2, email);
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                // Already registered
                response.sendRedirect("register.jsp?error=exists");
                return;
            }

            // 2. Insert new staff / doctor record into staff_users
            String insertSql = "INSERT INTO staff_users (staff_code, full_name, email, password_hash, role, department_id, status) VALUES (?, ?, ?, ?, ?, ?, 'Active')";
            PreparedStatement pstmt = conn.prepareStatement(insertSql);
            pstmt.setString(1, staffCode);
            pstmt.setString(2, fullName);
            pstmt.setString(3, email);
            pstmt.setString(4, password); // In production, hash with BCrypt
            pstmt.setString(5, role);
            pstmt.setInt(6, deptId);

            int result = pstmt.executeUpdate();

            // Also if role is Doctor, add/ensure entry in doctors table
            if (result > 0 && "Doctor".equalsIgnoreCase(role)) {
                try {
                    String docSql = "INSERT INTO doctors (name, specialization, department_id, qualification, experience_years, schedule_days, available_hours, status, email) " +
                                    "VALUES (?, ?, ?, 'MBBS, MD Specialist', 5, 'Mon - Sat', '9:00 AM - 5:00 PM', 'Available', ?)";
                    PreparedStatement docStmt = conn.prepareStatement(docSql);
                    docStmt.setString(1, fullName);
                    docStmt.setString(2, "Specialist " + role);
                    docStmt.setInt(3, deptId);
                    docStmt.setString(4, email);
                    docStmt.executeUpdate();
                } catch(Exception ex) {
                    // Ignore duplicate doctor insertion
                }
            }

            if (result > 0) {
                // Success: Redirect to login.jsp with success message
                response.sendRedirect("login.jsp?msg=registered&code=" + staffCode);
            } else {
                response.sendRedirect("register.jsp?error=failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("register.jsp?error=failed");
        }
    }
}
