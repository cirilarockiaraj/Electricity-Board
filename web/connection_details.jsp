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
                                    <i class="fa fa-plug"></i>
                                </span> 
                                Connection details
                            </h3>
                            <br><br>
                            <!--Row-->

                            <div class="row">
                                <div class="col-md-12 grid-margin stretch-card">
                                    <div class="card">
                                        <div class="card-body">
                                            <h4 class="card-title">General Information</h4>
                                            <table class="table table-striped">
                                                <tbody>
                                                    <tr>
                                                        <td> Service number </td>
                                                        <td> ${ser_no} </td>
                                                    </tr>
                                                    <tr>
                                                        <td> Service type </td>
                                                        <td> ${con_type} </td>
                                                    </tr>
                                                    <tr>
                                                        <td> Current Status </td>
                                                        <td> ${status} </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                            <br><br>
                                            <h4 class="card-title">Personal Information</h4>
                                            <table class="table table-striped">
                                                <tbody>
                                                    <tr>
                                                        <td> Service holder name </td>
                                                        <td> ${name} </td>
                                                    </tr>
                                                    <tr>
                                                        <td> Father's name </td>
                                                        <td> ${father} </td>
                                                    </tr>
                                                    <tr>
                                                        <td> Occupation </td>
                                                        <td> ${occupation} </td>
                                                    </tr>
                                                    <tr>
                                                        <td> Gender </td>
                                                        <td> ${gender} </td>
                                                    </tr>
                                                    <tr>
                                                        <td> Date of birth </td>
                                                        <td> ${dob} </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                            <br><br>
                                            <h4 class="card-title">Address Information</h4>
                                            <table class="table table-striped">
                                                <tbody>
                                                    <tr>
                                                        <td> Flat/plot/house no </td>
                                                        <td> ${house} </td>
                                                    </tr>
                                                    <tr>
                                                        <td> Village/City name </td>
                                                        <td> ${city} </td>
                                                    </tr>
                                                    <tr>
                                                        <td> District </td>
                                                        <td> ${district} </td>
                                                    </tr>
                                                    <tr>
                                                        <td> State </td>
                                                        <td> ${state} </td>
                                                    </tr>
                                                    <tr>
                                                        <td> Country </td>
                                                        <td> ${country} </td>
                                                    </tr>
                                                    <tr>
                                                        <td> Pincode </td>
                                                        <td> ${pincode} </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                            <br><br>
                                            <h4 class="card-title">Contact Information</h4>
                                            <table class="table table-striped">
                                                <tbody>
                                                    <tr>
                                                        <td> Contact number </td>
                                                        <td> ${mobile} </td>
                                                    </tr>
                                                    <tr>
                                                        <td> Additional contact number </td>
                                                        <td> ${additional} </td>
                                                    </tr>
                                                    <tr>
                                                        <td> Email ID </td>
                                                        <td> ${email} </td>
                                                    </tr>
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