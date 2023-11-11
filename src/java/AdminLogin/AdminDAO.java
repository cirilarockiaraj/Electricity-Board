package AdminLogin;

import connection.db;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author CIRIL AROCKIARAJ
 */
public class AdminDAO {

    public admin verify(String user, String pass) throws SQLException, ClassNotFoundException {

        admin ad = null;
        try (Connection conn=db.initializeDatabase()){
            String sql = "SELECT * FROM admin_profile WHERE username = ? AND password = ?";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, user);
            statement.setString(2, pass);

            ResultSet result = statement.executeQuery();

            if (result.next()) {
                ad = new admin();
                ad.setUsername(result.getString("username"));
                ad.setPassword(result.getString("password"));
                ad.setImage(result.getString("image"));
                ad.setDob(result.getString("dob"));
                ad.setProfession(result.getString("profession"));
                ad.setContact_no(result.getString("contact_no"));
                ad.setEmail_id(result.getString("email_id"));
                ad.setAddress(result.getString("address"));
            }
        }

        return ad;
    }

}
