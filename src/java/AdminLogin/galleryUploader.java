package AdminLogin;

import connection.db;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 *
 * @author CIRIL AROCKIARAJ
 */
@MultipartConfig(maxFileSize = 16177215)
@WebServlet(name = "galleryUploader", urlPatterns = {"/galleryUploader"})
public class galleryUploader extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        Part image = request.getPart("image");
        InputStream is = null;
        String msg = "";
        if (image != null) {
            is = image.getInputStream();
            try {
                Connection con = db.initializeDatabase();
                String sql = "INSERT INTO gallery(images) VALUES(?)";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setBlob(1, is);
                int res = ps.executeUpdate();
                if (res > 0) {
                    msg = "image uploaded successfully..";
                } else {
                    msg = "failed to upload";
                }
            } catch (ClassNotFoundException | SQLException e) {
                out.print(e);
            }
        } else {
            msg = "image null";
        }
        request.setAttribute("msg", msg);
        RequestDispatcher dis = request.getRequestDispatcher("controls.jsp");
        dis.forward(request, response);
    }
}
