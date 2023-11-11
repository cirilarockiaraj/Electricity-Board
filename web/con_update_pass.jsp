<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String cid = null;
    cid = (String) session.getAttribute("conID");
%>
<!DOCTYPE html>
<html>
    <head>
        <%
            if (cid == null) {
                response.sendRedirect("con_forget_pass.jsp");
                session.removeAttribute("conID");
            }
        %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>consumer_forget password</title>
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
    <style>
        body{
            background-image: url(image/slider_images/5.jpg);
            background-size: cover;
        }
        .card{
            position: absolute;
            left: 50%;
            top: 50%;
            transform: translate(-50%, -50%);
        }
    </style>
    <body>
        <div class="container-md">
            <div class="card p-4 bg-light w-25">
                <div align="center">
                    <i class="mdi mdi-file-export text-secondary" style="font-size: 80px;"></i>
                </div><br>
                <form method="post" action="changePassword">
                    <div class="form-group">
                        <label class="form-label">Password</label>
                        <div class="input-group">
                            <input type="password" name="pass" id="pass" class="form-control">
                            <span class="input-group-text" onclick="taggle_pass()"><i id="eye" class="mdi mdi-eye-off"></i></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Confirm password</label>
                        <div class="input-group">
                            <input type="password" name="con_pass" id="pass1" class="form-control">
                            <span class="input-group-text" onclick="taggle_pass1()"><i id="eye1" class="mdi mdi-eye-off"></i></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="form-label text-danger">${msg1}</label>
                    </div>
                    <div class="form-group">
                        <button type="submit" class="btn btn-gradient-primary">Update</button>
                    </div>
                </form>
            </div>
        </div>
        <script>
            function taggle_pass(){
                var pass=document.getElementById('pass');
                var eye=document.getElementById('eye');
                if(pass.type==="password"){
                    pass.type="text";
                    eye.className="mdi mdi-eye-check";
                }
                else{
                    pass.type="password";
                    eye.className="mdi mdi-eye-off";
                }
            }
            function taggle_pass1(){
                var pass=document.getElementById('pass1');
                var eye=document.getElementById('eye1');
                if(pass.type==="password"){
                    pass.type="text";
                    eye.className="mdi mdi-eye-check";
                }
                else{
                    pass.type="password";
                    eye.className="mdi mdi-eye-off";
                }
            }
        </script>
    </body>
</html>
