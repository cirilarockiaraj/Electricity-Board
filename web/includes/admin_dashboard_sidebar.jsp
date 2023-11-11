<!-- partial:../../partials/_sidebar.html -->
<nav class="sidebar sidebar-offcanvas" id="sidebar">
    <ul class="nav">
        <li class="nav-item nav-profile">
            <a href="#" class="nav-link">
                <div class="nav-profile-image">
                    <img src="admin_profiles/${ad.image}" alt="profile">
                    <span class="login-status online"></span>
                    <!--change to offline or busy as needed-->
                </div>
                <div class="nav-profile-text d-flex flex-column">
                    <span class="font-weight-bold mb-2">${ad.username}</span>
                    <span class="text-secondary text-small">${ad.profession}</span>
                </div>
                <i class="mdi mdi-bookmark-check text-success nav-profile-badge"></i>
            </a>
        </li>
        
        <!--Dashboard-->
        <li class="nav-item">
            <a class="nav-link" href="admin_dashboard.jsp">
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
                    <li class="nav-item"> <a class="nav-link" href="connection_request.jsp">Connection requests</a></li>
                    <li class="nav-item"> <a class="nav-link" href="view_all_connection.jsp">View connections</a></li>
                    <li class="nav-item"> <a class="nav-link" href="add_connection.jsp">Add new connection</a></li>
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
                    <li class="nav-item"> <a class="nav-link" href="view_all_consumer.jsp">View all consumer details</a></li>
                    <li class="nav-item"> <a class="nav-link" href="add_consumer.jsp">Add new consumer</a></li>
                </ul>
            </div>
        </li>

        <!--employee details-->
        <li class="nav-item">
            <a class="nav-link" data-bs-toggle="collapse" href="#employee" aria-expanded="false" aria-controls="employee">
                <span class="menu-title">Employees</span>
                <i class="menu-arrow"></i>
                <i class="mdi mdi-human-greeting menu-icon"></i>
            </a>
            <div class="collapse" id="employee">
                <ul class="nav flex-column sub-menu">
                    <li class="nav-item"> <a class="nav-link" href="view_all_employee.jsp">View all employee details</a></li>
                    <li class="nav-item"> <a class="nav-link" href="add_employee.jsp">Hire new employee</a></li>
                </ul>
            </div>
        </li>

        <!--Admin details-->
        <li class="nav-item">
            <a class="nav-link" data-bs-toggle="collapse" href="#Admin" aria-expanded="false" aria-controls="Admin">
                <span class="menu-title">Administrators</span>
                <i class="menu-arrow"></i>
                <i class="mdi mdi mdi-account-card-details menu-icon"></i>
            </a>
            <div class="collapse" id="Admin">
                <ul class="nav flex-column sub-menu">
                    <li class="nav-item"> <a class="nav-link" href="view_all_admin.jsp">View all admin details</a></li>
                    <li class="nav-item"> <a class="nav-link" href="add_admin.jsp">Add new admin</a></li>
                </ul>
            </div>
        </li>
        
        <!--bill payment-->
        
        <li class="nav-item">
            <a class="nav-link" data-bs-toggle="collapse" href="#billing" aria-expanded="false" aria-controls="Admin">
                <span class="menu-title">Billing</span>
                <i class="menu-arrow"></i>
                <i class="mdi mdi-tag-multiple menu-icon"></i>
            </a>
            <div class="collapse" id="billing">
                <ul class="nav flex-column sub-menu">
                    <li class="nav-item"> <a class="nav-link" href="add_unit.jsp">Add electricity bill</a></li>
                    <li class="nav-item"> <a class="nav-link" href="includes/tariff_pdf.html" target="_blank">View Tariff calculation</a></li>
                    <li class="nav-item"> <a class="nav-link" href="adminSidePay.jsp">Pay electricity bill</a></li>
                    <li class="nav-item"> <a class="nav-link" href="view_all_bills.jsp">View all bills</a></li>
                </ul>
            </div>
        </li>
        
        
        <!--Messages-->
        <li class="nav-item">
            <a class="nav-link" href="admin_message.jsp">
                <span class="menu-title">Messages</span>
                <i class="mdi mdi-email-outline menu-icon"></i>
            </a>
        </li>
        
        <li class="nav-item">
            <a class="nav-link" href="admin_view_complaints.jsp">
                <span class="menu-title">Complaints</span>
                <i class="mdi mdi-file-document-box menu-icon"></i>
            </a>
        </li>
        
        <li class="nav-item">
            <a class="nav-link" href="admin_view_aathar.jsp">
                <span class="menu-title">Aathar details</span>
                <i class="mdi mdi-account-card-details menu-icon"></i>
            </a>
        </li>
        
        <li class="nav-item">
            <a class="nav-link" href="admin_unlock_account.jsp">
                <span class="menu-title">Locked Accounts</span>
                <i class="mdi mdi-lock menu-icon"></i>
            </a>
        </li>

        <!--Controls-->
        <li class="nav-item">
            <a class="nav-link" href="controls.jsp">
                <span class="menu-title">Controls</span>
                <i class="mdi mdi-settings menu-icon"></i>
            </a>
        </li>
    </ul>
</nav>
<!-- partial -->