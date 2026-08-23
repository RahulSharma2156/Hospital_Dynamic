<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, hospital.com.DBConnection" %>
<%
    // Session Check - protect dashboard
    String userName = (String) session.getAttribute("user_name");
    String userRole = (String) session.getAttribute("user_role");
    String staffCode = (String) session.getAttribute("staff_code");

    if (userName == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Doctor & Staff Dashboard | CityCare Hospital</title>
    <!-- Google Fonts & Font Awesome -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;500;600;700&family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <style>
        :root {
            --primary: #0284c7;
            --primary-hover: #0369a1;
            --primary-light: #e0f2fe;
            --secondary: #0d9488;
            --dark: #0f172a;
            --dark-muted: #64748b;
            --light-bg: #f8fafc;
            --border-color: #e2e8f0;
            --success: #10b981;
            --danger: #ef4444;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Plus Jakarta Sans', sans-serif; }
        body { background-color: var(--light-bg); color: var(--dark); }

        /* Top Navbar */
        .dash-nav {
            background: #ffffff;
            border-bottom: 1px solid var(--border-color);
            padding: 14px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .logo-box {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .logo-icon {
            width: 40px;
            height: 40px;
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #fff;
            font-size: 20px;
        }

        .logo-title {
            font-family: 'Outfit', sans-serif;
            font-size: 20px;
            font-weight: 800;
            color: var(--dark);
        }

        .user-nav {
            display: flex;
            align-items: center;
            gap: 18px;
        }

        .user-pill {
            display: flex;
            align-items: center;
            gap: 10px;
            background: var(--primary-light);
            padding: 6px 14px;
            border-radius: 999px;
            font-size: 14px;
            font-weight: 700;
            color: var(--primary-hover);
        }

        .role-badge {
            background: #0284c7;
            color: #fff;
            padding: 2px 8px;
            border-radius: 999px;
            font-size: 11px;
            text-transform: uppercase;
        }

        .btn-logout {
            background: #fee2e2;
            color: #dc2626;
            border: 1px solid #fca5a5;
            padding: 8px 16px;
            border-radius: 8px;
            font-size: 13px;
            font-weight: 700;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            transition: 0.2s;
        }

        .btn-logout:hover {
            background: #dc2626;
            color: #fff;
        }

        /* Container */
        .dash-container {
            max-width: 1200px;
            margin: 30px auto;
            padding: 0 20px;
        }

        /* Stats Cards */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: #ffffff;
            border: 1px solid var(--border-color);
            border-radius: 14px;
            padding: 24px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.03);
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .stat-val {
            font-size: 28px;
            font-weight: 800;
            color: var(--dark);
            margin-top: 4px;
        }

        .stat-lbl {
            font-size: 13px;
            font-weight: 600;
            color: var(--dark-muted);
        }

        .stat-icon {
            width: 50px;
            height: 50px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
        }

        .icon-blue { background: #e0f2fe; color: var(--primary); }
        .icon-green { background: #dcfce7; color: var(--success); }
        .icon-orange { background: #ffedd5; color: #ea580c; }

        /* Table Card */
        .table-card {
            background: #ffffff;
            border: 1px solid var(--border-color);
            border-radius: 16px;
            padding: 26px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.04);
        }

        .table-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .table-title {
            font-size: 20px;
            font-weight: 700;
            color: var(--dark);
        }

        .table-responsive {
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            text-align: left;
        }

        th {
            background: #f8fafc;
            color: var(--dark-muted);
            font-size: 13px;
            font-weight: 700;
            padding: 14px 16px;
            border-bottom: 2px solid var(--border-color);
            text-transform: uppercase;
        }

        td {
            padding: 16px;
            font-size: 14px;
            border-bottom: 1px solid #f1f5f9;
            color: var(--dark);
        }

        tr:hover {
            background: #f8fafc;
        }

        .badge-status {
            padding: 4px 10px;
            border-radius: 999px;
            font-size: 12px;
            font-weight: 700;
            display: inline-block;
        }

        .badge-confirmed { background: #dcfce7; color: #16a34a; }
        .badge-pending { background: #fef9c3; color: #ca8a04; }

        .btn-view-site {
            background: var(--primary);
            color: #fff;
            padding: 8px 16px;
            border-radius: 8px;
            font-size: 13px;
            font-weight: 600;
            text-decoration: none;
        }

        /* Serial Number column */
        .col-sr { width: 48px; text-align: center; color: var(--dark-muted); font-weight: 700; font-size: 13px; }

        /* Checkbox column */
        .col-check { width: 44px; text-align: center; }
        .col-check input[type=checkbox] {
            width: 17px; height: 17px; cursor: pointer;
            accent-color: var(--danger);
        }

        /* Delete Toolbar */
        .delete-toolbar {
            display: flex;
            align-items: center;
            gap: 12px;
            flex-wrap: wrap;
        }
        .select-all-box {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 13px;
            font-weight: 700;
            color: var(--dark-muted);
            cursor: pointer;
        }
        .select-all-box input[type=checkbox] {
            width: 17px; height: 17px;
            accent-color: var(--primary);
            cursor: pointer;
        }
        .btn-del-selected {
            background: #fee2e2;
            color: #dc2626;
            border: 1.5px solid #fca5a5;
            padding: 8px 16px;
            border-radius: 8px;
            font-size: 13px;
            font-weight: 700;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            transition: 0.2s;
        }
        .btn-del-selected:hover {
            background: #dc2626;
            color: #fff;
            border-color: #dc2626;
        }
        .btn-del-all {
            background: #0f172a;
            color: #fff;
            border: 1.5px solid #0f172a;
            padding: 8px 16px;
            border-radius: 8px;
            font-size: 13px;
            font-weight: 700;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            transition: 0.2s;
        }
        .btn-del-all:hover {
            background: #dc2626;
            border-color: #dc2626;
        }
        .selected-count-badge {
            background: #fee2e2;
            color: #dc2626;
            border-radius: 999px;
            padding: 3px 10px;
            font-size: 12px;
            font-weight: 800;
            display: none;
        }

        /* Alert banners */
        .alert-del-success {
            background: #dcfce7; color: #15803d;
            border: 1px solid #86efac;
            padding: 12px 18px; border-radius: 10px;
            margin-bottom: 18px; font-weight: 700;
            font-size: 14px; display: flex; align-items: center; gap: 8px;
        }
        .alert-del-error {
            background: #fee2e2; color: #dc2626;
            border: 1px solid #fca5a5;
            padding: 12px 18px; border-radius: 10px;
            margin-bottom: 18px; font-weight: 700;
            font-size: 14px; display: flex; align-items: center; gap: 8px;
        }
        .alert-del-warn {
            background: #fef9c3; color: #a16207;
            border: 1px solid #fde047;
            padding: 12px 18px; border-radius: 10px;
            margin-bottom: 18px; font-weight: 700;
            font-size: 14px; display: flex; align-items: center; gap: 8px;
        }

        /* Highlight selected rows */
        tr.row-selected { background-color: #fff1f2 !important; }

        @media(max-width: 768px) {
            .dash-nav { padding: 12px 15px; }
            .dash-container { padding: 0 10px; }
        }
    </style>
</head>
<body>

    <!-- Dashboard Navigation Bar -->
    <nav class="dash-nav">
        <div class="logo-box">
            <div class="logo-icon"><i class="fa-solid fa-hospital"></i></div>
            <div class="logo-title">CityCare Hospital <span style="font-size:12px; color:var(--primary);">Staff Portal</span></div>
        </div>

        <div class="user-nav">
            <div class="user-pill">
                <i class="fa-solid fa-user-doctor"></i> <%= userName %> 
                <span class="role-badge"><%= userRole %> (<%= staffCode %>)</span>
            </div>
            <a href="index.jsp#appointment" class="btn-view-site"><i class="fa-solid fa-calendar-plus"></i> Book Appointment</a>
            <a href="index.jsp#track" class="btn-view-site"><i class="fa-solid fa-magnifying-glass"></i> Track Status</a>
            <a href="index.jsp" class="btn-view-site" target="_blank"><i class="fa-solid fa-globe"></i> View Website</a>
            <a href="Logout_Servlet" class="btn-logout"><i class="fa-solid fa-right-from-bracket"></i> Logout</a>
        </div>
    </nav>

    <!-- Main Container -->
    <div class="dash-container">

        <%
            /* ---- Delete Alert Messages ---- */
            String delStatus = request.getParameter("del");
            String delCount  = request.getParameter("count");
            String delType   = request.getParameter("type");
        %>
        <% if ("success".equals(delStatus)) { %>
        <div class="alert-del-success">
            <i class="fa-solid fa-circle-check"></i>
            <% if ("all".equals(delType)) { %>
                All appointments deleted successfully! (<strong><%= delCount %></strong> records removed)
            <% } else { %>
                <strong><%= delCount %></strong> appointment(s) deleted successfully!
            <% } %>
        </div>
        <% } else if ("none".equals(delStatus)) { %>
        <div class="alert-del-warn">
            <i class="fa-solid fa-triangle-exclamation"></i>
            No appointment selected. Please select at least one to delete.
        </div>
        <% } else if ("error".equals(delStatus) || "dberror".equals(delStatus)) { %>
        <div class="alert-del-error">
            <i class="fa-solid fa-circle-xmark"></i>
            Error deleting appointment(s). Please try again.
        </div>
        <% } %>
        
        <%
            int totalAppts = 0;
            int confirmedCount = 0;
            int todayCount = 0;

            try (Connection conn = DBConnection.getConnection()) {
                if (conn != null) {
                    Statement st = conn.createStatement();
                    ResultSet rs1 = st.executeQuery("SELECT COUNT(*) FROM appointments");
                    if (rs1.next()) totalAppts = rs1.getInt(1);

                    ResultSet rs2 = st.executeQuery("SELECT COUNT(*) FROM appointments WHERE status = 'Confirmed'");
                    if (rs2.next()) confirmedCount = rs2.getInt(1);

                    ResultSet rs3 = st.executeQuery("SELECT COUNT(*) FROM appointments WHERE appointment_date = CURDATE()");
                    if (rs3.next()) todayCount = rs3.getInt(1);
                }
            } catch(Exception e) {}
        %>

        <!-- Top Statistics Cards -->
        <div class="stats-grid">
            <div class="stat-card">
                <div>
                    <div class="stat-lbl">Total Appointments</div>
                    <div class="stat-val"><%= totalAppts %></div>
                </div>
                <div class="stat-icon icon-blue"><i class="fa-solid fa-calendar-check"></i></div>
            </div>

            <div class="stat-card">
                <div>
                    <div class="stat-lbl">Confirmed Visits</div>
                    <div class="stat-val"><%= confirmedCount %></div>
                </div>
                <div class="stat-icon icon-green"><i class="fa-solid fa-circle-check"></i></div>
            </div>

            <div class="stat-card">
                <div>
                    <div class="stat-lbl">Today's Queue</div>
                    <div class="stat-val"><%= todayCount %></div>
                </div>
                <div class="stat-icon icon-orange"><i class="fa-solid fa-user-clock"></i></div>
            </div>
        </div>

        <!-- Live Appointments Table -->
        <form id="deleteForm" action="DeleteAppointment_Servlet" method="POST">
        <input type="hidden" name="action" id="formAction" value="delete_selected">

        <div class="table-card">
            <div class="table-header">
                <h2 class="table-title"><i class="fa-solid fa-list-check" style="color:var(--primary);"></i> Patient Appointments Queue</h2>

                <!-- Delete Toolbar -->
                <div class="delete-toolbar">
                    <label class="select-all-box">
                        <input type="checkbox" id="selectAllChk" title="Select All">
                        Select All
                    </label>
                    <span class="selected-count-badge" id="selectedBadge">0 selected</span>
                    <button type="button" class="btn-del-selected" onclick="submitDeleteSelected()">
                        <i class="fa-solid fa-trash-can"></i> Delete Selected
                    </button>
                    <button type="button" class="btn-del-all" onclick="submitDeleteAll()">
                        <i class="fa-solid fa-trash"></i> Delete All
                    </button>
                    <a href="dashboard.jsp" style="font-size: 13px; color: var(--primary); font-weight:700; text-decoration: none;">
                        <i class="fa-solid fa-rotate-right"></i> Refresh
                    </a>
                </div>
            </div>

            <div class="table-responsive">
                <table id="apptTable">
                    <thead>
                        <tr>
                            <th class="col-check"><i class="fa-solid fa-square-check" style="color:var(--dark-muted);"></i></th>
                            <th class="col-sr">#</th>
                            <th>Appt No</th>
                            <th>Patient Name</th>
                            <th>Phone</th>
                            <th>Department</th>
                            <th>Assigned Doctor</th>
                            <th>Date</th>
                            <th>Remarks</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            try (Connection conn = DBConnection.getConnection()) {
                                if (conn != null) {
                                    String sql = "SELECT a.id, a.appointment_no, a.patient_name, a.patient_phone, a.appointment_date, a.symptoms_remarks, a.status, " +
                                                 "d.name AS dept_name, doc.name AS doctor_name " +
                                                 "FROM appointments a " +
                                                 "LEFT JOIN departments d ON a.department_id = d.id " +
                                                 "LEFT JOIN doctors doc ON a.doctor_id = doc.id " +
                                                 "ORDER BY a.id DESC";

                                    Statement stmt = conn.createStatement();
                                    ResultSet rs = stmt.executeQuery(sql);

                                    boolean hasData = false;
                                    int srNo = 0;
                                    while (rs.next()) {
                                        hasData = true;
                                        srNo++;
                                        String apptNo = rs.getString("appointment_no");
                                        String pName = rs.getString("patient_name");
                                        String phone = rs.getString("patient_phone");
                                        String dept = rs.getString("dept_name") != null ? rs.getString("dept_name") : "General";
                                        String doc = rs.getString("doctor_name") != null ? rs.getString("doctor_name") : "On-Duty";
                                        String date = rs.getString("appointment_date");
                                        String remarks = rs.getString("symptoms_remarks");
                                        String status = rs.getString("status");
                        %>
                            <tr class="appt-row">
                                <td class="col-check">
                                    <input type="checkbox" class="row-chk" name="appt_ids" value="<%= apptNo %>" onchange="updateSelectedCount()">
                                </td>
                                <td class="col-sr"><%= srNo %></td>
                                <td style="font-weight:700; color:var(--primary);"><%= apptNo %></td>
                                <td style="font-weight:600;"><%= pName %></td>
                                <td><i class="fa-solid fa-phone" style="font-size:11px; color:var(--dark-muted);"></i> <%= phone %></td>
                                <td><%= dept %></td>
                                <td><%= doc %></td>
                                <td style="color:#dc2626; font-weight:600;"><%= date %></td>
                                <td title="<%= remarks != null ? remarks : "No remarks" %>"><%= remarks != null && !remarks.trim().isEmpty() ? remarks : "-" %></td>
                                <td>
                                    <span class="badge-status <%= "Confirmed".equalsIgnoreCase(status) ? "badge-confirmed" : "badge-pending" %>">
                                        <%= status %>
                                    </span>
                                </td>
                            </tr>
                        <%
                                    }
                                    if (!hasData) {
                        %>
                            <tr>
                                <td colspan="10" style="text-align:center; padding:30px; color:var(--dark-muted);"><i class="fa-solid fa-calendar-xmark" style="margin-right:8px;"></i>No appointments found in database.</td>
                            </tr>
                        <%
                                    }
                                }
                            } catch(Exception e) {
                        %>
                            <tr>
                                <td colspan="10" style="color:red; text-align:center;">Error loading queue: <%= e.getMessage() %></td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
        </form>

    </div>

    <!-- JavaScript for checkbox logic -->
    <script>
        // Select All / Deselect All
        document.getElementById('selectAllChk').addEventListener('change', function() {
            const checkboxes = document.querySelectorAll('.row-chk');
            checkboxes.forEach(chk => {
                chk.checked = this.checked;
                const row = chk.closest('tr');
                if (this.checked) row.classList.add('row-selected');
                else row.classList.remove('row-selected');
            });
            updateSelectedCount();
        });

        // Update selected count badge
        function updateSelectedCount() {
            const checkboxes = document.querySelectorAll('.row-chk');
            let count = 0;
            checkboxes.forEach(chk => {
                const row = chk.closest('tr');
                if (chk.checked) {
                    count++;
                    row.classList.add('row-selected');
                } else {
                    row.classList.remove('row-selected');
                }
            });
            const badge = document.getElementById('selectedBadge');
            if (count > 0) {
                badge.style.display = 'inline-block';
                badge.textContent = count + ' selected';
            } else {
                badge.style.display = 'none';
            }
            // Sync select-all checkbox state
            const selectAll = document.getElementById('selectAllChk');
            selectAll.checked = (count === checkboxes.length && checkboxes.length > 0);
            selectAll.indeterminate = (count > 0 && count < checkboxes.length);
        }

        // Delete Selected
        function submitDeleteSelected() {
            const checked = document.querySelectorAll('.row-chk:checked');
            if (checked.length === 0) {
                alert('Koi appointment select nahi ki! Pehle checkbox select karen.');
                return;
            }
            if (confirm(checked.length + ' appointment(s) delete karna chahte hain?')) {
                document.getElementById('formAction').value = 'delete_selected';
                document.getElementById('deleteForm').submit();
            }
        }

        // Delete All
        function submitDeleteAll() {
            const rows = document.querySelectorAll('.row-chk');
            if (rows.length === 0) {
                alert('Table mein koi appointment nahi hai!');
                return;
            }
            if (confirm('Saari ' + rows.length + ' appointments delete karna chahte hain? Yeh action UNDO nahi hoga!')) {
                document.getElementById('formAction').value = 'delete_all';
                // Uncheck all so no filter applies — server handles DELETE all
                document.querySelectorAll('.row-chk').forEach(c => c.checked = false);
                document.getElementById('deleteForm').submit();
            }
        }
    </script>

</body>
</html>
