<%@page import="java.util.Base64"%>
<%@page import="java.sql.*"%>
<%@page import="connection.db"%>
<div class="row">
    <%
        Blob image = null;
        byte[] imgData = null;
        String encImg = null;
        String pic = null;
        try {
            Connection con = db.initializeDatabase();
            String sql = "SELECT images FROM gallery";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                image = rs.getBlob("images");
                imgData = image.getBytes(1, (int) image.length());
                encImg =Base64.getEncoder().encodeToString(imgData);
                pic="data:image/jpg;base64,"+encImg;
    %>
    <a href="<%=pic%>" data-toggle="lightbox" data-gallery="example-gallery" class="col-sm-4 p-1">
        <img src="<%=pic%>" class="img-fluid h-100">
    </a>
    <%            
            }
        } catch (Exception e) {
            out.print(e);
        }
    %>
</div>
<br>