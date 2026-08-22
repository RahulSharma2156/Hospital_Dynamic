package hospital.com;

import java.sql.Connection;
import java.sql.DriverManager;

/**
 * ============================================================
 * DBConnection.java
 * CityCare Hospital - MySQL Database Connection Helper
 * ============================================================
 */
public class DBConnection {

    // -------------------------------------------------------
    // UPDATE THESE 3 VALUES TO MATCH YOUR MYSQL SETUP:
    // -------------------------------------------------------
    private static final String DB_URL  = "jdbc:mysql://localhost:3306/hospital_db"
                                        + "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "Rahul@123"; // Change if your MySQL password is different or ""

    /**
     * Returns an active JDBC Connection to hospital_db.
     * Returns null if connection fails (caller should handle gracefully).
     */
    public static Connection getConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
        } catch (Exception e) {
            System.err.println("[DBConnection] ERROR: Cannot connect to MySQL - " + e.getMessage());
            return null;
        }
    }
}
