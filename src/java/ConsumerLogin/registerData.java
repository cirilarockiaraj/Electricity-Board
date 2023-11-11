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
import org.json.*;

/**
 *
 * @author CIRIL AROCKIARAJ
 */
@WebServlet(name = "registerData", urlPatterns = {"/registerData"})
public class registerData extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String data = request.getParameter("dt");
        JSONObject res = new JSONObject();
        try{
            Connection con=db.initializeDatabase();
            String sql="SELECT * FROM services WHERE service_no=?";
            PreparedStatement ps=con.prepareStatement(sql);
            ps.setString(1, data);
            ResultSet rs=ps.executeQuery();
            if(rs.next()){
                res.put("name", rs.getString("service_holder_name"));
                res.put("dob", rs.getString("date_of_birth"));
                res.put("contact", rs.getString("mobile_no"));
                res.put("email", rs.getString("email_id"));
            }
            out.print(res);
        }
        catch(ClassNotFoundException | SQLException | JSONException e){
            out.print(e);
        }
    }
}
