<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="dbcon.dbconn"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Base64" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Review Voter Document - Election Commission</title>
    
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
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
        }
        
        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            color: #333;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }
        
        .document-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
            width: 100%;
            max-width: 800px;
            border: 1px solid rgba(255, 255, 255, 0.3);
            animation: fadeInUp 0.8s ease-out;
        }
        
        .header-section {
            text-align: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid rgba(30, 60, 114, 0.1);
        }
        
        .page-title {
            font-size: 2.5rem;
            font-weight: 700;
            background: linear-gradient(45deg, var(--primary), var(--secondary));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 15px;
        }
        
        .page-subtitle {
            color: #666;
            font-size: 1.1rem;
            opacity: 0.9;
        }
        
        .document-section {
            background: rgba(30, 60, 114, 0.05);
            border-radius: 15px;
            padding: 30px;
            margin-bottom: 30px;
            border: 2px dashed rgba(30, 60, 114, 0.2);
        }
        
        .section-title {
            font-size: 1.3rem;
            font-weight: 600;
            color: var(--primary);
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .section-title i {
            color: var(--accent);
        }
        
        .document-preview {
            text-align: center;
            padding: 20px;
        }
        
        .document-image {
            max-width: 100%;
            height: auto;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
            border: 3px solid var(--light);
            transition: all 0.3s ease;
        }
        
        .document-image:hover {
            transform: scale(1.02);
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.3);
        }
        
        .no-document {
            text-align: center;
            padding: 40px 20px;
            color: #666;
        }
        
        .no-document i {
            font-size: 4rem;
            margin-bottom: 15px;
            opacity: 0.5;
        }
        
        .no-document h4 {
            color: var(--danger);
            margin-bottom: 10px;
        }
        
        .action-section {
            background: rgba(30, 60, 114, 0.03);
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 25px;
        }
        
        .action-title {
            font-size: 1.2rem;
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
            border-radius: 12px;
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
        
        .btn-accept {
            background: linear-gradient(45deg, var(--success), #66bb6a);
            color: white;
        }
        
        .btn-accept:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(76, 175, 80, 0.4);
            color: white;
        }
        
        .btn-back {
            background: rgba(30, 60, 114, 0.1);
            color: var(--primary);
            border: 2px solid var(--primary);
        }
        
        .btn-back:hover {
            background: var(--primary);
            color: white;
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(30, 60, 114, 0.3);
        }
        
        .voter-info {
            background: linear-gradient(135deg, var(--light), #f8fdff);
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 25px;
            border-left: 4px solid var(--accent);
        }
        
        .info-title {
            font-size: 1.1rem;
            font-weight: 600;
            color: var(--primary);
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .info-content {
            color: #555;
            font-size: 1rem;
            word-break: break-all;
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
        
        .security-notice {
            background: rgba(79, 195, 247, 0.1);
            border: 1px solid rgba(79, 195, 247, 0.3);
            border-radius: 10px;
            padding: 15px;
            margin-top: 20px;
            text-align: center;
        }
        
        .security-notice i {
            color: var(--accent);
            margin-right: 8px;
        }
        
        .security-notice span {
            font-weight: 600;
            color: var(--primary);
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
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }
        
        .pulse-animation {
            animation: pulse 2s infinite;
        }
        
        
        @media (max-width: 768px) {
            .document-container {
                padding: 25px;
            }
            
            .page-title {
                font-size: 2rem;
            }
            
            .action-buttons {
                flex-direction: column;
            }
            
            .btn {
                width: 100%;
                justify-content: center;
            }
        }
        
        @media (max-width: 480px) {
            body {
                padding: 10px;
            }
            
            .document-container {
                padding: 20px;
            }
            
            .page-title {
                font-size: 1.7rem;
            }
            
            .document-section, .action-section {
                padding: 20px;
            }
        }
    </style>
</head>

<%
String email = request.getParameter("email");
byte[] imageBytes = null;

String imageType = "image/jpeg";

try {
    Connection con = dbconn.create();
    String sql = "SELECT * FROM studentvoute.voteid WHERE studentmail=?";
    PreparedStatement ps = con.prepareStatement(sql);
    ps.setString(1, email);
    ResultSet rs = ps.executeQuery();

    if (rs.next()) {
        Blob blob = rs.getBlob(5);
        if (blob != null) {
            imageBytes = blob.getBytes(1, (int) blob.length());

            // 🔍 Detect image type using magic numbers
            if (imageBytes.length > 4) {
                // PNG
                if (imageBytes[0] == (byte)0x89 &&
                    imageBytes[1] == (byte)0x50 &&
                    imageBytes[2] == (byte)0x4E &&
                    imageBytes[3] == (byte)0x47) {
                    imageType = "image/png";
                }
                // JPEG
                else if (imageBytes[0] == (byte)0xFF &&
                         imageBytes[1] == (byte)0xD8) {
                    imageType = "image/jpeg";
                }
                // GIF
                else if (imageBytes[0] == (byte)0x47 &&
                         imageBytes[1] == (byte)0x49 &&
                         imageBytes[2] == (byte)0x46) {
                    imageType = "image/gif";
                }
                // WEBP
                else if (imageBytes[0] == (byte)0x52 &&
                         imageBytes[1] == (byte)0x49 &&
                         imageBytes[2] == (byte)0x46 &&
                         imageBytes[3] == (byte)0x46) {
                    imageType = "image/webp";
                }
            }
        }
    }
    rs.close();
    ps.close();
    con.close();
} catch (Exception e) {
    e.printStackTrace();
}
%>

<body>
    <div class="document-container">
       
        <div class="header-section">
            <h1 class="page-title">
                <i class="fas fa-file-contract"></i>
                Voter Document Review
            </h1>
            <p class="page-subtitle">Review the uploaded voter document and take appropriate action</p>
        </div>

        
        <div class="voter-info">
            <h3 class="info-title">
                <i class="fas fa-user-circle"></i>
                Voter Information
            </h3>
            <p class="info-content">
                <strong>Email:</strong> <%= email %>
                <span class="status-indicator status-pending">
                    <i class="fas fa-clock"></i>
                    Pending Review
                </span>
            </p>
        </div>

       
        <div class="document-section">
            <h3 class="section-title">
                <i class="fas fa-id-card"></i>
                Uploaded Voter Document
            </h3>
            
            <div class="document-preview">
           <% if (imageBytes != null) { %>
    <img src="data:<%= imageType %>;base64,<%= Base64.getEncoder().encodeToString(imageBytes) %>"
         class="document-image"
         alt="Voter Document">
<% } else { %>

    <div class="no-document">
        <i class="fas fa-file-exclamation"></i>
        <h4>No Document Uploaded</h4>
        <p>The voter has not uploaded any document for verification.</p>
    </div>
<% } %>

            </div>
        </div>

       
        <div class="action-section">
            <h3 class="action-title">Verification Action</h3>
            <div class="action-buttons">
                <a href="javascript:history.back()" class="btn btn-back">
                    <i class="fas fa-arrow-left"></i>
                    Back to Applications
                </a>
                
                <% if (imageBytes != null) { %>
                <form action="vaccept.jsp" method="post" style="margin: 0;">
                    <input type="hidden" name="email" value="<%=email%>">
                    <button type="submit" class="btn btn-accept pulse-animation">
                        <i class="fas fa-check-circle"></i>
                        Accept & Approve
                    </button>
                </form>
                <% } else { %>
                <button class="btn btn-accept" disabled style="opacity: 0.6; cursor: not-allowed;">
                    <i class="fas fa-check-circle"></i>
                    Accept & Approve
                </button>
                <% } %>
            </div>
        </div>

       
        <div class="security-notice">
            <i class="fas fa-shield-alt"></i>
            <span>Security Notice:</span> All voter documents are securely processed and verified according to election commission guidelines.
        </div>
    </div>

    <script>
        
        document.addEventListener('DOMContentLoaded', function() {
            const docImage = document.querySelector('.document-image');
            if (docImage) {
                docImage.addEventListener('mouseenter', function() {
                    this.style.transform = 'scale(1.05)';
                });
                
                docImage.addEventListener('mouseleave', function() {
                    this.style.transform = 'scale(1)';
                });
            }
            
            
            const acceptForm = document.querySelector('form[action="vaccept.jsp"]');
            if (acceptForm) {
                acceptForm.addEventListener('submit', function(e) {
                    if (!confirm('Are you sure you want to approve this voter application? This action cannot be undone.')) {
                        e.preventDefault();
                    }
                });
            }
        });
    </script>
</body>
</html>