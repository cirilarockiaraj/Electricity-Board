<%@page import="java.util.Base64"%>
<%@page import="java.io.OutputStream"%>
<%@page import="connection.db"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%!
    String status = null;
%>
<%
    if (request.getParameter("searchBtn") != null) {
        status = request.getParameter("searchData");
    }
%>



<!DOCTYPE html>
<html lang="en">
    <head>
        <%
            response.setHeader("Cache-Control", "no-cache");
            response.setHeader("Cache-Control", "no-store");
            response.setDateHeader("Expires", 0);
            response.setHeader("Pragma", "no-cache");
            if (session.getAttribute("ad") == null)
                response.sendRedirect("adminerror-404.html");
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
        <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <!-- End layout styles -->
        <link rel="shortcut icon" href="image/light.ico" />

        <style>
            table {
                display: block;
                overflow-x: auto;
                white-space: nowrap;
            }
        </style>

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
                            <h3 class="page-title">
                                <span class="page-title-icon bg-gradient-primary text-white me-2">
                                    <i class="mdi mdi mdi-account-card-details"></i>
                                </span> 
                                Aathar data
                            </h3>

                            <!--adding new admin panel-->

                            <div class="col-12 grid-margin stretch-card">
                                <div class="card p-3">
                                    <div class="card-body">
                                        <div class="input-group mb-3">
                                            <form method="POST" action="">
                                                <div class="input-group">
                                                    <div class="form-outline">
                                                        <input type="search" name="searchData" class="form-control" placeholder="Search the status of complaint"/>
                                                    </div>
                                                    <button type="submit" name="searchBtn" class="btn btn-primary btn-sm">
                                                        <i class="fas fa-search"></i>
                                                    </button>
                                                </div>
                                            </form>
                                        </div>
                                        <table class="w-100" cellpadding="12" id="myTable">
                                            <thead>
                                            <th>Service number</th>
                                            <th>Name</th>
                                            <th>Aathar number</th>
                                            <th>Aathar card</th>
                                            <th>Contact number</th>
                                            <th>Email ID</th>
                                            <th>Register time</th>
                                            <th>Action</th>
                                            <th>Delete?</th>
                                            </thead>
                                        <%
                                            Blob image = null;
                                            byte[] imgData = null;
                                            String encodeImg = null;
                                            String pic = null;
                                            try {
                                                Connection conn = db.initializeDatabase();
                                                String sql = "";
                                                if (status != null) {
                                                    sql = "SELECT * FROM aathar_data WHERE status LIKE '" + status + "%' OR service_no LIKE '%"+status+"%'";
                                                    status = null;
                                                } else {
                                                    status = null;
                                                    sql = "SELECT * FROM aathar_data ORDER BY id DESC";
                                                }
                                                status = null;
                                                PreparedStatement ps = conn.prepareStatement(sql);
                                                ResultSet rs = ps.executeQuery();
                                                status = null;
                                                while (rs.next()) {
                                                    int id = rs.getInt("id");
                                                    image = rs.getBlob("aathar");
                                                    imgData = image.getBytes(1, (int) image.length());
                                                    encodeImg = Base64.getEncoder().encodeToString(imgData);
                                                    pic = "data:image/jpg;base64," + encodeImg;
                                        %>
                                        <tbody>
                                        <td><%=rs.getString("service_no")%></td>
                                        <td><%=rs.getString("name")%></td>
                                        <td><%=rs.getString("aathar_no")%></td>
                                        <td>
                                            <a href="#" onclick="image('<%=pic%>')">
                                                <img src="<%=pic%>" style="width:100px; height: 50px;" alt="Error"/>
                                            </a>
                                        </td>
                                        <td><%=rs.getString("contact_no")%></td>
                                        <td><%=rs.getString("email")%></td>
                                        <td><%=rs.getString("reg_date_time")%></td>
                                        <td>
                                            <%
                                                String sts = rs.getString("status");
                                                if (sts.equals("pending")) {
                                            %>
                                            <a href="aathar_detail?id=<%=id%>&&btn=accept" class="badge badge-success text-decoration-none text-light">Accept</a>
                                            <a href="aathar_detail?id=<%=id%>&&btn=reject" class="badge badge-danger text-decoration-none text-light">Reject</a>
                                            <%
                                            } else if (sts.equals("accepted")) {
                                            %>
                                            <label class="badge badge-success">Accepted</label>
                                            <%
                                            } else {
                                            %>
                                            <label class="badge badge-danger">Rejected</label>
                                            <%
                                                }
                                            %>
                                        </td>
                                        <td>
                                            <a href="aathar_detail?id=<%=id%>&&btn=delete" class="badge badge-danger text-decoration-none text-light">Delete</a>
                                        </td>
                                        </tbody>
                                        <%
                                                    status = null;
                                                }
                                            } catch (Exception e) {
                                                out.print(e);
                                            }
                                        %>
                                    </table>
                                </div>
                            </div> 
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <footer>
            <jsp:include page="includes/footer.jsp"></jsp:include>
        </footer>
    </div>
</body>


<script src="page_components/vendors/js/vendor.bundle.base.js"></script>
<script src="page_components/js/off-canvas.js"></script>
<script src="page_components/js/hoverable-collapse.js"></script>
<script src="page_components/js/misc.js"></script>
<script src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.11.3/js/dataTables.bootstrap5.min.js"></script>

<script>
            function image(pics) {
                Swal.fire({
                    title: '',
                    text: '',
                    imageUrl: pics,
                    imageWidth: 500,
                    imageHeight: 250,
                    imageAlt: 'Image error',
                });
            }
</script>

</html>