<%@page import="connection.db"%>
<%@page import="java.sql.*"%>
<div class="card-body">
    <h3 class="card-title">Add new consumer</h3>

    <%
        PreparedStatement ps;
    %>


    <form action="add_consumer" method="post">
        <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <label for="exampleInputUsername1">Consumer name</label>
                    <input type="text" class="form-control" name="name" id="exampleInputUsername1" placeholder="Username" required="">
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label for="examplesno1">Service number</label>
                    <input class="form-control" list="browsers" name="s_no" id="browser" required="">
                    <datalist id="browsers">

                        <%
                            try {
                                Connection conn = db.initializeDatabase();
                                String query3 = "SELECT service_no FROM services";
                                ps = conn.prepareStatement(query3);
                                ResultSet rs = ps.executeQuery();
                                while (rs.next()) {
                        %>

                        <option value="<%=rs.getString("service_no")%>">

                            <%
                                    }
                                } catch (Exception e) {
                                    out.print(e);
                                }
                            %>


                    </datalist>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <label for="exampleInputPassword1">Password</label>
                    <input type="password" class="form-control" name="pass" id="exampleInputPassword1" placeholder="Password" required="">
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label for="exampleInputPassword1">Confirm Password</label>
                    <input type="password" class="form-control" name="conPass" id="exampleInputPassword2" placeholder="Confirm password" required="">
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <label for="exampleInputEmail1">Date of birth</label>
                    <input type="date" class="form-control" name="dob" id="exampleInputEmail1" required="">
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label for="exampleInputEmail1">Contact number</label>
                    <input type="number" class="form-control" name="contact" id="exampleInputEmail1" placeholder="Contact number">
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <label for="exampleInputEmail1">Email address</label>
                    <input type="email" class="form-control" name="email" id="exampleInputEmail1" placeholder="Email">
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label for="exampleInputConfirmPassword1">Profession &nbsp;<i>(Default)</i></label>
                    <input type="text" class="form-control" name="profe" id="exampleInputEmail1" value="Consumer" readonly="">
                </div>
            </div>
        </div>
        <button type="submit" name="add_consumer" class="btn btn-gradient-primary me-2">Submit</button>
        <button class="btn btn-gradient-danger" type="reset">Cancel</button>
    </form>
</div>