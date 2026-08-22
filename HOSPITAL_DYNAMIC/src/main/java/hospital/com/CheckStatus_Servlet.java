package hospital.com;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/CheckStatus_Servlet")
public class CheckStatus_Servlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String query = request.getParameter("search_query");

        if (query != null) {
            query = query.trim();
        } else {
            query = "";
        }

        out.println("<!DOCTYPE html>");
        out.println("<html lang='en'>");
        out.println("<head>");
        out.println("<meta charset='UTF-8'>");
        out.println("<meta name='viewport' content='width=device-width, initial-scale=1.0'>");
        out.println("<title>Appointment Status | CityCare Hospital</title>");
        out.println("<link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css'>");
        out.println("<style>");
        out.println("body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f0f9ff; margin: 0; padding: 40px 20px; display: flex; justify-content: center; align-items: center; min-height: 80vh; }");
        out.println(".status-card { background: #ffffff; width: 100%; max-width: 600px; border-radius: 16px; box-shadow: 0 10px 30px rgba(2, 132, 199, 0.15); border: 1px solid #e0f2fe; padding: 36px; }");
        out.println(".header { text-align: center; margin-bottom: 24px; }");
        out.println(".logo { font-size: 24px; font-weight: 800; color: #0f172a; display: flex; align-items: center; justify-content: center; gap: 10px; margin-bottom: 8px; }");
        out.println(".badge-status { display: inline-block; padding: 6px 16px; border-radius: 999px; font-size: 14px; font-weight: 700; background: #dcfce7; color: #15803d; margin: 10px 0; }");
        out.println(".detail-table { width: 100%; border-collapse: collapse; margin: 20px 0; }");
        out.println(".detail-table tr { border-bottom: 1px solid #f1f5f9; }");
        out.println(".detail-table td { padding: 14px 8px; font-size: 15px; }");
        out.println(".label { color: #64748b; font-weight: 600; width: 40%; }");
        out.println(".val { color: #0f172a; font-weight: 700; text-align: right; }");
        out.println(".btn-back { display: block; text-align: center; background: #0284c7; color: #ffffff; padding: 12px 24px; border-radius: 8px; text-decoration: none; font-weight: 700; margin-top: 24px; transition: 0.2s; }");
        out.println(".btn-back:hover { background: #0369a1; }");
        out.println(".not-found { text-align: center; padding: 30px 10px; }");
        out.println(".not-found i { font-size: 48px; color: #ef4444; margin-bottom: 16px; }");
        out.println("</style>");
        out.println("</head>");
        out.println("<body>");

        out.println("<div class='status-card'>");
        out.println("<div class='header'>");
        out.println("<div class='logo'><i class='fa-solid fa-hospital' style='color:#0284c7;'></i> CityCare Hospital</div>");
        out.println("<h2 style='color:#0284c7; margin:0;'>Appointment Details</h2>");
        out.println("</div>");

        try (Connection conn = DBConnection.getConnection()) {
            if (conn == null) {
                out.println("<div class='not-found'>");
                out.println("<i class='fa-solid fa-triangle-exclamation'></i>");
                out.println("<h3>Database Connection Error</h3>");
                out.println("<p>Unable to connect to MySQL database.</p>");
                out.println("</div>");
            } else {
                String sql = "SELECT a.appointment_no, a.patient_name, a.patient_phone, a.appointment_date, a.symptoms_remarks, a.status, " +
                             "d.name AS dept_name, doc.name AS doctor_name " +
                             "FROM appointments a " +
                             "LEFT JOIN departments d ON a.department_id = d.id " +
                             "LEFT JOIN doctors doc ON a.doctor_id = doc.id " +
                             "WHERE a.patient_phone = ? OR a.appointment_no = ? " +
                             "ORDER BY a.id DESC LIMIT 1";

                PreparedStatement pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, query);
                pstmt.setString(2, query);
                ResultSet rs = pstmt.executeQuery();

                if (rs.next()) {
                    out.println("<div style='text-align:center;'>");
                    out.println("<span class='badge-status'><i class='fa-solid fa-circle-check'></i> Status: " + rs.getString("status") + "</span>");
                    out.println("</div>");

                    out.println("<table class='detail-table'>");
                    out.println("<tr><td class='label'><i class='fa-solid fa-ticket'></i> Appointment No:</td><td class='val' style='color:#0284c7;'>" + rs.getString("appointment_no") + "</td></tr>");
                    out.println("<tr><td class='label'><i class='fa-solid fa-user'></i> Patient Name:</td><td class='val'>" + rs.getString("patient_name") + "</td></tr>");
                    out.println("<tr><td class='label'><i class='fa-solid fa-phone'></i> Phone Number:</td><td class='val'>" + rs.getString("patient_phone") + "</td></tr>");
                    out.println("<tr><td class='label'><i class='fa-solid fa-calendar-day'></i> Booking Date:</td><td class='val' style='color:#dc2626; font-size:16px;'>" + rs.getString("appointment_date") + "</td></tr>");
                    out.println("<tr><td class='label'><i class='fa-solid fa-stethoscope'></i> Department:</td><td class='val'>" + (rs.getString("dept_name") != null ? rs.getString("dept_name") : "General") + "</td></tr>");
                    out.println("<tr><td class='label'><i class='fa-solid fa-user-doctor'></i> Assigned Doctor:</td><td class='val'>" + (rs.getString("doctor_name") != null ? rs.getString("doctor_name") : "On-Duty Specialist") + "</td></tr>");
                    out.println("<tr><td class='label'><i class='fa-solid fa-notes-medical'></i> Remarks:</td><td class='val'>" + (rs.getString("symptoms_remarks") != null ? rs.getString("symptoms_remarks") : "N/A") + "</td></tr>");
                    out.println("</table>");
                } else {
                    out.println("<div class='not-found'>");
                    out.println("<i class='fa-solid fa-circle-xmark'></i>");
                    out.println("<h3 style='color:#ef4444;'>No Appointment Found</h3>");
                    out.println("<p style='color:#64748b;'>Mobile number ya Appointment ID (<b>" + query + "</b>) ke liye koi booking nahi mili.</p>");
                    out.println("</div>");
                }
            }
        } catch (Exception e) {
            out.println("<p style='color:red; text-align:center;'>Error: " + e.getMessage() + "</p>");
        }

        out.println("<a href='index.jsp' class='btn-back'><i class='fa-solid fa-arrow-left'></i> Back to Home Page</a>");
        out.println("</div>");
        out.println("</body>");
        out.println("</html>");
    }
}
