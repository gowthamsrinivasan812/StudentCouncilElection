<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="dbcon.dbconn" %>
<%@ page import="java.sql.*" %>

<%
String email = request.getParameter("email");
byte[] pdfData = null;

try {
    Connection con = dbconn.create();
    PreparedStatement ps = con.prepareStatement(
        "SELECT file FROM vote.application WHERE email=?"
    );
    ps.setString(1, email);
    ResultSet rs = ps.executeQuery();

    if (rs.next()) {
        pdfData = rs.getBytes("file");
    }

    rs.close();
    ps.close();
} catch (Exception e) {
    out.println("DB Error: " + e);
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Nomination Document - Election Commission</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #1e3c72;
            --secondary: #2a5298;
            --accent: #4fc3f7;
            --success: #4caf50;
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
            color: #333;
            min-height: 100vh;
            padding: 20px;
        }
        
        .document-container {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
            padding: 30px;
            max-width: 1200px;
            margin: 0 auto;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.3);
            animation: fadeInUp 0.8s ease-out;
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
            font-size: 2.2rem;
            font-weight: 700;
            color: var(--primary);
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        .page-title i {
            color: var(--secondary);
        }
        
        .candidate-info {
            background: rgba(30, 60, 114, 0.05);
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 25px;
            border-left: 4px solid var(--accent);
        }
        
        .info-title {
            font-size: 1.1rem;
            font-weight: 600;
            color: var(--primary);
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .info-content {
            color: #555;
            font-size: 1rem;
            word-break: break-all;
        }
        
        .document-section {
            background: rgba(30, 60, 114, 0.03);
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 30px;
            border: 2px dashed rgba(30, 60, 114, 0.1);
        }
        
        .section-title {
            font-size: 1.5rem;
            color: var(--primary);
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .section-title i {
            color: var(--accent);
        }
        
        .pdf-viewer {
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
            border: 3px solid #e1e5ee;
            background: white;
        }
        
        .no-document {
            text-align: center;
            padding: 60px 20px;
            color: #666;
        }
        
        .no-document i {
            font-size: 4rem;
            margin-bottom: 15px;
            opacity: 0.5;
        }
        
        .no-document h3 {
            color: var(--danger);
            margin-bottom: 10px;
        }
        
        .action-section {
            background: rgba(30, 60, 114, 0.05);
            border-radius: 15px;
            padding: 25px;
            margin-top: 30px;
        }
        
        .action-title {
            font-size: 1.3rem;
            font-weight: 600;
            color: var(--primary);
            margin-bottom: 20px;
            text-align: center;
        }
        
        .action-buttons {
            display: flex;
            gap: 20px;
            justify-content: center;
            flex-wrap: wrap;
        }
        
        .btn {
            padding: 14px 30px;
            border-radius: 10px;
            font-weight: 600;
            font-size: 1rem;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            text-decoration: none;
            border: none;
            cursor: pointer;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }
        
        .btn-back {
            background: rgba(30, 60, 114, 0.1);
            color: var(--primary);
            border: 2px solid var(--primary);
        }
        
        .btn-back:hover {
            background: var(--primary);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(30, 60, 114, 0.3);
        }
        
        .btn-accept {
            background: linear-gradient(45deg, var(--success), #66bb6a);
            color: white;
        }
        
        .btn-accept:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(76, 175, 80, 0.4);
        }
        
        .security-notice {
            background: rgba(46, 204, 113, 0.1);
            border: 1px solid rgba(46, 204, 113, 0.3);
            border-radius: 10px;
            padding: 15px;
            margin-top: 25px;
            text-align: center;
        }
        
        .security-notice i {
            color: var(--success);
            margin-right: 8px;
        }
        
        .status-indicator {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 8px 16px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.9rem;
            margin-left: 15px;
        }
        
        .status-pending {
            background: rgba(255, 152, 0, 0.1);
            color: #f57c00;
            border: 1px solid rgba(255, 152, 0, 0.3);
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
            .document-container {
                padding: 20px;
            }
            
            .page-title {
                font-size: 1.8rem;
            }
            
            .header-section {
                flex-direction: column;
                align-items: flex-start;
            }
            
            .action-buttons {
                flex-direction: column;
            }
            
            .btn {
                width: 100%;
                justify-content: center;
            }
            
            .pdf-viewer {
                height: 500px;
            }
        }
        
        @media (max-width: 480px) {
            body {
                padding: 10px;
            }
            
            .page-title {
                font-size: 1.5rem;
            }
            
            .section-title {
                font-size: 1.3rem;
            }
            
            .pdf-viewer {
                height: 400px;
            }
        }
    </style>
</head>

<body>
    <div class="document-container">
        
        <div class="header-section">
            <h1 class="page-title">
                <i class="fas fa-file-contract"></i>
                Nomination Document
            </h1>
            <a href="Nominationview.jsp" class="btn btn-back">
                <i class="fas fa-arrow-left"></i>
                Back to Nominations
            </a>
        </div>

        
        <div class="candidate-info">
            <h3 class="info-title">
                <i class="fas fa-user-tie"></i>
                Candidate Information
            </h3>
            <p class="info-content">
                <strong>Email:</strong> <%= email %>
                <span class="status-indicator status-pending">
                    <i class="fas fa-clock"></i>
                    Under Review
                </span>
            </p>
        </div>

        
        <div class="document-section">
            <h2 class="section-title">
                <i class="fas fa-file-pdf"></i>
                Nomination Declaration Document
            </h2>
            
            <% if (pdfData != null) { %>
                <%
                    String base64Pdf = java.util.Base64.getEncoder().encodeToString(pdfData);
                    String pdfURL = "data:application/pdf;base64," + base64Pdf;
                %>
                <div class="pdf-viewer">
                    <iframe src="<%= pdfURL %>" width="100%" height="600px" style="border: none;"></iframe>
                </div>
            <% } else { %>
                <div class="no-document">
                    <i class="fas fa-file-exclamation"></i>
                    <h3>Document Not Found</h3>
                    <p>No nomination document found for candidate: <%= email %></p>
                </div>
            <% } %>
        </div>

        
            
            <div class="security-notice">
                <i class="fas fa-shield-alt"></i>
                <span>Security Verified:</span> All nomination documents are securely processed and verified.
            </div>
        </div>
    </div>

    <script>
       
        document.addEventListener('DOMContentLoaded', function() {
            const acceptForm = document.querySelector('form[action="vaccept.jsp"]');
            if (acceptForm) {
                acceptForm.addEventListener('submit', function(e) {
                    if (!confirm('Are you sure you want to approve this candidate nomination? This action will mark the candidate as eligible.')) {
                        e.preventDefault();
                    }
                });
            }
            
           
            const pdfIframe = document.querySelector('iframe');
            if (pdfIframe) {
                pdfIframe.addEventListener('load', function() {
                    this.style.opacity = '1';
                });
                
                pdfIframe.style.opacity = '0';
                pdfIframe.style.transition = 'opacity 0.3s ease';
            }
        });
    </script>
</body>
</html>