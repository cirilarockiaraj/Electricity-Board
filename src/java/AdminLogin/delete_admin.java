/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package AdminLogin;

import connection.db;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
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
@WebServlet(name = "delete_admin", urlPatterns = {"/delete_admin"})
public class delete_admin extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();

        Connection conn;
        PreparedStatement ps1, ps2;
        String imgName = "";

        String id = request.getParameter("id");

        try {
            conn=db.initializeDatabase();
            ps1 = conn.prepareStatement("SELECT image FROM admin_profile WHERE id=?");
            ps1.setString(1, id);
            ResultSet rs = ps1.executeQuery();
            while (rs.next()) {
                imgName = rs.getString("image");
                File f = new File("E:/Java/Electricity_board/web/admin_profiles/" + imgName);
                f.delete();
            }
        } catch (ClassNotFoundException | SQLException e) {
            out.print(e);
        }

        try {
            conn=db.initializeDatabase();
            ps2 = conn.prepareStatement("DELETE FROM admin_profile WHERE id=?");
            ps2.setString(1, id);
            ps2.executeUpdate();
        } catch (SQLException e) {
            out.print(e);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(delete_admin.class.getName()).log(Level.SEVERE, null, ex);
        }
        response.sendRedirect("view_all_admin.jsp");
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
