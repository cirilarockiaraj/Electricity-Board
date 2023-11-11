package ConsumerLogin;

import Sendsms.generateOTP;
import connection.db;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.MessagingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import mailer.mail;

@WebServlet(name = "register_consumer", urlPatterns = {"/register_consumer"})
public class register_consumer extends HttpServlet {

    Connection conn, conn1;
    PreparedStatement ps1, ps2;
    int con_id, id;
    String msg = null, SuccMsg = null;

    public void generate_id() {
        try {
            conn = db.initializeDatabase();
            String query = "SELECT consumer_id FROM consumer_profile ORDER BY consumer_id DESC LIMIT 1";
            ps1 = conn.prepareStatement(query);
            ResultSet rs = ps1.executeQuery();
            if (rs.next()) {
                id = rs.getInt("consumer_id");
                id = id + 1;
                con_id = id;
            } else {
                con_id = 1000;
            }
        } catch (ClassNotFoundException | SQLException e) {
            msg = "" + e;
        }
    }

    public boolean verify(String sno) {
        try {
            conn1 = db.initializeDatabase();
            String query = "SELECT service_no FROM consumer_profile WHERE service_no=?";
            ps2 = conn1.prepareStatement(query);
            ps2.setString(1, sno);
            ResultSet rs = ps2.executeQuery();
            if (rs.next()) {
                return true;
            } else {
                return false;
            }
        } catch (ClassNotFoundException | SQLException e) {
            msg = "" + e;
        }
        return false;
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out=response.getWriter();

        String name = request.getParameter("name").toUpperCase();
        String s_no = request.getParameter("s_no").toUpperCase();
        String pass = request.getParameter("pass");
        String conpass = request.getParameter("conPass");
        String dob = request.getParameter("dob");
        String contact = request.getParameter("contact");
        String email = request.getParameter("email");
        String profession = "Consumer";
        String message = null, otp = null;

        HttpSession session = request.getSession();

        if (name.equals("") || s_no.equals("") || pass.equals("") || conpass.equals("") || dob.equals("") || contact.equals("") || email.equals("") || profession.equals("")) {
            msg = "fill";
        } else {
            if (pass.length() >= 8) {
                if (pass.equals(conpass)) {
                    if (verify(s_no) == false) {
                        generate_id();
                        session.setAttribute("con_id", con_id);
                        session.setAttribute("pass", pass);
                        session.setAttribute("name", name);
                        session.setAttribute("sno", s_no);
                        session.setAttribute("dob", dob);
                        session.setAttribute("prof", profession);
                        session.setAttribute("contact", contact);
                        session.setAttribute("email", email);
                        //generate otp
                        generateOTP g = new generateOTP();
                        otp = g.OTP();
                        //setting otp on session
                        session.setAttribute("otp", otp);
                        message = otp + " is your one time password to proceed on Electricity Board. It is valid for 2 minutes. Do not share yout OTP with anyone.";
                        mail m = new mail();
                        try {
                            m.send(email, "Electricity Board", message);
                        } catch (MessagingException ex) {
                            Logger.getLogger(forgetPassword.class.getName()).log(Level.SEVERE, null, ex);
                        }
                        msg=otp;
                        session.setMaxInactiveInterval(120);
                    } else {
                        msg = "exist";
                    }
                } else {
                    msg = "mismatched";
                }
            } else {
                msg = "minimum";
            }
        }
        out.print(msg);
//        request.setAttribute("message", msg);
//        request.getRequestDispatcher("register_consumer.jsp").forward(request, response);
//        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
