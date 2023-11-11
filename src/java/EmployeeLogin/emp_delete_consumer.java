/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package EmployeeLogin;

import ConsumerLogin.delete_consumer;
import connection.db;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author CIRIL AROCKIARAJ
 */
@WebServlet(name = "emp_delete_consumer", urlPatterns = {"/emp_delete_consumer"})
public class emp_delete_consumer extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out=response.getWriter();
        Connection conn;
        PreparedStatement ps;

        String id = request.getParameter("id");
        try {
            conn=db.initializeDatabase();
            ps = conn.prepareStatement("DELETE FROM consumer_profile WHERE id=?");
            ps.setString(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            out.print(e);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(delete_consumer.class.getName()).log(Level.SEVERE, null, ex);
        }
        response.sendRedirect("emp_view_consumer.jsp");
    }
}
