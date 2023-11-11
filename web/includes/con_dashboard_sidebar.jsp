<!-- partial:../../partials/_sidebar.html -->
<nav class="sidebar sidebar-offcanvas" id="sidebar">
    <ul class="nav">
        <li class="nav-item nav-profile">
            <a href="#" class="nav-link">
                <div class="nav-profile-text d-flex flex-column">
                    <span class="font-weight-bold mb-2">${con.name}</span>
                    <span class="text-secondary text-small">${con.profession}</span>
                </div>
                <i class="mdi mdi-bookmark-check text-success nav-profile-badge"></i>
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="con_dashboard.jsp">
                <span class="menu-title">Dashboard</span>
                <i class="fa-solid fa-gauge menu-icon"></i>
            </a>
        </li>

        <!--Connections-->
        <li class="nav-item">
            <a class="nav-link" href="connection_details">
                <span class="menu-title">Connection detail</span>
                <i class="fa fa-plug menu-icon"></i>
            </a>
        </li>

        <!--consumer details-->
        <li class="nav-item">
            <a class="nav-link" href="con_pay_bill.jsp">
                <span class="menu-title">Pay electricity bill</span>
                <i class="fa-solid fa-money-check-dollar menu-icon"></i>
            </a>
        </li>

        <!--bill payment-->

        <li class="nav-item">
            <a class="nav-link" href="con_transaction.jsp">
                <span class="menu-title">Transaction history</span>
                <i class="fa fa-history menu-icon"></i>
            </a>
        </li>
        
        <!--upload Aathar-->
        <li class="nav-item">
            <a class="nav-link" href="upload_aathar.jsp">
                <span class="menu-title">Upload Aathar</span>
                <i class="mdi mdi-arrow-up-bold-circle menu-icon"></i>
            </a>
        </li>
        
        <!--Post Compliant-->
        <li class="nav-item">
            <a class="nav-link" data-bs-toggle="collapse" href="#compliant" aria-expanded="false" aria-controls="compliant">
                <span class="menu-title">Compliant</span>
                <i class="menu-arrow"></i>
                <i class="mdi mdi-file-document-box menu-icon"></i>
            </a>
            <div class="collapse" id="compliant">
                <ul class="nav flex-column sub-menu">
                    <li class="nav-item"> <a class="nav-link" href="con_complient.jsp">Post Complaint</a></li>
                    <li class="nav-item"> <a class="nav-link" href="con_complient_history.jsp">Complaint Status</a></li>
                </ul>
            </div>
        </li>
    </ul>
</nav>
<!-- partial -->