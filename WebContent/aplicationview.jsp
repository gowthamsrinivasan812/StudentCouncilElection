<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="dbcon.dbconn"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Voter Applications - Election Commission</title>


<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">

<style>
    :root {
        --primary: #1e3c72;
        --secondary: #2a5298;
        --accent: #4fc3f7;
        --success: #4caf50;
        --light: #e3f2fd;
        --dark: #0d47a1;
    }
    
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }
    
    body {
        font-family: 'Inter', sans-serif;
        background: linear-gradient(135deg, var(--primary), var(--secondary));
        color: white;
        min-height: 100vh;
        padding: 20px;
    }
    
    .main-container {
        max-width: 1400px;
        margin: 0 auto;
    }
    
    .header-section {
        background: rgba(255, 255, 255, 0.1);
        backdrop-filter: blur(15px);
        border-radius: 20px;
        padding: 30px;
        margin-bottom: 30px;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
        border: 1px solid rgba(255, 255, 255, 0.2);
        animation: fadeInDown 0.8s ease-out;
    }
    
    .page-title {
        font-size: 2.5rem;
        font-weight: 700;
        margin-bottom: 10px;
        background: linear-gradient(45deg, #fff, var(--accent));
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        text-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
    }
    
    .page-subtitle {
        font-size: 1.1rem;
        opacity: 0.9;
        margin-bottom: 25px;
    }
    
    .search-section {
        background: rgba(255, 255, 255, 0.08);
        border-radius: 15px;
        padding: 25px;
        margin-bottom: 30px;
        border: 1px solid rgba(255, 255, 255, 0.15);
        animation: fadeInUp 0.8s ease-out 0.2s both;
    }
    
    .search-title {
        font-size: 1.3rem;
        font-weight: 600;
        margin-bottom: 20px;
        display: flex;
        align-items: center;
        gap: 10px;
    }
    
    .search-title i {
        color: var(--accent);
    }
    
    .filter-row {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 20px;
        margin-bottom: 20px;
    }
    
    .filter-group {
        display: flex;
        flex-direction: column;
        gap: 8px;
    }
    
    .filter-label {
        font-weight: 500;
        font-size: 0.9rem;
        opacity: 0.9;
    }
    
    .filter-select {
        background: rgba(255, 255, 255, 0.1);
        border: 2px solid rgba(255, 255, 255, 0.2);
        border-radius: 12px;
        padding: 12px 15px;
        color: white;
        font-size: 1rem;
        transition: all 0.3s ease;
        backdrop-filter: blur(10px);
    }
    
    .filter-select:focus {
        outline: none;
        border-color: var(--accent);
        box-shadow: 0 0 0 3px rgba(79, 195, 247, 0.3);
        background: rgba(255, 255, 255, 0.15);
    }
    
    .filter-select option {
        background: var(--primary);
        color: white;
    }
    
    .search-actions {
        display: flex;
        gap: 15px;
        justify-content: flex-end;
        flex-wrap: wrap;
    }
    
    .btn-search {
        background: linear-gradient(45deg, var(--accent), #29b6f6);
        border: none;
        padding: 12px 25px;
        border-radius: 12px;
        color: white;
        font-weight: 600;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        gap: 8px;
        box-shadow: 0 4px 15px rgba(41, 182, 246, 0.4);
    }
    
    .btn-search:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(41, 182, 246, 0.6);
    }
    
    .btn-reset {
        background: rgba(255, 255, 255, 0.1);
        border: 2px solid rgba(255, 255, 255, 0.3);
        padding: 12px 25px;
        border-radius: 12px;
        color: white;
        font-weight: 600;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        gap: 8px;
    }
    
    .btn-reset:hover {
        background: rgba(255, 255, 255, 0.2);
        transform: translateY(-2px);
    }
    
    .table-container {
        background: rgba(255, 255, 255, 0.08);
        backdrop-filter: blur(15px);
        border-radius: 20px;
        padding: 30px;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
        border: 1px solid rgba(255, 255, 255, 0.2);
        animation: fadeInUp 0.8s ease-out 0.4s both;
    }
    
    .table-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 25px;
        flex-wrap: wrap;
        gap: 15px;
    }
    
    .table-title {
        font-size: 1.5rem;
        font-weight: 600;
        display: flex;
        align-items: center;
        gap: 10px;
    }
    
    .table-title i {
        color: var(--accent);
    }
    
    .applications-count {
        background: var(--accent);
        color: var(--primary);
        padding: 5px 12px;
        border-radius: 20px;
        font-weight: 600;
        font-size: 0.9rem;
    }
    
    .table-responsive {
        border-radius: 15px;
        overflow: hidden;
    }
    
    .applications-table {
        width: 100%;
        background: rgba(255, 255, 255, 0.05);
        border-collapse: collapse;
        border-radius: 15px;
        overflow: hidden;
    }
    
    .applications-table th {
        background: linear-gradient(45deg, var(--dark), var(--primary));
        padding: 18px 15px;
        font-weight: 600;
        text-align: center;
        font-size: 0.95rem;
        border-bottom: 2px solid rgba(255, 255, 255, 0.1);
    }
    
    .applications-table td {
        padding: 16px 15px;
        text-align: center;
        vertical-align: middle;
        border-bottom: 1px solid rgba(255, 255, 255, 0.05);
        font-weight: 400;
    }
    
    .applications-table tbody tr {
        transition: all 0.3s ease;
        background: rgba(255, 255, 255, 0.02);
    }
    
    .applications-table tbody tr:hover {
        background: rgba(255, 255, 255, 0.1);
        transform: translateY(-1px);
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
    }
    
    .btn-view {
        background: linear-gradient(45deg, var(--success), #66bb6a);
        border: none;
        padding: 10px 20px;
        border-radius: 10px;
        color: white;
        font-weight: 500;
        transition: all 0.3s ease;
        display: inline-flex;
        align-items: center;
        gap: 6px;
        text-decoration: none;
        box-shadow: 0 3px 10px rgba(76, 175, 80, 0.3);
    }
    
    .btn-view:hover {
        transform: translateY(-2px) scale(1.05);
        box-shadow: 0 5px 15px rgba(76, 175, 80, 0.4);
        color: white;
    }
    
    .no-data {
        text-align: center;
        padding: 50px 20px;
        opacity: 0.7;
    }
    
    .no-data i {
        font-size: 3rem;
        margin-bottom: 15px;
        opacity: 0.5;
    }
    
    .action-buttons {
        display: flex;
        gap: 15px;
        justify-content: center;
        margin-top: 30px;
        flex-wrap: wrap;
    }
    
    .btn-back {
        background: rgba(255, 255, 255, 0.1);
        border: 2px solid rgba(255, 255, 255, 0.3);
        padding: 12px 25px;
        border-radius: 12px;
        color: white;
        font-weight: 600;
        transition: all 0.3s ease;
        display: inline-flex;
        align-items: center;
        gap: 8px;
        text-decoration: none;
    }
    
    .btn-back:hover {
        background: rgba(255, 255, 255, 0.2);
        transform: translateY(-2px);
        color: white;
    }
    
    
    @keyframes fadeInDown {
        from {
            opacity: 0;
            transform: translateY(-30px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }
    
    @keyframes fadeInUp {
        from {
            opacity: 0;
            transform: translateY(30px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }
    
    
    @media (max-width: 768px) {
        .header-section {
            padding: 20px;
        }
        
        .page-title {
            font-size: 2rem;
        }
        
        .filter-row {
            grid-template-columns: 1fr;
        }
        
        .search-actions {
            justify-content: stretch;
        }
        
        .btn-search, .btn-reset {
            flex: 1;
            justify-content: center;
        }
        
        .table-header {
            flex-direction: column;
            align-items: flex-start;
        }
        
        .applications-table {
            font-size: 0.9rem;
        }
        
        .applications-table th,
        .applications-table td {
            padding: 12px 8px;
        }
    }
    
    @media (max-width: 480px) {
        body {
            padding: 10px;
        }
        
        .page-title {
            font-size: 1.7rem;
        }
        
        .table-container {
            padding: 20px 15px;
        }
    }
</style>
</head>

<body>
<div class="main-container">
    
    <div class="header-section">
        <h1 class="page-title">
            <i class="fas fa-users"></i>
            Voter Applications
        </h1>
        <p class="page-subtitle">Manage and review voter registration applications with advanced filtering options</p>
    </div>  
    <div class="table-container">
        <div class="table-header">
            <h3 class="table-title">
                <i class="fas fa-list-alt"></i>
                Applications List
                <span class="applications-count" id="applicationsCount">0 Applications</span>
            </h3>
        </div>
        
        <div class="table-responsive">
            <table class="applications-table">
                <thead>
                    <tr>
                        <th>StudentName</th>
                        <th>Student EMail</th>
                        <th>Student  Department</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody id="applicationsTableBody">
                    <%
                        Connection con = null;
                        PreparedStatement ps = null;
                        ResultSet rs = null;
                        int applicationCount = 0;
                        
                        try {
                            con = dbconn.create();
                            ps = con.prepareStatement("SELECT * FROM `studentvoute`.`voteid` WHERE status='Apply'");
                            rs = ps.executeQuery();
                            
                            while (rs.next()) {
                                applicationCount++;
                    %>
                    <tr data-district="<%= rs.getString(1) %>" data-assembly="<%= rs.getString(2) %>" data-mobile="<%= rs.getString(4) %>">
                        <td><%= rs.getString(2) %></td>
                        <td><%= rs.getString(3) %></td>
                        <td><%= rs.getString(4) %></td>
                        <td>
                            <a href="emview.jsp?email=<%= rs.getString(3) %>" class="btn-view">
                                <i class="fas fa-eye"></i>
                                View Details
                            </a>
                        </td>
                    </tr>
                    <% 
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            try {
                                if (rs != null) rs.close();
                                if (ps != null) ps.close();
                                if (con != null) con.close();
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        }
                    %>
                    
                    <% if (applicationCount == 0) { %>
                    <tr>
                        <td colspan="4" class="no-data">
                            <i class="fas fa-inbox"></i>
                            <h4>No Applications Found</h4>
                            <p>There are currently no voter applications pending review.</p>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
        
        <div class="action-buttons">
            <a href="javascript:history.back()" class="btn-back">
                <i class="fas fa-arrow-left"></i>
                Back to Dashboard
            </a>
        </div>
    </div>
</div>


<script>
    
    document.addEventListener('DOMContentLoaded', function() {
        updateApplicationsCount();
    });
    
    function updateApplicationsCount() {
        const visibleRows = document.querySelectorAll('#applicationsTableBody tr[data-district]:not([style*="display: none"])');
        document.getElementById('applicationsCount').textContent = visibleRows.length + ' Applications';
    }
    
    function filterApplications() {
        const districtFilter = document.getElementById('districtFilter').value.toLowerCase();
        const assemblyFilter = document.getElementById('assemblyFilter').value.toLowerCase();
        const mobileFilter = document.getElementById('mobileFilter').value.toLowerCase();
        
        const rows = document.querySelectorAll('#applicationsTableBody tr[data-district]');
        
        rows.forEach(row => {
            const district = row.getAttribute('data-district').toLowerCase();
            const assembly = row.getAttribute('data-assembly').toLowerCase();
            const mobile = row.getAttribute('data-mobile').toLowerCase();
            
            const districtMatch = !districtFilter || district.includes(districtFilter);
            const assemblyMatch = !assemblyFilter || assembly.includes(assemblyFilter);
            const mobileMatch = !mobileFilter || mobile.includes(mobileFilter);
            
            if (districtMatch && assemblyMatch && mobileMatch) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        });
        
        updateApplicationsCount();
    }
    
    function resetFilters() {
        document.getElementById('districtFilter').value = '';
        document.getElementById('assemblyFilter').value = '';
        document.getElementById('mobileFilter').value = '';
        
        const rows = document.querySelectorAll('#applicationsTableBody tr[data-district]');
        rows.forEach(row => {
            row.style.display = '';
        });
        
        updateApplicationsCount();
    }
    
   
    document.getElementById('mobileFilter').addEventListener('input', function() {
        filterApplications();
    });
</script>

</body>
</html>