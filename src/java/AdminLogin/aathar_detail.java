/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package AdminLogin;

import ConsumerLogin.aathar_upload;
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
import mailer.mail;

/**
 *
 * @author CIRIL AROCKIARAJ
 */
@WebServlet(name = "aathar_detail", urlPatterns = {"/aathar_detail"})
public class aathar_detail extends HttpServlet {

    Connection con;
    String name = "";
    String sno = "";
    String email = "";

    public void user_data(String id) {
        try {
            con = db.initializeDatabase();
            String sql = "SELECT * FROM aathar_data WHERE id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                name = rs.getString("name");
                sno = rs.getString("service_no");
                email = rs.getString("email");
            }
        } catch (ClassNotFoundException | SQLException e) {

        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        String id = request.getParameter("id");
        String button = request.getParameter("btn");
        String status = null;
        String sub = "Electricity Board";
        String message = "";

        if (button.equals("accept")) {
            user_data(id);
            status = "accepted";
            message = "Hi " + name + ", \nYour service number " + sno + " your aathar card accepted successfully..";
        } else if (button.equals("reject")) {
            user_data(id);
            status = "rejected";
            message = "Hi " + name + ", \nYour service number " + sno + " your aathar card rejected! please contact administrator.";
        } else if (button.equals("delete")) {
            try {
                con = db.initializeDatabase();
                String sql1 = "DELETE FROM aathar_data WHERE id=?";
                PreparedStatement ps = con.prepareStatement(sql1);
                ps.setString(1, id);
                ps.executeUpdate();
            } catch (ClassNotFoundException | SQLException e) {
                out.println(e);
            }
        }
        try {
            con = db.initializeDatabase();
            String sql = "UPDATE aathar_data SET status=? WHERE id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, status);
            ps.setString(2, id);
            ps.executeUpdate();

            mail m = new mail();
            try {
                m.send(email, sub, message);
            } catch (MessagingException ex) {
                Logger.getLogger(aathar_upload.class.getName()).log(Level.SEVERE, null, ex);
            }
        } catch (ClassNotFoundException | SQLException e) {
            out.println(e);
        }
        response.sendRedirect("admin_view_aathar.jsp");
    }
}
