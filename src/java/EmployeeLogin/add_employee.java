package EmployeeLogin;

import connection.db;
import java.io.*;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.MessagingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import mailer.mail;

/**
 * s
 *
 * @author CIRIL AROCKIARAJ
 */
@MultipartConfig
@WebServlet(name = "add_employee", urlPatterns = {"/add_employee"})
public class add_employee extends HttpServlet {

    String msg = null;
    String emp_id;
    Connection conn;
    PreparedStatement ps1, ps2;

    public void employee_id() {
        try {
            conn = db.initializeDatabase();
            String query = "SELECT emp_id FROM employee_profile ORDER BY emp_id DESC LIMIT 1";
            ps1 = conn.prepareStatement(query);
            ResultSet rs = ps1.executeQuery();
            if (rs.next()) {
                String ap = rs.getString("emp_id");
                int ln = ap.length();
                String stxt = ap.substring(0, 7);
                String snum = ap.substring(7, ln);
                int n = Integer.parseInt(snum);
                n++;
                snum = Integer.toString(n);
                emp_id = stxt + snum;
            } else {
                emp_id = "TNEBEMP101".toUpperCase();
            }
        } catch (ClassNotFoundException | NumberFormatException | SQLException e) {
            System.err.print(e);
        }
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        PrintWriter out = response.getWriter();

        Part file = request.getPart("image");
        String fileName = file.getSubmittedFileName();
        String uploadPath = "../emp_profiles/" + fileName;

        String name = request.getParameter("name");
        String pass = request.getParameter("pass");
        String dob = request.getParameter("dob");
        long contact = Long.parseLong(request.getParameter("contact"));
        String email = request.getParameter("email");
        String profession = request.getParameter("profe");
        String hire_dist = request.getParameter("district");
        String hire_city = request.getParameter("office");
        String address = request.getParameter("address");
        
        employee_id();
        String sub = "Electricity Board";
        String msgs = "Hi " + name + ", \n Congratulations you are successfully appointed in Electricity Board. \n\n Employee ID : " + emp_id + "\n Temporary password : " + pass + "\n\n Office details :\n District : " + hire_dist + "\n city : " + hire_city + "\n Thankyou.";

        if (address.equals("") || name.equals("") || pass.equals("") || dob.equals("") || email.equals("") || profession.equals("")) {
            msg = "Please fill out all fields....";
        } else {
            if (pass.length() >= 8) {
                try (FileOutputStream fos = new FileOutputStream(uploadPath)) {
                    InputStream is = file.getInputStream();
                    byte[] data = new byte[is.available()];
                    is.read(data);
                    fos.write(data);
                    fos.close();
                } catch (IOException e) {
                    out.print(e);
                }

                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    conn = db.initializeDatabase();

                    String query1 = "INSERT INTO employee_profile(emp_id, image, emp_name, dob, password, profession, contact_no, email_id, hire_district, office, address) VALUES (?,?,?,?,?,?,?,?,?,?,?)";
                    ps2 = conn.prepareStatement(query1);
                    ps2.setString(1, emp_id);
                    ps2.setString(2, fileName);
                    ps2.setString(3, name);
                    ps2.setString(4, dob);
                    ps2.setString(5, pass);
                    ps2.setString(6, profession);
                    ps2.setLong(7, contact);
                    ps2.setString(8, email);
                    ps2.setString(9, hire_dist);
                    ps2.setString(10, hire_city);
                    ps2.setString(11, address);
                    int row = ps2.executeUpdate();

                    if (row > 0) {

                        msg = "New employee added successfully...";
                        mail m = new mail();
                        try {
                            m.send(email, sub, msgs);
                        } catch (MessagingException ex) {
                            Logger.getLogger(emp_payment.class.getName()).log(Level.SEVERE, null, ex);
                        }
                    }

                } catch (ClassNotFoundException | SQLException e) {
                    msg = "" + e;
                }

            } else {
                msg = "Error : " + "\tPassword must be minimum 8 characters";
            }
        }

        request.setAttribute("message", msg);
        request.setAttribute("empId", emp_id);
        request.getRequestDispatcher("add_employee.jsp").forward(request, response);
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
