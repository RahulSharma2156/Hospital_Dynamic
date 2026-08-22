package hospital.com;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * ============================================================
 * DeleteAppointment_Servlet.java
 * CityCare Hospital - Delete Appointment(s) Servlet
 * Handles:
 *   - Delete selected appointments (by appointment_no list)
 *   - Delete all appointments
 * Called from dashboard.jsp via POST form.
 * ============================================================
 */
@WebServlet("/DeleteAppointment_Servlet")
public class DeleteAppointment_Servlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Session check - only logged-in staff can delete
        String userName = (String) request.getSession().getAttribute("user_name");
        if (userName == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action"); // "delete_selected" or "delete_all"

        try (Connection conn = DBConnection.getConnection()) {
            if (conn == null) {
                response.sendRedirect("dashboard.jsp?del=dberror");
                return;
            }

            if ("delete_all".equals(action)) {
                // -------------------------------------------------------
                // Delete ALL appointments from the table
                // -------------------------------------------------------
                PreparedStatement ps = conn.prepareStatement("DELETE FROM appointments");
                int rows = ps.executeUpdate();
                response.sendRedirect("dashboard.jsp?del=success&count=" + rows + "&type=all");

            } else if ("delete_selected".equals(action)) {
                // -------------------------------------------------------
                // Delete only the selected appointments (by appointment_no)
                // -------------------------------------------------------
                String[] selectedIds = request.getParameterValues("appt_ids");

                if (selectedIds == null || selectedIds.length == 0) {
                    response.sendRedirect("dashboard.jsp?del=none");
                    return;
                }

                // Build parameterized query: DELETE WHERE appointment_no IN (?, ?, ...)
                StringBuilder sb = new StringBuilder("DELETE FROM appointments WHERE appointment_no IN (");
                for (int i = 0; i < selectedIds.length; i++) {
                    sb.append("?");
                    if (i < selectedIds.length - 1) sb.append(",");
                }
                sb.append(")");

                PreparedStatement ps = conn.prepareStatement(sb.toString());
                for (int i = 0; i < selectedIds.length; i++) {
                    ps.setString(i + 1, selectedIds[i]);
                }

                int rows = ps.executeUpdate();
                response.sendRedirect("dashboard.jsp?del=success&count=" + rows + "&type=selected");

            } else {
                response.sendRedirect("dashboard.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("dashboard.jsp?del=error&msg=" +
                    java.net.URLEncoder.encode(e.getMessage(), "UTF-8"));
        }
    }
}
