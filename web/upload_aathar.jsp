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
        <title>Consumer | aathar upload</title>
        <%
            response.setHeader("Cache-Control", "no-cache");
            response.setHeader("Cache-Control", "no-store");
            response.setDateHeader("Expires", 0);
            response.setHeader("Pragma", "no-cache");
            consumer cons = (consumer) session.getAttribute("con");
            if (cons == null) {
                response.sendRedirect("con_login.jsp");
            } else {
        %>
        <!-- plugins:css -->
        <link rel="stylesheet" href="page_components/vendors/mdi/css/materialdesignicons.min.css">
        <link rel="stylesheet" href="page_components/vendors/css/vendor.bundle.base.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" />
        <link rel="stylesheet" href="page_components/css/style.css">
        <!-- End layout styles -->
        <link rel="shortcut icon" href="image/light.ico" />
    </head>
    <body>
        <%
            boolean isExist = false;
            String status = null;
            String sno = null;

            //consumer cons = (consumer) session.getAttribute("con");
            sno = cons.getServiceNo();
            Connection con = db.initializeDatabase();
            String sql = "SELECT * FROM aathar_data WHERE service_no=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, sno);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                isExist = true;
                status = rs.getString("status");
            } else {
                isExist = false;
            }
        %>
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
                                    <i class="mdi mdi-arrow-up-bold-circle"></i>
                                </span> 
                                Upload Aathar
                            </h3>
                            <br><br>
                            <!--Row-->

                            <div class="row">
                                <div class="col-md-12 grid-margin stretch-card">
                                    <div class="card">
                                        <div class="card-body">
                                        <%
                                            if (isExist == true) {
                                                if (status.equals("pending")) {
                                        %>
                                        <div class="row">
                                            <div class="col-5"></div>
                                            <div class="col-4">
                                                <i class="mdi mdi-information-outline text-warning" style="font-size: 100px;" align="center"></i>
                                            </div>
                                            <div class="col-4"></div>

                                        </div>                    
                                        <div class="row">
                                            <div class="col-1"></div>
                                            <div class="col-10">
                                                <h2 align="center">Your Aathar submitted successfully.</h2>
                                                <h4 align="center">Current status is pending</h4>
                                            </div>
                                            <div class="col-1"></div>
                                        </div>
                                        <%
                                        } else if (status.equals("accepted")) {
                                        %>
                                        <div class="row">
                                            <div class="col-5"></div>
                                            <div class="col-4">
                                                <i class="mdi mdi-check-circle-outline text-success" style="font-size: 100px;" align="center"></i>
                                            </div>
                                            <div class="col-4"></div>

                                        </div>                    
                                        <div class="row">
                                            <div class="col-3"></div>
                                            <div class="col-6">
                                                <h2 align="center">Your Aathar submitted successfully.</h2>
                                                <h4 align="center">Your Aathar accepted</h4>
                                            </div>
                                            <div class="col-3"></div>
                                        </div>
                                        <%
                                        } else {
                                        %>
                                        <div class="row">
                                            <div class="col-5"></div>
                                            <div class="col-4">
                                                <i class="mdi mdi-close-circle-outline text-danger" style="font-size: 100px;" align="center"></i>
                                            </div>
                                            <div class="col-4"></div>

                                        </div>                    
                                        <div class="row">
                                            <div class="col-3"></div>
                                            <div class="col-6">
                                                <h2 align="center">Your Aathar card is Rejected</h2>
                                                <h4 align="center">Contact administrator &nbsp;<a href="contact.jsp" class="text-decoration-none">Click here</a></h4>
                                            </div>
                                            <div class="col-3"></div>
                                        </div>
                                        <%
                                            }
                                        } else {
                                        %>
                                        <form method="POST" action="aathar_upload" enctype="multipart/form-data">
                                            <div class="row">
                                                <div class="col-6">
                                                    <div class="form-group">
                                                        <label class="form-label">Enter your Aathar number</label>
                                                        <input type="number" name="aNo" class="form-control" onkeypress="if (this.value.length > 11)
                                                                    return false;">
                                                    </div> 
                                                </div>
                                                <div class="col-6">
                                                    <div class="form-group">
                                                        <label class="form-label">Upload your aathar card &nbsp;&nbsp; format(.jpg, .jpeg, .png)</label>
                                                        <input type="file" name="a_photo" class="form-control" size="50">
                                                    </div> 
                                                </div>
                                            </div>
                                            <button type="submit" class="btn btn-gradient-success btn-icon-text"><i class="mdi mdi-upload btn-icon-prepend"></i> Upload </button>
                                            <button type="reset" class="btn btn-danger">Cancel</button>
                                        </form>
                                        <%
                                            }
                                        %>
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
    <%}%>
</html>