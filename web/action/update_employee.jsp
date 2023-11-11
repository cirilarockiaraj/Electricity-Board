<%@page import="connection.db"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin | update admin</title>

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

            String name = request.getParameter("name");
            String pass = request.getParameter("pass");
            String dob = request.getParameter("dob");
            String contact = request.getParameter("contact");
            String email = request.getParameter("email");
            String profession = request.getParameter("profe");
            String district = request.getParameter("district");
            String office = request.getParameter("office");
            String address = request.getParameter("address");

            if (request.getParameter("update_admin") != null) {
                Class.forName("com.mysql.jdbc.Driver");
                try {
                    Connection conn = db.initializeDatabase();
                    ps2 = conn.prepareStatement("UPDATE employee_profile SET emp_name=?,dob=?, password=?, profession=?, contact_no=?, email_id=?, hire_district=?, office=?, address=? WHERE id=?");
                    ps2.setString(1, name);
                    ps2.setString(2, dob);
                    ps2.setString(3, pass);
                    ps2.setString(4, profession);
                    ps2.setString(5, contact);
                    ps2.setString(6, email);
                    ps2.setString(7, district);
                    ps2.setString(8, office);
                    ps2.setString(9, address);
                    ps2.setString(10, id);
                    ps2.executeUpdate();

        %>
        <script>swal("Success", "Record updated successfully..", "success");</script>
        <%                    } catch (Exception e) {
        %>
        <script>swal("Failur", "" + e, "Error");</script>
        <%
                }
            }
        %>


        <div class="card">
            <div class="card-body">
                <h3 class="card-title">Update administrator data</h3>
                <div class="float-end">
                    <p class="mb-0"><a class="small text-muted font-weight-bold text-decoration-none" href="../view_all_employee.jsp">< Back to dashboard</a>
                    </p>
                </div>
                <form method="post" action="">


                    <%
                        Class.forName("com.mysql.jdbc.Driver");
                        try {
                            Connection conn = db.initializeDatabase();
                            ps1 = conn.prepareStatement("select * from employee_profile where id = ?");
                            ps1.setString(1, id);
                            ResultSet rs1 = ps1.executeQuery();
                            while (rs1.next()) {
                    %>


                    <div class="form-group">
                        <img src="../emp_profiles/<%= rs1.getString("image")%>" width="110" height="150" alt="image not found"/>
                    </div>
                    <div class="form-group">
                        <label for="exampleInputUsername1">Employee ID</label>
                        <input type="text" class="form-control" name="emp_id" id="exampleInputUsername1" value="<%=rs1.getString("emp_id")%>" disabled="">
                    </div>
                    <div class="form-group">
                        <label for="exampleInputUsername1">Employee name</label>
                        <input type="text" class="form-control" name="name" id="exampleInputUsername1" value="<%=rs1.getString("emp_name")%>" required="">
                    </div>
                    <div class="form-group">
                        <label for="exampleInputPassword1">Password</label>
                        <input type="text" class="form-control" name="pass" id="exampleInputPassword1" value="<%=rs1.getString("password")%>" required="">
                    </div>

                    <div class="form-group">
                        <label for="exampleInputEmail1">Date of birth</label>
                        <input type="date" class="form-control" name="dob" value="<%=rs1.getString("dob")%>" id="exampleInputEmail1" required="">
                    </div>

                    <div class="form-group">
                        <label for="exampleInputContact">Contact number</label>
                        <input type="number" class="form-control" name="contact" id="exampleInputEmail1" value="<%=rs1.getString("contact_no")%>" >
                    </div>

                    <div class="form-group">
                        <label for="exampleInputEmail1">Email address</label>
                        <input type="email" class="form-control" name="email" id="exampleInputEmail1" value="<%=rs1.getString("email_id")%>" required="">
                    </div>

                    <div class="form-group">
                        <label for="exampleInputConfirmPassword1">Profession</label>
                        <select class="form-select" name="profe" aria-label="Default select example" required="">
                            <option value="Employee for office">Employee for Office</option>
                            <option value="Employee for power plant">Employee for power plant</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="exampleInputUsername1">Hiring District</label>
                        <select class="form-select form-select-md" name="district" aria-label=".form-select-lg example" required="">
                            <%
                                Statement stmt = conn.createStatement();
                                String sql2 = "SELECT * FROM tamilnadu_districts";
                                ResultSet rs2 = stmt.executeQuery(sql2);
                                while (rs2.next()) {
                            %>
                            <option value="<%=rs2.getString("district")%>"><%=rs2.getString("district")%></option>
                            <%}%>
                        </select>
                    </div>
                        
                    <div class="form-group">
                        <label for="exampleInputEmail1">Hire city name</label>
                        <input type="text" class="form-control" name="office" id="exampleInputEmail1" value="<%=rs1.getString("office")%>" required="">
                    </div>

                    <div class="form-group">
                        <label for="exampleInputEmail1">Address</label>
                        <textarea name="address" rows="5" class="form-control" required=""><%=rs1.getString("address")%></textarea>
                    </div>
                    <button type="submit" name="update_admin" class="btn btn-gradient-primary me-2">Update</button>
                    <button class="btn btn-gradient-danger"><a href="../view_all_admin.jsp" class="text-light text-decoration-none" >Cancel</a></button>

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
