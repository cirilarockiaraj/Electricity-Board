<%@page import="java.sql.*"%>
<%@page import="connection.db"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%!
    String name = "";

%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Electricity Board | Registration</title>

        <!-- plugins:css -->
        <link rel="stylesheet" href="page_components/vendors/mdi/css/materialdesignicons.min.css">
        <link rel="stylesheet" href="page_components/vendors/css/vendor.bundle.base.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" />
        <link rel="stylesheet" href="page_components/css/style.css">
        <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script src="js/jquery.js"></script>
        <link rel="shortcut icon" href="image/light.ico" />
    </head>
    <body>
        <div class="container">
            <div class="content-wrapper">
                <div class="d-flex">
                    <a href="con_login.jsp" class="auth-link text-black text-decoration-none"><i class="fa-solid fa-arrow-left" style="font-size: 25px;"></i></a>
                </div>
                <h2 class="text-center">Register for new consumer</h2>
                <div class="row p-3">
                    <div class="col-md-12 grid-margin stretch-card">
                        <div class="card bg-dark text-light">
                            <!-- Messages -->
                            <%
                                String err = null;
                                String succ = null;
                                err = (String) request.getAttribute("message");
                                succ = (String) request.getAttribute("SuccMsg");
                                if (err != null) {
                            %>
                            <script>Swal.fire('Error !', '<%=err%>', 'error');</script>
                            <%
                                }
                                if (succ != null) {
                            %>
                            <script>Swal.fire('Account created successfully', '<%=succ%>', 'success')</script>
                            <%
                                }
                            %>
                            <div class="card-body">
                                <%                                    PreparedStatement ps;
                                %>


                                <form id="form">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="examplesno1">Service number</label>
                                                <input type="text" class="form-control" name="s_no" id="s_no" required="">
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="exampleInputUsername1">Consumer name</label>
                                                <input type="text" class="form-control" name="name" id="name" placeholder="Enter consumer name" readonly="" required="">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="exampleInputPassword1">Password</label>
                                                <div class="input-group">
                                                    <input type="password" class="form-control" name="pass" id="pass" placeholder="Password" required="">
                                                    <span class="input-group-text" onclick="taggle_pass()"><i id="eye" class="mdi mdi-eye-off"></i></span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="exampleInputPassword1">Confirm Password</label>
                                                <div class="input-group">
                                                    <input type="password" class="form-control" name="conPass" id="pass1" placeholder="Confirm password" required="">
                                                    <span class="input-group-text" onclick="taggle_pass1()"><i id="eye" class="mdi mdi-eye-off"></i></span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="exampleInputEmail1">Date of birth</label>
                                                <input type="date" class="form-control" id="dob" name="dob" readonly="" required="">
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="exampleInputEmail1">Contact number</label>
                                                <input type="number" class="form-control" id="contact" name="contact" placeholder="Contact number" readonly="" required="">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="exampleInputEmail1">Email address</label>
                                                <input type="email" class="form-control" name="email" id="email" placeholder="Email ID" readonly="" required="">
                                            </div>
                                        </div>
                                    </div>
                                    <input type="submit" name="add_consumer" class="btn btn-gradient-primary btn-rounded me-2" value="Submit">
                                    <button class="btn btn-gradient-danger btn-rounded" type="reset">Cancel</button>
                                    <div class="d-flex justify-content-end"
                                         <p class="text-center mt-5 mb-0">Do you have an account? <a href="con_login.jsp" class="fw-bold text-avatar"><u>Sign in</u></a></p>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>


    <script src="page_components/vendors/js/vendor.bundle.base.js"></script>
    <script src="page_components/js/off-canvas.js"></script>
    <script src="page_components/js/hoverable-collapse.js"></script>
    <script src="page_components/js/misc.js"></script>

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
                                                        function taggle_pass1() {
                                                            var pass = document.getElementById('pass1');
                                                            var eye = document.getElementById('eye1');
                                                            if (pass.type === "password") {
                                                                pass.type = "text";
                                                                eye.className = "mdi mdi-eye-check";
                                                            } else {
                                                                pass.type = "password";
                                                                eye.className = "mdi mdi-eye-off";
                                                            }
                                                        }
    </script>

    <script>
        $(document).ready(function () {
            $("#s_no").keyup(function () {
                let data = $("#s_no").val();
                if (data != "") {
                    $.post("registerData", {dt: data}, function (res) {
                        var dt = JSON.parse(res);
                        var array = Object.values(dt)
                        //$(".row").html(res)
                        $("#name").val(array[2]);
                        $("#dob").val(array[0]);
                        $("#contact").val(array[1]);
                        $("#email").val(array[3]);
                    });
                }
            });

            $("#form").submit(function (event) {
                event.preventDefault();
                $.ajax({
                    url: "register_consumer",
                    type: "POST",
                    data: $("#form").serialize(),
                    beforeSend: function () {
                        $("#form").find("input[type='submit']").val("Loading..");
                    },
                    success: function (result) {
                        if (result == "fill") {
                            Swal.fire('Required !', 'Please fillout all fields', 'error');
                        } else if (result == "exist") {
                            Swal.fire('Exist', 'Already exist', 'warning');
                        } else if (result == "mismatched") {
                            Swal.fire('Mismatched', 'Password and confirm password mismatched', 'error');
                        } else if (result == "minimum") {
                            Swal.fire('Minimum characters', 'Password minimum 8 characters', 'error');
                        } else {
                            location.href = "enterOTP_1.jsp";
                        }
                        $("#form").find("input[type='submit']").val("Submit");
                        clear();
                    }
                });
            });
        });
        function clear() {
            $("#form").find(".form-control").val("");
        }

    </script>
</html>