<%@page import="connection.db"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Contact</title>
        <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
        <link rel="stylesheet" type="text/css" href="css/design.min.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" />
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jquery.js"></script>
        <script src="js/popper.min.js"></script>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <link rel="shortcut icon" href="image/light.ico" />
    </head>
    <body>


        <%
            int updateQuery = 0;
            String status = "read";

            if (request.getParameter("submit") != null) {
                String name = request.getParameter("name");
                String email = request.getParameter("email");
                String subject = request.getParameter("subject");
                String message = request.getParameter("message");
                if (name == "" || email == "" || subject == "" || message == "") {
        %>
        <script>
            Swal.fire({
                icon: 'error',
                title: 'Oops...',
                text: 'Please fill out all fields!'
            });
        </script>
        <%
        } else {
            try {
                Connection conn=db.initializeDatabase();
                String query = "INSERT INTO contact_msg(name, email_id, subject, message, status) VALUES (?,?,?,?,?)";
                PreparedStatement ps = conn.prepareStatement(query);
                ps.setString(1, name);
                ps.setString(2, email);
                ps.setString(3, subject);
                ps.setString(4, message);
                ps.setString(5, status);

                updateQuery = ps.executeUpdate();
                if (updateQuery > 0) {
        %>
        <script>
            Swal.fire(
                    'Success!',
                    'Your message sended succesfully!',
                    'success'
                    );
        </script>
        <%
            }
        } catch (Exception e) {
        %>
        <script>
            Swal.fire(
                    'The Internet?',
                    'That thing is still around?',
                    'question'
                    );
        </script>
        <%
                    }
                }
            }
        %>



        <!-- header -->
        <div>
            <jsp:include page="includes/header.jsp"></jsp:include>
            </div>
            <!--content-->
            <div class="container-lg">
                <div class="p-5"></div>
                <br>
                <!--Section: Contact v.2-->
            <jsp:include page="includes/contact.jsp"></jsp:include>
                <!--Section: Contact v.2-->
            </div>

            <!--footer-->
            <div>
            <jsp:include page="includes/footer.jsp"></jsp:include>
        </div>
    </body>
</html>
