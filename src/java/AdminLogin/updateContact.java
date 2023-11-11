package AdminLogin;

import connection.db;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author CIRIL AROCKIARAJ
 */
@WebServlet(name = "updateContact", urlPatterns = {"/updateContact"})
public class updateContact extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out=response.getWriter();
        String address=request.getParameter("address");
        String contact=request.getParameter("contact");
        String email=request.getParameter("email");
        String page="controls.jsp";
        String msg="";
        
        try{
            Connection con=db.initializeDatabase();
            String sql="UPDATE contact SET address=?, contact_no=?, email=?;";
            PreparedStatement ps=con.prepareStatement(sql);
            ps.setString(1, address);
            ps.setString(2, contact);
            ps.setString(3, email);
            int row=ps.executeUpdate();
            if(row>0){
                msg="Contact details updated successfully..";
            }
        }
        catch(ClassNotFoundException | SQLException e){
            out.print(e);
        }
        request.setAttribute("msg", msg);
        RequestDispatcher dis=request.getRequestDispatcher(page);
        dis.forward(request, response);
    }
}
