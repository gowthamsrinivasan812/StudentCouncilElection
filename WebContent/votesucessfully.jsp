<!DOCTYPE html>
<%@page import="dbcon.dbconn"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<%@page import="Servlet.LocalDate" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date" %>
<html lang="en">
<head>
    <title>Vote Confirmation - Secure Voting</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta charset="utf-8">
    <meta http-equiv="refresh" content="4; URL=votermain.jsp">
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
            display: flex;
            justify-content: center;
            align-items: center;
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
        
        .confirmation-container {
            display: flex;
            width: 100%;
            max-width: 800px;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            box-shadow: var(--shadow);
            overflow: hidden;
            min-height: 500px;
            backdrop-filter: blur(10px);
        }
        
        .success-section {
            flex: 1;
            background: linear-gradient(135deg, var(--success), #27ae60);
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: 40px;
            color: white;
            text-align: center;
            position: relative;
            overflow: hidden;
        }
        
        .success-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxMDAlIiBoZWlnaHQ9IjEwMCUiPjxkZWZzPjxwYXR0ZXJuIGlkPSJwYXR0ZXJuIiB3aWR0aD0iNDAiIGhlaWdodD0iNDAiIHBhdHRlcm5Vbml0cz0idXNlclNwYWNlT25Vc2UiIHBhdHRlcm5UcmFuc2Zvcm09InJvdGF0ZSg0NSkiPjxyZWN0IHdpZHRoPSIyMCIgaGVpZ2h0PSIyMCIgZmlsbD0icmdiYSgyNTUsMjU1LDI1NSwwLjA1KSIvPjwvcGF0dGVybj48L2RlZnM+PHJlY3QgZmlsbD0idXJsKCNwYXR0ZXJuKSIgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSIvPjwvc3ZnPg==');
        }
        
        .success-content {
            z-index: 1;
            max-width: 400px;
        }
        
        .success-icon {
            font-size: 5rem;
            margin-bottom: 30px;
            color: rgba(255, 255, 255, 0.9);
            animation: bounce 2s infinite;
        }
        
        .success-section h2 {
            font-size: 2.2rem;
            margin-bottom: 20px;
            font-weight: 600;
        }
        
        .success-section p {
            font-size: 1.1rem;
            opacity: 0.9;
            line-height: 1.6;
            margin-bottom: 25px;
        }
        
        .countdown {
            font-size: 1.3rem;
            font-weight: 600;
            margin-top: 20px;
            padding: 15px 25px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 15px;
            backdrop-filter: blur(10px);
        }
        
        .details-section {
            flex: 1;
            padding: 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        
        .section-header {
            text-align: center;
            margin-bottom: 30px;
        }
        
        .section-header h1 {
            color: var(--primary);
            font-size: 2rem;
            margin-bottom: 10px;
            position: relative;
            padding-bottom: 15px;
        }
        
        .section-header h1:after {
            content: '';
            position: absolute;
            width: 60px;
            height: 4px;
            background: var(--secondary);
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            border-radius: 2px;
        }
        
        .vote-confirmation {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
            text-align: center;
            margin-bottom: 25px;
        }
        
        .candidate-info {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 20px;
        }
        
        .symbol-image {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            object-fit: cover;
            border: 4px solid var(--success);
            box-shadow: 0 8px 25px rgba(46, 204, 113, 0.3);
            background: white;
            padding: 8px;
        }
        
        .candidate-name {
            font-size: 1.6rem;
            color: var(--primary);
            font-weight: 600;
            margin-bottom: 10px;
        }
        
        .vote-badge {
            background: linear-gradient(45deg, var(--success), #27ae60);
            color: white;
            padding: 8px 20px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.9rem;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        
        .confirmation-message {
            background: rgba(52, 152, 219, 0.1);
            border: 1px solid rgba(52, 152, 219, 0.3);
            border-radius: 10px;
            padding: 20px;
            margin-top: 20px;
            text-align: center;
            font-size: 0.95rem;
        }
        
        .confirmation-message i {
            color: var(--secondary);
            margin-right: 8px;
        }
        
        .no-image {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            color: #95a5a6;
            padding: 20px;
            background: #f8f9fa;
            border-radius: 50%;
            border: 2px dashed #dee2e6;
            width: 120px;
            height: 120px;
        }
        
        .no-image i {
            font-size: 2.5rem;
            margin-bottom: 8px;
            opacity: 0.6;
        }
        
        
        @keyframes bounce {
            0%, 20%, 50%, 80%, 100% {
                transform: translateY(0);
            }
            40% {
                transform: translateY(-10px);
            }
            60% {
                transform: translateY(-5px);
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
        
        .confirmation-container {
            animation: fadeInUp 0.8s ease-out;
        }
        
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }
        
        .pulse {
            animation: pulse 2s infinite;
        }
        
       
        @media (max-width: 768px) {
            .confirmation-container {
                flex-direction: column;
            }
            
            .success-section {
                padding: 30px 20px;
            }
            
            .details-section {
                padding: 30px 20px;
            }
            
            .success-icon {
                font-size: 4rem;
            }
            
            .success-section h2 {
                font-size: 1.8rem;
            }
        }
    </style>
</head>

<body>
    <div class="confirmation-container">
        
        <div class="success-section">
            <div class="success-content">
                <div class="success-icon">
                    <i class="fas fa-check-circle"></i>
                </div>
                <h2>Vote Successfully Cast!</h2>
                <p>Thank you for participating in the democratic process. Your vote has been securely recorded and will help shape the future.</p>
                
                <div class="countdown">
                    <i class="fas fa-redo"></i>
                    Redirecting in <span id="countdown">4</span> seconds
                </div>
            </div>
        </div>
        
       
        <div class="details-section">
            <div class="section-header">
                <h1>Vote Confirmation</h1>
                <p>Your voting details are shown below</p>
            </div>
            
            <div class="vote-confirmation">
                <div class="candidate-info">
                    <%
                        String email = session.getAttribute("studentEmail").toString();
                        byte[] blobpic = null;
                        String status = "Voted";
                        Connection con = dbconn.create();
                        PreparedStatement ps = con.prepareStatement("SELECT * FROM `studentvoute`.`votes` where mail='"+email+"'");
                        ResultSet rs = ps.executeQuery();
                        
                        if (rs.next()) {
                            blobpic = rs.getBytes(3);
                            Statement st = con.createStatement();
                            st.executeUpdate("UPDATE `studentvoute`.`voteid` set status='"+status+"' where studentmail='"+email+"' ");
                    %>
                    
                    
                    <div>
                        <%
                            if (blobpic != null) {
                                String base64Image = Base64.getEncoder().encodeToString(blobpic);
                        %>
                                <img src="data:image/jpeg;base64,<%= base64Image %>" 
                                     class="symbol-image pulse"
                                     alt="Candidate Symbol">
                        <%
                            } else {
                        %>
                                <div class="no-image">
                                    <i class="fas fa-flag"></i>
                                    <small>No Symbol</small>
                                </div>
                        <%
                            }
                        %>
                    </div>
                    
                   
                    <div>
                        <h3 class="candidate-name"><%= rs.getString(2) %></h3>
                        <span class="vote-badge">
                            <i class="fas fa-check"></i>
                            Successfully Voted
                        </span>
                    </div>
                    <%
                        }
                        rs.close();
                        ps.close();
                        con.close();
                    %>
                </div>
            </div>
            
            <div class="confirmation-message">
                <i class="fas fa-shield-alt"></i>
                <span>Vote Secured:</span> Your ballot has been encrypted and stored securely. 
                You will be automatically redirected to the main page.
            </div>
        </div>
    </div>

    <script>
        
        let seconds = 4;
        const countdownElement = document.getElementById('countdown');
        
        const countdown = setInterval(function() {
            seconds--;
            countdownElement.textContent = seconds;
            
            if (seconds <= 0) {
                clearInterval(countdown);
            }
        }, 1000);
        
        
        window.addEventListener('load', function() {
            document.body.style.opacity = 1;
        });
        
        document.body.style.opacity = 0;
        document.body.style.transition = 'opacity 0.5s ease';
    </script>
</body>
</html>