<%@page import="EmployeeLogin.employee"%>
<%@page import="connection.db"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>

        <%    response.setHeader("Cache-Control", "no-cache");
            response.setHeader("Cache-Control", "no-store");
            response.setDateHeader("Expires", 0);
            response.setHeader("Pragma", "no-cache");
            if (session.getAttribute("emp") == null)
                response.sendRedirect("emperror-404.html");
        %>
        <script>history.forward();</script>

        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Electricity Board | Employee</title>

        <!-- plugins:css -->
        <link rel="stylesheet" type="text/css" href="page_components/vendors/mdi/css/materialdesignicons.min.css">
        <link rel="stylesheet" type="text/css" href="page_components/vendors/css/vendor.bundle.base.css">
        <link rel="stylesheet" type="text/css" href="page_components/css/style.css">
        <link rel="stylesheet" type="text/css" href="css/design.min.css">
        <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" />
        <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.1.3/css/bootstrap.min.css">
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.3/css/dataTables.bootstrap5.min.css"/>
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/buttons/2.2.3/css/buttons.bootstrap5.min.css">
        <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.12.1/js/jquery.dataTables.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
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
            <jsp:include page="includes/emp_dashboard_header.jsp"></jsp:include>
                <!-- partial -->
                <div class="container-fluid page-body-wrapper">
                    <!-- partial:../../partials/_sidebar.html -->
                <jsp:include page="includes/emp_dashboard_sidebar.jsp"></jsp:include>


                    <div class="main-panel">
                        <div class="content-wrapper">
                            <h3 class="page-title">
                                <span class="page-title-icon bg-gradient-primary text-white me-2">
                                    <i class="mdi mdi-file-document-box"></i>
                                </span> 
                                Complaints
                            </h3>
                            <br><br>
                            <!--adding new admin panel-->

                            <div class="col-12 grid-margin stretch-card">
                                <div class="card">
                                    <div class="card-body">
                                        <table class="table table-hover w-100" id="list">
                                            <thead>
                                            <th>Service number</th>
                                            <th>Name</th>
                                            <th>Flat/plot/house no</th>
                                            <th>Street</th>
                                            <th>City/ Village</th>
                                            <th>District</th>
                                            <th>Contact no</th>
                                            <th>complaints</th>
                                            <th>Compliant reg</th>
                                            <th>Action</th>
                                            </thead>
                                            <tfoot>
                                            <th>Service number</th>
                                            <th>Name</th>
                                            <th>Flat/plot/house no</th>
                                            <th>Street</th>
                                            <th>City/ Village</th>
                                            <th>District</th>
                                            <th>Contact no</th>
                                            <th>complaints</th>
                                            <th>Compliant reg</th>
                                            <th>Action</th>
                                            </tfoot>
                                            <tbody>
                                            <%
                                                employee emp = (employee) session.getAttribute("emp");
                                                String dist = emp.getDistrict();
                                                try {
                                                    Connection conn = db.initializeDatabase();
                                                    String sql = "SELECT * FROM compliants WHERE district=? ORDER BY id DESC";
                                                    PreparedStatement ps = conn.prepareStatement(sql);
                                                    ps.setString(1, dist);
                                                    ResultSet rs = ps.executeQuery();
                                                    while (rs.next()) {
                                                        int id = rs.getInt("id");
                                            %>
                                            <tr>
                                                <td><%=rs.getString("service_no")%></td>
                                                <td><%=rs.getString("name")%></td>
                                                <td><%=rs.getString("house_no")%></td>
                                                <td><%=rs.getString("street")%></td>
                                                <td><%=rs.getString("city")%></td>
                                                <td><%=rs.getString("district")%></td>
                                                <td><%=rs.getString("contact_no")%></td>
                                                <td><%=rs.getString("compliant")%></td>
                                                <td><%=rs.getString("reg_time")%></td>
                                                <td>
                                                    <%
                                                        String sts = rs.getString("status");
                                                        if (sts.equals("pending")) {
                                                    %>
                                                    <a href="update_complaint?id=<%=id%>&sts=<%=sts%>" class="text-decoration-none btn btn-danger">Recived &nbsp;&nbsp;<i class="mdi mdi-close"></i></a>
                                                        <%
                                                        } else if (sts.equals("In progress")) {
                                                        %>
                                                    <a href="update_complaint?id=<%=id%>&sts=<%=sts%>" class="text-decoration-none btn btn-warning">Complete &nbsp;&nbsp;<i class="mdi mdi-alert"></i></a>
                                                        <%
                                                        } else {
                                                        %>
                                                    <a href="#" class="text-decoration-none btn btn-success">Completed &nbsp;&nbsp;<i class="mdi mdi-check"></i></a>
                                                        <%
                                                            }
                                                        %>
                                                </td>
                                            </tr>
                                            <%
                                                    }
                                                } catch (Exception e) {
                                                    out.print(e);
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
    </body>

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
                    select: true,
                    dom: 'Bfrtip',
                    buttons: [
                        'copyHtml5',
                        'excelHtml5',
                        'csvHtml5',
                        'pdfHtml5'
                    ]
                });
            });

    </script>

</html>