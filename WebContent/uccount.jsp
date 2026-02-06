<%@page import="dbcon.dbconn"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<%@page import="Servlet.LocalDate" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Election Results - Voter Portal</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #2c3e50;
            --secondary: #3498db;
            --accent: #e74c3c;
            --success: #2ecc71;
            --light: #ecf0f1;
            --dark: #2c3e50;
            --gradient: linear-gradient(135deg, #3498db, #2c3e50);
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
            min-height: 100vh;
            padding: 20px;
            position: relative;
        }
        
        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxMDAlIiBoZWlnaHQ9IjEwMCUiPjxkZWZzPjxwYXR0ZXJuIGlkPSJwYXR0ZXJuIiB3aWR0aD0iNDAiIGhlaWdodD0iNDAiIHBhdHRlcm5Vbml0cz0idXNlclNwYWNlT25Vc2UiIHBhdHRlcm5UcmFuc2Zvcm09InJvdGF0ZSg0NSkiPjxyZWN0IHdpZHRoPSIyMCIgaGVpZ2h0PSIyMCIgZmlsbD0icmdiYSgyNTUsMjU1LDI1NSwwLjA1KSIvPjwvcGF0dGVybj48L2RlZnM+PHJlY3QgZmlsbD0idXJsKCNwYXR0ZXJuKSIgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSIvPjwvc3ZnPg==');
            z-index: -1;
        }
        
        .main-container {
            max-width: 1400px;
            margin: 0 auto;
        }
        
        .header-section {
            text-align: center;
            margin-bottom: 40px;
        }
        
        .page-title {
            color: white;
            font-size: 2.8rem;
            font-weight: 700;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
            margin-bottom: 15px;
        }
        
        .page-subtitle {
            color: rgba(255, 255, 255, 0.9);
            font-size: 1.2rem;
            margin-bottom: 10px;
        }
        
        .assembly-info {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 30px;
            text-align: center;
            box-shadow: var(--shadow);
            backdrop-filter: blur(10px);
        }
        
        .assembly-title {
            font-size: 1.3rem;
            color: var(--primary);
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }
        
        .assembly-title i {
            color: var(--secondary);
        }
        
        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .stat-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            padding: 25px;
            text-align: center;
            box-shadow: var(--shadow);
            backdrop-filter: blur(10px);
            transition: var(--transition);
            border: 2px solid transparent;
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
            border-color: var(--secondary);
        }
        
        .stat-icon {
            font-size: 2.5rem;
            margin-bottom: 15px;
            color: var(--secondary);
        }
        
        .stat-number {
            font-size: 2.2rem;
            font-weight: 700;
            margin-bottom: 5px;
            color: var(--primary);
        }
        
        .stat-label {
            font-size: 0.9rem;
            color: #666;
            font-weight: 500;
        }
        
        .winner-section {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 30px;
            margin-bottom: 30px;
            text-align: center;
            box-shadow: var(--shadow);
            backdrop-filter: blur(10px);
            border-left: 5px solid var(--success);
            animation: pulse 2s infinite;
        }
        
        .winner-title {
            font-size: 1.5rem;
            color: var(--primary);
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }
        
        .winner-title i {
            color: var(--success);
        }
        
        .winner-name {
            font-size: 2.2rem;
            font-weight: 700;
            margin-bottom: 10px;
            color: var(--success);
        }
        
        .winner-votes {
            font-size: 1.3rem;
            color: #666;
        }
        
        .results-container {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 30px;
            box-shadow: var(--shadow);
            backdrop-filter: blur(10px);
            margin-bottom: 30px;
        }
        
        .results-title {
            font-size: 1.8rem;
            color: var(--primary);
            margin-bottom: 25px;
            text-align: center;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }
        
        .results-title i {
            color: var(--secondary);
        }
        
        .table-responsive {
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
        }
        
        .results-table {
            width: 100%;
            background: white;
            border-collapse: collapse;
            border-radius: 15px;
            overflow: hidden;
        }
        
        .results-table th {
            background: linear-gradient(45deg, var(--primary), var(--secondary));
            color: white;
            padding: 18px 15px;
            font-weight: 600;
            text-align: center;
            font-size: 0.95rem;
            border: none;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .results-table td {
            padding: 16px 15px;
            text-align: center;
            vertical-align: middle;
            border-bottom: 1px solid #e1e5ee;
            font-weight: 500;
            color: var(--dark);
            border: none;
        }
        
        .results-table tbody tr {
            transition: var(--transition);
            background: white;
        }
        
        .results-table tbody tr:hover {
            background: rgba(52, 152, 219, 0.08);
            transform: translateY(-1px);
        }
        
        .candidate-image {
            width: 80px;
            height: 80px;
            border-radius: 8px;
            object-fit: cover;
            border: 3px solid #e1e5ee;
            transition: var(--transition);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        
        .candidate-image:hover {
            transform: scale(1.05);
            border-color: var(--secondary);
        }
        
        .no-image {
            width: 80px;
            height: 80px;
            background: #f8f9fa;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #95a5a6;
            font-size: 0.8rem;
            margin: 0 auto;
            border: 2px dashed #dee2e6;
        }
        
        .vote-count {
            font-size: 1.3rem;
            font-weight: 700;
            color: var(--success);
        }
        
        .action-buttons {
            display: flex;
            gap: 15px;
            justify-content: center;
            margin-top: 30px;
            flex-wrap: wrap;
        }
        
        .btn-back {
            background: red;
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
            cursor: pointer;
        }
        
        .btn-back:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: translateY(-2px);
            color: white;
        }
        
        .btn-print {
            background: var(--gradient);
            border: none;
            padding: 12px 25px;
            border-radius: 12px;
            color: white;
            font-weight: 600;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            gap: 8px;
            cursor: pointer;
            box-shadow: 0 4px 15px rgba(52, 152, 219, 0.4);
        }
        
        .btn-print:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(52, 152, 219, 0.6);
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
        
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.02); }
            100% { transform: scale(1); }
        }
        
       
        @media print {
            body {
                background: white !important;
                color: black !important;
                padding: 10px;
            }
            
            .btn-back, .btn-print {
                display: none !important;
            }
            
            .stat-card, .assembly-info, .results-container, .winner-section {
                background: white !important;
                box-shadow: none !important;
                border: 1px solid #ddd !important;
            }
        }
        
       
        @media (max-width: 768px) {
            .header-section {
                margin-bottom: 30px;
            }
            
            .page-title {
                font-size: 2.2rem;
            }
            
            .stats-container {
                grid-template-columns: 1fr;
            }
            
            .winner-name {
                font-size: 1.8rem;
            }
            
            .results-table {
                font-size: 0.9rem;
            }
            
            .results-table th,
            .results-table td {
                padding: 12px 8px;
            }
            
            .candidate-image {
                width: 60px;
                height: 60px;
            }
            
            .action-buttons {
                flex-direction: column;
                align-items: center;
            }
            
            .btn-back, .btn-print {
                width: 100%;
                max-width: 300px;
                justify-content: center;
            }
        }
        
        @media (max-width: 480px) {
            body {
                padding: 10px;
            }
            
            .page-title {
                font-size: 2rem;
            }
            
            .results-container {
                padding: 20px 15px;
            }
        }
    </style>
