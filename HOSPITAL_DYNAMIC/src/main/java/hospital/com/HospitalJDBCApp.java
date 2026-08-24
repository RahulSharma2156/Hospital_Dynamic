package hospital.com;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Scanner;

/**
 * ============================================================================
 * CityCare Hospital Management System - Java JDBC Console Application
 * Database: MySQL (hospital_db)
 *
 * Features:
 * 1. Add New Staff Member
 * 2. View All Staff Members
 * 3. Search Staff Member
 * 4. Update Staff Details
 * 5. Delete Staff Member
 * 6. Book Patient Appointment
 * 7. View All Appointments
 * 8. Exit
 * ============================================================================
 */
public class HospitalJDBCApp {

    // ============================================================
    // DATABASE CONNECTION DETAILS
    // ============================================================

    private static final String DB_URL =
            "jdbc:mysql://localhost:3306/hospital_db"
            + "?useSSL=false"
            + "&allowPublicKeyRetrieval=true"
            + "&serverTimezone=UTC";

    private static final String DB_USER = "root";

    private static final String DB_PASS = "Rahul@123";

    private static final Scanner scanner = new Scanner(System.in);

    // ============================================================
    // MAIN METHOD
    // ============================================================

    public static void main(String[] args) {

        System.out.println("==========================================================");
        System.out.println("          WELCOME TO CITYCARE HOSPITAL");
        System.out.println("             JDBC CONSOLE APPLICATION");
        System.out.println("==========================================================");

        // Test database connection
        try (Connection conn = getConnection()) {

            if (conn != null) {

                System.out.println(
                    "SUCCESS: Connected to MySQL Database "
                    + "(hospital_db) successfully!"
                );
            }

        } catch (SQLException e) {

            System.err.println(
                "ERROR: Could not connect to MySQL database."
            );

            System.err.println(
                "Make sure MySQL Server is running."
            );

            System.err.println(
                "Check MySQL username, password and Connector/J."
            );

            System.err.println(
                "Details: " + e.getMessage()
            );

            return;
        }

        // ========================================================
        // MAIN MENU
        // ========================================================

        while (true) {

            System.out.println();
            System.out.println("----------------- MAIN MENU -----------------");

            System.out.println("1. Add New Staff Member");
            System.out.println("2. View All Staff Members");
            System.out.println("3. Search Staff Member by Staff Code");
            System.out.println("4. Update Staff Details");
            System.out.println("5. Delete Staff Member");
            System.out.println("6. Book New Patient Appointment");
            System.out.println("7. View All Appointments");
            System.out.println("8. Exit Application");

            System.out.print("Select an option (1-8): ");

            int choice;

            try {

                choice = Integer.parseInt(
                    scanner.nextLine().trim()
                );

            } catch (NumberFormatException e) {

                System.out.println(
                    "Invalid input! Please enter a number between 1 and 8."
                );

                continue;
            }

            switch (choice) {

                case 1:
                    insertStaff();
                    break;

                case 2:
                    viewAllStaff();
                    break;

                case 3:
                    searchStaffByCode();
                    break;

                case 4:
                    updateStaff();
                    break;

                case 5:
                    deleteStaff();
                    break;

                case 6:
                    insertAppointment();
                    break;

                case 7:
                    viewAllAppointments();
                    break;

                case 8:

                    System.out.println(
                        "Exiting Application. Thank you!"
                    );

                    scanner.close();
                    return;

                default:

                    System.out.println(
                        "Invalid choice! Please choose from 1 to 8."
                    );
            }
        }
    }

    // ============================================================
    // DATABASE CONNECTION
    // ============================================================

    private static Connection getConnection()
            throws SQLException {

        try {

            Class.forName(
                "com.mysql.cj.jdbc.Driver"
            );

        } catch (ClassNotFoundException e) {

            throw new SQLException(
                "MySQL JDBC Driver not found. "
                + "Add MySQL Connector/J to the project.",
                e
            );
        }

        return DriverManager.getConnection(
            DB_URL,
            DB_USER,
            DB_PASS
        );
    }

