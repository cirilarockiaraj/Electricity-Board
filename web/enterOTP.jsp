<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String cid = null;
    cid = (String) session.getAttribute("conID");
    String email = (String) request.getAttribute("email");
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
        input{
            text-align: center;
            font-weight: bold;
            font-size: 25px;
        }
    </style>
    <body>
        <div class="container-md">
            <div class="card p-4 bg-light" style="width: 10cm;">
                <div align="center">
                    <i class="mdi mdi-shield-check text-success" style="font-size: 60px;"></i>
                </div><br>
                <p><b>The OTP sends your registered email id of <i><%out.print(email.substring(0, 5));%>xxxxxxxx</i>&nbsp;<i id="timer"></i></b></p>
                <form method="post" action="verifyOTP">
                    <div class="form-group">
                        <label class="form-label">Enter OTP</label><br>
                        <input type="text" name="n1" id="first" class="form-control-color" onkeyup="movetoNext(this, 'second')" maxlength="1">
                        <input type="text" name="n2" id="second" class="form-control-color" onkeyup="movetoNext(this, 'third')" maxlength="1">
                        <input type="text" name="n3" id="third" class="form-control-color" onkeyup="movetoNext(this, 'fourth')" maxlength="1">
                        <input type="text" name="n4" id="fourth" class="form-control-color" onkeyup="movetoNext(this, 'fifth')" maxlength="1">
                        <input type="text" name="n5" id="fifth" class="form-control-color" maxlength="1"><br>
                        <label class="form-label text-danger">${msg}</label>
                    </div>
                    <div class="form-group" id="verify">
                        <button type="submit" class="btn btn-primary">Verify OTP</button>
                    </div>
                    <div class="form-group" id="resend" style="display: none;">
                        <a href="forgetPassword?conid=<%=cid%>" class="btn btn-primary w-50">Resend OTP</a>
                    </div>
                </form>
            </div>
        </div>
    </body>
    <script>
        const COUNTER_KEY = 'my-counter';

        function countDown(i, callback) {
            //callback = callback || function(){};
            timer = setInterval(function () {
                minutes = parseInt(i / 60, 10);
                seconds = parseInt(i % 60, 10);

                minutes = minutes < 10 ? "0" + minutes : minutes;
                seconds = seconds < 10 ? "0" + seconds : seconds;

                document.getElementById('timer').innerHTML = " Valid : " + minutes + ":" + seconds;

                if ((i--) > 0) {
                    window.sessionStorage.setItem(COUNTER_KEY, i);
                } else {
                    document.getElementById("verify").style.display = "none";
                    document.getElementById("resend").style.display = "block";
                    window.sessionStorage.removeItem(COUNTER_KEY);
                    clearInterval(timer);
                    callback();
                }
            }, 1000);
        }
        window.onload = function () {
            var countDownTime = window.sessionStorage.getItem(COUNTER_KEY) || 120;
            countDown(countDownTime, function () {
                $('#myModal').modal('show');
            });
        };
    </script>


    <script type="text/javascript">
        document.getElementById("first").focus();
        function movetoNext(current, nextFieldID) {
            if (current.value.length >= current.maxLength) {
                document.getElementById(nextFieldID).focus();
            }
        }
    </script>
</html>
