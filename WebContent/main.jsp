<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <title>Email Verification - Secure Online Voting</title>
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
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }
        
        .verification-container {
            background: white;
            border-radius: 20px;
            box-shadow: var(--shadow);
            overflow: hidden;
            width: 100%;
            max-width: 500px;
            padding: 40px;
            text-align: center;
            animation: fadeIn 0.8s ease-out;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .verification-icon {
            width: 100px;
            height: 100px;
            background: rgba(52, 152, 219, 0.1);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 25px;
            color: var(--secondary);
            font-size: 2.5rem;
            animation: pulse 2s infinite;
        }
        
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }
        
        .verification-header h1 {
            color: var(--primary);
            font-size: 2rem;
            margin-bottom: 10px;
        }
        
        .verification-header p {
            color: #666;
            margin-bottom: 30px;
            line-height: 1.6;
        }
        
        .form-group {
            margin-bottom: 25px;
            text-align: left;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: var(--primary);
            font-weight: 500;
            font-size: 0.95rem;
        }
        
        .input-with-icon {
            position: relative;
        }
        
        .form-control {
            width: 100%;
            padding: 15px 20px 15px 50px;
            border: 2px solid #e1e5ee;
            border-radius: 10px;
            font-size: 1rem;
            transition: var(--transition);
            background: white;
            color: var(--dark);
        }
        
        .form-control:focus {
            outline: none;
            border-color: var(--secondary);
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.2);
        }
        
        .input-icon {
            position: absolute;
            top: 50%;
            left: 20px;
            transform: translateY(-50%);
            color: #a0a0a0;
            font-size: 1.2rem;
            transition: var(--transition);
        }
        
        .form-control:focus + .input-icon {
            color: var(--secondary);
        }
        
        .otp-display {
            background: rgba(46, 204, 113, 0.1);
            border: 2px dashed var(--success);
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 25px;
            text-align: center;
        }
        
        .otp-display h3 {
            color: var(--success);
            font-size: 1.5rem;
            letter-spacing: 3px;
            margin: 0;
        }
        
        .otp-label {
            font-size: 0.9rem;
            color: #666;
            margin-bottom: 5px;
            display: block;
        }
        
        .btn-submit {
            background: var(--gradient);
            color: white;
            border: none;
            border-radius: 10px;
            padding: 16px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            display: flex;
            align-items: center;
            justify-content: center;
            width: 100%;
            box-shadow: 0 5px 15px rgba(52, 152, 219, 0.4);
        }
        
        .btn-submit:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(52, 152, 219, 0.6);
        }
        
        .btn-submit i {
            margin-left: 10px;
            transition: var(--transition);
        }
        
        .btn-submit:hover i {
            transform: translateX(5px);
        }
        
        .verification-footer {
            margin-top: 25px;
            padding-top: 20px;
            border-top: 1px solid #eee;
        }
        
        .verification-footer p {
            color: #666;
            font-size: 0.9rem;
            margin-bottom: 15px;
        }
        
        .back-link {
            display: inline-flex;
            align-items: center;
            color: var(--secondary);
            font-weight: 500;
            text-decoration: none;
            transition: var(--transition);
        }
        
        .back-link:hover {
            color: var(--accent);
        }
        
        .back-link i {
            margin-right: 8px;
            transition: var(--transition);
        }
        
        .back-link:hover i {
            transform: translateX(-3px);
        }
        
        .security-note {
            background: rgba(52, 152, 219, 0.05);
            border-radius: 10px;
            padding: 15px;
            margin-top: 20px;
            text-align: left;
        }
        
        .security-note h4 {
            color: var(--primary);
            font-size: 1rem;
            margin-bottom: 8px;
            display: flex;
            align-items: center;
        }
        
        .security-note h4 i {
            color: var(--success);
            margin-right: 8px;
        }
        
        .security-note p {
            font-size: 0.85rem;
            color: #666;
            margin: 0;
            line-height: 1.5;
        }
        
        
        .success-message {
            background: rgba(46, 204, 113, 0.1);
            border-left: 4px solid var(--success);
            color: #27ae60;
            padding: 12px 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            display: none;
            text-align: left;
        }
        
        
        @media (max-width: 576px) {
            .verification-container {
                padding: 30px 20px;
            }
            
            .verification-header h1 {
                font-size: 1.7rem;
            }
        }
    </style>
</head>
<%
    Random r1 = new Random(); 
    String key2 = "ABCDEFGH123456789";
    char c5 = key2.charAt(r1.nextInt(key2.length()));
    char c6 = key2.charAt(r1.nextInt(key2.length()));
    char c7 = key2.charAt(r1.nextInt(key2.length()));
    char c8 = key2.charAt(r1.nextInt(key2.length()));
    char c9 = key2.charAt(r1.nextInt(key2.length()));
    String t6 = "" + c5 + "" + c6 + "" + c7 + "" + c8 + "" + c9;
%>
<body>
    <div class="verification-container">
        <div class="verification-icon">
            <i class="fas fa-envelope"></i>
        </div>
        
        <div class="verification-header">
            <h1>Email Verification</h1>
            
        </div>
        
    
        <form action="MailSendkey" method="post">
            <input type="hidden" name="otp" value="<%= t6 %>">
            
            
            
            <div class="form-group">
                <label for="pid">Email Address</label>
                <div class="input-with-icon">
                    <input type="email" id="pid" name="pid" placeholder="Enter your registered email address" class="form-control" required autocomplete="off">
                    <i class="fas fa-envelope input-icon"></i>
                </div>
            </div>
            
            <button type="submit" class="btn-submit">
                Verify Email
                <i class="fas fa-paper-plane"></i>
            </button>
        </form>
        
       
        <div class="verification-footer">
            <p>Need to update your registration details?</p>
            <a href="voterreg.jsp" class="back-link">
                <i class="fas fa-arrow-left"></i>
                Back to Registration
            </a>
        </div>
    </div>

    <script>
        
        document.querySelector('form').addEventListener('submit', function(e) {
            const btn = document.querySelector('.btn-submit');
            btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Sending...';
            btn.disabled = true;
            
           
            setTimeout(function() {
                btn.innerHTML = 'Send Verification Code <i class="fas fa-paper-plane"></i>';
                btn.disabled = false;
                
                
                document.getElementById('success-message').style.display = 'block';
            }, 2000);
        });
        
        
        document.getElementById('pid').addEventListener('focus', function() {
            this.parentElement.querySelector('.input-icon').style.color = 'var(--secondary)';
        });
        
        document.getElementById('pid').addEventListener('blur', function() {
            if (!this.value) {
                this.parentElement.querySelector('.input-icon').style.color = '#a0a0a0';
            }
        });
    </script>
</body>
</html>