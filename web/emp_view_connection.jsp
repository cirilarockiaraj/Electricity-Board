<%@page import="EmployeeLogin.employee"%>
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
            <jsp:include page="includes/emp_dashboard_header.jsp"></jsp:include>
                <!-- partial -->
                <div class="container-fluid page-body-wrapper">
                    <!-- partial:../../partials/_sidebar.html -->
                <jsp:include page="includes/emp_dashboard_sidebar.jsp"></jsp:include>


                    <div class="main-panel">
                        <div class="content-wrapper">
                            <h2>
                                Connections in ${emp.district} district
                        </h2>

                        <!--adding new admin panel-->

                        <div class="col-12 grid-margin stretch-card">
                            <div class="card">
                                <div class="card-body">
                                    <h4 class="card-title">Consumer List</h4>
                                    <div class="scroll">
                                        <table id="list" class="table table-striped table-bordered table-hover" cellspacing="0" width="100%">
                                            <thead class="table-dark">
                                                <tr>
                                                    <th> Service number </th>
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
                                                    <th> Status Click to activate </th>
                                                    <th> Action </th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%
                                                    try {
                                                        employee e = (employee) session.getAttribute("emp");
                                                        Connection conn = db.initializeDatabase();
                                                        String sql = "SELECT * FROM services WHERE district=?";
                                                        PreparedStatement stmt = conn.prepareStatement(sql);
                                                        stmt.setString(1, e.getDistrict());
                                                        ResultSet rs = stmt.executeQuery();
                                                        while (rs.next()) {
                                                            String id = rs.getString("id");
                                                %>
                                                <tr>
                                                    <td> <%= rs.getString("service_no")%> </td>
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
                                                        <%
                                                            if (rs.getString("status") == "pending") {
                                                        %>
                                                        <a class="btn btn-danger" href="action/emp_status_update.jsp?id=<%=id%>">Pending</a>
                                                        <%
                                                        } else {
                                                        %>
                                                        <p class="btn btn-success">Live</p>
                                                        <%
                                                            }
                                                        %>
                                                    </td>

                                                    <td>
                                                        <a href="action/emp_update_connection.jsp?id=<%=id%>"><i class="fas fa-edit text-md-start" aria-hidden="true"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;
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
    <script src="https://cdn.datatables.net/buttons/2.3.2/js/dataTables.buttons.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.3.2/js/buttons.html5.min.js"></script>

    <script>
            $(document).ready(function () {
                $('#list').DataTable({
                    pageLength: 10,
                    filter: true,
                    deferRender: true,
                    "searching": true,
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
                    location.href = "action/emp_delete_connection.jsp?id=" + id;
                }
            })
        }
    </script>

</html>