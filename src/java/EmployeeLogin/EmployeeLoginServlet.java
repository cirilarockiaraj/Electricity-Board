package EmployeeLogin;

import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/Employeelogin")
public class EmployeeLoginServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String empid = request.getParameter("empid");
        String pass = request.getParameter("pass");
        EmployeeDAO empDao = new EmployeeDAO();

        try {
            employee employee = empDao.checkLogin(empid, pass);
            String destPage="emp_login.jsp";

            if (employee != null) {
                HttpSession session = request.getSession(false);
                session.setAttribute("emp", employee);
                destPage = "emp_dashboard.jsp";
            } else {
                request.setAttribute("msg", "error");
                RequestDispatcher dispatcher = request.getRequestDispatcher(destPage);
                dispatcher.forward(request, response);
            }
            request.setAttribute("msg", "error");
            RequestDispatcher dispatcher = request.getRequestDispatcher(destPage);
            dispatcher.forward(request, response);

        } catch (IOException | ClassNotFoundException | SQLException | ServletException e) {
            RequestDispatcher dispatcher = request.getRequestDispatcher("emperror-500.html");
            dispatcher.forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
