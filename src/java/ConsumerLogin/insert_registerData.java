package ConsumerLogin;

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

/**
 *
 * @author CIRIL AROCKIARAJ
 */
@WebServlet(name = "insert_registerData", urlPatterns = {"/insert_registerData"})
public class insert_registerData extends HttpServlet {

    String SuccMsg = null;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        int con_id=(int)session.getAttribute("con_id");
        String pass=(String)session.getAttribute("pass");
        String name=(String)session.getAttribute("name");
        String s_no=(String)session.getAttribute("sno");
        String dob=(String)session.getAttribute("dob");
        String profession=(String)session.getAttribute("prof");
        String contact=(String)session.getAttribute("contact");
        String email=(String)session.getAttribute("email");
        try {
            Connection conn = db.initializeDatabase();
            String query2 = "INSERT INTO consumer_profile(consumer_id, password, name, service_no, dob, profession, contact_no, email_id) VALUES (?,?,?,?,?,?,?,?)";
            PreparedStatement ps2 = conn.prepareStatement(query2);
            ps2.setInt(1, con_id);
            ps2.setString(2, pass);
            ps2.setString(3, name);
            ps2.setString(4, s_no);
            ps2.setString(5, dob);
            ps2.setString(6, profession);
            ps2.setString(7, contact);
            ps2.setString(8, email);
            int row = ps2.executeUpdate();

            if (row > 0) {
                mail m = new mail();
                try {
                    m.send(email, "Electricity Board", "Hi " + name + ", \nyour consumer id : " + con_id + " use this consumer id to sign in");
                } catch (MessagingException ex) {
                    Logger.getLogger(register_consumer.class.getName()).log(Level.SEVERE, null, ex);
                }
                session.removeAttribute("con_id");
                session.removeAttribute("pass");
                session.removeAttribute("name");
                session.removeAttribute("sno");
                session.removeAttribute("dob");
                session.removeAttribute("prof");
                session.removeAttribute("contact");
                session.removeAttribute("email");
                session.removeAttribute("otp");
                SuccMsg = "Account created successfully consumer id sends your registered email id";
            }

        } catch (ClassNotFoundException | SQLException e) {
            out.print(e);
        }
        request.setAttribute("SuccMsg", SuccMsg);
        request.getRequestDispatcher("con_login.jsp").forward(request, response);
    }
}
