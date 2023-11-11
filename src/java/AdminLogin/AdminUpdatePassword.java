package AdminLogin;

import ConsumerLogin.*;
import connection.db;
import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author CIRIL AROCKIARAJ
 */
@WebServlet(name = "AdminUpdatePassword", urlPatterns = {"/AdminUpdatePassword"})
public class AdminUpdatePassword extends HttpServlet {

    String msg1 = "";
    Connection conn;

    public Boolean checkPass(String oldPass, String user) {
        try {
            conn = db.initializeDatabase();
            String sql = "SELECT * FROM admin_profile WHERE username=? AND password = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, user);
            ps.setString(2, oldPass);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (ClassNotFoundException | SQLException e) {
            msg1 = "" + e;
        }
        return false;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        admin ad = (admin)session.getAttribute("ad");
        String user=ad.getUsername();
        String oldPass = request.getParameter("oldPass");
        String newPass = request.getParameter("newPass");
        String conPass = request.getParameter("conPass");
        boolean oldCheck = checkPass(oldPass, user);
        
        if (oldCheck == true) {
            if (newPass.equals(conPass)) {
                try {
                    conn = db.initializeDatabase();
                    PreparedStatement ps = conn.prepareStatement("UPDATE admin_profile SET password=? WHERE username=? AND password=?");
                    ps.setString(1, newPass);
                    ps.setString(2, user);
                    ps.setString(3, oldPass);
                    ps.executeUpdate();
                    msg1 = "Password updated successfully...";
                } catch (ClassNotFoundException | SQLException e) {
                    msg1 = "" + e;
                }
            } else {
                msg1 = "password and confirm password mismatched...";
            }
        } else {
            msg1 = "Old password does not matched...";
        }

        request.setAttribute("msg1", msg1);
        request.getRequestDispatcher("admin_dashboard.jsp").forward(request, response);

    }
}
