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
        <link rel="stylesheet" href="page_components/vendors/mdi/css/materialdesignicons.min.css">
        <link rel="stylesheet" href="page_components/vendors/css/vendor.bundle.base.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" />
        <link rel="stylesheet" href="page_components/css/style.css">
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
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
                            <h3 class="page-title">
                                <span class="page-title-icon bg-gradient-primary text-white me-2">
                                    <i class="mdi mdi-account"></i>
                                </span> 
                                Profile
                            </h3>
                            <div class="row p-3">
                                <div class="col-md-12 grid-margin stretch-card">
                                    <div class="card">
                                        <section class="p-5">
                                            <div class="row">
                                                <div class="col-12">
                                                    <img src="admin_profiles/${ad.image}" style="border: 1px solid black; border-radius: 5px;" width="150" height="190" class="float-end" alt="image error">
                                            </div>

                                            <div class="row p-1">
                                                <div class="col-6">
                                                    <h6>Username</h6>
                                                </div>
                                                <div class="col-6">
                                                    <h6>${ad.username}</h6>
                                                </div>
                                            </div>
                                            <div class="row p-1">
                                                <div class="col-6">
                                                    <h6>Date of birth</h6>
                                                </div>
                                                <div class="col-6">
                                                    <h6>${ad.dob}</h6>
                                                </div>
                                            </div>
                                            <div class="row p-1">
                                                <div class="col-6">
                                                    <h6>Position</h6>
                                                </div>
                                                <div class="col-6">
                                                    <h6>${ad.profession}</h6>
                                                </div>
                                            </div>
                                            <div class="row p-1">
                                                <div class="col-6">
                                                    <h6>Contact number</h6>
                                                </div>
                                                <div class="col-6">
                                                    <h6>${ad.contact_no}</h6>
                                                </div>
                                            </div>
                                            <div class="row p-1">
                                                <div class="col-6">
                                                    <h6>Email ID</h6>
                                                </div>
                                                <div class="col-6">
                                                    <h6>${ad.email_id}</h6>
                                                </div>
                                            </div>
                                            <div class="row p-1">
                                                <div class="col-6">
                                                    <h6>Address</h6>
                                                </div>
                                                <div class="col-6">
                                                    <h6>${ad.address}</h6>
                                                </div>
                                            </div>
                                    </section>
                                </div>
                            </div>
                        </div>
                    </div>
                    <footer>
                        <jsp:include page="includes/footer.jsp"></jsp:include>
                    </footer>
                </div>
            </div>

    </body>


    <script src="page_components/vendors/js/vendor.bundle.base.js"></script>
    <script src="page_components/js/off-canvas.js"></script>
    <script src="page_components/js/hoverable-collapse.js"></script>
    <script src="page_components/js/misc.js"></script>

</html>