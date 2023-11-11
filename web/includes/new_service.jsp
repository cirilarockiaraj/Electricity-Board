<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="mailer.mail"%>
<%@page import="connection.db"%>
<%@page import="java.sql.*"%>

<%
    try {
        Connection conn = db.initializeDatabase();
        Statement stmt = conn.createStatement();
%>
<form id="form" onsubmit="return validateForm()">
    <section class="p-5">
        <!--1st row-->
        <div class="row">
            <input type="text" class="form-control" value="" readonly="" disabled="">
            <br><br>
            <h5>General Information</h5>
            <hr>
            <p><b>Note : </b>request number is generated automatically.</p>
            <br><br>
            <div class="col-md-4">
                <!--dropend button -->
                <div class="form-group">
                    <label for="exampleInputUsername1">Select connection type</label>&nbsp;&nbsp;*
                    <select class="form-select form-select-md" name="con_type" aria-label=".form-select-lg example" required="">
                        <option disabled selected value="">Please select the connection type</option>
                        <option disabled><b>Low tension supply</b></option>
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
                        <option disabled>--------------------------------------------------------</option>
                        <option disabled><b>High tension supply</b></option>
                        <option value="HL1"> > Level I - A & B</option>
                        <option value="HL2"> > Level II - A & B</option>
                        <option value="HL3"> > Level III</option>
                        <option value="HL4"> > Level IV</option>
                        <option value="HL5"> > Level V</option>
                    </select>
                </div>
                <!--// dropend button--> 
            </div>
            <div class="col-md-4">
                <a class="text-decoration-none link-primary" href="includes/tariff_pdf.html" target="_blank">View tariff detail</a>
            </div>
        </div>
        <!--// 1st row-->

        <br>
        <br>
        <!--2nd row-->
        <div class="row">
            <h5>Applicant details</h5>
            <hr>
            <div class="col-md-4">
                <div class="form-group">
                    <label for="exampleInputUsername1">First name</label>&nbsp;&nbsp;*
                    <input type="text" class="form-control" name="fname" placeholder="Enter first name" required="">
                </div>
            </div>

            <div class="col-md-4">
                <div class="form-group">
                    <label for="exampleInputUsername1">Last name</label>&nbsp;&nbsp;*
                    <input type="text" class="form-control" name="lname" placeholder="Enter last name" required="">
                </div>
            </div>

            <div class="col-md-4">
                <div class="form-group">
                    <label for="exampleInputUsername1">Father's name</label>&nbsp;&nbsp;*
                    <input type="text" class="form-control" name="father_name" placeholder="enter your father's name" required="">
                </div>
            </div>
        </div>
        <!--// 2nd row-->
        <br>
        <!--2nd sub row-->
        <div class="row">
            <div class="col-md-4">
                <div class="form-group">
                    <label for="exampleInputUsername1">Date of birth</label>&nbsp;&nbsp;*
                    <input type="date" class="form-control" id="datefield" max="" name="dob" required="">
                    <i class="text-danger" id="dobErr"></i>
                </div>
            </div>

            <div class="col-md-4">
                <div class="form-group">
                    <label for="exampleInputUsername1">Occupation</label>&nbsp;&nbsp;*
                    <input type="text" class="form-control" id="exampleInputUsername1" name="occupation" placeholder="Enter your occupation" required="">
                </div>
            </div>

            <div class="col-md-4">
                <div class="form-group">
                    <label for="exampleInputUsername1">Gender</label>&nbsp;&nbsp;*<br>
                    <div class="btn-group" role="group" aria-label="Basic radio toggle button group">
                        <label class="form-check-label">
                            <input type="radio" class="form-check-input" name="gend" id="optionsRadios1" value="Male"> Male
                        </label>
                        &nbsp;&nbsp;&nbsp;
                        <label class="form-check-label">
                            <input type="radio" class="form-check-input" name="gend" id="optionsRadios1" value="Female"> Female
                        </label>
                        &nbsp;&nbsp;&nbsp;
                        <label class="form-check-label">
                            <input type="radio" class="form-check-input" name="gend" id="optionsRadios1" value="Transgender"> Transgender
                        </label>
                    </div>
                </div>
            </div>
        </div>

        <!--//2nd sub row-->
        <br> 
        <br>
        <!--3rd row-->
        <div class="row">
            <h5>Address at which supply requires</h5>
            <hr>
            <div class="col-md-4">
                <div class="form-group">
                    <label for="exampleInputUsername1">plot/flat/house/survey number</label>&nbsp;&nbsp;*
                    <input type="text" class="form-control" id="exampleInputUsername1" name="flat_no" placeholder="plot/flat/house/survey number" required="">
                </div>
            </div>

            <div class="col-md-4">
                <div class="form-group">
                    <label for="exampleInputUsername1">village/city name</label>&nbsp;&nbsp;*
                    <input type="text" class="form-control" id="exampleInputUsername1" name="city" placeholder="village/city name" required="">
                </div>
            </div>

            <div class="col-md-4">
                <div class="form-group">
                    <label for="exampleInputUsername1">Country</label>&nbsp;&nbsp;*
                    <select class="form-select form-select-md" name="country" aria-label=".form-select-lg example" required="">
                        <%
                            String sql1 = "SELECT * FROM country";
                            ResultSet rs1 = stmt.executeQuery(sql1);
                            while (rs1.next()) {
                        %>
                        <option value="<%=rs1.getString("country_name")%>"><%=rs1.getString("country_name")%></option>
                        <%}%>
                    </select>
                </div>
            </div>
        </div>
        <!--// 3rd row-->
        <br>
        <!--4th row-->
        <div class="row">
            <div class="col-md-4">
                <div class="form-group">
                    <label for="exampleInputUsername1">State</label>&nbsp;&nbsp;*
                    <select class="form-select form-select-md" name="state" aria-label=".form-select-lg example" required="">
                        <%
                            String sql2 = "SELECT * FROM indian_states";
                            ResultSet rs2 = stmt.executeQuery(sql2);
                            while (rs2.next()) {
                        %>
                        <option value="<%=rs2.getString("state")%>"><%=rs2.getString("state")%></option>
                        <%}%>
                    </select>
                </div>
            </div>

            <div class="col-md-4">
                <div class="form-group">
                    <label for="exampleInputUsername1">District</label>&nbsp;&nbsp;*
                    <select class="form-select form-select-md" name="district" aria-label=".form-select-lg example" required="">
                        <%
                            String sql3 = "SELECT * FROM tamilnadu_districts";
                            ResultSet rs3 = stmt.executeQuery(sql3);
                            while (rs3.next()) {
                        %>
                        <option value="<%=rs3.getString("district")%>"><%=rs3.getString("district")%></option>
                        <%}%>
                    </select>
                </div>
            </div>

            <div class="col-md-4">
                <div class="form-group">
                    <label for="exampleInputUsername1">Pincode</label>&nbsp;&nbsp;*
                    <input type="text" class="form-control" id="exampleInputUsername1" name="pincode" placeholder="Enter pincode" maxlength="6" required="">
                </div>
            </div>
        </div>
        <!--// 4th row-->


        <br><br>
        <!--5th row-->
        <div class="row">
            <h5>Contact details</h5>
            <hr>
            <div class="col-md-4">
                <div class="form-group">
                    <label for="exampleInputUsername1">Contact number</label>&nbsp;&nbsp;*
                    <input type="tel" class="form-control" pattern="[6-9]{1}[0-9]{9}" name="contact" placeholder="Enter your contact number" minlength="10" maxlength="10" required="">
                </div>
            </div>

            <div class="col-md-4">
                <div class="form-group">
                    <label for="exampleInputUsername1">Additional contact number</label>&nbsp;&nbsp;<i>(optional)</i>
                    <input type="tel" class="form-control" name="add_cont" placeholder="Enter additional contact number" minlength="10" maxlength="10">
                </div>
            </div>

            <div class="col-md-4">
                <div class="form-group">
                    <label for="exampleInputUsername1">Email Id</label>&nbsp;&nbsp;*
                    <input type="email" name="email" class="form-control" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$"  placeholder="Enter your email id" required="">
                </div>
            </div>
        </div>
        <!--// 5th row-->
        <br>
        <br>
        <div class="row">
            <hr>
            <div class="col-md-auto">
                <input type="submit" name="submit" class="btn btn-primary" value="Submit">
            </div>
            <div class="col-md-auto">
                <input type="reset" name="reset" class="btn btn-danger" value="Clear">
            </div>
        </div>
    </section>
</form>
<%
    } catch (Exception e) {
        out.print(e);
    }
