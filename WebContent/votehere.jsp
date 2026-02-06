<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="dbcon.dbconn"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<%@page import="Servlet.LocalDate" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date" %>
<%@ page import="java.util.Base64" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Cast Your Vote - Secure Voting</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/bootstrap.min.css">
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
        
        .election-info {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 30px;
            text-align: center;
            box-shadow: var(--shadow);
            backdrop-filter: blur(10px);
        }
        
        .info-badges {
            display: flex;
            justify-content: center;
            gap: 20px;
            flex-wrap: wrap;
            margin-top: 15px;
        }
        
        .info-badge {
            background: linear-gradient(45deg, var(--secondary), #2980b9);
            color: white;
            padding: 10px 20px;
            border-radius: 25px;
            font-weight: 500;
            font-size: 1rem;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .voting-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 30px;
            box-shadow: var(--shadow);
            backdrop-filter: blur(10px);
        }
        
        .card-title {
            font-size: 2rem;
            color: var(--primary);
            margin-bottom: 30px;
            text-align: center;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 15px;
        }
        
        .card-title i {
            color: var(--secondary);
        }
        
        .candidates-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 25px;
            margin-top: 20px;
        }
        
        .candidate-card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
            transition: var(--transition);
            border: 2px solid transparent;
            text-align: center;
        }
        
        .candidate-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
            border-color: var(--secondary);
        }
        
        .candidate-images {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-bottom: 20px;
        }
        
        .candidate-image {
            width: 100px;
            height: 100px;
            border-radius: 12px;
            object-fit: cover;
            border: 3px solid #e1e5ee;
            transition: var(--transition);
        }
        
        .symbol-image {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid #e1e5ee;
            transition: var(--transition);
            background: white;
            padding: 5px;
        }
        
        .candidate-image:hover, .symbol-image:hover {
            transform: scale(1.05);
            border-color: var(--secondary);
        }
        
        .candidate-details {
            margin-bottom: 20px;
        }
        
        .candidate-name {
            font-size: 1.4rem;
            color: var(--primary);
            font-weight: 600;
            margin-bottom: 10px;
        }
        
        .candidate-party {
            font-size: 1.1rem;
            color: var(--secondary);
            font-weight: 500;
            margin-bottom: 15px;
            padding: 8px 15px;
            background: rgba(52, 152, 219, 0.1);
            border-radius: 20px;
            display: inline-block;
        }
        
        .candidate-location {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-bottom: 15px;
            flex-wrap: wrap;
        }
        
        .location-badge {
            background: linear-gradient(45deg, #95a5a6, #7f8c8d);
            color: white;
            padding: 6px 12px;
            border-radius: 15px;
            font-size: 0.85rem;
            font-weight: 500;
        }
        
        .btn-vote {
            background: linear-gradient(45deg, var(--success), #27ae60);
            color: white;
            border: none;
            padding: 12px 30px;
            border-radius: 10px;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
            box-shadow: 0 4px 15px rgba(46, 204, 113, 0.4);
            font-size: 1rem;
            width: 100%;
            justify-content: center;
        }
        
        .btn-vote:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(46, 204, 113, 0.6);
            color: white;
        }
        
        .no-image {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            color: #95a5a6;
            padding: 15px;
            background: #f8f9fa;
            border-radius: 10px;
            border: 2px dashed #dee2e6;
        }
        
        .no-image i {
            font-size: 2rem;
            margin-bottom: 8px;
            opacity: 0.6;
        }
        
        .security-notice {
            background: rgba(52, 152, 219, 0.1);
            border: 1px solid rgba(52, 152, 219, 0.3);
            border-radius: 10px;
            padding: 20px;
            margin-top: 30px;
            text-align: center;
            font-size: 0.95rem;
        }
        
        .security-notice i {
            color: var(--secondary);
            margin-right: 8px;
        }
        
        /* Animations */
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
        
        .candidate-card {
            animation: fadeInUp 0.6s ease-out;
        }
        
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.02); }
            100% { transform: scale(1); }
        }
        
        .pulse {
            animation: pulse 2s infinite;
        }
        
        @media (max-width: 768px) {
            .candidates-grid {
                grid-template-columns: 1fr;
            }
            
            .page-title {
                font-size: 2.2rem;
            }
            
            .info-badges {
                flex-direction: column;
                align-items: center;
            }
            
            .candidate-images {
                flex-direction: column;
                align-items: center;
            }
        }
    </style>
