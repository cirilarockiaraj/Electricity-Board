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
            <jsp:include page="includes/con_dashboard_header.jsp"></jsp:include>
                <!-- partial -->
                <div class="container-fluid page-body-wrapper">
                    <!-- partial:../../partials/_sidebar.html -->
                <jsp:include page="includes/con_dashboard_sidebar.jsp"></jsp:include>
                    <div class="main-panel">
                        <div class="content-wrapper">
                            <h3 class="page-title">
                                <span class="page-title-icon bg-gradient-primary text-white me-2">
                                    <i class="fa-solid fa-money-check-dollar"></i>
                                </span> 
                                Pay Electricity bill
                            </h3>
                            <br><br>
                            <!--Row-->

                            <div class="row d-flex justify-content-center">
                                <div class="col-md-6 grid-margin stretch-card">
                                    <div class="card">
                                        <div class="card-body">
                                            <h4 class="card-title">Online bill payment</h4>
                                            <i class="text-danger">${msg}</i><br><br>
                                            <form method="post" action="con_pay_bill">
                                                <div class="form-group">
                                                    <label>service number</label>
                                                    <input type="text" class="form-control" value="${con.serviceNo}" name="s_no" readonly="" required="">
                                            </div>
                                            <%!
                                                String month=null;
                                                String sts="";
                                            %>
                                            <%
                                                try {
                                                    consumer cons=(consumer) session.getAttribute("con");
                                                    String sno=cons.getServiceNo();
                                                    Connection conn = db.initializeDatabase();
                                                    String query1 = "SELECT * FROM eb_bill_payment WHERE service_no=? AND status=?";
                                                    PreparedStatement ps1 = conn.prepareStatement(query1);
                                                    ps1.setString(1, sno);
                                                    ps1.setString(2, "unpaid");
                                                    ResultSet rs1 = ps1.executeQuery();
                                                    if(rs1.next()) {
                                                        month = rs1.getString("month_year");
                                                        sts=rs1.getString("status");
                                                    }
                                                    else{
                                                        month = null;
                                                        sts="";
                                                    }
                                                } catch (Exception e) {
                                                    out.print(e);
                                                }
                                            %>
                                            <div class="form-group">
                                                <label>Month &nbsp;&nbsp;ex:<i>(January2022)</i></label>
                                                <input type="text" class="form-control" name="month" value="<%out.print(month);%>" readonly="" required="">
                                            </div>
                                            <div class="form-group">
                                                <button type="submit" <%if(sts==""){%>disabled=""<%}%> class="btn btn-gradient-info"><i class="fa-brands fa-amazon-pay" style="font-size: 25px;"></i></button>
                                            </div>
                                        </form>
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