</head>

<body>
    <div class="main-container">
        
        <div class="header-section">
            <h1 class="page-title">
                <i class="fas fa-chart-bar"></i>
                Election Results
            </h1>
            <p class="page-subtitle">Official voting results and winner declaration</p>
        </div>

        <%
        String ass = request.getParameter("ass");
        System.out.println("ass  " + ass);
        
        try {
            int a = 0;
            int b = 0;
            String name = "";
            int total = 0;
            Connection con = dbconn.create();
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("SELECT count(id) FROM studentvoute.votes where status='Voted' and dept='" + ass + "'");
            while (rs.next()) {
                total = rs.getInt(1);
            }
        %>

        
        <div class="assembly-info">
            <h3 class="assembly-title">
                <i class="fas fa-map-marker-alt"></i>
                 Candidate Department: <span style="color: var(--secondary);"><%= ass %></span>
            </h3>
        </div>

        
        <div class="stats-container">
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-users"></i>
                </div>
                <div class="stat-number"><%= total %></div>
                <div class="stat-label">Total Votes Cast</div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-user-tie"></i>
                </div>
                <%
                    ResultSet candidateCount = st.executeQuery("SELECT COUNT(DISTINCT crollnum) FROM studentvoute.votes WHERE status='Voted' and dept='" + ass + "'");
                    int candidates = 0;
                    if (candidateCount.next()) {
                        candidates = candidateCount.getInt(1);
                    }
                %>
                <div class="stat-number"><%= candidates %></div>
                <div class="stat-label">Candidates</div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-percentage"></i>
                </div>
                <div class="stat-number">
                    <%
                        if (total > 0) {
                            out.print("100%");
                        } else {
                            out.print("0%");
                        }
                    %>
                </div>
                <div class="stat-label">Voting Completed</div>
            </div>
        </div>

       
        <%
            ResultSet rs1 = st.executeQuery("SELECT *, count(crollnum) as vote_count FROM studentvoute.votes WHERE status='Voted' and dept='" + ass + "' group by crollnum");
            while (rs1.next()) {
                b = Integer.valueOf(rs1.getString("vote_count"));
                if (a < b) {
                    a = b;
                    name = rs1.getString(2);
                }
            }
        %>
        
        <div class="winner-section">
            <h2 class="winner-title">
                <i class="fas fa-trophy"></i>
                Election Winner
            </h2>
            <div class="winner-name"><%= name %></div>
            <div class="winner-votes">Winning with <%= a %> votes</div>
        </div>

       
        <div class="results-container">
            <h2 class="results-title">
                <i class="fas fa-list-ol"></i>
                Detailed Results
            </h2>
            
            <div class="table-responsive">
                <table class="results-table">
                    <thead>
                        <tr>
                            <th>Candidate RollNumber</th>
                            <th>status</th>
                            <th>Department</th>
                            <th>Candidate Photo</th>
                            <th>Total Votes</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            ResultSet rs2 = st.executeQuery("SELECT *, count(crollnum) as vote_count FROM studentvoute.votes WHERE status='Voted' and dept='" + ass + "' group by crollnum");
                            while (rs2.next()) {
                               String blobpic = rs2.getString(3);
                        %>
                        <tr>
                           <td><strong><%= rs2.getString(2) %></strong></td>
                       <td><%= rs2.getString(6)%></td>
                            <td><%= rs2.getString(4) %></td>                       
                            <td>
                            
                             <% if (blobpic != null && !blobpic.trim().isEmpty()) { %>
            <img src="<%= blobpic %>" class="candidate-image"" />
        <% } else { %>
           <div class="no-image">
                                            <i class="fas fa-user"></i>
                                        </div>
        <% } %>
                            
                            
                            
                               
                            </td>
                            <td class="vote-count"><%= rs2.getString("vote_count") %></td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
            
            <div class="action-buttons">
                <a href="votermain.jsp" class="btn-back">
                    <i class="fas fa-arrow-left"></i>
                    Back to Dashboard
                </a>
                <button onclick="window.print();" class="btn-print">
                    <i class="fas fa-print"></i>
                    Print Results
                </button>
            </div>
        </div>
        
        <%
            } catch (Exception e) {
                System.out.println(e);
            }
        %>
    </div>

    <script>
        
        window.addEventListener('load', function() {
            document.body.style.opacity = 1;
        });
        
        document.body.style.opacity = 0;
        document.body.style.transition = 'opacity 0.5s ease';
    </script>
</body>
</html>