</head>

<%
String email = (String) session.getAttribute("studentEmail");
String dept  = (String) session.getAttribute("studentcourse");

if (email == null || dept == null) {
    response.sendRedirect("login.jsp");
    return;
}
%>


<body>
    <div class="main-container">
        
        <div class="header-section">
            <h1 class="page-title">
                <i class="fas fa-vote-yea"></i>
                Cast Your Vote
            </h1>
            <p class="page-subtitle">Your voice matters - Choose your candidate wisely</p>
        </div>

       
        <div class="election-info">
            <h3 style="color: var(--primary); margin-bottom: 15px;">
                <i class="fas fa-info-circle"></i>
                Election Information
            </h3>
            <div class="info-badges">
                <div class="info-badge">
                    <i class="fas fa-map-marker-alt"></i>
                    Department: <%= dept %>
                </div>
               
                <div class="info-badge">
                    <i class="fas fa-user-check"></i>
                    Voter: <%= email %>
                </div>
            </div>
        </div>

        
        <div class="voting-card">
            <h2 class="card-title">
                <i class="fas fa-users"></i>
                Candidates in Your Constituency
            </h2>
            
            <div class="candidates-grid">
                <%
                
                
             
                
                
                    Connection con = dbconn.create();
                PreparedStatement ps = con.prepareStatement(
                	    "SELECT * FROM studentvoute.eligible WHERE status='Eligible'"
                	);
                    ResultSet rs = ps.executeQuery();
                    
                    while(rs.next()) {
                    	
                    	  
                    	
                        String imageurl = rs.getString(5);
                        String symbolurl = rs.getString(6);
                        
                        
                        
                     
                %>
                <div class="candidate-card">
                    
                    <div class="candidate-images">
                        
                        <div>
                        
                        <% if (imageurl != null && !imageurl.trim().isEmpty()) { %>
            <img src="<%= imageurl %>" class="candidate-image" />
        <% } else { %>
           <div class="no-image">No Photo</div>
        <% } %>
                         
                        </div>
                        
                       
                        <div>
                        
                        
                        <% if (symbolurl != null && !symbolurl.trim().isEmpty()) { %>
            <img src="<%= symbolurl %>" class="symbol-image pulse" />
        <% } else { %>
          <div class="no-image">
                                        <i class="fas fa-flag"></i>
                                        <small>No Symbol</small>
                                    </div>
        <% } %>
                        
                            
                        </div>
                    </div>
                    
                    
                    <div class="candidate-details">
                        <h3 class="candidate-name"><%= rs.getString(2) %></h3>                                        
                        <div class="candidate-location">
                            <span class="location-badge">
                                <i class="fas fa-map"></i>
                                <%= rs.getString(4) %>
                            </span>
                            <span class="location-badge">
                                <i class="fas fa-building"></i>
                                <%= rs.getString(3) %>
                            </span>
                        </div>
                    </div>
                    
                   
                    <a href="voteed.jsp?cname=<%=rs.getString(2)%>&&cemail=<%=rs.getString(4)%>&&cdept=<%=rs.getString(3)%>&&mail=<%=email%>&&course=<%=dept %>" 
                       class="btn-vote">
                        <i class="fas fa-check-circle"></i>
                        Vote for <%= rs.getString(1)%>
                    </a>
                </div>
                <%
                    }
                    rs.close();
                    ps.close();
                    con.close();
                %>
            </div>
            
            <div class="security-notice">
                <i class="fas fa-shield-alt"></i>
                <span>Secure Voting:</span> Your vote is confidential and cannot be changed once submitted. 
                This is a one-way process to ensure election integrity.
            </div>
        </div>
    </div>

    <script>
        
        window.addEventListener('load', function() {
            document.body.style.opacity = 1;
        });
        
        document.body.style.opacity = 0;
        document.body.style.transition = 'opacity 0.5s ease';
        
       
        document.addEventListener('DOMContentLoaded', function() {
            const cards = document.querySelectorAll('.candidate-card');
            cards.forEach((card, index) => {
                card.style.animationDelay = `${index * 0.1}s`;
            });
        });
        
       
        window.addEventListener('beforeunload', function(e) {
            e.preventDefault();
            e.returnValue = '';
        });
    </script>
</body>
</html>