<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Consumer login</title>
        <link rel="stylesheet" type="text/css" href="page_components/vendors/mdi/css/materialdesignicons.min.css">
        <link rel="stylesheet" type="text/css" href="page_components/vendors/css/vendor.bundle.base.css">
        <link rel="stylesheet" type="text/css" href="page_components/css/style.css">
        <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
        <link rel="stylesheet" type="text/css" href="css/design.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" />
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jquery.js"></script>
        <link rel="shortcut icon" href="image/light.ico" />
    </head>
    <body>
        <%
            String msg = "error";
            if (msg.equals(request.getAttribute("msg"))) {
        %>
        <script>
            Swal.fire({
                title: "Error",
                text: "Username or password mismatched",
                icon: "error",
                button: "Ok",
            });
        </script>
        <%
            }
            String msg1 = "locked";
            if (msg1.equals(request.getAttribute("msg"))) {
        %>
        <script>
            Swal.fire({
                title: 'Your Account is locked',
                text: 'Contact admin or account will be automatically unlocked after one day',
                imageUrl: 'image/lock.png',
                imageWidth: 200,
                imageHeight: 200,
                imageAlt: 'Custom image',
            });
        </script>
        <%
            }
        %>
        <div>
            <section class="vh-100 bg-image"
                     style="background-image: url('image/slider_images/3.jpg'); background-size: cover;">
                <div class="mask d-flex align-items-center h-100">
                    <div class="container h-100">
                        <div class="row d-flex justify-content-center align-items-center h-100">
                            <div class="col-12 col-md-9 col-lg-7 col-xl-6">
                                <div class="card" style="border-radius: 15px;">
                                    <div class="card-body p-5">
                                        <h2 class="text-uppercase text-center mb-1">Sign In</h2>

                                        <div class="d-flex justify-content-between p-3">
                                            <a href="index.jsp" class="auth-link text-black text-decoration-none float-end"><i class="fa-solid fa-arrow-left" style="font-size: 25px;"></i></a>
                                        </div>

                                        <form action="ConsumerLoginServlet" method="post">
                                            <div class="form-outline mb-4">
                                                <input type="text" id="form3Example3cg" name="conid" class="form-control form-control-lg" required="" />
                                                <label class="form-label" for="form3Example3cg">Consumer ID</label>
                                            </div>

                                            <div class="form-outline mb-4">
                                                <div class="input-group">
                                                    <input type="password" name="pass" id="pass" class="form-control form-control-lg" required="" />
                                                    <span onclick="taggle_pass()" class="input-group-text"><i id="eye" class="mdi mdi-eye-off"></i></span>
                                                </div>
                                                <label class="form-label" for="form3Example4cg">Password</label>
                                            </div>
                                            <div class="d-flex justify-content-between"
                                                 <p class="text-start text-muted mt-5 mb-0"><a href="con_forget_pass.jsp" class="fw-bold text-body">Forget password?</a></p>
                                            </div>
                                            <div class="d-flex justify-content-center">
                                                <button type="submit" class="btn btn-success btn-block btn-lg gradient-custom-4 text-body">Sign In</button>
                                            </div>

                                            <div class="d-flex justify-content-center"
                                                 <p class="text-center text-muted mt-5 mb-0">Don't have an account? <a href="register_consumer.jsp" class="fw-bold text-body"><u>Sign up</u></a></p>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
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
    </body>
</html>
