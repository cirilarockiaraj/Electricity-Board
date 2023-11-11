<%@page import="connection.db"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Electricity Board | Admin</title>

        <!-- plugins:css -->
        <link rel="stylesheet" type="text/css" href="page_components/vendors/mdi/css/materialdesignicons.min.css">
        <link rel="stylesheet" type="text/css" href="page_components/vendors/css/vendor.bundle.base.css">
        <link rel="stylesheet" type="text/css" href="page_components/css/style.css">
        <link rel="stylesheet" type="text/css" href="css/design.min.css">
        <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" />
        <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.1.3/css/bootstrap.min.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.3/css/dataTables.bootstrap5.min.css"/>
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/buttons/2.2.3/css/buttons.bootstrap5.min.css">
        <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.12.1/js/jquery.dataTables.js"></script>
        <script src="js/jquery.js"></script>
        <link rel="shortcut icon" href="image/light.ico" />

        <style>
            .table {
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
                            <h2>Requests</h2>

                            <!--adding new admin panel-->

                            <div class="col-12 grid-margin stretch-card">
                                <div class="card">
                                    <div class="card-body">
                                        <br><br>
                                        <table class="table table-striped table-hover" id="list" width="100%">
                                            <thead class="table-dark">
                                            <th> Request number </th>
                                            <th> Connection Type</th>
                                            <th> Service holder name </th>
                                            <th> Father's name </th>
                                            <th> Occupation </th>
                                            <th> Gender </th>
                                            <th> Date of birth </th>
                                            <th> house number </th>
                                            <th> village/city name </th>
                                            <th> District </th>
                                            <th> State </th>
                                            <th> Country </th>
                                            <th> Pin code </th>
                                            <th> Contact no </th>
                                            <th> Additional contact no </th>
                                            <th> Email ID </th>
                                            <th> Action </th>
                                            </thead>
                                            <tbody>
                                            <%
                                                try {
                                                    Connection conn = db.initializeDatabase();
                                                    String sql = "SELECT * FROM services WHERE status=? OR status=?";
                                                    PreparedStatement statement = conn.prepareStatement(sql);
                                                    statement.setString(1, "pending");
                                                    statement.setString(2, "wait");
                                                    ResultSet rs = statement.executeQuery();
                                                    while (rs.next()) {
                                                        String id = rs.getString("id");
                                            %>
                                            <tr>
                                                <td> <%= rs.getString("req_no")%> </td>
                                                <td> <%= rs.getString("connection_type")%> </td>
                                                <td> <%= rs.getString("service_holder_name")%> </td>
                                                <td> <%= rs.getString("father_name")%> </td>
                                                <td> <%= rs.getString("occupation")%> </td>
                                                <td> <%= rs.getString("gender")%> </td>
                                                <td> <%= rs.getString("date_of_birth")%> </td>
                                                <td> <%= rs.getString("house_no")%> </td>
                                                <td> <%= rs.getString("city_village_town_name")%> </td>
                                                <td> <%= rs.getString("district")%> </td>
                                                <td> <%= rs.getString("state")%> </td>
                                                <td> <%= rs.getString("country")%> </td>
                                                <td> <%= rs.getString("pincode")%> </td>
                                                <td> <%= rs.getString("mobile_no")%> </td>
                                                <td> <%= rs.getString("additional_mobile_no")%> </td>
                                                <td> <%= rs.getString("email_id")%> </td>
                                                <td>
                                                    <%if (rs.getString("status").equals("wait")) {%>
                                                    <a class="btn btn-gradient-primary" href="action/status_update.jsp?id=<%=id%>&&action=recover">Recover ?</a>
                                                    <%} else {%>
                                                    <a class="btn btn-gradient-success" href="action/status_update.jsp?id=<%=id%>&&action=activate">Activate</a>
                                                    <a class="btn btn-gradient-warning" href="action/status_update.jsp?id=<%=id%>&&action=wait">Wait</a>
                                                    <a class="btn btn-gradient-danger" onclick="confirm(<%=id%>)">Reject</a>
                                                    <%}%>
                                                </td>
                                            </tr>
                                            <%
                                                    }
                                                } catch (Exception e) {

                                                }
                                            %>
                                        </tbody>
                                    </table>
                                </div>
                            </div> 
                        </div>
                    </div>
                    <footer>
                        <jsp:include page="includes/footer.jsp"></jsp:include>
                    </footer>
                </div>
            </div>
        </div>
        <script src="page_components/vendors/js/vendor.bundle.base.js"></script>
        <script src="page_components/js/off-canvas.js"></script>
        <script src="page_components/js/hoverable-collapse.js"></script>
        <script src="page_components/js/misc.js"></script>
        <script src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.datatables.net/1.11.3/js/dataTables.bootstrap5.min.js"></script>
        <script src="https://cdn.datatables.net/buttons/2.3.2/js/dataTables.buttons.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
        <script src="https://cdn.datatables.net/buttons/2.3.2/js/buttons.html5.min.js"></script>

        <script>
                                                        $(document).ready(function () {
                                                            $('#list').DataTable({
                                                                select: true
                                                            });
                                                        });
        </script>
        <script>
            function confirm(id) {
                Swal.fire({
                    title: 'Are you sure?',
                    text: "Reject this application",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Yes, reject it!'
                }).then((result) => {
                    if (result.isConfirmed) {
                        location.href = "action/status_update.jsp?id=" + id + "&&action=reject";
                    }
                });
            }
        </script>
    </body>
</html>