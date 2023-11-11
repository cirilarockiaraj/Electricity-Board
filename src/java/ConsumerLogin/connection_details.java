package ConsumerLogin;

import connection.db;
import java.io.IOException;
import java.sql.*;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet(name = "connection_details", urlPatterns = {"/connection_details"})
public class connection_details extends HttpServlet {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        consumer co = (consumer)session.getAttribute("con");
        String sno=co.getServiceNo();
        try {
            Connection conn = db.initializeDatabase();
            String sql="SELECT * FROM services WHERE service_no=?";
            PreparedStatement ps=conn.prepareStatement(sql);
            ps.setString(1, sno);
            ResultSet rs=ps.executeQuery();
            while(rs.next())
            {
                request.setAttribute("ser_no", rs.getString("service_no"));
                request.setAttribute("con_type", rs.getString("connection_type"));
                request.setAttribute("status", rs.getString("status"));
                request.setAttribute("name", rs.getString("service_holder_name"));
                request.setAttribute("father", rs.getString("father_name"));
                request.setAttribute("occupation", rs.getString("occupation"));
                request.setAttribute("gender", rs.getString("gender"));
                request.setAttribute("dob", rs.getString("date_of_birth"));
                request.setAttribute("house", rs.getString("house_no"));
                request.setAttribute("city", rs.getString("city_village_town_name"));
                request.setAttribute("district", rs.getString("district"));
                request.setAttribute("state", rs.getString("state"));
                request.setAttribute("country", rs.getString("country"));
                request.setAttribute("pincode", rs.getString("pincode"));
                request.setAttribute("mobile", rs.getString("mobile_no"));
                request.setAttribute("additional", rs.getString("additional_mobile_no"));
                request.setAttribute("email", rs.getString("email_id"));
                
                request.getRequestDispatcher("connection_details.jsp").forward(request, response);//dispatcher
                
            }
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(connection_details.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
