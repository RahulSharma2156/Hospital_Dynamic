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

/**
 * ============================================================
 * Appointment_Servlet.java
 * CityCare Hospital - Book Patient Appointment Servlet
 * Receives form POST from index.jsp/index.html,
 * inserts into appointments table, redirects with success msg.
 * ============================================================
 */
@WebServlet("/Appointment_Servlet")
public class Appointment_Servlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // Read form parameters
        String patientName  = request.getParameter("patient_name");
        String patientPhone = request.getParameter("patient_phone");
        String deptIdStr    = request.getParameter("department_id");
        String docIdStr     = request.getParameter("doctor_id");
        String apptDate     = request.getParameter("appointment_date");
        String symptoms     = request.getParameter("symptoms");

        // Basic validation
        if (patientName == null || patientName.trim().isEmpty() ||
            patientPhone == null || patientPhone.trim().isEmpty() ||
            deptIdStr == null || deptIdStr.trim().isEmpty() ||
            apptDate == null || apptDate.trim().isEmpty()) {
            response.sendRedirect("index.jsp?msg=error&reason=missing_fields#appointment");
            return;
        }

        patientName  = patientName.trim();
        patientPhone = patientPhone.trim();
        apptDate     = apptDate.trim();
        symptoms     = (symptoms != null) ? symptoms.trim() : "";

        int deptId = 0;
        int docId  = 0;
        try {
            deptId = Integer.parseInt(deptIdStr.trim());
            if (docIdStr != null && !docIdStr.trim().isEmpty()) {
                docId = Integer.parseInt(docIdStr.trim());
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("index.jsp?msg=error&reason=invalid_fields#appointment");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {
            if (conn == null) {
                response.sendRedirect("index.jsp?msg=error&reason=db_error#appointment");
                return;
            }

            // -------------------------------------------------------
            // Auto-generate unique Appointment Number: APT-2026-XXXX
            // -------------------------------------------------------
            String apptNo = generateAppointmentNo(conn);

            // -------------------------------------------------------
            // Insert new appointment into appointments table
            // -------------------------------------------------------
            String sql = "INSERT INTO appointments " +
                         "(appointment_no, patient_name, patient_phone, department_id, doctor_id, " +
                         "appointment_date, symptoms_remarks, status) " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?, 'Confirmed')";

            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, apptNo);
            pstmt.setString(2, patientName);
            pstmt.setString(3, patientPhone);
            pstmt.setInt(4, deptId);

            if (docId > 0) {
                pstmt.setInt(5, docId);
            } else {
                pstmt.setNull(5, java.sql.Types.INTEGER);
            }

            pstmt.setString(6, apptDate);
            pstmt.setString(7, symptoms);

            int rows = pstmt.executeUpdate();

            if (rows > 0) {
                // Success - redirect back to index.jsp with success message and appointment number
                response.sendRedirect("index.jsp?msg=booked&appt=" +
                        java.net.URLEncoder.encode(apptNo, "UTF-8") + "#appointment");
            } else {
                response.sendRedirect("index.jsp?msg=error&reason=insert_failed#appointment");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("index.jsp?msg=error&reason=" +
                    java.net.URLEncoder.encode(e.getMessage(), "UTF-8") + "#appointment");
        }
    }

    /**
     * Auto-generates a unique appointment number like APT-2026-0004
     * by finding the current MAX id in the appointments table.
     */
    private String generateAppointmentNo(Connection conn) {
        int nextId = 1;
        try {
            PreparedStatement ps = conn.prepareStatement(
                    "SELECT COALESCE(MAX(id), 0) + 1 AS next_id FROM appointments");
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                nextId = rs.getInt("next_id");
            }
        } catch (Exception e) {
            // Fallback: use timestamp-based suffix
            nextId = (int)(System.currentTimeMillis() % 10000);
        }
        return String.format("APT-2026-%04d", nextId);
    }
}
