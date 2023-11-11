<%@page import="java.sql.*"%>
<%@page import="connection.db"%>
<section class="myclass mb-4 bg-light p-5">

    <!--Section heading-->
    <h2 class="h1-responsive font-weight-bold text-center my-4">Contact us</h2>
    <!--Section description-->
    <p class="text-center w-responsive mx-auto mb-5">Do you have any questions? Please do not hesitate to contact us directly. Our team will come back to you within
        a matter of hours to help you.</p>

    <div class="row">

        <!--Grid column-->
        <div class="col-md-9 mb-md-0 mb-5">
            <form action="" method="post">

                <!--Grid row-->
                <div class="row">

                    <!--Grid column-->
                    <div class="col-md-6">
                        <div class="md-form mb-0">
                            <label for="name" class="">Your name</label>
                            <input type="text" id="name" name="name" class="form-control" required="">
                        </div>
                    </div>
                    <!--Grid column-->

                    <!--Grid column-->
                    <div class="col-md-6">
                        <div class="md-form mb-0">
                            <label for="email" class="">Your email</label>
                            <input type="text" id="email" name="email" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$" class="form-control" required="">
                        </div>
                    </div>
                    <!--Grid column-->

                </div>
                <!--Grid row-->

                <!--Grid row-->
                <div class="row">
                    <div class="col-md-12">
                        <div class="md-form mb-0">
                            <label for="subject" class="">Subject</label>
                            <input type="text" id="subject" name="subject" class="form-control" required="">
                        </div>
                    </div>
                </div>
                <!--Grid row-->

                <!--Grid row-->
                <div class="row">

                    <!--Grid column-->
                    <div class="col-md-12">

                        <div class="md-form">
                            <label for="message">Your message</label>
                            <textarea type="text" id="message" name="message" rows="5" maxlength="400" class="form-control md-textarea" required=""></textarea>
                        </div>

                    </div>
                </div><br>
                <div class="text-md-left">
                    <button class="btn btn-primary" name="submit" type="submit">Send</button>
                </div>
                <!--Grid row-->

            </form>
            <div class="status"></div>
        </div>
        <!--Grid column-->
        <%
            String address="", contact="", email="";
            try{
                Connection con=db.initializeDatabase();
                String sql="SELECT * FROM contact";
                PreparedStatement ps=con.prepareStatement(sql);
                ResultSet rs=ps.executeQuery();
                if(rs.next()){
                    address=rs.getString(2);
                    contact=rs.getString(3);
                    email=rs.getString(4);
                }
            }
            catch(Exception e){
                out.print(e);
            }
        %>
        <!--Grid column-->
        <div class="col-md-3 text-center">
            <ul class="list-unstyled mb-0">
                <li><i class="fas fa-map-marker-alt fa-2x"></i>
                    <p><%=address%></p>
                </li>

                <li><i class="fas fa-phone mt-4 fa-2x"></i>
                    <p>+91 <%=contact%></p>
                </li>

                <li><i class="fas fa-envelope mt-4 fa-2x"></i>
                    <p><%=email%></p>
                </li>
            </ul>
        </div>
        <!--Grid column-->

    </div>

</section>