    // ============================================================
    // 1. INSERT STAFF
    // ============================================================

    private static void insertStaff() {

        System.out.println(
            "\n--- [INSERT] Add New Staff Member ---"
        );

        System.out.print(
            "Enter Staff Code (e.g. STF-3001): "
        );

        String staffCode =
            scanner.nextLine().trim();

        System.out.print(
            "Enter Employee Full Name: "
        );

        String fullName =
            scanner.nextLine().trim();

        System.out.print(
            "Enter Email Address: "
        );

        String email =
            scanner.nextLine().trim();

        System.out.print(
            "Enter Password: "
        );

        String password =
            scanner.nextLine().trim();

        System.out.print(
            "Enter Role (Doctor / Nurse / Administrator / Lab Tech): "
        );

        String role =
            scanner.nextLine().trim();

        String sql =
            "INSERT INTO staff_users "
            + "(staff_code, full_name, email, password_hash, role) "
            + "VALUES (?, ?, ?, ?, ?)";

        try (
            Connection conn = getConnection();
            PreparedStatement pstmt =
                conn.prepareStatement(sql)
        ) {

            pstmt.setString(1, staffCode);
            pstmt.setString(2, fullName);
            pstmt.setString(3, email);
            pstmt.setString(4, password);
            pstmt.setString(5, role);

            int rowsAffected =
                pstmt.executeUpdate();

            if (rowsAffected > 0) {

                System.out.println(
                    "SUCCESS: Staff Member '"
                    + fullName
                    + "' inserted successfully!"
                );

            } else {

                System.out.println(
                    "FAILED: Staff member was not inserted."
                );
            }

        } catch (SQLException e) {

            System.err.println(
                "Error inserting staff: "
                + e.getMessage()
            );
        }
    }

    // ============================================================
    // 2. VIEW ALL STAFF
    // ============================================================

