<%@page import="java.util.Base64"%>
<%@page import="connection.db"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<%
    String id = null;
    id = request.getParameter("id");
    if (id != null) {
        try {
            Connection con = db.initializeDatabase();
            String sql = "DELETE FROM gallery WHERE id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            out.print(e);
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <%    response.setHeader("Cache-Control", "no-cache");
            response.setHeader("Cache-Control", "no-store");
            response.setDateHeader("Expires", 0);
            response.setHeader("Pragma", "no-cache");
            if (session.getAttribute("ad") == null) {
                response.sendRedirect("adminerror-404.html");
            }
        %>
        <script>history.forward();</script>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Electricity Board | Admin</title>

        <!-- plugins:css -->
        <link rel="stylesheet" href="page_components/vendors/mdi/css/materialdesignicons.min.css">
        <link rel="stylesheet" href="page_components/vendors/css/vendor.bundle.base.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" />
        <link rel="stylesheet" href="page_components/css/style.css">
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <link rel="shortcut icon" href="image/light.ico" />
    </head>
    <body>
        <div class="container-scroller">
            <!-- partial:../../partials/_navbar.html -->
            <jsp:include page="includes/admin_dashboard_header.jsp"></jsp:include>
                <!-- partial -->
                <div class="container-fluid page-body-wrapper">
                    <!-- partial:../../partials/_sidebar.html -->
                <jsp:include page="includes/admin_dashboard_sidebar.jsp"></jsp:include>


                    <div class="main-panel">
                        <div class="content-wrapper">
                            <h2>Controls</h2>
                            <label class="alert-success">${msg}</label><br>
                        <%
                            String res = "";
                            if (request.getParameter("update_about") != null) {
                                String title = request.getParameter("title");
                                String about = request.getParameter("about");

                                try {
                                    Connection conn = db.initializeDatabase();
                                    String query = "UPDATE about SET title=?, about=?";
                                    PreparedStatement ps = conn.prepareStatement(query);
                                    ps.setString(1, title);
                                    ps.setString(2, about);
                                    ps.executeUpdate();
                                    res = "Page updated successfully....";

                                } catch (Exception e) {
                                    out.print(e);
                                }
                            }
                        %>
                        <br>
                        <details class="bg-light p-3">
                            <summary><b>Edit the about page</b></summary>
                            <!--adding new admin panel-->

                            <div class="row p-3">
                                <div class="col-md-12 grid-margin stretch-card">
                                    <div class="card">
                                        <div class="card-body">
                                            <h3 class="card-title">Update about page</h3><br>
                                            <form method="post">
                                                <div class="form-group">
                                                    <p class="text-success"><%out.print(res);%></p>
                                                </div>
                                                <div class="form-group">
                                                    <label>Enter sub title</label>
                                                    <%
                                                        try {
                                                            Connection conn = db.initializeDatabase();
                                                            PreparedStatement ps1 = conn.prepareStatement("select * from about");
                                                            ResultSet rs1 = ps1.executeQuery();
                                                            while (rs1.next()) {
                                                    %>
                                                    <input type="text" name="title" value="<%out.print(rs1.getString("title"));%>" class="form-control">
                                                </div>
                                                <div class="form-group">

                                                    <textarea class="form-control border-2" name="about" width="100" rows="8"><%out.print(rs1.getString("about"));%></textarea>
                                                    <%
                                                            }
                                                        } catch (Exception e) {
                                                            out.print(e);
                                                        }
                                                    %>
                                                </div>
                                                <div class="form-group">
                                                    <button type="submit" name="update_about" class="btn btn-gradient-primary me-2">Update</button>
                                                    <button class="btn btn-gradient-danger" type="reset">Clear</button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </details>
                        <hr>
                        <%--upload galary images--%>
                        <details class="bg-light p-3">
                            <summary><b>Upload images for gallery</b></summary><br>
                            <form action="galleryUploader" method="POST" enctype="multipart/form-data">
                                <div class="form-group">
                                    <label for="image" class="form-label">Select image</label>
                                    <input type="file" name="image" id="id" class="form-control w-50" accept="image/png,image/jpeg" required="">
                                </div>
                                <div class="form-group">
                                    <input type="submit" value="Upload" class="btn btn-gradient-success">
                                </div>
                                <!<!-- Show images -->
                                <div class="row">
                                    <%
                                        Blob image = null;
                                        byte[] imgData = null;
                                        String encImg = null;
                                        String pic = null;
                                        try {
                                            Connection con = db.initializeDatabase();
                                            String sql = "SELECT * FROM gallery";
                                            PreparedStatement ps = con.prepareStatement(sql);
                                            ResultSet rs = ps.executeQuery();

                                            while (rs.next()) {
                                                String ids=rs.getString("id");
                                                image = rs.getBlob("images");
                                                imgData = image.getBytes(1, (int) image.length());
                                                encImg = Base64.getEncoder().encodeToString(imgData);
                                                pic = "data:image/jpg;base64," + encImg;
                                    %>
                                    <div class="col-1">
                                        <a href="controls.jsp?id=<%=ids%>" class="col-sm-4 p-1">
                                            <img src="<%=pic%>" class="img-fluid h-100 w-100">
                                            <span>Delete?</span>
                                        </a>
                                    </div>
                                    <%
                                            }
                                        } catch (Exception e) {
                                            out.print(e);
                                        }
                                    %>
                                </div>
                            </form>
                        </details>
                        <hr>
                        <%--update contact page detail--%>
                        <details class="bg-light p-3">
                            <summary><b>Update contact details</b></summary><br>
                                <%
                                    String address = "", contact = "", email = "";
                                    try {
                                        Connection con = db.initializeDatabase();
                                        String sql = "SELECT * FROM contact";
                                        PreparedStatement ps = con.prepareStatement(sql);
                                        ResultSet rs = ps.executeQuery();
                                        if (rs.next()) {
                                            address = rs.getString(2);
                                            contact = rs.getString(3);
                                            email = rs.getString(4);
                                        }
                                    } catch (Exception e) {
                                        out.print(e);
                                    }
                                %>
                            <form action="updateContact" method="POST">
                                <div class="form-group">
                                    <label for="image" class="form-label">Location</label>
                                    <div class="input-group w-50">
                                        <span class="input-group-text"><i class="mdi mdi-map-marker"></i></span>
                                        <textarea name="address" class="form-control" required=""><%=address%></textarea>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="image" class="form-label">Contact number</label>
                                    <div class="input-group w-50">
                                        <span class="input-group-text"><i class="mdi mdi-phone"></i></span>
                                        <input type="text" name="contact" value="<%=contact%>" class="form-control" required="">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="image" class="form-label">Email</label>
                                    <div class="input-group w-50">
                                        <span class="input-group-text"><i class="mdi mdi-email"></i></span>
                                        <input type="text" name="email" value="<%=email%>" class="form-control" required="">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <input type="submit" value="Update" class="btn btn-gradient-primary">
                                </div>
                            </form>
                        </details>
                    </div>
                    <footer>
                        <jsp:include page="includes/footer.jsp"></jsp:include>
                    </footer>
                </div>
            </div>
        </div>
    </body>


    <script src="page_components/vendors/js/vendor.bundle.base.js"></script>
    <script src="page_components/js/off-canvas.js"></script>
    <script src="page_components/js/hoverable-collapse.js"></script>
    <script src="page_components/js/misc.js"></script>

</html>