%>
<script>
    var today = new Date();
    var dd = today.getDate();
    var mm = today.getMonth() + 1; //January is 0!
    var yyyy = today.getFullYear();

    if (dd < 10) {
        dd = '0' + dd;
    }

    if (mm < 10) {
        mm = '0' + mm;
    }

    today = yyyy + '-' + mm + '-' + dd;
    document.getElementById("datefield").setAttribute("max", today);
</script>
<script>
    function validateForm() {
        var date = document.getElementById("datefield").value;
        var varDate = new Date(date);

        if (varDate >= new Date(today)) {
            document.getElementById("dobErr").innerHTML = "Invalid date of birth";
            return false;
        }
        return true;
    }
</script>

<script>
    $(document).ready(function () {
        //form submition
        $("#form").submit(function (event) {
            event.preventDefault();
            $.ajax({
                url: "newService",
                type: "POST",
                data: $("#form").serialize(),
                beforeSend: function () {
                    $("#form").find("input[type='submit']").val("Loading..");
                },
                success: function (result) {
                    if (result=="success") {
                        Swal.fire('Good job!','Request submitted successfully','success');
                    } else if(result=="exist") {
                        Swal.fire('Already exist','Request already exist','warning');
                    }
                    else{
                        Swal.fire('Failed','Failed to submit please try again','error');
                    }
                    $("#form").find("input[type='submit']").val("Submit");
                    clear();
                }
            });
        });
    });
    function clear(){
        $("#form").find(".form-control").val("");
    }
</script>