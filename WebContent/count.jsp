<%@page import="com.itextpdf.text.log.SysoCounter"%>
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
    <title>Election Results - Candidate Portal</title>
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
            max-width: 1400px;
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
            cursor: pointer;
        }
        
        .btn-back:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: translateY(-2px);
            color: white;
        }
        
        .candidate-info {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 25px;
            margin-bottom: 30px;
            box-shadow: var(--shadow);
            backdrop-filter: blur(10px);
            animation: fadeInDown 0.8s ease-out;
        }
        
        .info-title {
            font-size: 1.5rem;
            color: var(--primary);
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .info-title i {
            color: var(--secondary);
        }
        
        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            margin-bottom: 20px;
        }
        
        .info-item {
            display: flex;
            flex-direction: column;
            gap: 5px;
        }
        
        .info-label {
            font-size: 0.9rem;
            color: #666;
            font-weight: 500;
        }
        
        .info-value {
            font-size: 1.1rem;
            color: var(--primary);
            font-weight: 600;
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
        
        .results-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 30px;
            box-shadow: var(--shadow);
            backdrop-filter: blur(10px);
            margin-bottom: 30px;
            animation: fadeInUp 0.8s ease-out 0.2s both;
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
        
        .btn-print {
            background: linear-gradient(45deg, var(--accent), #c0392b);
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
            box-shadow: 0 4px 15px rgba(231, 76, 60, 0.4);
        }
        
        .btn-print:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(231, 76, 60, 0.6);
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
        
        
        @media print {
            body {
                background: white !important;
                color: black !important;
                padding: 10px;
            }
            
            .btn-back, .btn-print {
                display: none !important;
            }
            
            .stat-card, .candidate-info, .results-card {
                background: white !important;
                box-shadow: none !important;
                border: 1px solid #ddd !important;
            }
        }
        
        
        @media (max-width: 768px) {
            .header-section {
                flex-direction: column;
                text-align: center;
            }
            
            .page-title {
                font-size: 2rem;
            }
            
            .stats-container {
                grid-template-columns: 1fr;
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
                font-size: 1.7rem;
            }
            
            .candidate-info, .results-card {
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
            <a href="candidatemain.jsp" class="btn-back">
                <i class="fas fa-arrow-left"></i>
                Back to Dashboard
            </a>
        </div>

        <%
        String ass = request.getParameter("ass");
        String email = request.getParameter("cname");
        
        try {
            int total = 0;
            int sno = 0;
            Connection con = dbconn.create();
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("SELECT count(id) FROM studentvoute.votes where status='Voted' and dept='"+ass+"'");
            while(rs.next()) {
                total = rs.getInt(1);
            }
            
            ResultSet rs2 = st.executeQuery("SELECT * FROM studentvoute.votes where status='Voted' and dept='"+ass+"'");
            String candidateName = "";
            String partyName = "";
            String Department = "";
            String district = "";
            
            while(rs2.next()) {
                candidateName =email;
                partyName = rs2.getString(6);
                Department = rs2.getString(5);
                district = rs2.getString(4);
                break;
            }
            System.out.println("name"+email);
        %>

       
        <div class="candidate-info">
            <h2 class="info-title">
                <i class="fas fa-user-tie"></i>
                Candidate Profile
            </h2>
            <div class="info-grid">
                <div class="info-item">
                    <span class="info-label">Candidate Name</span>
                    <span class="info-value"><%= email %></span>
                    
                </div>      
                <div class="info-item">
                    <span class="info-label">Department</span>
                    <span class="info-value"><%= ass %></span>
                </div>
              
            </div>
        </div>

       
        <div class="stats-container">
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-vote-yea"></i>
                </div>
                <div class="stat-number"><%= total %></div>
                <div class="stat-label">Total Votes Received</div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-chart-line"></i>
                </div>
                <div class="stat-number">
                    <%
                        ResultSet totalVotesRs = st.executeQuery("SELECT count(id) FROM studentvoute.votes where status='Voted' and dept='"+ass+"'");
                        int totalConstituencyVotes = 0;
                        if(totalVotesRs.next()) {
                            totalConstituencyVotes = totalVotesRs.getInt(1);
                        }
                        double votePercentage = totalConstituencyVotes > 0 ? (total * 100.0 / totalConstituencyVotes) : 0;
                    %>
                    <%= String.format("%.1f", votePercentage) %>%
                </div>
                <div class="stat-label">Vote Share</div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-trophy"></i>
                </div>
                <div class="stat-number">
                    <%
                        ResultSet maxVotesRs = st.executeQuery("SELECT MAX(vote_count) FROM (SELECT COUNT(id) as vote_count FROM studentvoute.votes WHERE status='Voted' and dept='"+ass+"' GROUP BY crollnum) as votes");
                        int maxVotes = 0;
                        if(maxVotesRs.next()) {
                            maxVotes = maxVotesRs.getInt(1);
                        }
                        String position = total == maxVotes ? "1st" : "Other";
                    %>
                    <%= position %>
                </div>
                <div class="stat-label">Position</div>
            </div>
        </div>

        
        <div class="results-card">
            <h2 class="results-title">
                <i class="fas fa-list-ol"></i>
                Detailed Vote Count
            </h2>
            
            <div class="table-responsive">
                <table class="results-table">
                    <thead>
                        <tr>
                            <th>Candidate Rollnumber</th>
                            <th>Candidate Mail</th>
                            <th>Department</th>
                            <th>Candidate Photo</th>
                            <th>Total Votes</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        ResultSet rs1 = st.executeQuery("SELECT * FROM studentvoute.votes where status='Voted' and dept='"+ass+"'");
                        while(rs1.next()) {
                            sno = sno + 1;
                            String blobpic = rs1.getString(3);
                        %>
                        <tr>
                            <td><strong><%= rs1.getString(2) %></strong></td>
                            <td><%= rs1.getString(6) %></td>
                            <td><%= rs1.getString(4) %></td>
                            <td>
                            
                             <% if (blobpic != null && !blobpic.trim().isEmpty()) { %>
            <img src="<%= blobpic %>" class="candidate-image"" />
        <% } else { %>
           <div class="no-image">
                                            <i class="fas fa-user"></i>
                                        </div>
        <% } %>
                            
                            
                            
                               
                            </td>
                            <%
                            int id = 0;
                            ResultSet rs3 = st.executeQuery("SELECT count(id) FROM studentvoute.votes where crollnum='"+rs1.getString(2)+"'");
                            while(rs3.next()) {
                                int id1 = rs3.getInt(1);
                            %>
                            <td class="vote-count"><%= id1 %></td>
                        </tr>
                        <% } %>
                        <% } %>
                    </tbody>
                </table>
            </div>
            
            <div class="action-buttons">
                <button onclick="window.print();" class="btn-print">
                    <i class="fas fa-print"></i>
                    Print Results
                </button>
            </div>
        </div>
        
        <%
            } catch(Exception e) {
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