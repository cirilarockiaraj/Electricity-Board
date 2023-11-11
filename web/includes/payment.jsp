<%@page import="connection.db"%>
<%@page import="java.sql.*"%>
<div class="row p-2">
    <div class="col-md-6 grid-margin stretch-card">
        <div class="card">
            <div class="alert alert-warning alert-dismissible fade show" role="alert">
                <p>${msg}</p>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <div class="card-body">
                <h3 class="card-title">Hand payment</h3>
                <form method="post" action="bill_pay">
                    <div class="form-group">
                        <label for="exampleInputUsername1">Enter service number</label>
                        <input class="form-control" list="browsers" name="s_no" id="browser" required="">
                        <datalist id="browsers">

                            <%
                                try {
                                    Connection conn=db.initializeDatabase();
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
                    <div class="form-group">
                        <label for="enteryear">Enter year</label>
                        <input type="text" name="year" class="form-control" required="">
                    </div>
                    <div class="form-group">
                        <button type="submit" name="submit" class="btn btn-gradient-primary me-2">Submit</button>
                        <button class="btn btn-gradient-danger" type="reset">Cancel</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <style>
        table, th, td {
            border: 1px solid black;
            border-collapse: collapse;
            width: 100%;
        }
        th, td {
            padding: 12px;
        }
    </style>

    <div class="col-md-6 grid-margin stretch-card">
        <div class="card">
            <div class="card-body">
                <div id="tbl">
                    <h3 class="card-title"><center>Electricity Board</center></h3>
                    <table>
                        <tr>
                            <th>Bill number</th>
                            <td>${bill_no}</td>
                        </tr>
                        <tr>
                            <th>Service number</th>
                            <td>${sNo}</td>
                        </tr>
                        <tr>
                            <th>Service holder name</th>
                            <td>${name}</td>
                        </tr>
                        <tr>
                            <th>Unit consumed in a month</th>
                            <td>${unit}</td>
                        </tr>
                        <tr>
                            <th>Total Amount</th>
                            <td>${totAmt}</td>
                        </tr>
                        <tr>
                            <th>Month</th>
                            <td>${mon_yr}</td>
                        </tr>
                        <tr>
                            <th>Payment status</th>
                            <td>${status}</td>
                        </tr>
                    </table>
                </div>
                <br>
                <div class="form-group">
                    <button name="print" onclick="printDiv('tbl')" class="btn btn-gradient-success me-2">Print</button>
                </div>
            </div>
        </div>
    </div>
    <script>
        function printDiv(tbl) {
            var printContents = document.getElementById(tbl).innerHTML;
            var originalContents = document.body.innerHTML;

            document.body.innerHTML = printContents;

            window.print();

            document.body.innerHTML = originalContents;
        }
    </script>