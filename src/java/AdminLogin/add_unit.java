package AdminLogin;

import connection.db;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.time.YearMonth;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "add_unit", urlPatterns = {"/add_unit"})
public class add_unit extends HttpServlet {

    Connection conn;
    PreparedStatement ps;

    public boolean serviceValidation(String s_no) {
        try {
            conn = db.initializeDatabase();
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

    public boolean checkStatus(String s_no) {
        try {
            conn = db.initializeDatabase();
            String query = "SELECT status FROM services WHERE service_no=?";
            ps = conn.prepareStatement(query);
            ps.setString(1, s_no);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                if (rs.getString("status").equals("Live")) {
                    return true;
                }
            }
        } catch (ClassNotFoundException | SQLException e) {

        }
        return false;
    }

    public boolean checkConType(String s_no, String s_type) {
        try {
            conn = db.initializeDatabase();
            String query = "SELECT connection_type FROM services WHERE service_no=?";
            ps = conn.prepareStatement(query);
            ps.setString(1, s_no);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                if (s_type.equals(rs.getString("connection_type"))) {
                    return true;
                }
            }
        } catch (ClassNotFoundException | SQLException e) {

        }
        return false;
    }

    public boolean unit_val(String s_no, String my) {
        try {
            conn = db.initializeDatabase();
            String query = "SELECT month_year FROM eb_bill_payment WHERE service_no=? AND month_year=?";
            ps = conn.prepareStatement(query);
            ps.setString(1, s_no);
            ps.setString(2, my);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return false;
            }
        } catch (ClassNotFoundException | SQLException e) {

        }
        return true;
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
        PrintWriter out = response.getWriter();

        double amt;
        double tot;
        double fixAmt;
        String status;
        int no;
        int bill_no = 0;
        String msg = "";

        int yre = YearMonth.now().getYear();
        String year = Integer.toString(yre);

        double unit = Double.parseDouble(request.getParameter("unit"));
        String s_type = request.getParameter("s_type");
        String s_no = request.getParameter("s_no");
        String month = request.getParameter("month");
        String my = month + year;

