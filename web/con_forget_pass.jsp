<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
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
                    <i class="mdi mdi-account-check text-secondary" style="font-size: 80px;"></i>
                </div><br>
                <form method="get" action="forgetPassword">
                    <div class="form-group">
                        <label class="form-label">Enter your consumer id</label>
                        <input type="text" name="conid" class="form-control">
                        <label class="form-label text-danger">${msg}</label>
                    </div>
                    <div class="form-group">
                        <a class="btn btn-gradient-info" href="con_login.jsp">Back</a>
                        <button type="submit" class="btn btn-gradient-primary">Next</button>
                    </div>
                </form>
            </div>
        </div>
    </body>
</html>
