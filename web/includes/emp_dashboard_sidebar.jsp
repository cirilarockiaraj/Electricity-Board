<!-- partial:../../partials/_sidebar.html -->
<nav class="sidebar sidebar-offcanvas" id="sidebar">
    <ul class="nav">
        <li class="nav-item nav-profile">
            <a href="#" class="nav-link">
                <div class="nav-profile-image">
                    <img src="emp_profiles/${emp.image}" alt="profile">
                    <span class="login-status online"></span>
                    <!--change to offline or busy as needed-->
                </div>
                <div class="nav-profile-text d-flex flex-column">
                    <span class="font-weight-bold mb-2">${emp.empName}</span>
                    <span class="text-secondary text-small">${emp.profession}</span>
                </div>
                <i class="mdi mdi-bookmark-check text-success nav-profile-badge"></i>
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="emp_dashboard.jsp">
                <span class="menu-title">Dashboard</span>
                <i class="mdi mdi-home menu-icon"></i>
            </a>
        </li>

        <!--Connections-->
        <li class="nav-item">
            <a class="nav-link" data-bs-toggle="collapse" href="#connection" aria-expanded="false" aria-controls="connection">
                <span class="menu-title">Connections</span>
                <i class="menu-arrow"></i>
                <i class="mdi mdi-vector-polyline menu-icon"></i>
            </a>
            <div class="collapse" id="connection">
                <ul class="nav flex-column sub-menu">
                    <li class="nav-item"> <a class="nav-link" href="emp_view_connection.jsp">View all connection details</a></li>
                    <li class="nav-item"> <a class="nav-link" href="emp_add_connection.jsp">Add new connection</a></li>
                </ul>
            </div>
        </li>

        <!--consumer details-->
        <li class="nav-item">
            <a class="nav-link" data-bs-toggle="collapse" href="#consumer" aria-expanded="false" aria-controls="consumer">
                <span class="menu-title">Consumers</span>
                <i class="menu-arrow"></i>
                <i class="mdi mdi-account-multiple menu-icon"></i>
            </a>
            <div class="collapse" id="consumer">
                <ul class="nav flex-column sub-menu">
                    <li class="nav-item"> <a class="nav-link" href="emp_view_consumer.jsp">View all consumer details</a></li>
                    <li class="nav-item"> <a class="nav-link" href="emp_add_consumer.jsp">Add new consumer</a></li>
                </ul>
            </div>
        </li>

        <!--bill payment-->

        <li class="nav-item">
            <a class="nav-link" data-bs-toggle="collapse" href="#billing" aria-expanded="false" aria-controls="billing">
                <span class="menu-title">Billing</span>
                <i class="menu-arrow"></i>
                <i class="mdi mdi-tag-multiple menu-icon"></i>
            </a>
            <div class="collapse" id="billing">
                <ul class="nav flex-column sub-menu">
                    <li class="nav-item"> <a class="nav-link" href="emp_add_unit.jsp">Add electricity bill</a></li>
                    <li class="nav-item"> <a class="nav-link" href="includes/tariff_pdf.html" target="_blank">View Tariff calculation</a></li>
                    <li class="nav-item"> <a class="nav-link" href="empSidePay.jsp">Pay electricity bill</a></li>
                    <li class="nav-item"> <a class="nav-link" href="emp_view_bills.jsp">View all bills</a></li>
                </ul>
            </div>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="emp_complaint.jsp">
                <span class="menu-title">Complaints</span>
                <i class="mdi mdi-file-document-box menu-icon"></i>
            </a>
        </li>
    </ul>
</nav>
<!-- partial -->