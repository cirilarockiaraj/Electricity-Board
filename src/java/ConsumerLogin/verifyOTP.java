/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
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
@WebServlet(name = "verifyOTP", urlPatterns = {"/verifyOTP"})
public class verifyOTP extends HttpServlet {
    
    public boolean verify(String cid, String otp){
        try{
            Connection con=db.initializeDatabase();
            String sql="SELECT otp FROM otpverify WHERE consumer_id=? AND valid > NOW()";
            PreparedStatement ps=con.prepareStatement(sql);
            ps.setString(1, cid);
            ResultSet rs=ps.executeQuery();
            
            while(rs.next()){
                if(rs.getString("otp").equals(otp)){
                    return true;
                }
            }
        }
        catch(ClassNotFoundException | SQLException e){
            
        }
        return false;
    }
    
    public void deleteOTP(String cid){
        try{
            Connection con=db.initializeDatabase();
            String sql="DELETE FROM otpverify WHERE consumer_id=?";
            PreparedStatement ps=con.prepareStatement(sql);
            ps.setString(1, cid);
            ps.executeUpdate();
        }
        catch(ClassNotFoundException | SQLException e){
            
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String n1, n2, n3, n4, n5;
        n1=request.getParameter("n1");
        n2=request.getParameter("n2");
        n3=request.getParameter("n3");
        n4=request.getParameter("n4");
        n5=request.getParameter("n5");
        
        String reciveOTP = n1+n2+n3+n4+n5;
        HttpSession session=request.getSession();
        String cid=(String) session.getAttribute("conID");
        
        String nextPage="enterOTP.jsp";
        String msg=null;
        
        if(verify(cid, reciveOTP)==true){
            deleteOTP(cid);
            nextPage="con_update_pass.jsp";
        }
        else{
            msg="Invalid OTP";
        }
        
        request.setAttribute("msg", msg);
        RequestDispatcher dispatcher = request.getRequestDispatcher(nextPage);
        dispatcher.forward(request, response);
    }
}
