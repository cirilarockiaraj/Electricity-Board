<%@page import="connection.db"%>
<%@page import="java.sql.*"%>
<%@page import="ConsumerLogin.consumer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Consumer | print bill</title>
        <link rel="stylesheet" type="text/css" href="page_components/vendors/mdi/css/materialdesignicons.min.css">
        <link rel="stylesheet" type="text/css" href="page_components/vendors/css/vendor.bundle.base.css">
        <link rel="stylesheet" type="text/css" href="page_components/css/style.css">
        <link rel="stylesheet" type="text/css" href="css/design.min.css">
        <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" />
        <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.1.3/css/bootstrap.min.css">
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.3/css/dataTables.bootstrap5.min.css"/>
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/buttons/2.2.3/css/buttons.bootstrap5.min.css">
        <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.12.1/js/jquery.dataTables.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <link rel="shortcut icon" href="image/light.ico" />
    </head>
    <body>

        <%!
            String bno, sno, name, month, sts;
            double unit, amt;
        %>

        <%
            String id = request.getParameter("id");
            try {
                Connection conn = db.initializeDatabase();
                String sql = "SELECT * FROM eb_bill_payment WHERE id=?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, id);
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    bno = rs.getString("bill_no");
                    sno = rs.getString("service_no");
                    unit = rs.getDouble("unit_consumed");
                    amt = rs.getDouble("total_amount");
                    sts = rs.getString("status");
                    month = rs.getString("month_year");
                }
            } catch (SQLException e) {
                out.print(e);
            }
            try {
                Connection conn = db.initializeDatabase();
                String sql2 = "SELECT * FROM services WHERE service_no=?";
                PreparedStatement ps2 = conn.prepareStatement(sql2);
                ps2.setString(1, sno);
                ResultSet rs2 = ps2.executeQuery();
                if (rs2.next()) {
                    name = rs2.getString("service_holder_name");
                }
            } catch (SQLException e) {
                out.print(e);
            }

        %>


        <section class="vh-100">
            <div class="mask d-flex align-items-center h-100">
                <div class="container h-100">
                    <div class="row d-flex justify-content-center align-items-center h-100">
                        <div class="col-12 col-md-9 col-lg-7 col-xl-6">
                            <div class="card" style="border-radius: 15px;">
                                <div class="card-body p-5">
                                    <a href="con_transaction.jsp" class="auth-link text-black text-decoration-none float-end"><i class="fa-solid fa-arrow-left" style="font-size: 25px;"></i></a>
                                    <div id="print">
                                        <img src="image/logo.png" width="150" height="100" alt="err"/>
                                        <table class="table table-striped table-primary">
                                            <tr>
                                                <th>Bill number</th>
                                                <td><%out.print(bno);%></td>
                                            </tr>
                                            <tr>
                                                <th>Service number</th>
                                                <td><%out.print(sno);%></td>
                                            </tr>
                                            <tr>
                                                <th>Name</th>
                                                <td><%out.print(name);%></td>
                                            </tr>
                                            <tr>
                                                <th>Unit consumed</th>
                                                <td><%out.print(unit);%></td>
                                            </tr>
                                            <tr>
                                                <th>Total Amount</th>
                                                <td><%out.print(amt);%></td>
                                            </tr>
                                            <tr>
                                                <th>Month</th>
                                                <td><%out.print(month);%></td>
                                            </tr>
                                            <tr>
                                                <th>Payment status</th>
                                                <td><%out.print(sts);%></td>
                                            </tr>
                                        </table>
                                    </div>
                                            <button class="btn btn-gradient-info" onclick="printDiv('print')"><i class="fa-solid fa-print"></i>&nbsp;&nbsp;Print</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <script>
        function printDiv(print) {
            var printContents = document.getElementById(print).innerHTML;
            var originalContents = document.body.innerHTML;

            document.body.innerHTML = printContents;

            window.print();

            document.body.innerHTML = originalContents;
        }
    </script>
    <script>window.oncontextmenu = function() {return false;}</script>
</body>
</html>
