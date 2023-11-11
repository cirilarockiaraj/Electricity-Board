<%@page import="connection.db"%>
<%@page import="java.sql.*"%>
<%
    PreparedStatement ps;
    String status = "readed";
    String id = request.getParameter("id");
    try {
        Connection conn=db.initializeDatabase();
        ps = conn.prepareStatement("UPDATE contact_msg SET status=? WHERE id = ?");
        ps.setString(1, status);
        ps.setString(2, id);
        ps.executeUpdate();
    } catch (Exception e) {
        out.print(e);
    }
    response.sendRedirect("../admin_message.jsp");
%>