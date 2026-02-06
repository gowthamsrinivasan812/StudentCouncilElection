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
    <title>Election Results - Election Commission</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #1e3c72;
            --secondary: #2a5298;
            --accent: #4fc3f7;
            --success: #4caf50;
            --warning: #ff9800;
            --danger: #f44336;
            --light: #e3f2fd;
            --dark: #0d47a1;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }
        
        body {
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
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        .page-subtitle {
            font-size: 1.1rem;
            opacity: 0.9;
            margin-bottom: 15px;
        }
        
        .assembly-info {
            background: rgba(255, 255, 255, 0.08);
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 25px;
            border-left: 4px solid var(--accent);
        }
        
        .assembly-title {
            font-size: 1.3rem;
            font-weight: 600;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .assembly-title i {
            color: var(--accent);
        }
        
        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .stat-card {
            background: rgba(255, 255, 255, 0.08);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            padding: 25px;
            text-align: center;
            border: 1px solid rgba(255, 255, 255, 0.15);
            transition: transform 0.3s ease;
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
        }
        
        .stat-icon {
            font-size: 2.5rem;
            margin-bottom: 15px;
            opacity: 0.8;
        }
        
        .stat-number {
            font-size: 2.2rem;
            font-weight: 700;
            margin-bottom: 5px;
        }
        
        .stat-label {
            font-size: 0.9rem;
            opacity: 0.8;
        }
        
        .winner-section {
            background: linear-gradient(135deg, var(--success), #45a049);
            border-radius: 20px;
            padding: 30px;
            margin-bottom: 30px;
            text-align: center;
            box-shadow: 0 10px 30px rgba(76, 175, 80, 0.3);
            border: 1px solid rgba(255, 255, 255, 0.3);
            animation: pulse 2s infinite;
        }
        
        .winner-title {
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }
        
        .winner-name {
            font-size: 2.2rem;
            font-weight: 700;
            margin-bottom: 10px;
            background: linear-gradient(45deg, #fff, #e8f5e8);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        
        .winner-votes {
            font-size: 1.3rem;
            opacity: 0.9;
        }
        
        .results-container {
            background: rgba(255, 255, 255, 0.08);
            backdrop-filter: blur(15px);
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            border: 1px solid rgba(255, 255, 255, 0.2);
            animation: fadeInUp 0.8s ease-out 0.4s both;
        }
        
        .results-title {
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .results-title i {
            color: var(--accent);
        }
        
        .table-responsive {
            border-radius: 15px;
            overflow: hidden;
        }
        
        .results-table {
            width: 100%;
            background: rgba(255, 255, 255, 0.05);
            border-collapse: collapse;
            border-radius: 15px;
            overflow: hidden;
        }
        
        .results-table th {
            background: linear-gradient(45deg, var(--dark), var(--primary));
            padding: 18px 15px;
            font-weight: 600;
            text-align: center;
            font-size: 0.95rem;
            border-bottom: 2px solid rgba(255, 255, 255, 0.1);
        }
        
        .results-table td {
            padding: 16px 15px;
            text-align: center;
            vertical-align: middle;
            border-bottom: 1px solid rgba(255, 255, 255, 0.05);
            font-weight: 400;
        }
        
        .results-table tbody tr {
            transition: all 0.3s ease;
            background: rgba(255, 255, 255, 0.02);
        }
        
        .results-table tbody tr:hover {
            background: rgba(255, 255, 255, 0.1);
            transform: translateY(-1px);
        }
        
        .candidate-image {
            width: 80px;
            height: 80px;
            border-radius: 8px;
            object-fit: cover;
            border: 2px solid rgba(255, 255, 255, 0.2);
            transition: all 0.3s ease;
        }
        
        .candidate-image:hover {
            transform: scale(1.1);
            border-color: var(--accent);
        }
        
        .no-image {
            width: 80px;
            height: 80px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #999;
            font-size: 0.8rem;
            margin: 0 auto;
        }
        
        .vote-count {
            font-size: 1.2rem;
            font-weight: 600;
            color: var(--accent);
        }
        
        .action-buttons {
            display: flex;
            gap: 15px;
            justify-content: space-between;
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
            cursor: pointer;
        }
        
        .btn-back:hover {
            background: rgba(255, 255, 255, 0.2);
            transform: translateY(-2px);
            color: white;
        }
        
        .btn-print {
            background: linear-gradient(45deg, var(--warning), #ffb300);
            border: none;
            padding: 12px 25px;
            border-radius: 12px;
            color: white;
            font-weight: 600;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            cursor: pointer;
            box-shadow: 0 4px 15px rgba(255, 152, 0, 0.4);
        }
        
        .btn-print:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(255, 152, 0, 0.6);
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
        
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.02); }
            100% { transform: scale(1); }
        }
        
        
        @media (max-width: 768px) {
            .header-section {
                padding: 20px;
            }
            
            .page-title {
                font-size: 2rem;
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
            }
            
            .btn-back, .btn-print {
                width: 100%;
                justify-content: center;
            }
        }
        
        @media (max-width: 480px) {
            body {
                padding: 10px;
            }
            
            .page-title {
                font-size: 1.7rem;
            }
            
            .results-container {
                padding: 20px 15px;
            }
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
            
            .winner-section {
                background: #f0f0f0 !important;
                color: black !important;
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
            
            <div class="assembly-info">
                <h3 class="assembly-title">
                    <i class="fas fa-map-marker-alt"></i>
                     Candidate Department: 
                    <%
                        String ass = request.getParameter("ass");
                        System.out.println("ass  " + ass);
                    %>
                    <span style="color: var(--accent);"><%= ass %></span>
                </h3>
            </div>
        </div>

        <%
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
            <h3 class="results-title">
                <i class="fas fa-list-ol"></i>
                Detailed Results
            </h3>
            
            <div class="table-responsive">
                <table class="results-table">
                    <thead>
                        <tr>
                            <th>Candidate Rollnumber</th>
                            <th>Status</th>
                            <th>Department</th>
                            <th>Candidate Image</th>
                            <th>Total Votes</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            ResultSet rs2 = st.executeQuery("SELECT *, count(crollnum) as vote_count FROM studentvoute.votes WHERE status='Voted' and dept='" + ass + "' group by crollnum");
                            while (rs2.next()) {
                                byte[] blobpic = rs2.getBytes(3);
                        %>
       <tr>
    <td><strong><%= rs2.getString(2) %></strong></td>
    <td><%= rs2.getString(6) %></td>
    <td><%= rs2.getString(4) %></td>

    <td>
        <%
            if (blobpic != null && blobpic.length > 0) {
                String base64Image = java.util.Base64.getEncoder().encodeToString(blobpic);
        %>
                <img src="data:image/jpeg;base64,<%= base64Image %>"
                     class="candidate-image"
                     alt="Candidate Photo"
                     width="80"
                     height="80">
        <%
            } else {
        %>
                <div class="no-image">
                    <i class="fas fa-user"></i>
                </div>
        <%
            }
        %>
    </td>

    <td class="vote-count"><%= rs2.getInt("vote_count") %></td>
</tr>

                        <% } %>
                    </tbody>
                </table>
            </div>
            
            <div class="action-buttons">
                <a href="ecvote.jsp" class="btn-back">
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