package ConsumerLogin;

import connection.db;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.MessagingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import mailer.mail;

@WebServlet(name = "message_send", urlPatterns = {"/message_send"})
public class message_send extends HttpServlet {

    String msg;

    Connection conn;
    PreparedStatement ps;

    public int bill_no;
    public String id;
    public String service_no;
    public String name;
    public String unit;
    public String totAmt;
    public String getMonth_year;
    public String status;
    public String setStatus = "paid";
    public String sts;
    public String amt;

    public void statusValidation(String s_no, String my) {
        try {
            conn = db.initializeDatabase();
            String query = "SELECT status FROM eb_bill_payment WHERE service_no=? AND month_year=?";
            ps = conn.prepareStatement(query);
            ps.setString(1, s_no);
            ps.setString(2, my);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                sts = rs.getString("status");
                amt = rs.getString("total_amount");
            }
        } catch (ClassNotFoundException | SQLException e) {

        }
    }

    public void BillDetail(String s_no) {
        try {
            conn = db.initializeDatabase();
            String query = "SELECT * FROM eb_bill_payment WHERE service_no=?";
            ps = conn.prepareStatement(query);
            ps.setString(1, s_no);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                id = rs.getString("id");
                bill_no = rs.getInt("bill_no");
                unit = rs.getString("unit_consumed");
                totAmt = rs.getString("total_amount");
                status = rs.getString("status");
                getMonth_year = rs.getString("month_year");
            }
        } catch (ClassNotFoundException | SQLException e) {

        }
    }

    public void insert_card(String cname, long cno, int cvv, String expDate) {
        try {
            conn = db.initializeDatabase();
            String query = "INSERT INTO card_details(card_holder_name, card_number, cvv, expiry_date) VALUES(?,?,?,?)";
            ps = conn.prepareStatement(query);
            ps.setString(1, cname);
            ps.setLong(2, cno);
            ps.setInt(3, cvv);
            ps.setString(4, expDate);
            ps.executeUpdate();
        } catch (ClassNotFoundException | SQLException e) {

        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        PrintWriter out = response.getWriter();
        //mail particulars

        String service_no = request.getParameter("service");
        String pay_month = request.getParameter("monthYear");

        //general information
        String name = request.getParameter("name");
        String email = request.getParameter("email");

        //card information
        String card_holder_name = request.getParameter("card_holder_name");
        long card_no = Long.parseLong(request.getParameter("card_no"));
        int cvv = Integer.parseInt(request.getParameter("cvv"));
        String exp_month = request.getParameter("month");
        String exp_year = request.getParameter("year");
        int year = Integer.parseInt(exp_year);
        String date = exp_month + exp_year;

        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy");
        LocalDateTime now = LocalDateTime.now();
        int currentYear = Integer.parseInt(dtf.format(now));
        
        String page="con_pay_next.jsp";

        String message = ("Hi " + name + " your service number is(" + service_no + ") date " + pay_month + " your payment successfully..");
        String sub = "Electricity bill payment successfully";

        statusValidation(service_no, pay_month);

        if (card_no < 12) {
            msg = "Card number invalid";

            request.setAttribute("msg", msg);
            response.sendRedirect("con_pay_next.jsp");
        } else {
            if (cvv < 3) {
                msg = "Invalid cvv";

                request.setAttribute("msg", msg);
                response.sendRedirect("con_pay_next.jsp");
            } else {
                switch (sts) {
                    case "b100":
                        msg = "You don't need to pay, for the unit is below 100 units";
                        request.setAttribute("msg", msg);
                        response.sendRedirect("con_pay_next.jsp");
                        break;
                    case "paid":
                        msg = "Already your payment successfully";
                        request.setAttribute("msg", msg);
                        response.sendRedirect("con_pay_next.jsp");
                        break;
                    case "unpaid":
                        if (year >= currentYear) {
                            try {
                                conn = db.initializeDatabase();
                                String query = "UPDATE eb_bill_payment SET status=? WHERE service_no=? AND month_year=?";
                                ps = conn.prepareStatement(query);
                                ps.setString(1, setStatus);
                                ps.setString(2, service_no);
                                ps.setString(3, pay_month);
                                ps.executeUpdate();

                                insert_card(card_holder_name, card_no, cvv, date);
                                mail m = new mail();
                                boolean res = m.send(email, sub, message);
                                if (res == true) {
                                    page="con_transaction.jsp";
                                } else {
                                    msg = "Failed to payment";
                                }
                            } catch (ClassNotFoundException | SQLException e) {
                                msg = "" + e;
                            } catch (MessagingException ex) {
                                Logger.getLogger(message_send.class.getName()).log(Level.SEVERE, null, ex);
                            }
                        }
                        else{
                            msg="Card is expired please use any other card!";
                        }
                        break;

                    default:
                        msg = "Fully subsidised by the Government";
                        request.setAttribute("msg", msg);
                        response.sendRedirect("con_transaction.jsp");
                        break;
                }
            }
        }
        request.setAttribute("msg", msg);
        RequestDispatcher dispatcher=request.getRequestDispatcher(page);
        dispatcher.forward(request, response);
    }
}
