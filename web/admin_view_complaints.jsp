<%@page import="connection.db"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%!
    String status=null;
%>
<%
    if(request.getParameter("searchBtn")!=null){
        status=request.getParameter("searchData");
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
                                    <i class="mdi mdi-file-document-box"></i>
                                </span> 
                                Complaints
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
                                        <table class="table table-hover w-100" id="myTable">
                                            <thead>
                                            <th>Service number</th>
                                            <th>Name</th>
                                            <th>Flat/plot/house no</th>
                                            <th>Street</th>
                                            <th>City/ Village</th>
                                            <th>District</th>
                                            <th>Contact no</th>
                                            <th>complaints</th>
                                            <th>Register time</th>
                                            <th>Action</th>
                                            </thead>
                                        <%
                                            try {
                                                Connection conn = db.initializeDatabase();
                                                String sql="";
                                                if(status !=null){
                                                    sql = "SELECT * FROM compliants WHERE status LIKE '"+status+"%' ORDER BY id DESC";
                                                }
                                                else{
                                                    status=null;
                                                    sql = "SELECT * FROM compliants ORDER BY id DESC";
                                                }
                                                PreparedStatement ps = conn.prepareStatement(sql);
                                                ResultSet rs = ps.executeQuery();
                                                while (rs.next()) {
                                                    int id = rs.getInt("id");
                                        %>
                                        <tbody>
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
                                            status=null;
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
            function myFunction() {
                // Declare variables
                var input, filter, table, tr, td, i, txtValue;
                input = document.getElementById("search");
                filter = input.value.toUpperCase();
                table = document.getElementById("myTable");
                tr = table.getElementsByTagName("tr");

                // Loop through all table rows, and hide those who don't match the search query
                for (i = 0; i < tr.length; i++) {
                    td = tr[i].getElementsByTagName("td")[0];
                    if (td) {
                        txtValue = td.textContent || td.innerText;
                        if (txtValue.toUpperCase().indexOf(filter) > -1) {
                            tr[i].style.display = "";
                        } else {
                            tr[i].style.display = "none";
                        }
                    }
                }
            }
</script>

</html>