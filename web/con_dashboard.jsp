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
        <title>Electricity Board | Consumers</title>

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
                                    <i class="fa-solid fa-gauge"></i>
                                </span> 
                                Dashboard
                            </h3>
                            <br><br>
                            <!--Row-->

                        <%!
                            double unit;
                            double tot;
                            String key;
                            float amt;
                        %>

                        <%
                            try {
                                consumer co = (consumer) session.getAttribute("con");
                                Connection conn = db.initializeDatabase();
                        %>

                        <div class="row">
                            <div class="col-md-6 stretch-card grid-margin">
                                <div class="card bg-gradient-success card-img-holder text-white">
                                    <div class="card-body">
                                        <img src="page_components/images/dashboard/circle.svg" class="card-img-absolute" alt="circle-image" />
                                        <h4 class="font-weight-normal mb-3">You consumed amount of power <i class="mdi mdi-lightbulb mdi-24px float-right"></i>
                                        </h4>
                                        <%
                                            String sql = "SELECT SUM(unit_consumed) FROM eb_bill_payment WHERE service_no=?";
                                            PreparedStatement ps = conn.prepareStatement(sql);
                                            ps.setString(1, co.getServiceNo());
                                            ResultSet rs = ps.executeQuery();
                                            while (rs.next()) {
                                                unit = rs.getDouble(1);

                                                if (unit < 1000) {
                                                    tot = unit;
                                                    key = "UNIT";
                                                } else if (unit >= Math.pow(1000, 1) && unit < Math.pow(1000, 2)) {
                                                    tot = ((unit * 1) / (Math.pow(1000, 1)));
                                                    key = "Kw";
                                                } else if (unit >= Math.pow(1000, 2) && unit < Math.pow(1000, 3)) {
                                                    tot = ((unit * 1) / (Math.pow(1000, 2)));
                                                    key = "Mw";
                                                } else if (unit >= Math.pow(1000, 3) && unit < Math.pow(1000, 4)) {
                                                    tot = ((unit * 1) / (Math.pow(1000, 3)));
                                                    key = "Gw";
                                                } else {
                                                    tot = ((unit * 1) / (Math.pow(1000, 4)));
                                                    key = "Tw";
                                                }
                                            }
                                        %>

                                        <center><h1 class="mb-5"><%out.print(tot + " " + key);%></h1></center>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-6 stretch-card grid-margin">
                                <div class="card bg-gradient-info card-img-holder text-white">
                                    <div class="card-body">
                                        <img src="page_components/images/dashboard/circle.svg" class="card-img-absolute" alt="circle-image" />
                                        <h4 class="font-weight-normal mb-3">You paid total amount of EB bill <i class="mdi mdi-tag-multiple mdi-24px float-right"></i>
                                        </h4>
                                        <%
                                            String sql2 = "SELECT SUM(total_amount) FROM eb_bill_payment WHERE service_no=? AND status=?";
                                            PreparedStatement ps1 = conn.prepareStatement(sql2);
                                            ps1.setString(1, co.getServiceNo());
                                            ps1.setString(2, "paid");
                                            ResultSet rs1 = ps1.executeQuery();
                                            while (rs1.next()) {
                                                amt = rs1.getFloat(1);
                                        %>

                                        <h2 class="mb-5"><i class="fa fa-inr" aria-hidden="true">&nbsp;</i><%=amt%></h2>
                                        <%}%>
                                        <h6 class="card-text"><a class="text-decoration-none text-light" href="con_transaction.jsp">View transaction history</a></h6>
                                    </div>
                                </div>
                            </div>

                            <!-- 2nd row -->
                            <div class="row">
                                <div class="col-md-6 grid-margin stretch-card">
                                    <div class="card">
                                        <div class="card-body">
                                            <h4 class="card-title">Change your password</h4>
                                            <div class="p-2">
                                                <p class="text-success"><i>${succ_msg}</i></p>
                                                <p class="text-danger"><i>${err_msg}</i></p>
                                            </div>
                                            <form method="post" action="updatePassword">
                                                <div class="form-group">
                                                    <label>Old password</label>
                                                    <input type="password" class="form-control" id="pass" name="oldPass" aria-label="Old password">
                                                </div>
                                                <div class="form-group">
                                                    <label>New password</label>
                                                    <input type="password" class="form-control" id="pass1" name="newPass" aria-label="New password">
                                                </div>
                                                <div class="form-group">
                                                    <label>Confirm password</label>
                                                    <input type="password" class="form-control" id="pass2" name="conPass" aria-label="Confirm password">
                                                </div>
                                                <div class="form-group">
                                                    <input class="form-check-input" type="checkbox" onclick="taggle_pass()"> &nbsp;&nbsp;
                                                    <label class="form-check-label" onclick="taggle_pass()">Show password</label>
                                                </div>
                                                <div class="form-group">
                                                    <button type="submit" class="btn btn-gradient-primary btn-rounded btn-fw">Update</button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- // 2nd row -->

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


                <%
                    } catch (Exception e) {
                        out.print(e);
                    }
                %>
            </div>

            <script>
                function taggle_pass() {
                    var pass = document.getElementById('pass');
                    var pass1 = document.getElementById('pass1');
                    var pass2 = document.getElementById('pass2');
                    if (pass.type === "password" && pass1.type === "password" && pass2.type === "password") {
                        pass.type = "text";
                        pass1.type = "text";
                        pass2.type = "text";
                    } else {
                        pass.type = "password";
                        pass1.type = "password";
                        pass2.type = "password";
                    }
                }
            </script>
    </body>
</html>