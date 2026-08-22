package HOSPITAL;
import java.sql.*;
public class HospitalDB {
    // Database ki details
    static String url  = "jdbc:mysql://localhost:3306/hospital_db";
    static String user = "root";
    static String pass = "Rahul@123"; // apna MySQL password daalo

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		 try {

	            // =====================
	            // STEP 1: Connect karo
	            // =====================
	            Connection conn = DriverManager.getConnection(url, user, pass);
	            System.out.println("Database connect ho gaya!");

	            // =====================
	            // STEP 2: INSERT
	            // Naya staff add karo
	            // =====================
	            String insertSQL = "INSERT INTO staff_users (staff_code, full_name, email, password_hash, role) VALUES (?, ?, ?, ?, ?)";
	            PreparedStatement insert = conn.prepareStatement(insertSQL);
	            insert.setString(1, "STF-9001");
	            insert.setString(2, "Rahul Sharma");
	            insert.setString(3, "rahul@citycare.com");
	            insert.setString(4, "pass123");
	            insert.setString(5, "Doctor");
	            insert.executeUpdate();
	            System.out.println("INSERT: Rahul Sharma add ho gaya!");

	            // =====================
	            // STEP 3: SELECT (Search)
	            // Sabhi staff dekho
	            // =====================
	            Statement stmt = conn.createStatement();
	            ResultSet rs = stmt.executeQuery("SELECT id, staff_code, full_name, role FROM staff_users");
	            System.out.println("\nSELECT: Sabhi Staff Members:");
	            System.out.println("ID  | Staff Code | Name                | Role");
	            System.out.println("----+------------+---------------------+-------");
	            while (rs.next()) {
	                System.out.printf("%-4d| %-11s| %-21s| %s%n",
	                    rs.getInt("id"),
	                    rs.getString("staff_code"),
	                    rs.getString("full_name"),
	                    rs.getString("role"));
	            }

	            // =====================
	            // STEP 4: UPDATE
	            // Staff ka naam update karo
	            // =====================
	            String updateSQL = "UPDATE staff_users SET full_name = ? WHERE staff_code = ?";
	            PreparedStatement update = conn.prepareStatement(updateSQL);
	            update.setString(1, "Rahul Kumar Sharma");
	            update.setString(2, "STF-9001");
	            update.executeUpdate();
	            System.out.println("\nUPDATE: STF-9001 ka naam update ho gaya!");

	            // =====================
	            // STEP 5: DELETE
	            // Staff ko hatao
	            // =====================
	            String deleteSQL = "DELETE FROM staff_users WHERE staff_code = ?";
	            PreparedStatement delete = conn.prepareStatement(deleteSQL);
	            delete.setString(1, "STF-9001");
	            delete.executeUpdate();
	            System.out.println("DELETE: STF-9001 delete ho gaya!");

	            // =====================
	            // STEP 6: Close karo
	            // =====================
	            conn.close();
	            System.out.println("\nDatabase band ho gaya. Kaam poora!");

	        } catch (SQLException e) {
	            // Agar koi error aaye toh yahan print hoga
	            System.out.println("Error aaya: " + e.getMessage());
	        }
	}

}






