<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
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
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.3/css/dataTables.bootstrap5.min.css"/>
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/buttons/2.2.3/css/buttons.bootstrap5.min.css">
        <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.12.1/js/jquery.dataTables.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <link rel="shortcut icon" href="image/light.ico" />
    </head>
    <style>
        table {
            display: block;
            overflow-x: auto;
            white-space: nowrap;
        }
    </style>
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
                            <h2>Messages</h2>


                            <div class="col-12 grid-margin stretch-card">
                                <div class="card p-3">
                                    <table id="list" class="table table-striped table-hover w-100" cellpadding="3">

                                    <%
                                        try {
                                            Connection conn = db.initializeDatabase();
                                            String sql = "SELECT * FROM contact_msg ORDER BY id DESC";
                                            PreparedStatement statement = conn.prepareStatement(sql);
                                            ResultSet rs = statement.executeQuery();
                                            while (rs.next()) {
                                                String id = rs.getString("id");
                                    %>

                                    <tr class="w-100">
                                    <ul class="nav" style="border-radius: 10px;">
                                        <li class="nav-item bg-dark p-1 w-100 text-light">
                                            <a class="nav-link" data-bs-toggle="collapse" href="#msg<%=id%>" aria-expanded="false" aria-controls="msg<%=id%>">
                                                <span class="menu-title"><h5 class="text-light""><%= rs.getString("name")%></h5></span>
                                            </a>
                                            <div class="collapse" id="msg<%=id%>">
                                                <ul class="nav flex-column sub-menu" style="margin-left: 20px;">
                                                    <li><h5><%= rs.getString("subject")%></h5></li>
                                                    <li>From : <%= rs.getString("email_id")%></li>
                                                    <li>Message : <%= rs.getString("Message")%></li>
                                                    <li>
                                                        <%
                                                            if (rs.getString("status").equals("read")) {
                                                        %>
                                                        <a style="cursor: pointer;" href="action/read_message.jsp?id=<%=id%>&&btn=accept" class="badge badge-danger text-decoration-none text-light">Readed</a>
                                                        <%
                                                        } else {
                                                        %>
                                                        <a style="cursor: pointer;" onclick="confirm(<%=id%>)" class="badge badge-light text-decoration-none text-dark">Delete?</a>
                                                        <%
                                                            }
                                                        %>
                                                    </li>
                                                </ul>
                                            </div>
                                        </li>
                                    </ul>
                                    </tr>
                                    <hr>
                                    <%
                                            }
                                        } catch (Exception e) {

                                        }
                                    %>
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
                text: "You won't be able to revert this!",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Yes, delete it!'
            }).then((result) => {
                if (result.isConfirmed) {
                    location.href = "action/delete_msg.jsp?id=" + id+"&&btn=accept";
                }
            })
        }
    </script>

</html>