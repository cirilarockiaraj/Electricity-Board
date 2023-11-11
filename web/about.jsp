<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>About</title>
        <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
        <link rel="stylesheet" type="text/css" href="css/dataTables.min.css" />
        <link rel="stylesheet" type="text/css" href="css/design.min.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" />
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jquery.dataTables.min.js"></script>
        <script src="js/jquery.js"></script>
        <script src="js/popper.min.js"></script>
        <link rel="shortcut icon" href="image/light.ico" />
    </head>
    <body>
        <!<!-- header -->
        <div>
            <jsp:include page="includes/header.jsp"></jsp:include>
        </div>
        <!--content-->
        <div class="container">
            <div class="p-5"></div>
            <br>
            <h2>About</h2>
            <hr>
        </div>
        <br>
        <div class="container bg-light">
            <jsp:include page="includes/about_data.jsp"></jsp:include>
        </div>
        <br>
        <!--footer-->
        <div>
            <jsp:include page="includes/footer.jsp"></jsp:include>
        </div>

    </body>
</html>
