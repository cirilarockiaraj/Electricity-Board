package ConsumerLogin;

import connection.db;
import java.io.IOException;
import java.sql.*;
import javax.servlet.RequestDispatcher;
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
@WebServlet(name = "updatePassword", urlPatterns = {"/updatePassword"})
public class updatePassword extends HttpServlet {

    String err_msg = "";
    String succ_msg = "";
    Connection conn;

    public Boolean checkPass(String oldPass, String sno) {
        try {
            conn = db.initializeDatabase();
            String sql = "SELECT * FROM consumer_profile WHERE service_no=? AND password = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, sno);
            ps.setString(2, oldPass);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (ClassNotFoundException | SQLException e) {
            err_msg = "" + e;
        }
        return false;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        consumer co = (consumer)session.getAttribute("con");
        String sno=co.getServiceNo();
        String oldPass = request.getParameter("oldPass");
        String newPass = request.getParameter("newPass");
        String conPass = request.getParameter("conPass");
        boolean oldCheck = checkPass(oldPass, sno);
        
        if (oldCheck == true) {
            if (newPass.equals(conPass)) {
                try {
                    conn = db.initializeDatabase();
                    PreparedStatement ps = conn.prepareStatement("UPDATE consumer_profile SET password=? WHERE service_no=?");
                    ps.setString(1, newPass);
                    ps.setString(2, sno);
                    ps.executeUpdate();
                    succ_msg = "Password updated successfully...";
                } catch (ClassNotFoundException | SQLException e) {
                    err_msg = "" + e;
                }
            } else {
                err_msg = "Password and confirm password mismatched!!!!!";
            }
        } else {
            err_msg = "Old password doesn't match!!!!";
        }

        request.setAttribute("succ_msg", succ_msg);
        request.setAttribute("err_msg", err_msg);
        request.getRequestDispatcher("con_dashboard.jsp").forward(request, response);

    }
}
