/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package EmployeeLogin;

import connection.db;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "emp_add_consumer", urlPatterns = {"/emp_add_consumer"})
public class emp_add_consumer extends HttpServlet {

    Connection conn;
    PreparedStatement ps1, ps2;
    int con_id, id;
    String msg = "";

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
        String profession = request.getParameter("profe");

        if (name.equals("") || s_no.equals("") || pass.equals("") || conpass.equals("") || dob.equals("") || contact.equals("") || email.equals("") || profession.equals("")) {
            msg = "Please fill out all fields";
        } else {
            if (pass.length() >= 8) {
                if (pass.equals(conpass)) {
                    try {
                        generate_id();
                        conn = db.initializeDatabase();
                        String query2 = "INSERT INTO consumer_profile(consumer_id, password, name, service_no, dob, profession, contact_no, email_id) VALUES (?,?,?,?,?,?,?,?)";
                        ps2 = conn.prepareStatement(query2);
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
                            msg = "New consumer added successfully" + "\t consumer ID : " + con_id;
                        }

                    } catch (ClassNotFoundException | SQLException e) {
                        out.print(e);

                    }
                } else {
                    msg = "Error : " + "\tPassword and confirm pasword is mismatch";
                }
            } else {
                msg = "Error : " + "\tPassword must be minimum 8 characters";
            }
        }
        request.setAttribute("message", msg);
        request.getRequestDispatcher("emp_add_consumer.jsp").forward(request, response);
    }
}
