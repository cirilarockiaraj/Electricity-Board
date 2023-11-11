package ConsumerLogin;
import connection.db;
import java.sql.*;

public class ConsumerDAO 
{
    public consumer verifyData(String cid, String pass) throws SQLException, ClassNotFoundException {

        consumer cons = null;
        try (Connection conn=db.initializeDatabase()){
            String sql = "SELECT * FROM consumer_profile WHERE consumer_id = ? AND password = ?";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, cid);
            statement.setString(2, pass);
            ResultSet result = statement.executeQuery();

            if (result.next()) {
                cons=new consumer();
                cons.setId(result.getString("id"));
                cons.setConId(result.getString("consumer_id"));
                cons.setPass(result.getString("password"));
                cons.setName(result.getString("name"));
                cons.setServiceNo(result.getString("service_no"));
                cons.setDob(result.getString("dob"));
                cons.setProfession(result.getString("profession"));
                cons.setContact(result.getString("contact_no"));
                cons.setEmail(result.getString("email_id"));
            }
        }

        return cons;
    }
}
