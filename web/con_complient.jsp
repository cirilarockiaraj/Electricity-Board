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
        <title>Consumer | Complaint</title>

        <%    response.setHeader("Cache-Control", "no-cache");
            response.setHeader("Cache-Control", "no-store");
            response.setDateHeader("Expires", 0);
            response.setHeader("Pragma", "no-cache");
            if (session.getAttribute("con") == null) {
                response.sendRedirect("con_login.jsp");
            } else {
        %>
        <script>history.forward();</script>

        <!-- plugins:css -->
        <link rel="stylesheet" href="page_components/vendors/mdi/css/materialdesignicons.min.css">
        <link rel="stylesheet" href="page_components/vendors/css/vendor.bundle.base.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" />
        <link rel="stylesheet" href="page_components/css/style.css">
        <!-- End layout styles -->
        <link rel="shortcut icon" href="image/light.ico" />
        <script src="js/jquery.js"></script>
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
                                    <i class="mdi mdi-file-document-box"></i>
                                </span> 
                                Complaint
                            </h3>
                            <br><br>
                            <!--Row-->
                        <%!
                            String name, house_no, city, district, contact;
                        %>
                        <%
                            consumer con = (consumer) session.getAttribute("con");
                            String sno = con.getServiceNo();

                            try {
                                Connection conn = db.initializeDatabase();
                                String sql = "SELECT * FROM services WHERE service_no=?";
                                PreparedStatement ps = conn.prepareStatement(sql);
                                ps.setString(1, sno);
                                ResultSet rs = ps.executeQuery();
                                while (rs.next()) {
                                    name = rs.getString("service_holder_name");
                                    house_no = rs.getString("house_no");
                                    city = rs.getString("city_village_town_name");
                                    district = rs.getString("district");
                                    contact = rs.getString("mobile_no");
                                }
                            } catch (SQLException | ClassNotFoundException ex) {
                                out.print(ex);
                            }
                        %>

                        <div class="row">
                            <div class="col-md-12 grid-margin stretch-card">
                                <div class="card">
                                    <div class="card-body">
                                        <form id="form">
                                            <div class="row">
                                                <div class="col-4">
                                                    <div class="form-group">
                                                        <label class="form-label">Enter your name</label>
                                                        <input type="text" name="name" value="<%out.print(name);%>" class="form-control" readonly="">
                                                    </div> 
                                                </div>
                                                <div class="col-4">
                                                    <div class="form-group">
                                                        <label class="form-label">Enter your Flat/plot/house no</label>
                                                        <input type="text" name="houseno" value="<%out.print(house_no);%>" class="form-control" readonly="">
                                                    </div> 
                                                </div>
                                                <div class="col-4">
                                                    <div class="form-group">
                                                        <label class="form-label">Enter your street</label>
                                                        <input type="text" name="street" class="form-control" required="">
                                                    </div> 
                                                </div>
                                                <div class="col-4">
                                                    <div class="form-group">
                                                        <label class="form-label">Enter your city/ village</label>
                                                        <input type="text" name="city" value="<%out.print(city);%>" class="form-control" readonly="">
                                                    </div> 
                                                </div>
                                                <div class="col-4">
                                                    <div class="form-group">
                                                        <label class="form-label">Select your district</label>
                                                        <input type="text" name="district" value="<%out.print(district);%>" class="form-control" readonly="">
                                                    </div> 
                                                </div>
                                                <div class="col-4">
                                                    <div class="form-group">
                                                        <label class="form-label">Enter your contact no</label>
                                                        <input type="number" name="contact" value="<%out.print(contact);%>" class="form-control" readonly="">
                                                    </div> 
                                                </div>
                                            </div><br>
                                            <div class="form-group">
                                                <label>Type the problems related on electricity</label>
                                                <textarea class="form-control" name="problem" maxlength="400" id="exampleTextarea1" rows="10" required=""></textarea>
                                            </div>
                                            <input type="submit" class="btn btn-gradient-primary me-2" value="Submit">
                                            <input type="reset" class="btn btn-danger" value="Cancel">
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
            }
                    </script>
                    <script>
                        $(document).ready(function () {
                            //form submition
                            $("#form").submit(function (event) {
                                event.preventDefault();
                                $.ajax({
                                    url: "post_compliant",
                                    type: "POST",
                                    data: $("#form").serialize(),
                                    beforeSend: function () {
                                        $("#form").find("input[type='submit']").val("Loading..");
                                    },
                                    success: function (result) {
                                        if (result) {
                                            alert("Complaint submitted successfully");
                                        } else {
                                            alert("Failed to submit please try again");
                                        }
                                        $("#form").find("input[type='submit']").val("Submit");
                                    }
                                });
                            });
                        });
                    </script>
                </div>
        </body>
    <%}%>
</html>