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
public class verifyOTP1 extends HttpServlet {
   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out=response.getWriter();
        
        String n1, n2, n3, n4, n5;
        n1=request.getParameter("n1");
        n2=request.getParameter("n2");
        n3=request.getParameter("n3");
        n4=request.getParameter("n4");
        n5=request.getParameter("n5");
        
        String reciveOTP = n1+n2+n3+n4+n5;
        HttpSession session=request.getSession();
        String otp=(String) session.getAttribute("otp");
        
        String msg=null;
        if(reciveOTP.equals(otp)){
            msg="success";
        }
        else{
            msg="fail";
        }
        out.print(msg);
    }
}
