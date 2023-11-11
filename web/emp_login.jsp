<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>employee login</title>
        <link rel="stylesheet" type="text/css" href="page_components/vendors/mdi/css/materialdesignicons.min.css">
        <link rel="stylesheet" type="text/css" href="page_components/vendors/css/vendor.bundle.base.css">
        <link rel="stylesheet" type="text/css" href="page_components/css/style.css">
        <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
        <link rel="stylesheet" type="text/css" href="css/employee_style.css">
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jquery.js"></script>
        <link rel="shortcut icon" href="image/light.ico" />
    </head>
    <body>
        <%
            String msg2 = "error";
            if (msg2.equals(request.getAttribute("msg"))) {
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
        <div>
            <section class="vh-100">
                <div class="container py-5 h-75">
                    <div class="row d-flex justify-content-center align-items-center h-75">
                        <div class="col col-xl-10">
                            <div class="card" style="border-radius: 1rem;">
                                <div class="row g-0">
                                    <div class="col-md-6 col-lg-5 d-none d-md-block">
                                        <img src="image/login_img.jpg"alt="login form" class="img-fluid" style="border-radius: 1rem 0 0 1rem;" />
                                    </div>
                                    <div class="col-md-6 col-lg-7 d-flex align-items-center">
                                        <div class="card-body p-4 p-lg-5 text-black">
                                            <div class="d-flex">
                                                <a href="index.jsp" class="auth-link text-black text-decoration-none"><i class="mdi mdi-arrow-left" style="font-size: 25px;"></i></a>
                                            </div>
                                            <form action="EmployeeLoginServlet" method="post">
                                                <div class="d-flex align-items-center justify-content-center mb-2 pb-0">
                                                    <h2>Sign In</h2>
                                                </div>

                                                <div class="form-outline mb-4">
                                                    <input type="text" name="empid" id="form2Example17" class="form-control form-control-lg" required="" />
                                                    <label class="form-label" for="form2Example17">Employee id</label>
                                                </div>

                                                <div class="form-outline mb-4">
                                                    <div class="input-group">
                                                        <input type="password" name="pass" id="pass" class="form-control form-control-lg " required="" />
                                                        <span onclick="taggle_pass()" class="input-group-text"><i id="eye" class="mdi mdi-eye-off"></i></span>
                                                    </div>
                                                    <label class="form-label" for="form2Example27">Password</label>
                                                </div>

                                                <div class="pt-1 mb-4">
                                                    <button class="btn btn-dark btn-lg btn-block" type="submit">Login</button>
                                                </div>

                                                <a class="small text-muted" href="#!">Forgot password?</a>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </div>
    </body>
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
</html>
