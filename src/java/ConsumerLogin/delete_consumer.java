package ConsumerLogin;

import connection.db;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "delete_consumer", urlPatterns = {"/delete_consumer"})
public class delete_consumer extends HttpServlet {

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
        PreparedStatement ps;

        String id = request.getParameter("id");
        try {
            conn=db.initializeDatabase();
            ps = conn.prepareStatement("DELETE FROM consumer_profile WHERE id=?");
            ps.setString(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            out.print(e);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(delete_consumer.class.getName()).log(Level.SEVERE, null, ex);
        }
        response.sendRedirect("view_all_consumer.jsp");
        processRequest(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException 
    {
     
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
