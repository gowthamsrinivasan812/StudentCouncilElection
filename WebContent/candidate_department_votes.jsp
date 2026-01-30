<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="dbcon.dbconn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Department-wise Votes | Election Analytics</title>
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
        --success-light: rgba(16, 185, 129, 0.1);
        --warning: #f59e0b;
        --danger: #ef4444;
        --info: #0ea5e9;
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
        background-image: 
            radial-gradient(circle at 10% 20%, rgba(59, 130, 246, 0.05) 0%, transparent 20%),
            radial-gradient(circle at 90% 80%, rgba(139, 92, 246, 0.05) 0%, transparent 20%);
    }
    
    .container {
        max-width: 1200px;
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
        padding: 12px 24px;
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
        box-shadow: 0 4px 12px rgba(59, 130, 246, 0.2);
    }
    
    /* Header */
    .header {
        background: linear-gradient(135deg, var(--card-bg) 0%, rgba(30, 41, 59, 0.95) 100%);
        border-radius: var(--radius);
        padding: 40px;
        margin-bottom: 30px;
        box-shadow: var(--shadow);
        border-left: 4px solid var(--info);
        position: relative;
        overflow: hidden;
        backdrop-filter: blur(10px);
    }
    
    .header::before {
        content: '';
        position: absolute;
        top: 0;
        right: 0;
        width: 300px;
        height: 300px;
        background: radial-gradient(circle, rgba(14, 165, 233, 0.1) 0%, transparent 70%);
        pointer-events: none;
    }
    
    .header-content {
        position: relative;
        z-index: 1;
    }
    
    .header h1 {
        font-size: 36px;
        font-weight: 700;
        background: linear-gradient(to right, var(--text-primary), var(--info));
        -webkit-background-clip: text;
        background-clip: text;
        color: transparent;
        margin-bottom: 12px;
        display: flex;
        align-items: center;
        gap: 12px;
    }
    
    .header .candidate-email {
        display: inline-flex;
        align-items: center;
        gap: 10px;
        background: rgba(14, 165, 233, 0.1);
        color: var(--info);
        padding: 12px 24px;
        border-radius: var(--radius-sm);
        font-family: 'Monaco', 'Consolas', monospace;
        font-size: 15px;
        border: 1px solid rgba(14, 165, 233, 0.3);
        margin-top: 15px;
    }
    
    .header .candidate-email i {
        font-size: 14px;
    }
    
    /* Search Section */
    .search-section {
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
        border: 1px solid var(--border-color);
    }
    
    .search-box {
        flex: 1;
        max-width: 500px;
        position: relative;
    }
    
    .search-box i {
        position: absolute;
        left: 18px;
        top: 50%;
        transform: translateY(-50%);
        color: var(--text-muted);
        z-index: 2;
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
        position: relative;
    }
    
    .search-box input:focus {
        outline: none;
        border-color: var(--info);
        box-shadow: 0 0 0 3px rgba(14, 165, 233, 0.2);
    }
    
    .search-hint {
        color: var(--text-muted);
        font-size: 13px;
        margin-top: 8px;
        display: flex;
        align-items: center;
        gap: 6px;
    }
    
    .clear-search {
        padding: 10px 18px;
        background: transparent;
        border: 1px solid var(--border-color);
        border-radius: var(--radius-sm);
        color: var(--text-secondary);
        cursor: pointer;
        font-size: 13px;
        font-weight: 500;
        transition: var(--transition);
        display: flex;
        align-items: center;
        gap: 6px;
    }
    
    .clear-search:hover {
        background: var(--danger);
        color: white;
        border-color: var(--danger);
    }
    
    /* Stats Summary */
    .stats-summary {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 20px;
        margin-bottom: 30px;
    }
    
    .stat-item {
        background: var(--card-bg);
        border-radius: var(--radius);
        padding: 25px;
        display: flex;
        align-items: center;
        gap: 15px;
        transition: var(--transition);
        border: 1px solid transparent;
    }
    
    .stat-item:hover {
        border-color: var(--info);
        transform: translateY(-3px);
        box-shadow: var(--shadow);
    }
    
    .stat-icon {
        width: 50px;
        height: 50px;
        border-radius: 12px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 22px;
    }
    
    .stat-icon.departments {
        background: rgba(59, 130, 246, 0.15);
        color: var(--primary);
    }
    
    .stat-icon.votes {
        background: rgba(16, 185, 129, 0.15);
        color: var(--success);
    }
    
    .stat-icon.max {
        background: rgba(245, 158, 11, 0.15);
        color: var(--warning);
    }
    
    .stat-icon.avg {
        background: rgba(139, 92, 246, 0.15);
        color: var(--secondary);
    }
    
    .stat-content h3 {
        font-size: 28px;
        font-weight: 700;
        margin-bottom: 4px;
    }
    
    .stat-content p {
        color: var(--text-muted);
        font-size: 14px;
    }
    
    /* Table Container */
    .table-container {
        background: var(--card-bg);
        border-radius: var(--radius);
        overflow: hidden;
        box-shadow: var(--shadow-lg);
        margin-bottom: 30px;
        border: 1px solid var(--border-color);
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
    
    .result-count {
        color: var(--text-muted);
        font-size: 14px;
        background: var(--darker-bg);
        padding: 6px 12px;
        border-radius: var(--radius-sm);
        border: 1px solid var(--border-color);
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
        transform: scale(1.01);
    }
    
    /* Department Tag */
    .dept-cell {
        display: flex;
        align-items: center;
        gap: 12px;
    }
    
    .dept-icon {
        width: 40px;
        height: 40px;
        border-radius: 10px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 18px;
    }
    
    .dept-cse { background: rgba(16, 185, 129, 0.15); color: var(--success); }
    .dept-it { background: rgba(139, 92, 246, 0.15); color: var(--secondary); }
    .dept-ece { background: rgba(245, 158, 11, 0.15); color: var(--warning); }
    .dept-mech { background: rgba(239, 68, 68, 0.15); color: var(--danger); }
    .dept-civil { background: rgba(6, 182, 212, 0.15); color: #06b6d4; }
    .dept-eee { background: rgba(236, 72, 153, 0.15); color: #ec4899; }
    .dept-bba { background: rgba(34, 197, 94, 0.15); color: #22c55e; }
    .dept-mba { background: rgba(168, 85, 247, 0.15); color: #a855f7; }
    
    /* Vote Bar */
    .vote-bar-container {
        width: 100%;
        background: var(--darker-bg);
        height: 8px;
        border-radius: 4px;
        overflow: hidden;
        margin-top: 8px;
    }
    
    .vote-bar {
        height: 100%;
        border-radius: 4px;
        transition: width 1s ease;
    }
    
    .vote-count {
        font-weight: 700;
        font-size: 20px;
        color: var(--text-primary);
        margin-bottom: 4px;
        display: flex;
        align-items: center;
        gap: 8px;
    }
    
    /* Chart Container */
    .chart-container {
        background: var(--card-bg);
        border-radius: var(--radius);
        padding: 30px;
        margin-bottom: 30px;
        box-shadow: var(--shadow);
        border: 1px solid var(--border-color);
    }
    
    .chart-container h3 {
        font-size: 20px;
        margin-bottom: 20px;
        display: flex;
        align-items: center;
        gap: 10px;
        color: var(--text-primary);
    }
    
    .chart-placeholder {
        height: 300px;
        display: flex;
        align-items: center;
        justify-content: center;
        background: var(--darker-bg);
        border-radius: var(--radius-sm);
        border: 2px dashed var(--border-color);
        color: var(--text-muted);
        font-size: 14px;
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
        border: 1px solid var(--border-color);
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
        color: var(--info);
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
    
    .empty-state h3 {
        font-size: 20px;
        margin-bottom: 10px;
        color: var(--text-secondary);
    }
    
    /* Responsive Design */
    @media (max-width: 768px) {
        body {
            padding: 15px;
        }
        
        .header {
            padding: 25px;
        }
        
        .header h1 {
            font-size: 28px;
        }
        
        .search-section {
            flex-direction: column;
        }
        
        .search-box {
            max-width: 100%;
        }
        
        .table-header {
            flex-direction: column;
            align-items: flex-start;
        }
        
        .data-table {
            display: block;
            overflow-x: auto;
        }
        
        .stats-summary {
            grid-template-columns: 1fr;
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
    
    @keyframes slideIn {
        from {
            opacity: 0;
            transform: translateX(-20px);
        }
        to {
            opacity: 1;
            transform: translateX(0);
        }
    }
    
    .data-table tbody tr {
        animation: slideIn 0.3s ease-out;
        animation-fill-mode: both;
    }
    
    .data-table tbody tr:nth-child(1) { animation-delay: 0.1s; }
    .data-table tbody tr:nth-child(2) { animation-delay: 0.2s; }
    .data-table tbody tr:nth-child(3) { animation-delay: 0.3s; }
    .data-table tbody tr:nth-child(4) { animation-delay: 0.4s; }
    .data-table tbody tr:nth-child(5) { animation-delay: 0.5s; }
    
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
        background: var(--info);
    }
</style>
</head>
<body>
    <div class="container">
        <!-- Back Button -->
        <button class="back-btn" onclick="goBack()">
            <i class="fas fa-arrow-left"></i> Back to Candidate List
        </button>
        
        <!-- Header -->
        <header class="header">
            <div class="header-content">
                <h1><i class="fas fa-chart-pie"></i> Department-wise Votes Analysis</h1>
                <p>Detailed breakdown of votes received by candidate across different departments</p>
                <div class="candidate-email">
                    <i class="fas fa-envelope"></i>
                    <%= request.getParameter("cemail") %>
                </div>
            </div>
        </header>
        
        <%
        String cemail = request.getParameter("cemail");
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        int totalDepartments = 0;
        int totalVotes = 0;
        int maxVotes = 0;
        String maxDept = "";
        boolean hasData = false;
        %>
        
        <!-- Stats Summary -->
        <div class="stats-summary">
            <div class="stat-item">
                <div class="stat-icon departments">
                    <i class="fas fa-building"></i>
                </div>
                <div class="stat-content">
                    <h3 id="deptCount">0</h3>
                    <p>Departments Voted</p>
                </div>
            </div>
            
            <div class="stat-item">
                <div class="stat-icon votes">
                    <i class="fas fa-vote-yea"></i>
                </div>
                <div class="stat-content">
                    <h3 id="totalVotes">0</h3>
                    <p>Total Votes Received</p>
                </div>
            </div>
            
            <div class="stat-item">
                <div class="stat-icon max">
                    <i class="fas fa-trophy"></i>
                </div>
                <div class="stat-content">
                    <h3 id="maxVotes">0</h3>
                    <p>Most Votes (Dept)</p>
                </div>
            </div>
            
            <div class="stat-item">
                <div class="stat-icon avg">
                    <i class="fas fa-chart-bar"></i>
                </div>
                <div class="stat-content">
                    <h3 id="avgVotes">0</h3>
                    <p>Average per Department</p>
                </div>
            </div>
        </div>
        
        <!-- Search Section -->
        <div class="search-section">
            <div class="search-box">
                <i class="fas fa-search"></i>
                <input type="text" id="searchInput" placeholder="Search departments by name...">
                <div class="search-hint">
                    <i class="fas fa-info-circle"></i> Type to filter departments
                </div>
            </div>
            <button class="clear-search" onclick="clearSearch()">
                <i class="fas fa-times"></i> Clear Search
            </button>
        </div>
        
        <!-- Chart Visualization -->
        <div class="chart-container">
            <h3><i class="fas fa-chart-bar"></i> Vote Distribution</h3>
            <div class="chart-placeholder" id="voteChart">
                <div style="text-align: center;">
                    <i class="fas fa-chart-bar" style="font-size: 48px; margin-bottom: 15px; display: block; opacity: 0.3;"></i>
                    <p>Vote distribution chart will appear here</p>
                </div>
            </div>
        </div>
        
        <!-- Table Container -->
        <div class="table-container">
            <div class="table-header">
                <h2><i class="fas fa-table"></i> Department Vote Breakdown</h2>
                <div class="result-count">
                    <span id="resultCount">0</span> departments found
                </div>
            </div>
            
            <table class="data-table" id="votesTable">
                <thead>
                    <tr>
                        <th>Department</th>
                        <th>Total Votes</th>
                        <th>Distribution</th>
                    </tr>
                </thead>
                <tbody id="tableBody">
                <%
                try {
                    con = dbconn.create();
                    ps = con.prepareStatement(
                        "SELECT dept, COUNT(*) AS deptVotes " +
                        "FROM studentvoute.votes " +
                        "WHERE cemail = ? " +
                        "GROUP BY dept"
                    );
                    ps.setString(1, cemail);
                    rs = ps.executeQuery();
                    
                    // First pass to collect data
                    java.util.List<String[]> deptData = new java.util.ArrayList<>();
                    while (rs.next()) {
                        hasData = true;
                        totalDepartments++;
                        int votes = rs.getInt("deptVotes");
                        totalVotes += votes;
                        if (votes > maxVotes) {
                            maxVotes = votes;
                            maxDept = rs.getString("dept");
                        }
                        deptData.add(new String[]{rs.getString("dept"), String.valueOf(votes)});
                    }
                    
                    // Second pass to render with percentage calculation
                    if (!deptData.isEmpty()) {
                        for (String[] data : deptData) {
                            String dept = data[0];
                            int votes = Integer.parseInt(data[1]);
                            double percentage = totalVotes > 0 ? (votes * 100.0 / totalVotes) : 0;
                            
                            // Determine department class
                            String deptClass = "dept-cse";
                            if(dept != null) {
                                String deptLower = dept.toLowerCase();
                                if(deptLower.contains("it")) deptClass = "dept-it";
                                else if(deptLower.contains("ece") || deptLower.contains("electronic")) deptClass = "dept-ece";
                                else if(deptLower.contains("mech")) deptClass = "dept-mech";
                                else if(deptLower.contains("civil")) deptClass = "dept-civil";
                                else if(deptLower.contains("eee") || deptLower.contains("electrical")) deptClass = "dept-eee";
                                else if(deptLower.contains("bba")) deptClass = "dept-bba";
                                else if(deptLower.contains("mba")) deptClass = "dept-mba";
                            }
                            
                            // Choose icon based on department
                            String deptIcon = "fas fa-building";
                            if(dept != null) {
                                String deptLower = dept.toLowerCase();
                                if(deptLower.contains("computer")) deptIcon = "fas fa-laptop-code";
                                else if(deptLower.contains("electronic")) deptIcon = "fas fa-microchip";
                                else if(deptLower.contains("mech") || deptLower.contains("mechanical")) deptIcon = "fas fa-cogs";
                                else if(deptLower.contains("civil")) deptIcon = "fas fa-hard-hat";
                                else if(deptLower.contains("electrical")) deptIcon = "fas fa-bolt";
                                else if(deptLower.contains("business")) deptIcon = "fas fa-chart-line";
                            }
                            %>
                            <tr class="dept-row" data-dept="<%= dept.toLowerCase() %>" data-votes="<%= votes %>">
                                <td>
                                    <div class="dept-cell">
                                        <div class="dept-icon <%= deptClass %>">
                                            <i class="<%= deptIcon %>"></i>
                                        </div>
                                        <div>
                                            <strong style="display: block; font-size: 16px;"><%= dept %></strong>
                                            <span style="color: var(--text-muted); font-size: 13px;"><%= String.format("%.1f", percentage) %>% of total</span>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <div class="vote-count">
                                        <i class="fas fa-vote-yea" style="color: var(--success);"></i>
                                        <%= votes %> votes
                                    </div>
                                </td>
                                <td>
                                    <div class="vote-bar-container">
                                        <div class="vote-bar" 
                                             style="width: <%= percentage %>%; background: linear-gradient(to right, var(--info), var(--primary));"
                                             data-percentage="<%= percentage %>">
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <%
                        }
                    }
                } catch(Exception e) {
                    e.printStackTrace();
                } finally {
                    if(rs != null) try { rs.close(); } catch(Exception e) {}
                    if(ps != null) try { ps.close(); } catch(Exception e) {}
                    if(con != null) try { con.close(); } catch(Exception e) {}
                }
                %>
                
                <% if(!hasData) { %>
                    <tr>
                        <td colspan="3">
                            <div class="empty-state">
                                <i class="fas fa-chart-pie"></i>
                                <h3>No Vote Data Found</h3>
                                <p>This candidate hasn't received any votes from departments yet.</p>
                            </div>
                        </td>
                    </tr>
                <% } %>
                </tbody>
            </table>
        </div>
        
        <!-- Footer -->
      
    </div>

    <script>
        // Initialize statistics and search
        document.addEventListener('DOMContentLoaded', function() {
            updateStatistics();
            initializeSearch();
            updateResultCount();
            animateVoteBars();
        });
        
        // Update statistics
        function updateStatistics() {
            document.getElementById('deptCount').textContent = <%= totalDepartments %>;
            document.getElementById('totalVotes').textContent = <%= totalVotes %>;
            document.getElementById('maxVotes').textContent = <%= maxVotes %>;
            
            const avgVotes = <%= totalDepartments > 0 ? (double)totalVotes / totalDepartments : 0 %>;
            document.getElementById('avgVotes').textContent = avgVotes.toFixed(1);
        }
        
        // Initialize search functionality
        function initializeSearch() {
            const searchInput = document.getElementById('searchInput');
            if(searchInput) {
                searchInput.addEventListener('input', function() {
                    const searchTerm = this.value.toLowerCase();
                    const rows = document.querySelectorAll('.dept-row');
                    let visibleCount = 0;
                    
                    rows.forEach(row => {
                        const dept = row.getAttribute('data-dept');
                        if(dept.includes(searchTerm)) {
                            row.style.display = '';
                            visibleCount++;
                        } else {
                            row.style.display = 'none';
                        }
                    });
                    
                    updateResultCount(visibleCount);
                    
                    // Update search hint
                    const searchHint = document.querySelector('.search-hint');
                    if (searchTerm.length > 0) {
                        searchHint.innerHTML = `<i class="fas fa-filter"></i> Showing ${visibleCount} of ${rows.length} departments`;
                    } else {
                        searchHint.innerHTML = `<i class="fas fa-info-circle"></i> Type to filter departments`;
                    }
                });
            }
        }
        
        // Update result count
        function updateResultCount(count) {
            const rows = document.querySelectorAll('.dept-row');
            const totalCount = rows.length;
            const visibleCount = count !== undefined ? count : totalCount;
            
            document.getElementById('resultCount').textContent = visibleCount;
        }
        
        // Clear search
        function clearSearch() {
            const searchInput = document.getElementById('searchInput');
            searchInput.value = '';
            searchInput.dispatchEvent(new Event('input'));
        }
        
        // Animate vote bars
        function animateVoteBars() {
            const voteBars = document.querySelectorAll('.vote-bar');
            voteBars.forEach(bar => {
                const percentage = bar.getAttribute('data-percentage');
                bar.style.width = '0%';
                setTimeout(() => {
                    bar.style.width = percentage + '%';
                }, 300);
            });
        }
        
        // Back button function
        function goBack() {
            window.location.href = 'ecvote.jsp';
        }
        
        // Create simple chart visualization
        function createChart() {
            const chartContainer = document.getElementById('voteChart');
            const rows = document.querySelectorAll('.dept-row');
            
            if (rows.length === 0) return;
            
            // Extract data for chart
            const chartData = [];
            rows.forEach(row => {
                const dept = row.querySelector('.dept-cell strong').textContent;
                const votes = parseInt(row.getAttribute('data-votes'));
                chartData.push({ dept, votes });
            });
            
            // Sort by votes
            chartData.sort((a, b) => b.votes - a.votes);
            
            // Create simple bar chart using divs
            let chartHTML = '<div style="height: 100%; display: flex; flex-direction: column; justify-content: space-around; padding: 10px;">';
            
            chartData.forEach(item => {
                const maxVotes = Math.max(...chartData.map(d => d.votes));
                const barWidth = maxVotes > 0 ? (item.votes / maxVotes * 100) : 0;
                
                chartHTML += `
                    <div style="margin-bottom: 15px;">
                        <div style="display: flex; justify-content: space-between; margin-bottom: 5px;">
                            <span style="color: var(--text-secondary); font-size: 13px;">${item.dept}</span>
                            <span style="color: var(--text-primary); font-weight: 600;">${item.votes}</span>
                        </div>
                        <div style="height: 8px; background: var(--darker-bg); border-radius: 4px; overflow: hidden;">
                            <div style="height: 100%; width: ${barWidth}%; background: linear-gradient(to right, var(--info), var(--primary)); border-radius: 4px; transition: width 1s ease;"></div>
                        </div>
                    </div>
                `;
            });
            
            chartHTML += '</div>';
            chartContainer.innerHTML = chartHTML;
        }
        
        // Create chart after page loads
        setTimeout(createChart, 500);
        
        // Add hover effects
        document.addEventListener('DOMContentLoaded', function() {
            const tableRows = document.querySelectorAll('.dept-row');
            tableRows.forEach(row => {
                row.addEventListener('mouseenter', function() {
                    this.style.boxShadow = '0 8px 25px rgba(0, 0, 0, 0.3)';
                });
                
                row.addEventListener('mouseleave', function() {
                    this.style.boxShadow = 'none';
                });
            });
        });
        
        // Highlight highest votes
        setTimeout(() => {
            const maxVoteRows = document.querySelectorAll('.dept-row');
            let maxVotes = 0;
            let maxRow = null;
            
            maxVoteRows.forEach(row => {
                const votes = parseInt(row.getAttribute('data-votes'));
                if (votes > maxVotes) {
                    maxVotes = votes;
                    maxRow = row;
                }
            });
            
            if (maxRow && maxVotes > 0) {
                maxRow.style.borderLeft = '4px solid var(--warning)';
                maxRow.style.background = 'rgba(245, 158, 11, 0.05)';
                
                // Add trophy icon
                const deptCell = maxRow.querySelector('.dept-cell');
                deptCell.innerHTML += '<span style="margin-left: auto; color: var(--warning);"><i class="fas fa-trophy"></i></span>';
            }
        }, 1000);
    </script>
</body>
</html>