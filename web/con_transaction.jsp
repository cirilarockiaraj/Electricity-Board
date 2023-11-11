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
        <title>Electricity Board | Consumer</title>

        <%    response.setHeader("Cache-Control", "no-cache");
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

        <style>
            .table_scroll {
                display: block;
                overflow-x: auto;
                white-space: nowrap;
            }
        </style>
    </head>
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
                                    <i class="fa fa-history"></i>
                                </span> 
                                Transaction history
                            </h3>
                            <br><br>
                            <!--Row-->

                            <div class="row">
                                <div class="col-md-12 grid-margin stretch-card">
                                    <div class="card">
                                        <div class="card-body">
                                            <table class="table table-striped table-bordered table-hover table_scroll">
                                                <thead class="bg-dark text-light">
                                                    <tr>
                                                        <th>Bill number</th>
                                                        <th>Unit Consumed</th>
                                                        <th>Total amount</th>
                                                        <th>Month</th>
                                                        <th>status</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                <%
                                                    try {
                                                        consumer co = (consumer) session.getAttribute("con");
                                                        String sno = co.getServiceNo();
                                                        Connection conn = db.initializeDatabase();
                                                        String sql = "SELECT * FROM eb_bill_payment WHERE service_no=?";
                                                        PreparedStatement ps = conn.prepareStatement(sql);
                                                        ps.setString(1, sno);
                                                        ResultSet rs = ps.executeQuery();
                                                        while (rs.next()) {
                                                            String status = rs.getString("status");
                                                            String id=rs.getString("id");
                                                %>
                                                <tr>
                                                    <td><%=rs.getString("bill_no")%> </td>
                                                    <td> <%=rs.getString("unit_consumed")%> </td>
                                                    <td> <%=rs.getString("total_amount")%> </td>
                                                    <td> <%=rs.getString("month_year")%> </td>
                                                    <td>
                                                        <%
                                                            if (status.equals("paid")) {
                                                                %>
                                                                <a href="con_print_bill.jsp?id=<%=id%>" class="btn btn-success text-decoration-none">Receipt</a>
                                                                <%
                                                            } else {
                                                        %>
                                                        <a href="con_pay_bill.jsp" class="btn btn-info text-decoration-none">Pay now</a>
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
                <script>window.oncontextmenu = function() {return false;}</script>
            </div>
    </body>
</html>