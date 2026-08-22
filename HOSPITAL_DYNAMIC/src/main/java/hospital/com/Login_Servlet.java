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
import jakarta.servlet.http.HttpSession;

@WebServlet(urlPatterns = {"/Login_Servlet", "/LoginServlet"})
public class Login_Servlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String staffCode = request.getParameter("staff_code");
        if (staffCode == null || staffCode.trim().isEmpty()) {
            staffCode = request.getParameter("username");
        }
        String password  = request.getParameter("password");

        try (Connection conn = DBConnection.getConnection()) {
            if (conn == null) {
                response.sendRedirect("login.jsp?error=dberror");
                return;
            }

            // User's original login logic
            String sql = "SELECT * FROM login WHERE userid = ? AND password = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, staffCode);
            pstmt.setString(2, password);

            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                // Login success
                HttpSession session = request.getSession();
                session.setAttribute("staffCode", rs.getString("userid"));
                session.setAttribute("loggedIn", true);
                
                // Dashboard compatibility
                session.setAttribute("user_name", rs.getString("userid"));
                session.setAttribute("user_role", "Staff");
                session.setAttribute("staff_code", rs.getString("userid"));

                response.sendRedirect("dashboard.jsp");
            } else {
                response.sendRedirect("login.jsp?error=invalid");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=invalid");
        }
    }
}
