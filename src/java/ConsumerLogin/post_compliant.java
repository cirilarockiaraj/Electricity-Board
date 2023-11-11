package ConsumerLogin;

import connection.db;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.MessagingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import mailer.mail;

/**
 *
 * @author CIRIL AROCKIARAJ
 */
@WebServlet(name = "post_compliant", urlPatterns = {"/post_compliant"})
public class post_compliant extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out=response.getWriter();
        
        HttpSession session = request.getSession();
        consumer con=(consumer)session.getAttribute("con");
        String msg="";
        String sno=con.getServiceNo();
        String email=con.getEmail();
        String name=request.getParameter("name");
        String house_no=request.getParameter("houseno");
        String street=request.getParameter("street");
        String city=request.getParameter("city");
        String district=request.getParameter("district");
        String contact=request.getParameter("contact");
        String problem=request.getParameter("problem");
        
        String sub="Electricity Board";
        String message="Hi "+name+", \n your service number : "+sno+" your complaint recived successfully...\n\t\t Thankyou";
        
        try{
            Connection conn=db.initializeDatabase();
            String query="INSERT INTO compliants(service_no, name, house_no, street, city, district, contact_no, compliant) VALUES (?,?,?,?,?,?,?,?)";
            PreparedStatement ps=conn.prepareStatement(query);
            ps.setString(1,sno);
            ps.setString(2,name);
            ps.setString(3,house_no);
            ps.setString(4,street);
            ps.setString(5,city);
            ps.setString(6,district);
            ps.setString(7,contact);
            ps.setString(8,problem);
            int row=ps.executeUpdate();
            if(row>0){
                mail m=new mail();
                try {
                    m.send(email, sub, message);
                } catch (MessagingException ex) {
                    Logger.getLogger(post_compliant.class.getName()).log(Level.SEVERE, null, ex);
                }
                out.print(true);
            }
        }
        catch(ClassNotFoundException | SQLException e){
            out.print(false);
        }
        //request.setAttribute("message", msg);
        //request.getRequestDispatcher("con_complient.jsp").forward(request, response);
    }
}
