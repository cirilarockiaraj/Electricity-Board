<%@page import="connection.db"%>
<%@page import="java.sql.*"%>
<%
    try{
        Connection conn=db.initializeDatabase();
        String sql = "SELECT * FROM about";
        PreparedStatement statement = conn.prepareStatement(sql);
        ResultSet rs = statement.executeQuery();
        while (rs.next()) {
%>

<h5><%=rs.getString("title")%></h5>
<p><%=rs.getString("about")%></p>
<%
    }
}catch(Exception e){
out.print(e);
}
%>