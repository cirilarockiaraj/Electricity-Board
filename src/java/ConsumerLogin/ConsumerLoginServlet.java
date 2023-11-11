/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package ConsumerLogin;

import connection.db;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author CIRIL AROCKIARAJ
 */
@WebServlet(name = "ConsumerLoginServlet", urlPatterns = {"/ConsumerLoginServlet"})
public class ConsumerLoginServlet extends HttpServlet {

    public void Lock_account(String user, String pass, String status) {
        try {
            Connection con = db.initializeDatabase();
            PreparedStatement ps;
            String sql = "INSERT INTO lockedaccounts(consumer_id, password, status) VALUES(?,?,?)";
            ps = con.prepareStatement(sql);
            ps.setString(1, user);
            ps.setString(2, pass);
            ps.setString(3, status);
            ps.executeUpdate();

        } catch (ClassNotFoundException | SQLException e) {

        }
    }

    public void checkStatus(String cid) {
        try {
            Connection con = db.initializeDatabase();
            PreparedStatement ps;
            String sql = "SELECT * FROM lockedaccounts WHERE NOW() > adding_time AND consumer_id=?";
            ps = con.prepareStatement(sql);
            ps.setString(1, cid);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                updateStatus(cid);
            }
        } catch (ClassNotFoundException | SQLException e) {

        }
    }

    public void updateStatus(String cid) {
        try {
            Connection con = db.initializeDatabase();
            PreparedStatement ps;
            String sql = "DELETE FROM lockedaccounts WHERE consumer_id=?";
            ps = con.prepareStatement(sql);
            ps.setString(1, cid);
            ps.executeUpdate();
        } catch (ClassNotFoundException | SQLException e) {

        }
    }

    public boolean currentStatus(String cid) {
        boolean flag=false;
        try {
            Connection con = db.initializeDatabase();
            PreparedStatement ps;
            String sql = "SELECT status FROM lockedaccounts WHERE consumer_id=?";
            ps = con.prepareStatement(sql);
            ps.setString(1, cid);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                flag = true;
            }
        } catch (ClassNotFoundException | SQLException e) {

        }
        return flag;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String conId = request.getParameter("conid");
        String pass = request.getParameter("pass");
        String destPage = "con_login.jsp";
        String msg = "";

        ConsumerDAO conDao = new ConsumerDAO();
        try {
            consumer consum = conDao.verifyData(conId, pass);

            HttpSession session = request.getSession(false);

            if (session.getAttribute("attempts") == null) {
                session.setAttribute("attempts", 1);
            }

            checkStatus(conId);

            if (currentStatus(conId) == true) {
                msg = "locked";
            } else {
                if (consum != null) {
                    session.removeAttribute("attempts");
                    session.setAttribute("con", consum);
                    destPage = "con_dashboard.jsp";
                } else {
                    msg = "error";
                    session.setAttribute("attempts", (int) session.getAttribute("attempts") + 1);
                    int attempt = (int) session.getAttribute("attempts");

                    if (attempt > 2) {
                        Lock_account(conId, pass, "locked");
                        session.removeAttribute("attempts");
                    }
                }

            }

        } catch (SQLException | ClassNotFoundException ex) {
            RequestDispatcher dispatcher = request.getRequestDispatcher("conerror-500.html");
            dispatcher.forward(request, response);
        }
        request.setAttribute("msg", msg);
        RequestDispatcher dispatcher = request.getRequestDispatcher(destPage);
        dispatcher.forward(request, response);

    }

}
