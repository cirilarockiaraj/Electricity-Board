/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package ConsumerLogin;

import connection.db;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.MessagingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import mailer.mail;

/**
 *
 * @author CIRIL AROCKIARAJ
 */
@WebServlet(name = "aathar_upload", urlPatterns = {"/aathar_upload"})
@MultipartConfig(maxFileSize = 16177215)
public class aathar_upload extends HttpServlet {
    
    String msg="";
    String name="";
    String contact="";
    String email="";
    String status="pending";
    Connection con;
    
    public void user_data(String sno){
        try{
            con=db.initializeDatabase();
            
            String sql="SELECT * FROM services WHERE service_no=?";
            PreparedStatement ps=con.prepareStatement(sql);
            ps.setString(1, sno);
            ResultSet rs=ps.executeQuery();
            if(rs.next()){
                name=rs.getString("service_holder_name");
                contact=rs.getString("mobile_no");
                email=rs.getString("email_id");
            }
        }
        catch(ClassNotFoundException | SQLException e){
            
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        PrintWriter out=response.getWriter();
        
        String aNo=request.getParameter("aNo");
        Part photo=request.getPart("a_photo");
        
        HttpSession session=request.getSession();
        consumer cons=(consumer) session.getAttribute("con");
        String sno=cons.getServiceNo();
        
        InputStream is = null;
        
        user_data(sno);
        
        String sub="Electricity Board";
        String message="Hi "+name+", \nYour service number "+sno+" your aathar card uploaded successfully..";
        
        if (photo != null) {
            is = photo.getInputStream();
            try{
                con=db.initializeDatabase();
                String sql="INSERT INTO aathar_data(service_no, name, aathar_no, aathar, contact_no, email, status) VALUES(?,?,?,?,?,?,?)";
                PreparedStatement ps=con.prepareStatement(sql);
                ps.setString(1, sno);
                ps.setString(2, name);
                ps.setString(3, aNo);
                ps.setBlob(4, is);
                ps.setString(5, contact);
                ps.setString(6, email);
                ps.setString(7, status);
                
                int row=ps.executeUpdate();
                if(row>0){
                    mail m=new mail();
                    try {
                        m.send(email, sub, message);
                    } catch (MessagingException ex) {
                        Logger.getLogger(aathar_upload.class.getName()).log(Level.SEVERE, null, ex);
                    }
                    msg="Aathar Uploaded successfully";
                }
            }
            catch(ClassNotFoundException | SQLException e){
                out.println(e);
            }
        }
        else{
            out.println("image null");
            out.println("<a href='upload_aathar.jsp'>Back</a>");
        }
        request.setAttribute("msg", msg);
        response.sendRedirect("upload_aathar.jsp");
    }
}
