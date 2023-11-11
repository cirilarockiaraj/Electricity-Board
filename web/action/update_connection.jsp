<%@page import="connection.db"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin | update connection</title>

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
            String id = request.getParameter("id");
            if (request.getParameter("submit") != null) {

                String con_type = request.getParameter("con_type");
                String name = request.getParameter("name").toUpperCase();
                String father_name = request.getParameter("father_name").toUpperCase();
                String occupation = request.getParameter("occupation");
                String gender = request.getParameter("gend");
                String dob = request.getParameter("dob");
                String flat_no = request.getParameter("flat_no");
                String city = request.getParameter("city");
                String country = request.getParameter("country");
                String state = request.getParameter("state");
                String district = request.getParameter("district");
                String pincode = request.getParameter("pincode");
                String contact = request.getParameter("contact");
                String add_cont = request.getParameter("add_cont");
                String email = request.getParameter("email");

                try {
                    Connection conn=db.initializeDatabase();
                    PreparedStatement ps2 = conn.prepareStatement("UPDATE services SET 	connection_type=?, service_holder_name=?, father_name=?, occupation=?, gender=?, date_of_birth=?, house_no=?, city_village_town_name=?, district=?, state=?, country=?, pincode=?, mobile_no=?, additional_mobile_no=?, email_id=? WHERE id=?");
                    ps2.setString(1, con_type);
                    ps2.setString(2, name);
                    ps2.setString(3, father_name);
                    ps2.setString(4, occupation);
                    ps2.setString(5, gender);
                    ps2.setString(6, dob);
                    ps2.setString(7, flat_no);
                    ps2.setString(8, city);
                    ps2.setString(9, district);
                    ps2.setString(10, state);
                    ps2.setString(11, country);
                    ps2.setString(12, pincode);
                    ps2.setString(13, contact);
                    ps2.setString(14, add_cont);
                    ps2.setString(15, email);
                    ps2.setString(16, id);
                    ps2.executeUpdate();
        %>
        <script>swal("Success", "Record updated successfully", "success");</script>

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
                <h3 class="card-title">Update service connection data</h3>
                <div class="float-end">
                    <p class="mb-0"><a class="small text-muted font-weight-bold text-decoration-none" href="../view_all_connection.jsp">< Back to dashboard</a>
                    </p>
                </div>
                <form method="post" action="">
                    <%
                        String count, dist,stat;
                    %>

                    <%
                        try {
                            Connection conn=db.initializeDatabase();
                            String query = "SELECT * FROM services WHERE id=?";
                            PreparedStatement ps = conn.prepareStatement(query);
                            ps.setString(1, id);
                            ResultSet res = ps.executeQuery();
                            while (res.next()) {
                                count=res.getString("country");
                                dist=res.getString("district");
                                stat=res.getString("state");
                    %>


                    <div class="form-group">
                        <label for="exampleInputUsername1">Service number</label>
                        <input type="text" class="form-control" name="s_no" id="" value="<%= res.getString("service_no")%>" readonly="">
                    </div>
                    <div class="form-group">
                        <label for="exampleInputPassword1">Connection type</label>
                        <select class="form-select" name="con_type" aria-label="Default select example">
                            <option disabled selected><b>Low tension supply</b></option>
                        <option value="LL1A" <%if(res.getString("connection_type").equals("LL1A")){%>selected<%}%>> > Level I - A</option>
                        <option value="LL1B" <%if(res.getString("connection_type").equals("LL1B")){%>selected<%}%>> > Level I - B</option>
                        <option value="LL1C" <%if(res.getString("connection_type").equals("LL1C")){%>selected<%}%>> > Level I - C</option>
                        <option value="LL2A" <%if(res.getString("connection_type").equals("LL2A")){%>selected<%}%>> > Level II - A</option>
                        <option value="LL2B1" <%if(res.getString("connection_type").equals("LL2B1")){%>selected<%}%>> > Level II - B(1)</option>
                        <option value="LL2B2" <%if(res.getString("connection_type").equals("LL2B2")){%>selected<%}%>> > Level II - B(2)</option>
                        <option value="LL2C" <%if(res.getString("connection_type").equals("LL2C")){%>selected<%}%>> > Level II - C</option>
                        <option value="LL3A1" <%if(res.getString("connection_type").equals("LL3A1")){%>selected<%}%>> > Level III - A(1)</option>
                        <option value="LL3A2" <%if(res.getString("connection_type").equals("LL3A2")){%>selected<%}%>> > Level III - A(2)</option>
                        <option value="LL3B" <%if(res.getString("connection_type").equals("LL3B")){%>selected<%}%>> > Level III - B</option>
                        <option value="LL4" <%if(res.getString("connection_type").equals("LL4")){%>selected<%}%>> > Level IV</option>
                        <option value="LL5" <%if(res.getString("connection_type").equals("LL5")){%>selected<%}%>> > Level V</option>
                        <option value="LL6" <%if(res.getString("connection_type").equals("LL6")){%>selected<%}%>> > Level VI</option>
                        <option disabled>--------------------------------------------------------</option>
                        <option disabled><b>High tension supply</b></option>
                        <option value="HL1" <%if(res.getString("connection_type").equals("HL1")){%>selected<%}%>> > Level I - A & B</option>
                        <option value="HL2" <%if(res.getString("connection_type").equals("HL2")){%>selected<%}%>> > Level II - A & B</option>
                        <option value="HL3" <%if(res.getString("connection_type").equals("HL3")){%>selected<%}%>> > Level III</option>
                        <option value="HL4" <%if(res.getString("connection_type").equals("HL4")){%>selected<%}%>> > Level IV</option>
                        <option value="HL5" <%if(res.getString("connection_type").equals("HL5")){%>selected<%}%>> > Level V</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="exampleInputPassword1">Service holder name</label>
                        <input type="text" class="form-control" name="name" id="" value="<%= res.getString("service_holder_name")%>" >
                    </div>

                    <div class="form-group">
                        <label for="exampleInputPassword1">Father's name</label>
                        <input type="text" class="form-control" name="father_name" value="<%= res.getString("father_name")%>" >
                    </div>

                    <div class="form-group">
                        <label for="exampleInputEmail1">Occupation</label>
                        <input type="text" class="form-control" name="occupation" value="<%= res.getString("occupation")%>" id="exampleInputEmail1" >
                    </div>

                    <div class="form-group">
                        <label for="exampleInputEmail1">Gender</label>
                        <select class="form-select" name="gend" aria-label="Default select example" >
                            <option value="Male" <%if(res.getString("gender").equals("Male")){%>selected<%}%>>Male</option>
                            <option value="Female" <%if(res.getString("gender").equals("Female")){%>selected<%}%>>Female</option>
                            <option value="Transgender" <%if(res.getString("gender").equals("Transgender")){%>selected<%}%>>Transgender</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="exampleInputConfirmPassword1">Date of birth</label>
                        <input type="date" class="form-control" name="dob" value="<%= res.getString("date_of_birth")%>" >
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="exampleInputEmail1">House/flat no</label>
                        <input type="text" class="form-control" name="flat_no" value="<%= res.getString("house_no")%>" >
                    </div>

                    <div class="form-group">
                        <label for="exampleInputEmail1">Village/city name</label>
                        <input type="text" class="form-control" name="city" value="<%= res.getString("city_village_town_name")%>" >
                    </div>

                    <div class="form-group">
                        <label for="exampleInputEmail1">District</label>
                        <select class="form-select form-select-md" name="district" aria-label=".form-select-lg example" >
                        <%
                            String sql3 = "SELECT * FROM tamilnadu_districts";
                            PreparedStatement ps1 = conn.prepareStatement(sql3);
                            ResultSet rs3 = ps1.executeQuery(sql3);
                            while (rs3.next()) {
                                String district=rs3.getString("district");
                        %>
                        <option value="<%=district%>" <%if(dist.equals(district)){%>selected<%}%>><%=rs3.getString("district")%></option>
                        <%}%>
                    </select>
                    </div>

                    <div class="form-group">
                        <label for="exampleInputEmail1">State</label>
                        <select class="form-select form-select-md" name="state" aria-label=".form-select-lg example" >
                        <%
                            String sql2 = "SELECT * FROM indian_states";
                            PreparedStatement ps2 = conn.prepareStatement(sql2);
                            ResultSet rs2 = ps2.executeQuery(sql2);
                            while (rs2.next()) {
                                String state=rs2.getString("state");
                        %>
                        <option value="<%=state%>" <%if(stat.equals(state)){%>selected<%}%>><%=rs2.getString("state")%></option>
                        <%}%>
                    </select>
                    </div>

                    <div class="form-group">
                        <label for="exampleInputEmail1">Country</label>
                        <select class="form-select form-select-md" name="country" aria-label=".form-select-lg example" >
                        <%
                            String sql1 = "SELECT * FROM country";
                            PreparedStatement ps3 = conn.prepareStatement(sql1);
                            ResultSet rs1 = ps3.executeQuery(sql1);
                            while (rs1.next()) {
                                String country=rs1.getString("country_name");
                        %>
                        <option value="<%=country%>" <%if(count.equals(country)){%>selected<%}%>><%=rs1.getString("country_name")%></option>
                        <%}%>
                    </select>
                    </div>

                    <div class="form-group">
                        <label for="exampleInputEmail1">Pincode</label>
                        <input type="text" class="form-control" name="pincode" value="<%=res.getString("pincode")%>" >
                    </div>

                    <div class="form-group">
                        <label for="exampleInputEmail1">Contact number</label>
                        <input type="text" class="form-control" name="contact" value="<%= res.getString("mobile_no")%>" >
                    </div>

                    <div class="form-group">
                        <label for="exampleInputEmail1">Additional contact number</label>
                        <input type="text" class="form-control" name="add_cont" value="<%= res.getString("additional_mobile_no")%>">
                    </div>

                    <div class="form-group">
                        <label for="exampleInputEmail1">Email id</label>
                        <input type="email" class="form-control" name="email" value="<%= res.getString("email_id")%>" >
                    </div>

                    <button type="submit" name="submit" class="btn btn-gradient-primary me-2">Update</button>
                    <button class="btn btn-gradient-danger"><a href="../view_all_connection.jsp" class="text-light text-decoration-none" >Cancel</a></button>

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
