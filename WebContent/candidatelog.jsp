<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
 <%
    String msg = request.getParameter("msg");
%>
 
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Candidate Login | Election Campaign Portal</title>
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
            color: white;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
            position: relative;
            overflow-x: hidden;
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
        
        .login-container {
            width: 100%;
            max-width: 1200px;
            display: flex;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 20px 50px rgba(0, 0, 0, 0.3);
            animation: fadeIn 0.8s ease-out;
        }
        
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        /* Left Panel - Info Section */
        .info-section {
            flex: 1;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            padding: 60px 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            border-right: 1px solid rgba(255, 255, 255, 0.2);
        }
        
        .logo {
            display: flex;
            align-items: center;
            margin-bottom: 40px;
            font-size: 1.8rem;
            font-weight: 700;
        }
        
        .logo i {
            margin-right: 15px;
            color: var(--light);
            font-size: 2.2rem;
        }
        
        .info-section h2 {
            font-size: 2.5rem;
            margin-bottom: 20px;
            font-weight: 700;
            background: linear-gradient(to right, #fff, #ecf0f1);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
        }
        
        .info-section p {
            font-size: 1.1rem;
            opacity: 0.9;
            line-height: 1.6;
            margin-bottom: 40px;
        }
        
        .info-list {
            list-style: none;
            margin-top: 20px;
        }
        
        .info-list li {
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            font-size: 1.1rem;
            opacity: 0.9;
            transition: var(--transition);
        }
        
        .info-list li:hover {
            opacity: 1;
            transform: translateX(5px);
        }
        
        .info-list i {
            margin-right: 15px;
            font-size: 1.5rem;
            color: var(--secondary);
            background: rgba(255, 255, 255, 0.1);
            width: 50px;
            height: 50px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        /* Right Panel - Form Section */
        .form-section {
            flex: 1;
            background: white;
            padding: 60px 50px;
            color: var(--dark);
        }
        
        .form-header {
            text-align: center;
            margin-bottom: 40px;
        }
        
        .form-header h1 {
            font-size: 2.8rem;
            color: var(--primary);
            margin-bottom: 10px;
            font-weight: 700;
        }
        
        .form-header p {
            color: #666;
            font-size: 1.1rem;
        }
        
        /* Alert Styling */
        .alert {
            background: rgba(231, 76, 60, 0.1);
            color: #e74c3c;
            padding: 16px 20px;
            border-radius: 12px;
            margin-bottom: 30px;
            display: flex;
            align-items: center;
            border-left: 4px solid #e74c3c;
            animation: slideIn 0.5s ease-out;
        }
        
        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateX(-20px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }
        
        .alert i {
            margin-right: 12px;
            font-size: 1.2rem;
        }
        
        /* Form Styling */
        .form-group {
            margin-bottom: 25px;
        }
        
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: var(--primary);
            font-size: 1rem;
        }
        .success-message {
    background: #2ecc71;
    color: white;
    padding: 15px;
    border-radius: 10px;
    margin-bottom: 20px;
    text-align: center;
    font-weight: 600;
    animation: fadeIn 0.5s ease-in-out;
}

.success-message i {
    margin-right: 8px;
}
        
        .input-with-icon {
            position: relative;
        }
        
        .form-control {
            width: 100%;
            padding: 18px 20px 18px 55px;
            border-radius: 12px;
            border: 2px solid #e1e5ee;
            font-size: 1.1rem;
            transition: var(--transition);
            background: #f8f9fa;
        }
        
        .form-control:focus {
            outline: none;
            border-color: var(--secondary);
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
            background: white;
        }
        
        .input-icon {
            position: absolute;
            left: 20px;
            top: 50%;
            transform: translateY(-50%);
            color: #888;
            font-size: 1.2rem;
        }
        
        .btn-submit {
            width: 100%;
            padding: 18px;
            background: var(--gradient);
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 1.2rem;
            font-weight: 600;
            cursor: pointer;
            margin-top: 10px;
            transition: var(--transition);
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }
        
        .btn-submit:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.5);
        }
        
        .btn-submit i {
            margin-left: 10px;
            font-size: 1.1rem;
        }
        
        .register-link {
            margin-top: 30px;
            text-align: center;
            color: #666;
        }
        
        .register-link a {
            color: var(--secondary);
            font-weight: 600;
            text-decoration: none;
            transition: var(--transition);
            padding: 5px 10px;
            border-radius: 6px;
        }
        
        .register-link a:hover {
            background: rgba(52, 152, 219, 0.1);
            text-decoration: underline;
        }
        
        /* Campaign Badge */
        .campaign-badge {
            display: inline-flex;
            align-items: center;
            background: rgba(46, 204, 113, 0.1);
            padding: 10px 20px;
            border-radius: 50px;
            margin-top: 30px;
            color: var(--success);
            font-weight: 600;
        }
        
        .campaign-badge i {
            margin-right: 8px;
        }
        
        /* Responsive Design */
        @media (max-width: 992px) {
            .login-container {
                flex-direction: column;
                max-width: 600px;
            }
            
            .info-section, .form-section {
                padding: 40px 30px;
            }
            
            .info-section {
                border-right: none;
                border-bottom: 1px solid rgba(255, 255, 255, 0.2);
            }
            
            .info-section h2 {
                font-size: 2.2rem;
            }
            
            .form-header h1 {
                font-size: 2.2rem;
            }
        }
        
        @media (max-width: 576px) {
            body {
                padding: 15px;
            }
            
            .info-section, .form-section {
                padding: 30px 20px;
            }
            
            .info-section h2 {
                font-size: 1.8rem;
            }
            
            .form-header h1 {
                font-size: 1.8rem;
            }
            
            .logo {
                font-size: 1.5rem;
            }
            
            .logo i {
                font-size: 1.8rem;
            }
        }
    </style>
