<%@page import="connection.db"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin | update consumer</title>

        <link rel="stylesheet" type="text/css" href="../page_components/vendors/mdi/css/materialdesignicons.min.css">
        <link rel="stylesheet" type="text/css" href="../page_components/vendors/css/vendor.bundle.base.css">
        <link rel="stylesheet" type="text/css" href="../page_components/css/style.css">
        <link rel="stylesheet" type="text/css" href="../css/design.min.css">
        <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" />
        <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.1.3/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.3/css/dataTables.bootstrap5.min.css"/>
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/buttons/2.2.3/css/buttons.bootstrap5.min.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <link rel="shortcut icon" href="../image/light.ico" />


    </head>
    <body class="container-md p-5">


        <%
            PreparedStatement ps1, ps2;
            String id = request.getParameter("id");

            if (request.getParameter("update_consumer") != null) {

                String con_id = request.getParameter("con_id");
                String pass = request.getParameter("pass");
                String name = request.getParameter("name");
                String s_no = request.getParameter("s_no");
                String dob = request.getParameter("dob");
                String contact = request.getParameter("contact");
                String email = request.getParameter("email");
                String profession = request.getParameter("profe");

                try {
                    Connection conn=db.initializeDatabase();
                    ps2 = conn.prepareStatement("UPDATE consumer_profile SET consumer_id=?, password=?, name=?, service_no=?, dob=?, profession=?, contact_no=?,email_id=? WHERE id=?");
                    ps2.setString(1, con_id);
                    ps2.setString(2, pass);
                    ps2.setString(3, name);
                    ps2.setString(4, s_no);
                    ps2.setString(5, dob);
                    ps2.setString(6, profession);
                    ps2.setString(7, contact);
                    ps2.setString(8, email);
                    ps2.setString(9, id);
                    ps2.executeUpdate();

        %>
        <script>swal("Success", "Record updated successfully..", "success");</script>
        <%                    
            } catch (Exception e) {
        %>
        <script>swal("Failur", "" + e, "Error");</script>
        <%
                }
            }
        %>


        <div class="card">
            <div class="card-body">
                <h3 class="card-title">Update consumer data</h3>
                <div class="float-end">
                    <p class="mb-0"><a class="small text-muted font-weight-bold text-decoration-none" href="../emp_view_consumer.jsp">< Back to dashboard</a>
                    </p>
                </div>
                <form method="post" action="">


                    <%
                        try {
                            Connection conn=db.initializeDatabase();
                            ps1 = conn.prepareStatement("select * from consumer_profile where id = ?");
                            ps1.setString(1, id);
                            ResultSet rs1 = ps1.executeQuery();
                            while (rs1.next()) {
                    %>

                    <div class="form-group">
                        <label for="exampleInputUsername1">Consumer ID</label>
                        <input type="text" class="form-control" name="con_id" id="" value="<%=rs1.getString("consumer_id")%>" readonly="">
                    </div>
                    <div class="form-group">
                        <label for="exampleInputPassword1">Password</label>
                        <input type="text" class="form-control" name="pass" id="" value="<%=rs1.getString("password")%>" required="">
                    </div>

                    <div class="form-group">
                        <label for="exampleInputPassword1">Consumer name</label>
                        <input type="text" class="form-control" name="name" id="" value="<%=rs1.getString("name")%>" required="">
                    </div>

                    <div class="form-group">
                        <label for="exampleInputPassword1">Service number</label>
                        <input type="text" class="form-control" name="s_no" value="<%=rs1.getString("service_no")%>" readonly="">
                    </div>

                    <div class="form-group">
                        <label for="exampleInputEmail1">Date of birth</label>
                        <input type="date" class="form-control" name="dob" value="<%=rs1.getString("dob")%>" id="exampleInputEmail1" required="">
                    </div>

                    <div class="form-group">
                        <label for="exampleInputContact">Contact number</label>
                        <input type="number" class="form-control" name="contact" value="<%=rs1.getString("contact_no")%>" >
                    </div>

                    <div class="form-group">
                        <label for="exampleInputEmail1">Email address</label>
                        <input type="email" class="form-control" name="email" value="<%=rs1.getString("email_id")%>" required="">
                    </div>

                    <div class="form-group">
                        <label for="exampleInputConfirmPassword1">Profession</label>
                        <input type="text" class="form-control" name="profe" value="<%=rs1.getString("profession")%>" readonly="">
                        </select>
                    </div>

                    <button type="submit" name="update_consumer" class="btn btn-gradient-primary me-2">Update</button>
                    <button class="btn btn-gradient-danger"><a href="../view_all_consumer.jsp" class="text-light text-decoration-none" >Cancel</a></button>

                    <%
                            }
                        } catch (Exception e) {
                            out.print(e);
                        }
                    %>

                </form>
            </div>
        </div>


        <script src="../page_components/vendors/js/vendor.bundle.base.js"></script>
        <script src="../page_components/js/off-canvas.js"></script>
        <script src="../page_components/js/hoverable-collapse.js"></script>
        <script src="../page_components/js/misc.js"></script>
        <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.12.1/js/jquery.dataTables.js"></script>

    </body>
</html>
