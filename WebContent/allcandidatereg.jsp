<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="dbcon.dbconn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Candidate Management | Student Voting System</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
    :root {
        --dark-bg: #0f172a;
        --darker-bg: #0a0f1f;
        --card-bg: #1e293b;
        --hover-bg: #2d3748;
        --primary: #3b82f6;
        --primary-hover: #2563eb;
        --secondary: #8b5cf6;
        --success: #10b981;
        --warning: #f59e0b;
        --danger: #ef4444;
        --text-primary: #f1f5f9;
        --text-secondary: #cbd5e1;
        --text-muted: #94a3b8;
        --border-color: #334155;
        --shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.5);
        --shadow-lg: 0 10px 25px -3px rgba(0, 0, 0, 0.7);
        --radius: 12px;
        --radius-sm: 8px;
        --transition: all 0.3s ease;
    }
    
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }
    
    body {
        background: var(--dark-bg);
        color: var(--text-primary);
        font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', system-ui, sans-serif;
        min-height: 100vh;
        padding: 20px;
        line-height: 1.6;
    }
    
    .container {
        max-width: 1400px;
        margin: 0 auto;
    }
    
    /* Back Button */
    .back-btn {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        background: var(--card-bg);
        color: var(--text-secondary);
        border: 1px solid var(--border-color);
        padding: 12px 20px;
        border-radius: var(--radius-sm);
        text-decoration: none;
        font-weight: 500;
        font-size: 15px;
        transition: var(--transition);
        margin-bottom: 25px;
        cursor: pointer;
    }
    
    .back-btn:hover {
        background: var(--hover-bg);
        color: var(--text-primary);
        transform: translateX(-3px);
        border-color: var(--primary);
    }
    
    /* Header */
    .header {
        background: var(--card-bg);
        border-radius: var(--radius);
        padding: 30px;
        margin-bottom: 25px;
        box-shadow: var(--shadow);
        border-left: 4px solid var(--primary);
        position: relative;
        overflow: hidden;
    }
    
    .header::before {
        content: '';
        position: absolute;
        top: 0;
        right: 0;
        width: 200px;
        height: 200px;
        background: radial-gradient(circle, rgba(59, 130, 246, 0.1) 0%, transparent 70%);
        pointer-events: none;
    }
    
    .header-content {
        display: flex;
        justify-content: space-between;
        align-items: center;
        flex-wrap: wrap;
        gap: 20px;
    }
    
    .header-text h1 {
        font-size: 32px;
        font-weight: 700;
        background: linear-gradient(to right, var(--text-primary), var(--primary));
        -webkit-background-clip: text;
        background-clip: text;
        color: transparent;
        margin-bottom: 8px;
        display: flex;
        align-items: center;
        gap: 12px;
    }
    
    .header-text p {
        color: var(--text-secondary);
        font-size: 16px;
        max-width: 600px;
    }
    
    /* Stats Cards */
    .stats-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
        gap: 20px;
        margin-bottom: 30px;
    }
    
    .stat-card {
        background: var(--card-bg);
        border-radius: var(--radius);
        padding: 25px;
        text-align: center;
        transition: var(--transition);
        border: 1px solid transparent;
        position: relative;
        overflow: hidden;
    }
    
    .stat-card:hover {
        transform: translateY(-5px);
        border-color: var(--primary);
        box-shadow: var(--shadow-lg);
    }
    
    .stat-card::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 4px;
        background: linear-gradient(to right, var(--primary), var(--secondary));
    }
    
    .stat-icon {
        width: 48px;
        height: 48px;
        background: rgba(59, 130, 246, 0.1);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto 15px;
        font-size: 20px;
        color: var(--primary);
    }
    
    .stat-number {
        font-size: 36px;
        font-weight: 700;
        margin-bottom: 5px;
        color: var(--text-primary);
    }
    
    .stat-label {
        color: var(--text-muted);
        font-size: 14px;
        font-weight: 500;
        text-transform: uppercase;
        letter-spacing: 1px;
    }
    
    /* Controls */
    .controls {
        background: var(--card-bg);
        border-radius: var(--radius);
        padding: 25px;
        margin-bottom: 30px;
        box-shadow: var(--shadow);
        display: flex;
        justify-content: space-between;
        align-items: center;
        flex-wrap: wrap;
        gap: 20px;
    }
    
    .search-box {
        flex: 1;
        max-width: 400px;
        position: relative;
    }
    
    .search-box i {
        position: absolute;
        left: 18px;
        top: 50%;
        transform: translateY(-50%);
        color: var(--text-muted);
    }
    
    .search-box input {
        width: 100%;
        padding: 14px 20px 14px 50px;
        background: var(--darker-bg);
        border: 1px solid var(--border-color);
        border-radius: var(--radius-sm);
        color: var(--text-primary);
        font-size: 15px;
        transition: var(--transition);
    }
    
    .search-box input:focus {
        outline: none;
        border-color: var(--primary);
        box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.2);
    }
    
    .filter-buttons {
        display: flex;
        gap: 12px;
        flex-wrap: wrap;
    }
    
    .filter-btn {
        padding: 12px 24px;
        background: var(--darker-bg);
        border: 1px solid var(--border-color);
        border-radius: var(--radius-sm);
        color: var(--text-secondary);
        font-weight: 500;
        cursor: pointer;
        transition: var(--transition);
        font-size: 14px;
        display: flex;
        align-items: center;
        gap: 8px;
    }
    
    .filter-btn:hover {
        background: var(--hover-bg);
        color: var(--text-primary);
    }
    
    .filter-btn.active {
        background: var(--primary);
        color: white;
        border-color: var(--primary);
    }
    
    /* Table Container */
    .table-container {
        background: var(--card-bg);
        border-radius: var(--radius);
        overflow: hidden;
        box-shadow: var(--shadow-lg);
        margin-bottom: 30px;
    }
    
    .table-header {
        background: rgba(30, 41, 59, 0.95);
        padding: 25px;
        border-bottom: 1px solid var(--border-color);
        display: flex;
        justify-content: space-between;
        align-items: center;
        flex-wrap: wrap;
        gap: 15px;
        backdrop-filter: blur(10px);
    }
    
    .table-header h2 {
        font-size: 22px;
        font-weight: 600;
        display: flex;
        align-items: center;
        gap: 12px;
    }
    
    .table-actions {
        display: flex;
        gap: 12px;
    }
    
    .action-btn {
        padding: 10px 18px;
        background: var(--darker-bg);
        border: 1px solid var(--border-color);
        border-radius: var(--radius-sm);
        color: var(--text-secondary);
        cursor: pointer;
        display: flex;
        align-items: center;
        gap: 8px;
        font-size: 14px;
        font-weight: 500;
        transition: var(--transition);
    }
    
    .action-btn:hover {
        background: var(--hover-bg);
        color: var(--text-primary);
        transform: translateY(-2px);
    }
    
    .action-btn.primary {
        background: var(--primary);
        color: white;
        border-color: var(--primary);
    }
    
    /* Table */
    .data-table {
        width: 100%;
        border-collapse: collapse;
    }
    
    .data-table thead {
        background: rgba(15, 23, 42, 0.8);
        backdrop-filter: blur(10px);
    }
    
    .data-table th {
        padding: 20px;
        text-align: left;
        font-weight: 600;
        color: var(--text-secondary);
        border-bottom: 1px solid var(--border-color);
        font-size: 14px;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        position: sticky;
        top: 0;
        background: rgba(15, 23, 42, 0.95);
    }
    
    .data-table td {
        padding: 20px;
        border-bottom: 1px solid var(--border-color);
        color: var(--text-primary);
        transition: var(--transition);
    }
    
    .data-table tbody tr {
        transition: var(--transition);
    }
    
    .data-table tbody tr:hover {
        background: var(--hover-bg);
    }
    
    /* Department Tags */
    .dept-tag {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        padding: 8px 16px;
        border-radius: 20px;
        font-size: 13px;
        font-weight: 600;
        background: rgba(59, 130, 246, 0.1);
        color: var(--primary);
        border: 1px solid rgba(59, 130, 246, 0.3);
    }
    
    .dept-cse { background: rgba(16, 185, 129, 0.1); color: var(--success); border-color: rgba(16, 185, 129, 0.3); }
    .dept-it { background: rgba(139, 92, 246, 0.1); color: var(--secondary); border-color: rgba(139, 92, 246, 0.3); }
    .dept-ece { background: rgba(245, 158, 11, 0.1); color: var(--warning); border-color: rgba(245, 158, 11, 0.3); }
    .dept-mech { background: rgba(239, 68, 68, 0.1); color: var(--danger); border-color: rgba(239, 68, 68, 0.3); }
    .dept-civil { background: rgba(6, 182, 212, 0.1); color: #06b6d4; border-color: rgba(6, 182, 212, 0.3); }
    .dept-eee { background: rgba(236, 72, 153, 0.1); color: #ec4899; border-color: rgba(236, 72, 153, 0.3); }
    
    /* Status Badges */
    .status-badge {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        padding: 8px 16px;
        border-radius: 20px;
        font-size: 13px;
        font-weight: 600;
    }
    
    .status-approved {
        background: rgba(16, 185, 129, 0.1);
        color: var(--success);
        border: 1px solid rgba(16, 185, 129, 0.3);
    }
    
    .status-pending {
        background: rgba(245, 158, 11, 0.1);
        color: var(--warning);
        border: 1px solid rgba(245, 158, 11, 0.3);
    }
    
    .status-rejected {
        background: rgba(239, 68, 68, 0.1);
        color: var(--danger);
        border: 1px solid rgba(239, 68, 68, 0.3);
    }
    
    /* ID Card Link */
    .id-card-link {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        color: var(--primary);
        text-decoration: none;
        font-weight: 500;
        padding: 8px 16px;
        border-radius: var(--radius-sm);
        background: rgba(59, 130, 246, 0.1);
        border: 1px solid rgba(59, 130, 246, 0.2);
        transition: var(--transition);
    }
    
    .id-card-link:hover {
        background: rgba(59, 130, 246, 0.2);
        transform: translateY(-2px);
        color: var(--primary-hover);
    }
    
    /* Footer */
    .footer {
        text-align: center;
        padding: 30px;
        color: var(--text-muted);
        font-size: 14px;
        background: var(--card-bg);
        border-radius: var(--radius);
        box-shadow: var(--shadow);
        margin-top: 30px;
    }
    
    .footer-links {
        display: flex;
        justify-content: center;
        gap: 25px;
        margin-top: 15px;
    }
    
    .footer-links a {
        color: var(--text-secondary);
        text-decoration: none;
        transition: var(--transition);
        display: flex;
        align-items: center;
        gap: 6px;
    }
    
    .footer-links a:hover {
        color: var(--primary);
    }
    
    /* Empty State */
    .empty-state {
        text-align: center;
        padding: 60px 20px;
        color: var(--text-muted);
    }
    
    .empty-state i {
        font-size: 48px;
        margin-bottom: 20px;
        opacity: 0.5;
    }
    
    /* Responsive Design */
    @media (max-width: 1200px) {
        .header-content {
            flex-direction: column;
            align-items: flex-start;
        }
        
        .stats-grid {
            grid-template-columns: repeat(2, 1fr);
        }
    }
    
    @media (max-width: 768px) {
        body {
            padding: 15px;
        }
        
        .header, .controls, .table-container {
            padding: 20px;
        }
        
        .stats-grid {
            grid-template-columns: 1fr;
        }
        
        .controls {
            flex-direction: column;
        }
        
        .search-box {
            max-width: 100%;
        }
        
        .table-header {
            flex-direction: column;
            align-items: flex-start;
        }
        
        .table-actions {
            width: 100%;
            justify-content: flex-start;
        }
        
        .data-table {
            display: block;
            overflow-x: auto;
        }
        
        .footer-links {
            flex-direction: column;
            gap: 15px;
        }
    }
    
    /* Animations */
    @keyframes fadeIn {
        from {
            opacity: 0;
            transform: translateY(20px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }
    
    .data-table tbody tr {
        animation: fadeIn 0.5s ease-out;
    }
    
    /* Scrollbar Styling */
    ::-webkit-scrollbar {
        width: 8px;
        height: 8px;
    }
    
    ::-webkit-scrollbar-track {
        background: var(--darker-bg);
        border-radius: 4px;
    }
    
    ::-webkit-scrollbar-thumb {
        background: var(--border-color);
        border-radius: 4px;
    }
    
    ::-webkit-scrollbar-thumb:hover {
        background: var(--primary);
    }
</style>
</head>
<body>
    <div class="container">
        <!-- Back Button -->
        <button class="back-btn" onclick="goBack()">
            <i class="fas fa-arrow-left"></i> Back to Dashboard
        </button>
        
        <!-- Header -->
        <header class="header">
            <div class="header-content">
                <div class="header-text">
                    <h1><i class="fas fa-user-tie"></i> Candidate Management</h1>
                    <p>Monitor and manage all nominated candidates for the Student Voting System</p>
                </div>
                <div class="header-stats">
                    <!-- Stats will be populated by JavaScript -->
                </div>
            </div>
        </header>
        
        <!-- Statistics Cards -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-users"></i>
                </div>
                <div class="stat-number" id="totalCandidates">0</div>
                <div class="stat-label">Total Candidates</div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-check-circle"></i>
                </div>
                <div class="stat-number" id="approvedCandidates">0</div>
                <div class="stat-label">Approved</div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-clock"></i>
                </div>
                <div class="stat-number" id="pendingCandidates">0</div>
                <div class="stat-label">Pending Review</div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-times-circle"></i>
                </div>
                <div class="stat-number" id="rejectedCandidates">0</div>
                <div class="stat-label">Rejected</div>
            </div>
        </div>
        
        <!-- Controls -->
        <div class="controls">
            <div class="search-box">
                <i class="fas fa-search"></i>
                <input type="text" id="searchInput" placeholder="Search candidates by department, roll number, or email...">
            </div>
            
            <div class="filter-buttons">
                <button class="filter-btn active" data-filter="all">
                    <i class="fas fa-list"></i> All
                </button>
                <button class="filter-btn" data-filter="approved">
                    <i class="fas fa-check"></i> Approved
                </button>
                <button class="filter-btn" data-filter="pending">
                    <i class="fas fa-clock"></i> Pending
                </button>
                <button class="filter-btn" data-filter="rejected">
                    <i class="fas fa-times"></i> Rejected
                </button>
            </div>
        </div>
        
        <!-- Table Container -->
        <div class="table-container">
            <div class="table-header">
                <h2><i class="fas fa-table"></i> Candidate Directory</h2>
                <div class="table-actions">              
                    <button class="action-btn primary" onclick="refreshData()">
                        <i class="fas fa-sync-alt"></i> Refresh
                    </button>
                </div>
            </div>
            
            <table class="data-table" id="candidatesTable">
                <thead>
                    <tr>
                        <th>Candidate Department</th>
                        <th>Roll Number</th>
                        <th>Candidate Email</th>
                        <th>Candidate Mobile</th>
                         <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                <%
                Connection con=null;
                PreparedStatement ps=null;
                ResultSet rs=null;
                int totalCount = 0;
                int approvedCount = 0;
                int pendingCount = 0;
                int rejectedCount = 0;
                boolean hasData = false;
                
                try{
                    con=dbconn.create();
                   String sql="SELECT * FROM `studentvoute`.`nominatecandidate`";
                   ps = con.prepareStatement(sql);
                   rs=ps.executeQuery();
                   while (rs.next()) {
                        hasData = true;
                        totalCount++;
                        String status = rs.getString("status");
                        String dept = rs.getString("class_department");
                        
                        // Count statuses
                        if("approved".equalsIgnoreCase(status)) {
                            approvedCount++;
                        } else if("rejected".equalsIgnoreCase(status)) {
                            rejectedCount++;
                        } else {
                            pendingCount++;
                        }
                        
                        // Determine department class
                        String deptClass = "dept-cse";
                        if(dept != null) {
                            dept = dept.toLowerCase();
                            if(dept.contains("it")) deptClass = "dept-it";
                            else if(dept.contains("ece") || dept.contains("electronic")) deptClass = "dept-ece";
                            else if(dept.contains("mech")) deptClass = "dept-mech";
                            else if(dept.contains("civil")) deptClass = "dept-civil";
                            else if(dept.contains("eee") || dept.contains("electrical")) deptClass = "dept-eee";
                        }
                        
                        // Determine status class
                        String statusClass = "status-pending";
                        String statusIcon = "fas fa-clock";
                        if("approved".equalsIgnoreCase(status)) {
                            statusClass = "status-approved";
                            statusIcon = "fas fa-check-circle";
                        } else if("rejected".equalsIgnoreCase(status)) {
                            statusClass = "status-rejected";
                            statusIcon = "fas fa-times-circle";
                        }
                        %>
                        
                        <tr class="candidate-row" data-status="<%= status != null ? status.toLowerCase() : "pending" %>">
                            <td>
                                <span class="dept-tag <%= deptClass %>">
                                    <i class="fas fa-graduation-cap"></i>
                                    <%=rs.getString("class_department") %>
                                </span>
                            </td>
                            <td>
                                <strong><%=rs.getString("roll_number") %></strong>
                            </td>
                            <td>
                                <i class="fas fa-envelope" style="margin-right: 8px; color: var(--text-muted);"></i>
                                <%=rs.getString("email") %>
                            </td>
                            <td>
                                <i class="fas fa-phone" style="margin-right: 8px; color: var(--text-muted);"></i>
                                <%=rs.getString("mobile") %>
                            </td>
                            
                            <td>
                                <span class="status-badge <%= statusClass %>">
                                    <i class="<%= statusIcon %>"></i>
                                    <%= status != null ? status : "Pending" %>
                                </span>
                            </td>
                        </tr>
                    <% 
                   }
                }catch(Exception e){
                    e.getMessage();
                }
                
                // Close resources
                if(rs != null) try { rs.close(); } catch(Exception e) {}
                if(ps != null) try { ps.close(); } catch(Exception e) {}
                if(con != null) try { con.close(); } catch(Exception e) {}
                %>
                
                <% if(!hasData) { %>
                    <tr>
                        <td colspan="6">
                            <div class="empty-state">
                                <i class="fas fa-user-slash"></i>
                                <h3>No Candidates Found</h3>
                                <p>No candidates have been nominated yet.</p>
                            </div>
                        </td>
                    </tr>
                <% } %>
                </tbody>
            </table>
        </div>
        
        <!-- Footer -->
        <footer class="footer">
            <p>&copy; <%= new java.text.SimpleDateFormat("yyyy").format(new java.util.Date()) %> Student Voting System | Secure Online Voting Platform</p>
            <div class="footer-links">
                <a href="#"><i class="fas fa-question-circle"></i> Help Center</a>
                <a href="#"><i class="fas fa-shield-alt"></i> Privacy Policy</a>
                <a href="#"><i class="fas fa-cogs"></i> System Status</a>
            </div>
        </footer>
    </div>

    <script>
        // Initialize statistics
        document.addEventListener('DOMContentLoaded', function() {
            updateStatistics();
            initializeEventListeners();
        });
        
        function updateStatistics() {
            // Update all statistics
            document.getElementById('totalCandidates').textContent = <%= totalCount %>;
            document.getElementById('approvedCandidates').textContent = <%= approvedCount %>;
            document.getElementById('pendingCandidates').textContent = <%= pendingCount %>;
            document.getElementById('rejectedCandidates').textContent = <%= rejectedCount %>;
        }
        
        function initializeEventListeners() {
            // Search functionality
            const searchInput = document.getElementById('searchInput');
            if(searchInput) {
                searchInput.addEventListener('input', function() {
                    const searchTerm = this.value.toLowerCase();
                    const rows = document.querySelectorAll('.candidate-row');
                    let visibleCount = 0;
                    
                    rows.forEach(row => {
                        const text = row.textContent.toLowerCase();
                        if(text.includes(searchTerm)) {
                            row.style.display = '';
                            visibleCount++;
                        } else {
                            row.style.display = 'none';
                        }
                    });
                    
                    // Update total count
                    document.getElementById('totalCandidates').textContent = visibleCount;
                });
            }
            
            // Filter functionality
            const filterButtons = document.querySelectorAll('.filter-btn');
            filterButtons.forEach(button => {
                button.addEventListener('click', function() {
                    // Update active button
                    filterButtons.forEach(btn => btn.classList.remove('active'));
                    this.classList.add('active');
                    
                    // Filter rows
                    const filter = this.getAttribute('data-filter');
                    const rows = document.querySelectorAll('.candidate-row');
                    let visibleCount = 0;
                    
                    rows.forEach(row => {
                        const status = row.getAttribute('data-status');
                        
                        if(filter === 'all' || status === filter) {
                            row.style.display = '';
                            visibleCount++;
                        } else {
                            row.style.display = 'none';
                        }
                    });
                    
                    // Update total count
                    document.getElementById('totalCandidates').textContent = visibleCount;
                });
            });
            
            // Add hover effects to table rows
            const tableRows = document.querySelectorAll('.candidate-row');
            tableRows.forEach(row => {
                row.addEventListener('mouseenter', function() {
                    this.style.transform = 'scale(1.01)';
                    this.style.boxShadow = '0 10px 25px rgba(0, 0, 0, 0.3)';
                });
                
                row.addEventListener('mouseleave', function() {
                    this.style.transform = 'scale(1)';
                    this.style.boxShadow = 'none';
                });
            });
        }
        
        // Back button function
        function goBack() {
            window.history.back();
            // In a real application, you might want to redirect to a specific page:
            // window.location.href = 'dashboard.jsp';
        }
        
        // Export data function
        function exportData() {
            alert('Exporting candidate data to CSV file...\n\nThis feature would generate and download a CSV file in a real application.');
            
            // In a real application, this would make an AJAX call to generate CSV
            // fetch('/export-candidates', { method: 'POST' })
            //     .then(response => response.blob())
            //     .then(blob => {
            //         const url = window.URL.createObjectURL(blob);
            //         const a = document.createElement('a');
            //         a.href = url;
            //         a.download = 'candidates.csv';
            //         document.body.appendChild(a);
            //         a.click();
            //         window.URL.revokeObjectURL(url);
            //     });
        }
        
        // Refresh data function
        function refreshData() {
            // Show loading state
            const refreshBtn = document.querySelector('.action-btn.primary');
            const originalContent = refreshBtn.innerHTML;
            refreshBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Refreshing...';
            refreshBtn.disabled = true;
            
            // Simulate refresh delay
            setTimeout(() => {
                window.location.reload();
            }, 1000);
        }
        
        // Add smooth scrolling for anchor links
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function(e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if(target) {
                    target.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                }
            });
        });
    </script>
</body>
</html>