        //unit calculation
        switch (s_type) {
            case "LL1A":
                if (unit <= 100) {
                    amt = 0;
                    fixAmt = 0;
                    status = "b100";
                } else if (unit <= 200) {
                    amt = (unit - 100) * 1.5;
                    fixAmt = 20;
                    status = "unpaid";
                } else if (unit <= 500) {
                    amt = (200 - 100) * 2 + (unit - 200) * 3;
                    fixAmt = 30;
                    status = "unpaid";
                } else {
                    amt = (200 - 100) * 3.50 + (500 - 200) * 4.60 + (unit - 500) * 6.60;
                    fixAmt = 50;
                    status = "unpaid";
                }
                tot = amt + fixAmt;
                break;
            /*unit calculation*/
            case "LL1B":
                amt = unit * 0;
                fixAmt = 0;
                status = "govt";
                tot = amt + fixAmt;
                break;
            case "LL1C":
                amt = unit * 4.60;
                fixAmt = 120;
                status = "unpaid";
                tot = amt + fixAmt;
                break;
            case "LL2A":
                amt = unit * 6.35;
                fixAmt = 120 / (unit / 1000);
                status = "unpaid";
                tot = amt + fixAmt;
                break;
            case "LL2B1":
                amt = unit * 5.75;
                fixAmt = 120 / (unit / 1000);
                status = "unpaid";
                tot = amt + fixAmt;
                break;
            case "LL2B2":
                amt = unit * 5.75;
                fixAmt = 120 / (unit / 1000);
                status = "unpaid";
                tot = amt + fixAmt;
                break;
            case "LL2C":
                amt = unit * 2.85;
                fixAmt = 120 / (unit / 1000);
                status = "unpaid";
                tot = amt + fixAmt;
                break;
            case "LL3A1":
                if (unit <= 500) {
                    amt = unit * 4.00;
                    fixAmt = 40 / (unit / 1000);
                    status = "unpaid";
                } else {
                    amt = unit * 4.60;
                    fixAmt = 40 / (unit / 1000);
                    status = "unpaid";
                }
                tot = amt + fixAmt;
                break;
            case "LL3A2":
                if (unit <= 750) {
                    amt = 0;
                    fixAmt = 0;
                    status = "govt";
                } else if (unit > 750 && unit <= 1000) {
                    amt = unit * 2.30;
                    fixAmt = 70 / (unit / 1000);
                    status = "unpaid";
                } else if (unit > 1000 && unit <= 1500) {
                    amt = unit * 3.45;
                    fixAmt = 70 / (unit / 1000);
                    status = "unpaid";
                } else {
                    amt = unit * 4.60;
                    fixAmt = 70 / (unit / 1000);
                    status = "unpaid";
                }
                tot = amt + fixAmt;
                break;
            case "LL3B":
                amt = unit * 6.35;
                fixAmt = 70 / (unit / 1000);
                status = "unpaid";
                tot = amt + fixAmt;
                break;
            case "LL4":
                amt = 0;
                fixAmt = 0;
                status = "govt";
                tot = amt + fixAmt;
                break;
            case "LL5":
                if (unit <= 100) {
                    amt = unit * 5.00;
                    fixAmt = 140 / (unit / 1000);
                    status = "unpaid";
                    tot = amt + fixAmt;
                } else {
                    amt = unit * 8.05;
                    fixAmt = 140 / (unit / 1000);
                    status = "unpaid";
                    tot = amt + fixAmt;
                }
                break;
            case "LL6":
                amt = unit * 12.00;
                fixAmt = 690 / (unit / 1000);
                status = "unpaid";
                tot = amt + fixAmt;
                break;
            default:
                switch (s_type) {
                    case "HL1":
                        amt = unit * 6.35;
                        fixAmt = 350;
                        status = "unpaid";
                        break;
                    case "HL2":
                        amt = unit * 6.35;
                        fixAmt = 350;
                        status = "unpaid";
                        break;
                    case "HL3":
                        amt = unit * 8.00;
                        fixAmt = 350;
                        status = "unpaid";
                        break;
                    case "HL4":
                        amt = unit * 0;
                        fixAmt = 0;
                        status = "govt";
                        break;
                    default:
                        amt = unit * 11.0;
                        fixAmt = 350;
                        status = "unpaid";
                        break;
                }
                tot = amt + fixAmt;
                break;
        }

        //Generate bill number
        try {
            conn = db.initializeDatabase();
            String query = "SELECT bill_no FROM eb_bill_payment ORDER BY bill_no DESC LIMIT 1";
            ps = conn.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                no = rs.getInt("bill_no");
                no = no + 1;
                bill_no = no;
            } else {
                bill_no = 100;
            }
        } catch (ClassNotFoundException | SQLException e) {
            out.print(e);
        }
        /*Generate bill number*/

        //check the service number
        boolean ser = serviceValidation(s_no);

        //check the status
        boolean st = checkStatus(s_no);

        //check connection type
        boolean type = checkConType(s_no, s_type);

        boolean unit_check = unit_val(s_no, my);

        if (ser == true) {
            if (st == true) {
                if (type == true) {
                    if (unit_check == true) {
                        try {
                            conn = db.initializeDatabase();
                            String query1 = "INSERT INTO eb_bill_payment(service_no, bill_no, unit_consumed, total_amount, status, month_year) VALUES (?,?,?,?,?,?)";
                            ps = conn.prepareStatement(query1);
                            ps.setString(1, s_no);
                            ps.setInt(2, bill_no);
                            ps.setDouble(3, unit);
                            ps.setDouble(4, tot);
                            ps.setString(5, status);
                            ps.setString(6, my);
                            int res = ps.executeUpdate();
                            if (res > 0) {
                                msg = "Unit added successfully";
                            }
                        } catch (ClassNotFoundException | SQLException e) {
                            out.print(e);
                        }
                    } else {
                        msg = "Already unit added successfully..";
                    }
                } else {
                    msg = "Connection type mismatched";
                }
            } else {
                msg = "Service is not activated";
            }
        } else {
            msg = "Service number mismatched";
        }

        request.setAttribute("tot", tot);
        request.setAttribute("msg", msg);
        request.getRequestDispatcher("add_unit.jsp").forward(request, response);
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