</head>

<body>
    <div class="login-container">
        <!-- Left Info Panel -->
        <div class="info-section">
            <div class="logo">
                <i class="fas fa-user-tie"></i>
                <span>Candidate Portal</span>
            </div>
            
            <h2>Welcome Back, Candidate</h2>
            <p>Access your campaign dashboard to manage your election profile, track progress, and connect with voters through our secure platform.</p>
            
            <ul class="info-list">
                <li><i class="fas fa-user-check"></i> Verified Candidate Access Only</li>
                <li><i class="fas fa-poll"></i> Real-time Voting Analytics</li>
                <li><i class="fas fa-chart-bar"></i> Live Election Results</li>
                <li><i class="fas fa-users"></i> Voter Engagement Platform</li>
            </ul>
            
            <div class="campaign-badge">
                <i class="fas fa-shield-check"></i>
                <span>Official Election Platform</span>
            </div>
        </div>
        
        <div class="form-section">
            <div class="form-header">
                <h1>Candidate Login</h1>
                <p>Election Campaign Portal</p>
            </div>
            
            <%
                String error = (String) request.getAttribute("errorMessage");
                if (error != null) {
            %>
                <div class="alert">
                    <i class="fas fa-exclamation-circle"></i>
                    <%= error %>
                </div>
            <%
                }
            %>
            
            <% if ("registered".equals(msg)) { %>
    <div class="success-message">
        <i class="fas fa-check-circle"></i>
        Registration successful! Please login.
    </div>
<% } %>
            
            
            <form action="candidatelog" method="post">
                <!-- Register Number Field -->
                <div class="form-group">
                    <label>Register Number</label>
                    <div class="input-with-icon">
                        <input type="text" name="userInput" class="form-control" required 
                               placeholder="Enter your register number">
                        <i class="fas fa-id-card input-icon"></i>
                    </div>
                </div>
                
                <!-- Password Field -->
                <div class="form-group">
                    <label>Password</label>
                    <div class="input-with-icon">
                        <input type="password" name="password" class="form-control" required 
                               placeholder="Enter your password">
                        <i class="fas fa-lock input-icon"></i>
                    </div>
                </div>
                
                <!-- Submit Button -->
                <button type="submit" class="btn-submit">
                    Login to Dashboard <i class="fas fa-sign-in-alt"></i>
                </button>
                
                <!-- Registration Link -->
                <div class="register-link">
                    New candidate? <a href="cadidatereg.jsp">Register your candidacy here</a>
                </div>
            </form>
        </div>
    </div>
    
    <script>
        // Simple input focus effect
        document.querySelectorAll('.form-control').forEach(input => {
            input.addEventListener('focus', function() {
                this.parentElement.querySelector('.input-icon').style.color = 'var(--secondary)';
            });
            
            input.addEventListener('blur', function() {
                this.parentElement.querySelector('.input-icon').style.color = '#888';
            });
        });
    </script>
</body>
</html>