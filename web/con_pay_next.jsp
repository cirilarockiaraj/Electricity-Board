<%@page import="ConsumerLogin.consumer"%>
<%@page import="connection.db"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Electricity Board | Consumer</title>

        <%    response.setHeader("Cache-Control", "no-cache");
            response.setHeader("Cache-Control", "no-store");
            response.setDateHeader("Expires", 0);
            response.setHeader("Pragma", "no-cache");
            if (session.getAttribute("con") == null)
                response.sendRedirect("conerror-404.html");
        %>
        <script>history.forward();</script>

        <!-- plugins:css -->
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

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.6.4/js/bootstrap-datepicker.js"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.6.4/css/bootstrap-datepicker.css" rel="stylesheet"/>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


        <link rel="shortcut icon" href="image/light.ico" />
    </head>
    <body>
        <section class="vh-100">
            <div class="mask d-flex align-items-center h-100">
                <div class="container h-100">
                    <div class="row d-flex justify-content-center align-items-center h-100">
                        <div class="col-12 col-md-9 col-lg-7 col-xl-6">
                            <div class="card" style="border-radius: 15px;">
                                <div class="card-body p-5">
                                    <h2 class="card-title"><i class="fa-brands fa-cc-amazon-pay" style="font-size: 50px;"></i></h2>
                                    <form method="post" action="message_send">

                                        <div class="row">
                                            <div class="col-md-8">
                                                <p class="text-danger">${msg}</p>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label>Service number</label>
                                                    <input type="text" name="service" class="form-control" value="${serno}" readonly="">
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label>Month</label>
                                                    <input type="text" name="monthYear" class="form-control" value="${monthYear}" readonly="">
                                                </div>
                                            </div>      
                                        </div>

                                        <div class="row">
                                            <h5 class="card-title">General info for send message</h5>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label>Name</label>
                                                    <input type="text" name="name" class="form-control" value="${con.name}" readonly="">
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label>Email ID</label>
                                                    <input type="text" name="email" class="form-control" value="${con.email}" readonly="">
                                                </div>
                                            </div>      
                                        </div>
                                        <br>
                                        <div>
                                            <div class="row">
                                                <h5 class="card-title">Card details</h5>
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label>Card holder name</label>
                                                        <input type="text" name="card_holder_name" class="form-control" placeholder="Card holder name" required="">
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label>Card number</label>
                                                        <input type="number" name="card_no" class="form-control" placeholder="1234-5678-9012" onkeypress="if (this.value.length > 11)
                    return false;" required="">     
                                                    </div>
                                                </div>      
                                            </div>
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label>CVV number</label>
                                                        <input type="password" name="cvv" class="form-control" placeholder="CVV" maxlength="3" required="">
                                                    </div>
                                                </div>
                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label>Expiry date</label>
                                                        <select class="form-control" name="month" required="">
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
                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label></label>
                                                        <input type="text" class="form-control" name="year" id="datepicker" placeholder="Year" required=""/>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <button type="submit" class="btn btn-gradient-primary w-50"><i class="fa-brands fa-amazon-pay" style="font-size: 25px;"></i></button>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <script>
        window.oncontextmenu = function () {
            return false;
        }</script>
    <script>
        $(document).ready(function () {
            $("#datepicker").datepicker({
                format: "yyyy",
                viewMode: "years",
                minViewMode: "years",
                autoclose: true
            });
        })
    </script>
</body>
</html>