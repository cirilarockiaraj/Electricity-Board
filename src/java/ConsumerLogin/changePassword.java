package ConsumerLogin;

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
import javax.servlet.http.HttpSession;

/**
 *
 * @author CIRIL AROCKIARAJ
 */
@WebServlet(name = "changePassword", urlPatterns = {"/changePassword"})
public class changePassword extends HttpServlet {
    
    public boolean updatePass(String cid, String newPass){
        try{
            Connection con=db.initializeDatabase();
            String sql="UPDATE consumer_profile SET password=? WHERE consumer_id=?";
            PreparedStatement ps=con.prepareCall(sql);
            ps.setString(1, newPass);
            ps.setString(2, cid);
            int row=ps.executeUpdate();
            if(row>0){
                return true;
            }
        }
        catch(ClassNotFoundException | SQLException e){
            
        }
        return false;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String pass=request.getParameter("pass");
        String con_pass=request.getParameter("con_pass");
        
        HttpSession session=request.getSession();
        String cid=(String) session.getAttribute("conID");
        
        String msg=null;
        String page="con_update_pass.jsp";
        
        if(pass.equals(con_pass)){
            if(updatePass(cid, pass)==true){
                session.removeAttribute("conID");
                page="con_login.jsp";
            }
        }
        else{
            msg="Password and confirm password mismatched";
        }
        request.setAttribute("msg1", msg);
        RequestDispatcher dispatcher = request.getRequestDispatcher(page);
        dispatcher.forward(request, response);
    }
}
