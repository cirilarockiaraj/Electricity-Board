<%@page import="connection.db"%>
<%@page import="java.sql.*"%>
<div class="row p-3">
    <div class="col-md-10 grid-margin stretch-card">
        <div class="card">
            <div class="alert alert-warning alert-dismissible fade show" role="alert">
                <p>Total Amount is : ${tot}</p>
                <p>${msg}</p>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <div class="card-body">
                <h3 class="card-title">Add unit</h3><br>
                <form method="post" action="add_unit">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="exampleInputUsername1">Service number</label>
                                <input class="form-control" list="browsers" name="s_no" id="browser" required="">
                                <datalist id="browsers">

                                    <%
                                        try {
                                            Connection conn = db.initializeDatabase();
                                            String query3 = "SELECT service_no FROM services";
                                            PreparedStatement ps = conn.prepareStatement(query3);
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
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="exampleInputPassword1">Enter no.of Unit consumed</label>
                                <input type="text" class="form-control" name="unit" placeholder="Enter no.of unit" required="">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="exampleInputConfirmPassword1">Supply type</label>
                                <select class="form-select" name="s_type" aria-label="Default select example" required="">
                                    <option disabled selected><b>Low tension supply</b></option>
                                    <option value="LL1A"> > Level I - A</option>
                                    <option value="LL1B"> > Level I - B</option>
                                    <option value="LL1C"> > Level I - C</option>
                                    <option value="LL2A"> > Level II - A</option>
                                    <option value="LL2B1"> > Level II - B(1)</option>
                                    <option value="LL2B2"> > Level II - B(2)</option>
                                    <option value="LL2C"> > Level II - C</option>
                                    <option value="LL3A1"> > Level III - A(1)</option>
                                    <option value="LL3A2"> > Level III - A(2)</option>
                                    <option value="LL3B"> > Level III - B</option>
                                    <option value="LL4"> > Level IV</option>
                                    <option value="LL5"> > Level V</option>
                                    <option value="LL6"> > Level VI</option>
                                    <option disabled>----------------------------------------------------------------------------------------------------------</option>
                                    <option disabled><b>High tension supply</b></option>
                                    <option value="HL1"> > Level I - A & B</option>
                                    <option value="HL2"> > Level II - A & B</option>
                                    <option value="HL3"> > Level III</option>
                                    <option value="HL4"> > Level IV</option>
                                    <option value="HL5"> > Level V</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="exampleInputConfirmPassword1">Select month</label>
                                <select class="form-select" name="month" aria-label="Default select example" required="">
                                    <option selected disabled>Select month</option>
                                    <option value="January">January</option>
                                    <option value="February">February</option>
                                    <option value="March">March</option>
                                    <option value="April">April</option>
                                    <option value="May">May</option>
                                    <option value="June">June</option>
                                    <option value="July">July</option>
                                    <option value="August">August</option>
                                    <option value="September">September</option>
                                    <option value="October">October</option>
                                    <option value="November">November</option>
                                    <option value="December">December</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <button type="submit" name="add_Unit" class="btn btn-gradient-primary me-2">Submit</button>
                        <button class="btn btn-gradient-danger" type="reset">Cancel</button>
                    </div>
                </form>
            </div>
        </div>
    </div>