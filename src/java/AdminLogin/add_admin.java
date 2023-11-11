package AdminLogin;

import connection.db;
import java.io.*;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@MultipartConfig(maxFileSize = 16177215)
public class add_admin extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        PrintWriter out = response.getWriter();

        String msg = null;

        Part file = request.getPart("image");
        String fileName = file.getSubmittedFileName();
        String uploadPath = "../admin_profiles/" + fileName;

        String uname = request.getParameter("uname");
        String pass = request.getParameter("pass");
        String conpass = request.getParameter("conPass");
        String dob = request.getParameter("dob");
        long contact = Long.parseLong(request.getParameter("contact"));
        String email = request.getParameter("email");
        String profession = request.getParameter("profe");
        String address = request.getParameter("address");

        if (address == "" || uname == "" || pass == "" || conpass == "" || dob == "" || email == "" || profession == "") {
            msg = "Please fill out all fields....";
        } else {
            if (pass.length() >= 8) {
                if (pass.equals(conpass)) {
                    try {
                        FileOutputStream fos = new FileOutputStream(uploadPath);
                        InputStream is = file.getInputStream();
                        byte[] data = new byte[is.available()];
                        is.read(data);
                        fos.write(data);
                        fos.close();
                    } catch (IOException e) {
                        out.print(e);
                    }

                    try {
                        Connection conn=db.initializeDatabase();
                        String query = "INSERT INTO admin_profile(username, password, image, dob, profession, contact_no, email_id, address) VALUES (?,?,?,?,?,?,?,?)";
                        PreparedStatement ps = conn.prepareStatement(query);
                        ps.setString(1, uname);
                        ps.setString(2, pass);
                        ps.setString(3, fileName);
                        ps.setString(4, dob);
                        ps.setString(5, profession);
                        ps.setLong(6, contact);
                        ps.setString(7, email);
                        ps.setString(8, address);
                        int row = ps.executeUpdate();

                        if (row > 0) {

                            msg = "New administrator added successfully...";

                        }

                    } catch (ClassNotFoundException | SQLException e) {
                        msg = "" + e;
                    }
                } else {
                    msg = "Password and confirm password are different";
                }
            } else {
                msg = "Error : " + "\tPassword must be minimum 8 characters";
            }
        }

        request.setAttribute("message", msg);
        request.getRequestDispatcher("add_admin.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
