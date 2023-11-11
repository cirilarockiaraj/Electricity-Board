<%@page import="connection.db"%>
<%@page import="java.sql.*"%>
<%
    PreparedStatement ps;
    String id = request.getParameter("id");
    try {
        Connection conn=db.initializeDatabase();
        ps = conn.prepareStatement("DELETE FROM services WHERE id=?");
        ps.setString(1, id);
        ps.executeUpdate();
    } catch (Exception e) {
        out.print(e);
    }
    response.sendRedirect("../emp_view_connection.jsp");
%>