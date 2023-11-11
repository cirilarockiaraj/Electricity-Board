package ConsumerLogin;

import connection.db;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "con_pay_bill", urlPatterns = {"/con_pay_bill"})
public class con_pay_bill extends HttpServlet {

    PreparedStatement ps;
    public String msg = "";

    public boolean serviceValidation(String s_no) throws SQLException, ClassNotFoundException {
        try (Connection conn = db.initializeDatabase()) {
            String query = "SELECT * FROM services";
            ps = conn.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                if (s_no.equals(rs.getString("service_no"))) {
                    return true;
                }
            }
        }
        return false;
    }

    public boolean dateValidation(String s_no, String my) throws SQLException, ClassNotFoundException {

        try (Connection conn = db.initializeDatabase()) {
            String query = "SELECT month_year FROM eb_bill_payment WHERE service_no=?";
            ps = conn.prepareStatement(query);
            ps.setString(1, s_no);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                if (my.equals(rs.getString("month_year"))) {
                    return true;
                }
            }
        }
        return false;
    }

    public boolean statusValidation(String s_no, String my) throws SQLException, ClassNotFoundException {
        try (Connection conn = db.initializeDatabase()) {
            String query = "SELECT status FROM eb_bill_payment WHERE service_no=? AND month_year=?";
            ps = conn.prepareStatement(query);
            ps.setString(1, s_no);
            ps.setString(2, my);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                if (rs.getString("status").equals("paid")) {
                    return false;
                }
            }
        }
        return true;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        boolean snoVal = false;
        boolean dateVal = false;
        boolean stsVal = false;
        
        String sno = request.getParameter("s_no");
        String month = request.getParameter("month");
        try {
            snoVal = serviceValidation(sno);
            dateVal = dateValidation(sno, month);
            stsVal = statusValidation(sno, month);
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(con_pay_bill.class.getName()).log(Level.SEVERE, null, ex);
        }

        if (snoVal == true) {
            if (dateVal == true) {
                if (stsVal == true) {
                    request.setAttribute("serno", sno);
                    request.setAttribute("monthYear", month);
                    RequestDispatcher dispatcher = request.getRequestDispatcher("con_pay_next.jsp");
                    dispatcher.forward(request, response);
                } else {
                    msg = "payment already successfully...";
                }
            } else {
                msg = "Invalid date !!!!";
            }
        } else {
            msg = "Service number is invalid !!!!";
        }
        request.setAttribute("msg", msg);
        RequestDispatcher dispatcher = request.getRequestDispatcher("con_pay_bill.jsp");
        dispatcher.forward(request, response);
    }
}
