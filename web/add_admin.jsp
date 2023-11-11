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
                            <h2>Administrators</h2>

                            <!--adding new admin panel-->

                            <div class="row p-3">
                                <div class="col-md-10 grid-margin stretch-card">
                                    <div class="card">
                                        <div class="alert alert-warning alert-dismissible fade show" role="alert">
                                            ${message}
                                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                        </div>
                                        <div class="card-body">
                                            <h3 class="card-title">Add new administrator</h3>
                                            <form method="post" action="add_admin"  enctype = "multipart/form-data">

                                                <div class="form-group">
                                                    <label for="exampleimage">Choose admin image</label><br>
                                                    <input type="file" name="image" class="form-control" id="customFile" required=""/>
                                                </div>
                                                <div class="form-group">
                                                    <label for="exampleInputUsername1">Username</label>
                                                    <input type="text" class="form-control" name="uname" id="exampleInputUsername1" placeholder="Username" required="">
                                                </div>
                                                <div class="form-group">
                                                    <label for="exampleInputPassword1">Password</label>
                                                    <input type="password" class="form-control" name="pass" id="exampleInputPassword1" placeholder="Password" required="">
                                                </div>
                                                <div class="form-group">
                                                    <label for="exampleInputPassword1">Confirm Password</label>
                                                    <input type="password" class="form-control" name="conPass" id="exampleInputPassword1" placeholder="Confirm password" required="">
                                                </div>

                                                <div class="form-group">
                                                    <label for="exampleInputEmail1">Date of birth</label>
                                                    <input type="date" class="form-control" name="dob" id="exampleInputEmail1" required="">
                                                </div>

                                                <div class="form-group">
                                                    <label for="exampleInputEmail1">Contact number</label>
                                                    <input type="number" class="form-control" name="contact" id="exampleInputEmail1" placeholder="Contact number">
                                                </div>

                                                <div class="form-group">
                                                    <label for="exampleInputEmail1">Email address</label>
                                                    <input type="email" class="form-control" name="email" id="exampleInputEmail1" placeholder="Email" required="">
                                                </div>

                                                <div class="form-group">
                                                    <label for="exampleInputConfirmPassword1">Profession</label>
                                                    <select class="form-select" name="profe" aria-label="Default select example" required="">
                                                        <option selected>Select profession</option>
                                                        <option value="Administrator Lvl 1">Administrator Lvl 1</option>
                                                        <option value="Administrator Lvl 2">Administrator Lvl 2</option>
                                                    </select>
                                                </div>

                                                <div class="form-group">
                                                    <label for="exampleInputEmail1">Address</label>
                                                    <textarea name="address" name="address" class="form-control" placeholder="Enter address" required=""></textarea>
                                                </div>
                                                <button type="submit" name="add_admin_data" class="btn btn-gradient-primary me-2">Submit</button>
                                                <button class="btn btn-gradient-danger" type="reset">Cancel</button>
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
                </body>


                <script src="page_components/vendors/js/vendor.bundle.base.js"></script>
                <script src="page_components/js/off-canvas.js"></script>
                <script src="page_components/js/hoverable-collapse.js"></script>
                <script src="page_components/js/misc.js"></script>

                </html>