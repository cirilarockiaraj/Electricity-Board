<%@page import="ConsumerLogin.consumer"%>
<%@page import="connection.db"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang="en">
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Consumer | Complaint history</title>

        <%  response.setHeader("Cache-Control", "no-cache");
            response.setHeader("Cache-Control", "no-store");
            response.setDateHeader("Expires", 0);
            response.setHeader("Pragma", "no-cache");
            if (session.getAttribute("con") == null)
                response.sendRedirect("con_login.jsp");
        %>
        <script>history.forward();</script>

        <!-- plugins:css -->
        <link rel="stylesheet" href="page_components/vendors/mdi/css/materialdesignicons.min.css">
        <link rel="stylesheet" href="page_components/vendors/css/vendor.bundle.base.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" />
        <link rel="stylesheet" href="page_components/css/style.css">
        <!-- End layout styles -->
        <link rel="shortcut icon" href="image/light.ico" />
    </head>
    <style>
        .table {
            display: block;
            overflow-x: auto;
            white-space: nowrap;
        }
    </style>
    <body>

        <div class="container-scroller">
            <!-- partial:../../partials/_navbar.html -->
            <jsp:include page="includes/con_dashboard_header.jsp"></jsp:include>
                <!-- partial -->
                <div class="container-fluid page-body-wrapper">
                    <!-- partial:../../partials/_sidebar.html -->
                <jsp:include page="includes/con_dashboard_sidebar.jsp"></jsp:include>
                    <div class="main-panel">
                        <div class="content-wrapper">
                            <h3 class="page-title">
                                <span class="page-title-icon bg-gradient-primary text-white me-2">
                                    <i class="mdi mdi-file-document-box"></i>
                                </span> 
                                Complaint history
                            </h3>
                            <br><br>
                            <!--Row-->

                            <div class="row">
                                <div class="col-md-12 grid-margin stretch-card">
                                    <div class="card">
                                        <div class="card-body">
                                            <table class="table table-hover w-100">
                                                <thead>
                                                <th>Sno</th>
                                                <th>Service number</th>
                                                <th>Name</th>
                                                <th>Your complaint</th>
                                                <th>Date and time</th>
                                                <th>Status</th>
                                                </thead>
                                            <%
                                                int num = 0;
                                                consumer con = (consumer) session.getAttribute("con");
                                                String sno = con.getServiceNo();
                                                try {
                                                    Connection conn = db.initializeDatabase();
                                                    String sql = "SELECT * FROM compliants WHERE service_no=? ORDER BY id DESC";
                                                    PreparedStatement ps = conn.prepareStatement(sql);
                                                    ps.setString(1, sno);
                                                    ResultSet rs = ps.executeQuery();
                                                    while (rs.next()) {
                                                        num += 1;
                                            %>
                                            <tbody>

                                            <td><%=num%></td>
                                            <td><%=rs.getString("service_no")%></td>
                                            <td><%=rs.getString("name")%></td>
                                            <td><%=rs.getString("compliant")%></td>
                                            <td><%=rs.getString("reg_time")%></td>
                                            <td>
                                                <%
                                                    String sts = rs.getString("status");
                                                    if (sts.equals("pending")) {
                                                %>
                                                <label class="badge badge-danger">Pending</label>
                                                <%
                                                } else if (sts.equals("In progress")) {
                                                %>
                                                <label class="badge badge-warning">In progress</label>
                                                <%
                                                } else {
                                                %>
                                                <label class="badge badge-success">Completed</label>
                                                <%
                                                    }
                                                %>
                                            </td>

                                            </tbody>
                                            <%
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
                    <footer>
                        <jsp:include page="includes/footer.jsp"></jsp:include>
                    </footer>
                </div>

                <script src="page_components/vendors/js/vendor.bundle.base.js"></script>
                <script src="page_components/js/off-canvas.js"></script>
                <script src="page_components/js/hoverable-collapse.js"></script>
                <script src="page_components/js/misc.js"></script>
                <script src="https://www.gstatic.com/charts/loader.js"></script>
                <script>window.oncontextmenu = function () {
                return false;
            }</script>
            </div>
    </body>
</html>