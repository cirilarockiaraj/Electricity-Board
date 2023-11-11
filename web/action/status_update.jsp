<%@page import="mailer.mail"%>
<%@page import="connection.db"%>
<%@page import="java.sql.*"%>
<%
    PreparedStatement ps;
    String status = "";
    String msg = "";
    String id = request.getParameter("id");
    String action = request.getParameter("action");

    String email = "";
    String name = "";
    String req_no = "";
    String service_no = null;
    String sno = "";
    String con_type = "";

    //geting info
    try {
        Connection conn = db.initializeDatabase();
        ps = conn.prepareStatement("SELECT * FROM services WHERE id=?");
        ps.setString(1, id);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            sno = rs.getString("service_no");
            email = rs.getString("email_id");
            req_no = rs.getString("req_no");
            name = rs.getString("service_holder_name");
            con_type = rs.getString("connection_type");
        }
    } catch (Exception ex) {
        out.print(ex);
    }

    mail m = new mail();

    if (action.equals("activate")) {
        status = "Live";
        try {
            if (sno.equals("")) {
                Connection conn = db.initializeDatabase();
                String query = "SELECT service_no FROM services ORDER BY service_no DESC LIMIT 1";
                ps = conn.prepareStatement(query);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    String ap = rs.getString("service_no");
                    int ln = ap.length();
                    String stxt = ap.substring(0, 4);
                    String snum = ap.substring(4, ln);
                    int n = Integer.parseInt(snum);
                    n++;
                    snum = Integer.toString(n);
                    service_no = stxt + snum;
                } else {
                    service_no = "TNEB101".toUpperCase();
                }
                msg = "Hi " + name + ",\nyour service number is : " + service_no + " your service type is : " + con_type + " and Your service activated successfully.\n\n\t\t Thankyou..";
                m.send(email, "Electricity Board", msg);
            } else {
                service_no = sno;
            }
        } catch (Exception e) {
            out.print(e);
        }
    } else if (action.equals("reject")) {
        status = "rejected";
        msg = "Hi " + name + ",\nyour request number is : " + req_no + " your request is rejected. please contact admin\n\n\t\t Thankyou..";
        m.send(email, "Electricity Board", msg);
    } else if (action.equals("wait")) {
        status = "wait";
        msg = "Hi " + name + ",\nyour request number is : " + req_no + " your request is waiting list. please wait and check email.\n\n\t\t Thankyou..";
        m.send(email, "Electricity Board", msg);
    } else if (action.equals("inactive")) {
        service_no = sno;
        status = "pending";
    } else {
        status = "pending";
    }

    try {
        Connection conn = db.initializeDatabase();
        ps = conn.prepareStatement("UPDATE services SET service_no=?, status=? WHERE id = ?");
        ps.setString(1, service_no);
        ps.setString(2, status);
        ps.setString(3, id);
        int row = ps.executeUpdate();
        if (row > 0) {
            response.sendRedirect("../connection_request.jsp");
        }
    } catch (Exception e) {
        out.print(e);
    }
%>