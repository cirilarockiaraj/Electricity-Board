package EmployeeLogin;
import connection.db;
import java.sql.*;

public class EmployeeDAO 
{
    public employee checkLogin(String empId, String pass) throws SQLException, ClassNotFoundException {
        
        employee emp = null;
        try (Connection conn=db.initializeDatabase()) {
            String sql = "SELECT * FROM employee_profile WHERE emp_id = ? AND password = ?";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, empId);
            statement.setString(2, pass);
            
            ResultSet result = statement.executeQuery();
            
            
            if (result.next()) {
                emp = new employee();
                emp.setId(result.getInt("id"));
                emp.setEmpId(result.getString("emp_id"));
                emp.setImage(result.getString("image"));
                emp.setEmpName(result.getString("emp_name"));
                emp.setDob(result.getString("dob"));
                emp.setPassword(result.getString("password"));
                emp.setProfession(result.getString("profession"));
                emp.setContact(result.getString("contact_no"));
                emp.setEmail(result.getString("email_id"));
                emp.setDistrict(result.getString("hire_district"));
                emp.setOffice(result.getString("office"));
                emp.setAddress(result.getString("address"));
            }
        }
 
        return emp;
    }
}
