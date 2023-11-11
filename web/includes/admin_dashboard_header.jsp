<%@page import="java.sql.*"%>
<!-- partial:../../partials/_navbar.html -->
<nav class="navbar default-layout-navbar col-lg-12 col-12 p-0 fixed-top d-flex flex-row">
    <div class="text-center navbar-brand-wrapper d-flex align-items-center justify-content-center">
        <a class="navbar-brand brand-logo" href="#"><h2>Electricity Board</h2></a>
        <a class="navbar-brand brand-logo-mini" href="#"><h1>EB</h1></a>
    </div>
    <div class="navbar-menu-wrapper d-flex align-items-stretch">
        <button class="navbar-toggler navbar-toggler align-self-center" type="button" data-toggle="minimize">
            <span class="mdi mdi-menu"></span>
        </button>
        <div class="search-field d-none d-md-block">
            <form class="d-flex align-items-center h-100" action="#">
                <div class="input-group">
                    <div class="input-group-prepend bg-transparent">
                        <i class="input-group-text border-0 mdi mdi-magnify"></i>
                    </div>
                    <input type="text" class="form-control bg-transparent border-0" placeholder="Search projects">
                </div>
            </form>
        </div>
        <ul class="navbar-nav navbar-nav-right">
            <li class="nav-item nav-profile dropdown">
                <a class="nav-link dropdown-toggle" id="profileDropdown" href="#" data-bs-toggle="dropdown" aria-expanded="false">
                    <div class="nav-profile-img">
                        <img src="admin_profiles/${ad.image}" alt="image">
                        <span class="availability-status online"></span>
                    </div>
                    <div class="nav-profile-text">
                        <p class="mb-1 text-black">${ad.username}</p>
                    </div>
                </a>
                <div class="dropdown-menu navbar-dropdown" aria-labelledby="profileDropdown">
                    <a class="dropdown-item" href="admin_profile.jsp">
                        <i class="mdi mdi-account text-success"></i> Profile </a>
                    <div class="dropdown-divider"></div>
                    <a class="dropdown-item" href="adminLogout">
                        <i class="mdi mdi-logout me-2 text-primary"></i> Sign out </a>
                </div>
            </li>

            <li class="nav-item dropdown">
                <a class="nav-link count-indicator dropdown-toggle" id="messageDropdown" href="#" data-bs-toggle="dropdown" aria-expanded="false">
                    <i class="mdi mdi-email-outline"></i>
                    <span class="count-symbol bg-warning"></span>
                </a>
                <div class="dropdown-menu dropdown-menu-right navbar-dropdown preview-list" aria-labelledby="messageDropdown">
                    <h6 class="p-3 mb-0">Messages</h6>
                    <div class="dropdown-divider"></div>

                    <%
                        Class.forName("com.mysql.jdbc.Driver");
                        try (Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/electricity_board", "root", "")) {
                            String sql = "SELECT * FROM contact_msg WHERE status='read' ORDER BY id DESC";
                            PreparedStatement statement = connection.prepareStatement(sql);
                            ResultSet rs = statement.executeQuery();
                            while (rs.next()) {
                                String date = rs.getString("time_date").substring(0, 10);
                                String time = rs.getString("time_date").substring(10, 16);
                    %>

                    <a class="dropdown-item preview-item" href="admin_message.jsp">
                        <div class="preview-item-content d-flex align-items-start flex-column justify-content-center">
                            <h6 class="preview-subject ellipsis mb-1 font-weight-normal"><%= rs.getString("name")%> send a message</h6>
                            <p class="text-gray mb-0"> <%out.print(date + " &nbsp;" + time);%> </p>
                        </div>
                    </a>
                    <%
                            }
                        } catch (Exception e) {
                            out.print(e);
                        }
                    %>
                    <%
                        Class.forName("com.mysql.jdbc.Driver");
                        try (Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/electricity_board", "root", "")) {
                            String sql = "SELECT COUNT(*) FROM contact_msg WHERE status='read'";
                            PreparedStatement statement = connection.prepareStatement(sql);
                            ResultSet rs = statement.executeQuery();
                            while (rs.next()) {
                    %>
                    <div class="dropdown-divider"></div>
                    <h6 class="p-3 mb-0 text-center"><%=rs.getString(1)%> New Messages</h6>
                    <%
                            }
                        } catch (Exception e) {
                            out.print(e);
                        }
                    %>

                </div>
            </li>
            <li class="nav-item d-none d-lg-block full-screen-link">
                <a class="nav-link">
                    <i class="mdi mdi-fullscreen" id="fullscreen-button"></i>
                </a>
            </li>
            <li class="nav-item nav-logout d-none d-lg-block">
                <a class="nav-link" href="adminLogout">
                    <i class="mdi mdi-power"></i>
                </a>
            </li>
            <li class="nav-item nav-settings d-none d-lg-block">
                <a class="nav-link" href="#">
                    <i class="mdi mdi-format-line-spacing"></i>
                </a>
            </li>
        </ul>
        <button class="navbar-toggler navbar-toggler-right d-lg-none align-self-center" type="button" data-toggle="offcanvas">
            <span class="mdi mdi-menu"></span>
        </button>
    </div>
</nav>
<!-- partial -->