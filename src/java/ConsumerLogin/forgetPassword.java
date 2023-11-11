package ConsumerLogin;

import Sendsms.generateOTP;
import Sendsms.sendOTP;
import connection.db;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.MessagingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import mailer.mail;

/**
 *
 * @author CIRIL AROCKIARAJ
 */
@WebServlet(name = "forgetPassword", urlPatterns = {"/forgetPassword"})
public class forgetPassword extends HttpServlet {

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    String contactno;
    String email;
    String msg = null;

    public boolean getData(String cid) {
        try {
            con = db.initializeDatabase();
            String sql = "SELECT contact_no, email_id FROM consumer_profile WHERE consumer_id=?";
            ps = con.prepareStatement(sql);
            ps.setString(1, cid);
            rs = ps.executeQuery();
            if (rs.next()) {
                contactno = rs.getString("contact_no");
                email = rs.getString("email_id");
                return true;
            }
        } catch (ClassNotFoundException | SQLException e) {
            msg = "Connection failed..";
        }
        return false;
    }

    public boolean insertOTP(String cid, String otp) {
        try {
            con = db.initializeDatabase();
            String sql = "INSERT INTO otpverify(consumer_id, otp) VALUES(?,?)";
            ps = con.prepareStatement(sql);
            ps.setString(1, cid);
            ps.setString(2, otp);
            int row = ps.executeUpdate();
            if (row > 0) {
                return true;
            }
        } catch (ClassNotFoundException | SQLException e) {

        }
        return false;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        String conid = request.getParameter("conid");
        generateOTP g = new generateOTP();
        String otp = null;
        String sub = "Electricity Board";
        String message = null;
        String nextPage = "con_forget_pass.jsp";
        if (getData(conid) == true) {
            otp = g.OTP();
            message = otp + " is your one time password to proceed on Electricity Board. It is valid for 2 minutes. Do not share yout OTP with anyone.";
            if (insertOTP(conid, otp) == true) {
                mail m = new mail();
                try {
                    m.send(email, sub, message);
                    HttpSession session = request.getSession();
                    session.setAttribute("conID", conid);
                    nextPage = "enterOTP.jsp";
                } catch (MessagingException ex) {
                    Logger.getLogger(forgetPassword.class.getName()).log(Level.SEVERE, null, ex);
                }
            } else {
                msg = "OTP is not send";
            }
        } else {
            msg = "Invalid consumer id";
        }
        request.setAttribute("msg", msg);
        request.setAttribute("email", email);
        RequestDispatcher dispatcher = request.getRequestDispatcher(nextPage);
        dispatcher.forward(request, response);
    }
}
