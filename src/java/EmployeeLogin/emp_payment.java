/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package EmployeeLogin;

import connection.db;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
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
@WebServlet(name = "emp_payment", urlPatterns = {"/emp_payment"})
public class emp_payment extends HttpServlet {

    Connection conn;
    PreparedStatement ps;

    public int bill_no;
    public String service_no;
    public String name;
    public String unit;
    public String totAmt;
    public String getMonth_year;
    public String status;
    public String setStatus = "paid";
    public String sts;
    public String email;

    public boolean serviceValidation(String s_no) {
        try {
            conn=db.initializeDatabase();
            String query = "SELECT * FROM services";
            ps = conn.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                if (s_no.equals(rs.getString("service_no"))) {
                    return true;
                }
            }
        } catch (ClassNotFoundException | SQLException e) {

        }
        return false;
    }

    public boolean dateValidation(String s_no, String my) {

        try {
            conn=db.initializeDatabase();
            String query = "SELECT month_year FROM eb_bill_payment WHERE service_no=?";
            ps = conn.prepareStatement(query);
            ps.setString(1, s_no);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                if (my.equals(rs.getString("month_year"))) {
                    return true;
                }
            }
        } catch (ClassNotFoundException | SQLException e) {

        }
        return false;
    }

    public void statusValidation(String s_no, String my) {
        try {
            conn=db.initializeDatabase();
            String query = "SELECT status FROM eb_bill_payment WHERE service_no=? AND month_year=?";
            ps = conn.prepareStatement(query);
            ps.setString(1, s_no);
            ps.setString(2, my);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                sts = rs.getString("status");
            }
        } catch (ClassNotFoundException | SQLException e) {

        }
    }

    public void profile(String s_no) {
        try {
            conn=db.initializeDatabase();
            String query = "SELECT * FROM services WHERE service_no=?";
            ps = conn.prepareStatement(query);
            ps.setString(1, s_no);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                service_no = rs.getString("service_no");
                name = rs.getString("service_holder_name");
                email = rs.getString("email_id");
            }
        } catch (ClassNotFoundException | SQLException e) {

        }
    }

    public void BillDetail(String s_no) {
        try {
            conn=db.initializeDatabase();
            String query = "SELECT * FROM eb_bill_payment WHERE service_no=?";
            ps = conn.prepareStatement(query);
            ps.setString(1, s_no);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                bill_no = rs.getInt("bill_no");
                unit = rs.getString("unit_consumed");
                totAmt = rs.getString("total_amount");
                status = rs.getString("status");
                getMonth_year = rs.getString("month_year");
            }
        } catch (ClassNotFoundException | SQLException e) {

        }
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String msg;
        String s_no = request.getParameter("s_no");
        String month = request.getParameter("month");
        String year = request.getParameter("year");
        String my = month + year;
        

        boolean service = serviceValidation(s_no);
        boolean date = dateValidation(s_no, my);
        statusValidation(s_no, my);

        if (service == true) {
            if (date == true) {
                switch (sts) {
                    case "b100":
                        msg = "You don't need to pay for the unit is below 100 units";
                        break;
                    case "paid":
                        msg = "Already your payment successfully";
                        break;
                    case "unpaid":
                        try {
                        conn=db.initializeDatabase();
                        String query = "UPDATE eb_bill_payment SET status=? WHERE service_no=?";
                        ps = conn.prepareStatement(query);
                        ps.setString(1, setStatus);
                        ps.setString(2, s_no);
                        ps.executeUpdate();
                        msg = "Payment successfully";
                    } catch (ClassNotFoundException | SQLException e) {
                        msg = "" + e;
                    }
                    break;
                    default:
                        msg = "Fully subsidised by the Government";
                    break;
                }
            } else {
                msg = month + " month bill has not added yet";
            }
        } else {
            msg = "Service number is not valid";
        }
        statusValidation(s_no, my);
        profile(s_no);
        
        String message = ("Hi " + name + " your service number is(" + service_no + ") date " + my + " your payment successfully..");
        String sub = "Electricity bill payment successfully";
        
        BillDetail(s_no);
        mail m=new mail();
        try {
            m.send(email, sub, message);
        } catch (MessagingException ex) {
            Logger.getLogger(emp_payment.class.getName()).log(Level.SEVERE, null, ex);
        }
        request.setAttribute(
                "msg", msg);
        request.setAttribute(
                "bill_no", bill_no);
        request.setAttribute(
                "sNo", service_no);
        request.setAttribute(
                "name", name);
        request.setAttribute(
                "unit", unit);
        request.setAttribute(
                "totAmt", totAmt);
        request.setAttribute(
                "mon_yr", getMonth_year);
        request.setAttribute(
                "status", sts);
        request.getRequestDispatcher(
                "empSidePay.jsp").forward(request, response);
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

