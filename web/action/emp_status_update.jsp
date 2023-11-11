<%@page import="mailer.mail"%>
<%@page import="connection.db"%>
<%@page import="java.sql.*"%>
<%
    PreparedStatement ps;
    String status = "Live";
    String id = request.getParameter("id");
    
    String email = "";
    String name = "";
    String service_no = "";
    String con_type = "";
    
    try {
        Connection conn=db.initializeDatabase();
        ps = conn.prepareStatement("UPDATE services SET status=? WHERE id = ?");
        ps.setString(1, status);
        ps.setString(2, id);
        ps.executeUpdate();
    } catch (Exception e) {
        out.print(e);
    }
    try {
        Connection conn = db.initializeDatabase();
        ps = conn.prepareStatement("SELECT * FROM services WHERE id=?");
        ps.setString(1, id);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            email = rs.getString("email_id");
            name = rs.getString("service_holder_name");
            service_no = rs.getString("service_no");
            con_type = rs.getString("connection_type");
        }
    } catch (Exception ex) {
        out.print(ex);
    }
    mail m = new mail();
    boolean res = m.send(email, "Electricity Board", "Hi " + name + " your service number is : " + service_no + " your service type is : " + con_type + " and Your service activated successfully.\n\n Thankyou..");
    if (res == true) {
        response.sendRedirect("../emp_view_connection.jsp");
    }
    else{
        response.sendRedirect("../emp_view_connection.jsp");
    }
%>