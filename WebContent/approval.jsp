
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ page import="dbcon.dbconn"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.Base64"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <title>Candidate Symbols - Election Portal</title>

    <!-- UI CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- SAME THEME AS YOUR APPLICATION PAGE -->
    <style>
        :root {
            --primary: #2c3e50;
            --secondary: #3498db;
            --accent: #e74c3c;
            --success: #2ecc71;
            --light: #ecf0f1;
            --dark: #2c3e50;
            --gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            --transition: all 0.3s ease;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }
        
        body {
            background: var(--gradient);
            color: #333;
            min-height: 100vh;
            padding: 20px;
        }
        
        .main-container {
            max-width: 1200px;
            margin: 0 auto;
        }
        
        .header-section {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            flex-wrap: wrap;
            gap: 20px;
        }
        
        .page-title {
            color: white;
            font-size: 2.5rem;
            font-weight: 700;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
        }
        
        .btn-back {
            background: rgba(255, 255, 255, 0.2);
            border: 2px solid rgba(255, 255, 255, 0.3);
            padding: 12px 25px;
            border-radius: 12px;
            color: white;
            font-weight: 600;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
            backdrop-filter: blur(10px);
        }
        
        .btn-back:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: translateY(-2px);
            color: white;
        }
        
        .content-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 30px;
            box-shadow: var(--shadow);
            backdrop-filter: blur(10px);
            margin-bottom: 30px;
            animation: fadeInUp 0.8s ease-out;
        }
        
        .card-title {
            font-size: 1.8rem;
            color: var(--primary);
            margin-bottom: 25px;
            text-align: center;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }
        
        .card-title i {
            color: var(--secondary);
        }
        
        .candidate-table {
            width: 100%;
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        
        .candidate-table thead {
            background: linear-gradient(45deg, var(--primary), var(--secondary));
        }
        
        .candidate-table th {
            color: white;
            padding: 15px;
            text-align: center;
            font-weight: 600;
        }
        
        .candidate-table td {
            padding: 15px;
            border-bottom: 1px solid #e1e5ee;
            vertical-align: middle;
            text-align: center;
        }
        
        .candidate-table tr:hover {
            background: rgba(52, 152, 219, 0.05);
        }
        
        .symbol-image {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid #e1e5ee;
        }
        
        .badge {
            padding: 6px 12px;
            border-radius: 6px;
            font-weight: 500;
            font-size: 0.85rem;
            display: inline-block;
        }
        
        .badge-primary {
            background: #e3f2fd;
            color: #1976d2;
        }
        
        .badge-secondary {
            background: #f3e5f5;
            color: #7b1fa2;
        }
        
        .empty-state {
            text-align: center;
            padding: 40px 20px;
            color: #666;
        }
        
        .empty-state i {
            font-size: 3rem;
            margin-bottom: 15px;
            opacity: 0.5;
        }
        
        .empty-state h4 {
            font-size: 1.3rem;
            margin-bottom: 10px;
            color: var(--primary);
        }
        
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        @media (max-width: 768px) {
            .header-section {
                flex-direction: column;
                text-align: center;
            }
            
            .page-title {
                font-size: 2rem;
            }
            
            .candidate-table {
                display: block;
                overflow-x: auto;
            }
        }
    </style>
</head>

<body>
<div class="main-container">

    <!-- Header -->
    <div class="header-section">
        <h1 class="page-title">
            <i class="fas fa-flag"></i>
            Candidate Symbols
        </h1>
        <a href="candidatemain.jsp" class="btn-back">
            <i class="fas fa-arrow-left"></i>
            Go Back
        </a>
    </div>

    <div class="content-card">
        <h2 class="card-title">
            <i class="fas fa-user-check"></i>
            Candidate Information
        </h2>

        <div class="table-responsive">
            <table class="candidate-table">
                <thead>
                    <tr>
                        <th>Candidate Name</th>
                        <th>Registration Number</th>
                        <th>Department</th>
                        <th>Email</th>
                        <th>Election Symbol</th>
                    </tr>
                </thead>

                <tbody>
<%
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    String email = session.getAttribute("candidateEmail").toString();
    String name = session.getAttribute("candidateName").toString();
    if (email == null) {
%>
        <tr>
            <td colspan="5">
                <div class="empty-state">
                    <i class="fas fa-exclamation-circle"></i>
                    <h4>Session Expired</h4>
                    <p>Please login again.</p>
                </div>
            </td>
        </tr>
<%
    } else {
        try {
            con = dbconn.create();
            String sql = "SELECT * FROM eligible WHERE email=?";
            ps = con.prepareStatement(sql);
            ps.setString(1, email);
            rs = ps.executeQuery();

            boolean found = false;

            while (rs.next()) {
                found = true;

               String symbol = rs.getString("symbol_url");
%>
<tr>
    <!-- Candidate Name -->
    <td>
        <strong><%= name %></strong>
    </td>

    <!-- Reg No -->
    <td>
        <span class="badge badge-primary">
            <%= rs.getString("rollno") %>
        </span>
    </td>

    <!-- Department -->
    <td>
        <span class="badge badge-secondary">
            <%= rs.getString("department") %>
        </span>
    </td>

    <!-- Email -->
    <td>
        <%= rs.getString("email") %>
    </td>

    <!-- Symbol -->
    <td>
        <img src="<%= symbol %>" class="symbol-image" />

    </td>
</tr>
<%
            }

            if (!found) {
%>
<tr>
    <td colspan="5">
        <div class="empty-state">
            <i class="fas fa-database"></i>
            <h4>No Data Found</h4>
            <p>No approved candidate details available.</p>
        </div>
    </td>
</tr>
<%
            }

        } catch (Exception e) {
%>
<tr>
    <td colspan="5" style="color:red;text-align:center;">
        <i class="fas fa-exclamation-triangle"></i>
        Error: <%= e.getMessage() %>
    </td>
</tr>
<%
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        }
    }
%>
                </tbody>
            </table>
        </div>
    </div>
</div>

</body>
</html>