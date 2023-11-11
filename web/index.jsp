<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home</title>
        <link rel="stylesheet" href="page_components/vendors/mdi/css/materialdesignicons.min.css">
        <link rel="stylesheet" href="page_components/vendors/css/vendor.bundle.base.css">
        <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
        <link rel="stylesheet" type="text/css" href="css/design.min.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" />
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jquery.dataTables.min.js"></script>
        <script src="js/jquery.js"></script>
        <script src="js/popper.min.js"></script>
        <link rel="shortcut icon" href="image/light.ico" />
    </head>
    <body>
        <!<!-- header -->
        <div>
            <jsp:include page="includes/header.jsp"></jsp:include>
            </div>
            <!--content-->
            <div class="container-fluid p-0">
                <div>
                    <div class="h-50"></div>
                <jsp:include page="includes/slider.jsp"></jsp:include>
                </div>
                <br>

                <hr>
                <!--card information-->
                <div class="bg-light p-4">
                    <h2>Services</h2><br>
                    <!-- card 1 -->
                    <div class="row">
                        <div class="col-3">
                            <div class="card text-white bg-primary mb-3 h-100" style="max-width: 18rem;">
                                <div class="card-header">Customer care</div>
                                <div class="card-body">
                                    <h5 class="card-title">Contact customer care</h5>
                                    <p class="card-text"><i class="mdi mdi-whatsapp"></i> +91 6382810644</p>
                                    <p class="card-text"><i class="mdi mdi-gmail"></i> 21pcs804@mail.sjctni.edu</p>
                                    <p class="card-text"><i class="mdi mdi-mail"></i> <a href="contact.jsp" class="link-light"> Send message</a></p>
                                </div>
                            </div>
                        </div>

                        <!-- card 2 -->
                        <div class="col-3">
                            <div class="card text-white bg-secondary mb-3 h-100" style="max-width: 18rem;">
                                <div class="card-header">Link with Aadhar</div>
                                <div class="card-body">
                                    <h5 class="card-title">Link your service connection number with Aadhaar</h5>
                                    <p class="card-text"><a href="upload_aathar.jsp"><img src="image/aadhar.jpg" alt="alt" width="100%" height="100%"/></a></p>
                                </div>
                            </div>
                        </div>

                        <!-- card 3 -->
                        <div class="col-3">
                            <div class="card text-dark bg-info mb-3 h-100" style="max-width: 18rem;">
                                <div class="card-header">Registration</div>
                                <div class="card-body">
                                    <h5 class="card-title">With registration</h5>
                                    <p class="card-text"><i class="mdi mdi-account"></i><a href="register_consumer.jsp" class="link-danger"> Click to register</a></p>
                                    <p class="card-text"><b>OR</b></p>
                                    <p class="card-text"><i class="mdi mdi-login"></i><a href="con_login.jsp" class="link-dark"> Already register</a></p>
                                </div>
                            </div>
                        </div>

                        <!-- card 4 -->
                        <div class="col-3">
                            <div class="card text-white bg-danger mb-3 h-100" style="max-width: 18rem;">
                                <div class="card-header">Services</div>
                                <div class="card-body">
                                    <h5 class="card-title">Consumer Services</h5>
                                    <p class="card-text"><i class="mdi mdi-tag"></i><a href="con_pay_bill.jsp" class="link-light"> Pay electricity bill</a></p>
                                    <p class="card-text"><i class="mdi mdi-history"></i><a href="con_transaction.jsp" class="link-light"> Payment history</a></p>
                                    <p class="card-text"><i class="mdi mdi-message"></i><a href="con_complient.jsp" class="link-light"> Consumer Complaints</a></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- //card information -->
                <br>
                <hr>
                <!-- map -->
                <div class="bg-light p-0  map">
                    <h2>Power plants in Tamil Nadu</h2><br>
                    <iframe src="https://www.google.com/maps/embed?pb=!1m16!1m12!1m3!1d4014174.951242424!2d76.21528307943676!3d10.727331279125554!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!2m1!1spower%20plant%20in%20tamil%20nadu!5e0!3m2!1sen!2sin!4v1657118379112!5m2!1sen!2sin" style="border:0;"></iframe>
                </div>
                <!-- //map -->
                <hr>
                <div class="w-100 bg-secondary text-light p-2 rounded-2">
                    <marquee direction="up" height="50px" scrollamount="1" style="text-align: center;">
                        <h4><i class="mdi mdi-whatsapp"></i> For Power Failure contact +91 6382810644</h4><br>
                        <h4>Energy is in limited supply, Use it wisely</h4><br>
                        <h4>Save Energy for benefit of self and Nation</h4><br>
                        <h4>Energy conservation, a key to sustainable development</h4><br>
                        <h4>Turn off lights and equipments when not in use</h4>
                    </marquee>
                </div>
                <hr>
                <br>
            </div>
            <!--footer-->
            <div>
            <jsp:include page="includes/footer.jsp"></jsp:include>
        </div>

    </body>
</html>
