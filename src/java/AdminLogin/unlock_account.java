/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package AdminLogin;

import connection.db;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author CIRIL AROCKIARAJ
 */
@WebServlet(name = "unlock_account", urlPatterns = {"/unlock_account"})
public class unlock_account extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        PrintWriter out=response.getWriter();
        
        String id=request.getParameter("id");
        
        try{
            Connection con=db.initializeDatabase();
            String sql="UPDATE lockedaccounts SET status=?, adding_time = NOW() WHERE id=?";
            PreparedStatement ps=con.prepareStatement(sql);
            ps.setString(1, "unlocked");
            ps.setString(2, id);
            
            int row=ps.executeUpdate();
            if(row>0){
                response.sendRedirect("admin_unlock_account.jsp");
            }
        }
        catch(ClassNotFoundException | SQLException e){
            out.println(e);
        }
    }
}
