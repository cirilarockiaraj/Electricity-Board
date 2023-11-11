package EmployeeLogin;

import connection.db;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "delete_employee", urlPatterns = {"/delete_employee"})
public class delete_employee extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
       
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException 
    {
        PrintWriter out=response.getWriter();
        Connection conn;
        PreparedStatement ps1, ps2;
        String imgName = "";

        String id = request.getParameter("id");

        try {
            conn=db.initializeDatabase();
            ps1 = conn.prepareStatement("SELECT image FROM employee_profile WHERE id=?");
            ps1.setString(1, id);
            ResultSet rs = ps1.executeQuery();
            while (rs.next()) {
                imgName = rs.getString("image");
                File f = new File("E:/Java/Electricity_board/web/emp_profiles/" + imgName);
                f.delete();
            }
        } catch (ClassNotFoundException | SQLException e) {
            out.print(e);
        }

        try {
            conn=db.initializeDatabase();
            ps2 = conn.prepareStatement("DELETE FROM employee_profile WHERE id=?");
            ps2.setString(1, id);
            ps2.executeUpdate();
        } catch (SQLException e) {
            out.print(e);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(delete_employee.class.getName()).log(Level.SEVERE, null, ex);
        }
        response.sendRedirect("view_all_employee.jsp");
        processRequest(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
