<%@page import="connection.db"%>
<%@page import="java.time.YearMonth"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <%    response.setHeader("Cache-Control", "no-cache");
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
                            <h2>Billing</h2>
                            <!--adding new admin panel-->


                            <div class="col-12 grid-margin stretch-card">
                                <div class="card p-3">
                                    <br><br>
                                    <table id="list" class="display table table-striped table-bordered table-hover" cellspacing="0" width="100%">
                                        <thead>
                                            <tr>
                                                <th> Bill no </th>
                                                <th> Service no </th>
                                                <th> Total amount of unit  </th>
                                                <th> Total Amount </th>
                                                <th> Payment status </th>
                                                <th> Month </th>
                                                <th> Action </th>
                                            </tr>
                                        </thead>
                                        <tfoot>
                                            <tr>
                                                <th> Bill no </th>
                                                <th> Service no </th>
                                                <th> Total amount of unit  </th>
                                                <th> Total Amount </th>
                                                <th> Payment status </th>
                                                <th> Month </th>
                                                <th> Action </th>
                                            </tr>
                                        </tfoot>
                                        <tbody>
                                        <%
                                            try {
                                                Connection conn = db.initializeDatabase();
                                                String sql = "SELECT * FROM eb_bill_payment";
                                                PreparedStatement statement = conn.prepareStatement(sql);
                                                ResultSet rs = statement.executeQuery();
                                                while (rs.next()) {
                                                    String id = rs.getString("id");
                                        %>
                                        <tr>
                                            <td> <%= rs.getString("bill_no")%> </td>
                                            <td> <%= rs.getString("service_no")%> </td>
                                            <td> <%= rs.getString("unit_consumed")%> </td>
                                            <td> &#8377; <%= rs.getString("total_amount")%> </td>
                                            <td> <%= rs.getString("status")%> </td>
                                            <td> <%= rs.getString("month_year")%> </td>

                                            <td>
                                                <a onclick="confirm(<%=id%>)"><i class="fa fa-trash text-danger text-md-start" aria-hidden="true"></i></a>
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
                    pageLength: 10,
                    select: true,
                    filter: true,
                    deferRender: true,
                    "searching": true,
                    dom: 'lBfrtip',
                    buttons: [
                        'copyHtml5',
                        'excelHtml5',
                        'csvHtml5',
                        'pdfHtml5'
                    ]
                });
            });
    </script>
    <script>
        function confirm(id) {
            Swal.fire({
                title: 'Are you sure?',
                text: "You won't be able to revert this!",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Yes, delete it!'
            }).then((result) => {
                if (result.isConfirmed) {
                    location.href = "action/delete_bill.jsp?id=" + id;
                }
            })
        }
    </script>
</html>