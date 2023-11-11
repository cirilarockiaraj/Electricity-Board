package EmployeeLogin;

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
@WebServlet(name = "update_complaint", urlPatterns = {"/update_complaint"})
public class update_complaint extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out=response.getWriter();
        int id=Integer.parseInt(request.getParameter("id"));
        String status=request.getParameter("sts");
        
        String str="";
        
        if(status.equals("pending")){
            str="In progress";
        }
        else{
            str="completed";
        }
        
        try{
            Connection conn=db.initializeDatabase();
            String sql="UPDATE compliants SET status=? WHERE id=?";
            PreparedStatement ps=conn.prepareStatement(sql);
            ps.setString(1, str);
            ps.setInt(2, id);
            ps.executeUpdate();
            response.sendRedirect("emp_complaint.jsp");
        }
        catch(IOException | ClassNotFoundException | SQLException e){
            out.print(e);
        }
    }
}
