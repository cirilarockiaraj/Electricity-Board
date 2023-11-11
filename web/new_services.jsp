<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>new service</title>
        <link rel="stylesheet" href="page_components/vendors/mdi/css/materialdesignicons.min.css">
        <link rel="stylesheet" href="page_components/vendors/css/vendor.bundle.base.css">
        <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
        <link rel="stylesheet" type="text/css" href="css/design.min.css" />
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jquery.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" />
        <link rel="shortcut icon" href="image/light.ico" />
    </head>
    <body>
        <!<!-- header -->
        <div>
            <jsp:include page="includes/header.jsp"></jsp:include>
            </div>
            <!--content-->
            <div class="container-lg">
                <div class="p-5"></div>
                <br>
                <h2>Apply new connection</h2>
                <hr>
                <br>
                <div class="myclass p-5 bg-light">
                <jsp:include page="includes/new_service.jsp"></jsp:include>
                </div>
            </div>
            <br>
            <!--footer-->
            <div>
            <jsp:include page="includes/footer.jsp"></jsp:include>
        </div>

    </body>
</html>
