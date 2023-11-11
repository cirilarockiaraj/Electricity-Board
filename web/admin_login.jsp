<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Administrator Login</title>
        <link rel="stylesheet" type="text/css" href="page_components/vendors/mdi/css/materialdesignicons.min.css">
        <link rel="stylesheet" type="text/css" href="page_components/vendors/css/vendor.bundle.base.css">
        <link rel="stylesheet" type="text/css" href="page_components/css/style.css">
        <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
        <link rel="stylesheet" href="page_components/vendors/mdi/css/materialdesignicons.min.css">
        <link rel="stylesheet" href="page_components/vendors/css/vendor.bundle.base.css">
        <link rel="stylesheet" href="page_components/css/style.css">
        <link rel="stylesheet" type="text/css" href="css/design.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" />
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jquery.js"></script>
        <link rel="shortcut icon" href="image/light.ico" />
    </head>
    <body>
        <%
            String msg1 = "error";
            if (msg1.equals(request.getAttribute("msg"))) {
        %>
        <script>
            swal({
                title: "Error",
                text: "Username or password mismatched",
                icon: "error",
                button: "Ok",
            });
        </script>
        <%
            }
        %>
        <div class="container-scroller">
            <div class="container-fluid page-body-wrapper full-page-wrapper">
                <div class="content-wrapper d-flex align-items-center auth">
                    <div class="row flex-grow">
                        <div class="col-lg-4 mx-auto">
                            <div class="auth-form-light text-left p-5">
                                <div class="d-flex">
                                    <a href="index.jsp" class="auth-link text-black text-decoration-none"><i class="mdi mdi-arrow-left" style="font-size: 25px;"></i></a>
                                </div>
                                <div class="brand-logo">
                                    <h2 class="text-center">Admin</h2>
                                </div>
                                <h6 class="font-weight-light">Sign in to continue.</h6>
                                <form class="pt-3" method="post" action="AdminLoginServlet">
                                    <div class="form-group">
                                        <input type="text" class="form-control form-control-lg" id="exampleInputEmail1" name="user" placeholder="Username" required="">
                                    </div>
                                    <div class="form-group">
                                        <div class="input-group">
                                            <input type="password" class="form-control form-control-lg" id="pass" name="pass" placeholder="Password" required="">
                                            <span onclick="taggle_pass()" class="input-group-text"><i id="eye" class="mdi mdi-eye-off"></i></span>
                                        </div>
                                    </div>
                                    <div class="mt-3">
                                        <button type="submit" class="btn btn-block btn-gradient-primary btn-lg font-weight-medium auth-form-btn" name="submit">SIGN IN</button>
                                    </div>
                                    <div class="my-2 d-flex justify-content-between align-items-center">
                                        <a href="#" class="auth-link text-black">Forgot password?</a>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- content-wrapper ends -->
            </div>
            <!-- page-body-wrapper ends -->
        </div>

        <script>
            function taggle_pass() {
                var pass = document.getElementById('pass');
                var eye = document.getElementById('eye');
                if (pass.type === "password") {
                    pass.type = "text";
                    eye.className = "mdi mdi-eye-check";
                } else {
                    pass.type = "password";
                    eye.className = "mdi mdi-eye-off";
                }
            }
        </script>

        <!-- container-scroller -->
        <!-- plugins:js -->
        <script src="../../assets/vendors/js/vendor.bundle.base.js"></script>
        <!-- endinject -->
        <!-- Plugin js for this page -->
        <!-- End plugin js for this page -->
        <!-- inject:js -->
        <script src="page_components/js/off-canvas.js"></script>
        <script src="page_components/js/hoverable-collapse.js"></script>
        <script src="page_components/js/misc.js"></script>
        <!-- endinject -->
    </body>
</html>
