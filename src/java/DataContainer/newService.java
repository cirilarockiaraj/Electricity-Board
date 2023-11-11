package DataContainer;

import connection.db;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.mail.MessagingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import mailer.mail;

/**
 *
 * @author CIRIL AROCKIARAJ
 */
@WebServlet(name = "newService", urlPatterns = {"/newService"})
public class newService extends HttpServlet {

    int req_no;
    String status = "pending";
    int updateQuery = 0;
    String msg = "";
    Connection conn = null;

    public boolean verify(String hno, String pin) {
        boolean flag = false;
        try {
            conn = db.initializeDatabase();
            String query = "SELECT house_no,pincode FROM services WHERE house_no=? AND pincode=?";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, hno);
            ps.setString(2, pin);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                flag = true;
            }
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println(e);
        }
        return flag;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        String con_type = request.getParameter("con_type");
        String fname = request.getParameter("fname");
        String lname = request.getParameter("lname");
        String father_name = request.getParameter("father_name").toUpperCase();
        String occupation = request.getParameter("occupation");
        String gender = request.getParameter("gend");
        String dob = request.getParameter("dob");
        String flat_no = request.getParameter("flat_no");
        String city = request.getParameter("city");
        String country = request.getParameter("country");
        String state = request.getParameter("state");
        String district = request.getParameter("district");
        String pincode = request.getParameter("pincode");
        long contact = Long.parseLong(request.getParameter("contact"));
        String add_cont = request.getParameter("add_cont");
        String email = request.getParameter("email");

        String name = (fname + " " + lname).toUpperCase();

        if (verify(flat_no, pincode) == false) {
            try {
                conn = db.initializeDatabase();
                String query = "SELECT req_no FROM services ORDER BY req_no DESC LIMIT 1";
                PreparedStatement ps = conn.prepareStatement(query);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    int n = rs.getInt("req_no");
                    n++;
                    req_no = n;
                } else {
                    req_no = 1000;
                }

                String query1 = "INSERT INTO services(req_no, connection_type, status, service_holder_name, father_name,occupation, gender, date_of_birth, house_no, city_village_town_name, district, state, country, pincode, mobile_no, additional_mobile_no, email_id) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
                ps = conn.prepareStatement(query1);
                ps.setInt(1, req_no);
                ps.setString(2, con_type);
                ps.setString(3, status);
                ps.setString(4, name);
                ps.setString(5, father_name);
                ps.setString(6, occupation);
                ps.setString(7, gender);
                ps.setString(8, dob);
                ps.setString(9, flat_no);
                ps.setString(10, city);
                ps.setString(11, district);
                ps.setString(12, state);
                ps.setString(13, country);
                ps.setString(14, pincode);
                ps.setLong(15, contact);
                ps.setString(16, add_cont);
                ps.setString(17, email);

                updateQuery = ps.executeUpdate();
                if (updateQuery > 0) {
                    mail m = new mail();
                    boolean res = m.send(email, "Electricity Board", "Hi " + name + ",\nyour request number is : " + req_no + " connection type is : " + con_type + " and your request submitted successfully. but currently your service is not activated will activate soon.\n\n\t\t Thankyou..");
                    if (res == true) {
                        out.print("success");
                    }
                }
            } catch (ClassNotFoundException | SQLException | MessagingException e) {
               out.print("faild");

            }
        } else {
            out.print("exist");

        }
    }
}