    private static void viewAllStaff() {

        System.out.println(
            "\n--- [READ] All Staff Members ---"
        );

        String sql =
            "SELECT id, staff_code, full_name, email, "
            + "role, status, created_at "
            + "FROM staff_users "
            + "ORDER BY id ASC";

        try (
            Connection conn = getConnection();
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql)
        ) {

            System.out.printf(
                "%-5s | %-12s | %-22s | %-25s | %-14s | %-8s%n",
                "ID",
                "Staff Code",
                "Full Name",
                "Email",
                "Role",
                "Status"
            );

            System.out.println(
                "---------------------------------------------------------------------------------------------"
            );

            boolean found = false;

            while (rs.next()) {

                found = true;

                System.out.printf(
                    "%-5d | %-12s | %-22s | %-25s | %-14s | %-8s%n",
                    rs.getInt("id"),
                    rs.getString("staff_code"),
                    rs.getString("full_name"),
                    rs.getString("email"),
                    rs.getString("role"),
                    rs.getString("status")
                );
            }

            if (!found) {

                System.out.println(
                    "No staff records found in database."
                );
            }

        } catch (SQLException e) {

            System.err.println(
                "Error fetching staff records: "
                + e.getMessage()
            );
        }
    }

    // ============================================================
    // 3. SEARCH STAFF
    // ============================================================

    private static void searchStaffByCode() {

        System.out.println(
            "\n--- [SEARCH] Find Staff Member ---"
        );

        System.out.print(
            "Enter Staff Code to Search (e.g. STF-1001): "
        );

        String staffCode =
            scanner.nextLine().trim();

        String sql =
            "SELECT id, staff_code, full_name, email, "
            + "role, status, created_at "
            + "FROM staff_users "
            + "WHERE staff_code = ?";

        try (
            Connection conn = getConnection();
            PreparedStatement pstmt =
                conn.prepareStatement(sql)
        ) {

            pstmt.setString(1, staffCode);

            try (
                ResultSet rs =
                    pstmt.executeQuery()
            ) {

                if (rs.next()) {

                    System.out.println(
                        "\n>>> MATCH FOUND <<<"
                    );

                    System.out.println(
                        "ID           : "
                        + rs.getInt("id")
                    );

                    System.out.println(
                        "Staff Code   : "
                        + rs.getString("staff_code")
                    );

                    System.out.println(
                        "Full Name    : "
                        + rs.getString("full_name")
                    );

                    System.out.println(
                        "Email        : "
                        + rs.getString("email")
                    );

                    System.out.println(
                        "Role         : "
                        + rs.getString("role")
                    );

                    System.out.println(
                        "Status       : "
                        + rs.getString("status")
                    );

                    System.out.println(
                        "Created At   : "
                        + rs.getTimestamp("created_at")
                    );

                } else {

                    System.out.println(
                        "NO RECORD FOUND with Staff Code: "
                        + staffCode
                    );
                }
            }

        } catch (SQLException e) {

            System.err.println(
                "Error searching staff record: "
                + e.getMessage()
            );
        }
    }

    // ============================================================
    // 4. UPDATE STAFF
    // ============================================================

    private static void updateStaff() {

        System.out.println(
            "\n--- [UPDATE] Update Staff Details ---"
        );

        System.out.print(
            "Enter Staff Code: "
        );

        String staffCode =
            scanner.nextLine().trim();

        System.out.print(
            "Enter New Full Name: "
        );

        String newName =
            scanner.nextLine().trim();

        System.out.print(
            "Enter New Email: "
        );

        String newEmail =
            scanner.nextLine().trim();

        System.out.print(
            "Enter New Role: "
        );

        String newRole =
            scanner.nextLine().trim();

        String sql =
            "UPDATE staff_users "
            + "SET full_name = ?, email = ?, role = ? "
            + "WHERE staff_code = ?";

        try (
            Connection conn = getConnection();
            PreparedStatement pstmt =
                conn.prepareStatement(sql)
        ) {

            pstmt.setString(1, newName);
            pstmt.setString(2, newEmail);
            pstmt.setString(3, newRole);
            pstmt.setString(4, staffCode);

            int rowsUpdated =
                pstmt.executeUpdate();

            if (rowsUpdated > 0) {

                System.out.println(
                    "SUCCESS: Staff record updated successfully!"
                );

            } else {

                System.out.println(
                    "FAILED: No staff member found with Staff Code: "
                    + staffCode
                );
            }

        } catch (SQLException e) {

            System.err.println(
                "Error updating staff record: "
                + e.getMessage()
            );
        }
    }

    // ============================================================
    // 5. DELETE STAFF
    // ============================================================

    private static void deleteStaff() {

        System.out.println(
            "\n--- [DELETE] Delete Staff Member ---"
        );

        System.out.print(
            "Enter Staff Code to Delete: "
        );

        String staffCode =
            scanner.nextLine().trim();

        System.out.print(
            "Are you sure? (yes/no): "
        );

        String confirm =
            scanner.nextLine().trim();

        if (!confirm.equalsIgnoreCase("yes")) {

            System.out.println(
                "Delete operation cancelled."
            );

            return;
        }

        String sql =
            "DELETE FROM staff_users "
            + "WHERE staff_code = ?";

        try (
            Connection conn = getConnection();
            PreparedStatement pstmt =
                conn.prepareStatement(sql)
        ) {

            pstmt.setString(1, staffCode);

            int rowsDeleted =
                pstmt.executeUpdate();

            if (rowsDeleted > 0) {

                System.out.println(
                    "SUCCESS: Staff record deleted."
                );

            } else {

                System.out.println(
                    "FAILED: Staff Code not found."
                );
            }

        } catch (SQLException e) {

            System.err.println(
                "Error deleting staff record: "
                + e.getMessage()
            );
        }
    }

    // ============================================================
    // 6. INSERT APPOINTMENT
    // ============================================================

    private static void insertAppointment() {

        System.out.println(
            "\n--- [INSERT] Book New Patient Appointment ---"
        );

        System.out.print(
            "Enter Appointment No (e.g. APT-2026-0005): "
        );

        String apptNo =
            scanner.nextLine().trim();

        System.out.print(
            "Enter Patient Full Name: "
        );

        String patientName =
            scanner.nextLine().trim();

        System.out.print(
            "Enter Patient Mobile Phone: "
        );

        String phone =
            scanner.nextLine().trim();

        System.out.print(
            "Enter Department ID: "
        );

        int deptId;

        try {

            deptId =
                Integer.parseInt(
                    scanner.nextLine().trim()
                );

        } catch (NumberFormatException e) {

            System.out.println(
                "Invalid Department ID."
            );

            return;
        }

        System.out.print(
            "Enter Doctor ID: "
        );

        int docId;

        try {

            docId =
                Integer.parseInt(
                    scanner.nextLine().trim()
                );

        } catch (NumberFormatException e) {

            System.out.println(
                "Invalid Doctor ID."
            );

            return;
        }

        System.out.print(
            "Enter Date (YYYY-MM-DD): "
        );

        String apptDate =
            scanner.nextLine().trim();

        System.out.print(
            "Enter Symptoms / Remarks: "
        );

        String symptoms =
            scanner.nextLine().trim();

        String sql =
            "INSERT INTO appointments "
            + "(appointment_no, patient_name, patient_phone, "
            + "department_id, doctor_id, appointment_date, "
            + "symptoms_remarks, status) "
            + "VALUES (?, ?, ?, ?, ?, ?, ?, 'Confirmed')";

        try (
            Connection conn = getConnection();
            PreparedStatement pstmt =
                conn.prepareStatement(sql)
        ) {

            pstmt.setString(1, apptNo);
            pstmt.setString(2, patientName);
            pstmt.setString(3, phone);
            pstmt.setInt(4, deptId);
            pstmt.setInt(5, docId);
            pstmt.setString(6, apptDate);
            pstmt.setString(7, symptoms);

            int rows =
                pstmt.executeUpdate();

            if (rows > 0) {

                System.out.println(
                    "SUCCESS: Appointment '"
                    + apptNo
                    + "' booked successfully!"
                );

            } else {

                System.out.println(
                    "FAILED: Appointment was not booked."
                );
            }

        } catch (SQLException e) {

            System.err.println(
                "Error booking appointment: "
                + e.getMessage()
            );
        }
    }

    // ============================================================
    // 7. VIEW ALL APPOINTMENTS
    // ============================================================

    private static void viewAllAppointments() {

        System.out.println(
            "\n--- [READ] All Patient Appointments ---"
        );

        String sql =
            "SELECT a.appointment_no, "
            + "a.patient_name, "
            + "a.patient_phone, "
            + "d.name AS dept_name, "
            + "a.status "
            + "FROM appointments a "
            + "JOIN departments d "
            + "ON a.department_id = d.id "
            + "ORDER BY a.id ASC";

        try (
            Connection conn = getConnection();
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql)
        ) {

            System.out.printf(
                "%-15s | %-20s | %-12s | %-24s | %-12s | %-10s%n",
                "Appt No",
                "Patient Name",
                "Phone",
                "Department",
                "Date",
                "Status"
            );

            System.out.println(
                "----------------------------------------------------------------------------------------------------"
            );

            boolean found = false;

            while (rs.next()) {

                found = true;

                System.out.printf(
                    "%-15s | %-20s | %-12s | %-24s | %-12s | %-10s%n",
                    rs.getString("appointment_no"),
                    rs.getString("patient_name"),
                    rs.getString("patient_phone"),
                    rs.getString("dept_name"),
                    rs.getDate("appointment_date"),
                    rs.getString("status")
                );
            }

            if (!found) {

                System.out.println(
                    "No appointment records found in database."
                );
            }

        } catch (SQLException e) {

            System.err.println(
                "Error fetching appointment records: "
                + e.getMessage()
            );
        }
    }
}