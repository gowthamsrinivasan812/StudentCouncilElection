<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Candidate Registration | Election Campaign Portal</title>
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
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
            position: relative;
            overflow-x: hidden;
        }
        
        /* SAME BACKGROUND PATTERN */
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
        
        .registration-container {
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
        
        /* Left Panel - SAME TRANSPARENT BACKGROUND */
        .info-section {
            flex: 1;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            padding: 60px 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            border-right: 1px solid rgba(255, 255, 255, 0.2);
            color: white;
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
            color: white;
            font-size: 2.2rem;
        }
        
        .info-section h2 {
            font-size: 2.5rem;
            margin-bottom: 20px;
            font-weight: 700;
            color: white;
            text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.2);
        }
        
        .info-section p {
            font-size: 1.1rem;
            opacity: 0.9;
            line-height: 1.6;
            margin-bottom: 40px;
            color: rgba(255, 255, 255, 0.9);
        }
        
        .benefits-list {
            list-style: none;
            margin-top: 20px;
        }
        
        .benefits-list li {
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            font-size: 1.1rem;
            opacity: 0.9;
            transition: var(--transition);
            color: white;
        }
        
        .benefits-list li:hover {
            opacity: 1;
            transform: translateX(5px);
        }
        
        .benefits-list i {
            margin-right: 15px;
            font-size: 1.5rem;
            color: white;
            background: rgba(255, 255, 255, 0.2);
            width: 50px;
            height: 50px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: var(--transition);
        }
        
        .benefits-list li:hover i {
            background: rgba(255, 255, 255, 0.3);
            transform: scale(1.1);
        }
        
        /* Right Panel - Form Section */
        .form-section {
            flex: 1.2;
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
        
        select.form-control {
            appearance: none;
            background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='currentColor' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3e%3cpolyline points='6 9 12 15 18 9'%3e%3c/polyline%3e%3c/svg%3e");
            background-repeat: no-repeat;
            background-position: right 20px center;
            background-size: 20px;
            padding-right: 50px;
        }
        
        .input-icon {
            position: absolute;
            left: 20px;
            top: 50%;
            transform: translateY(-50%);
            color: #666;
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
            margin-top: 20px;
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
        
        .login-link {
            margin-top: 30px;
            text-align: center;
            color: #666;
        }
        
        .login-link a {
            color: var(--secondary);
            font-weight: 600;
            text-decoration: none;
            transition: var(--transition);
            padding: 5px 10px;
            border-radius: 6px;
        }
        
        .login-link a:hover {
            background: rgba(52, 152, 219, 0.1);
            text-decoration: underline;
        }
        
        /* Campaign Badge */
        .campaign-badge {
            display: inline-flex;
            align-items: center;
            background: rgba(46, 204, 113, 0.2);
            padding: 12px 24px;
            border-radius: 50px;
            margin-top: 30px;
            color: white;
            font-weight: 600;
            border: 2px solid rgba(46, 204, 113, 0.3);
        }
        
        .campaign-badge i {
            margin-right: 10px;
            font-size: 1.2rem;
        }
        
        /* Responsive Design */
        @media (max-width: 992px) {
            .registration-container {
                flex-direction: column;
                max-width: 700px;
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
            
            .form-control {
                padding: 16px 16px 16px 45px;
                font-size: 1rem;
            }
        }
        
        /* Two column layout for better form organization */
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }
        
        @media (max-width: 768px) {
            .form-row {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>

<body>
    <div class="registration-container">
        <!-- Left Info Panel - SAME TRANSPARENT BACKGROUND -->
        <div class="info-section">
            <div class="logo">
                <i class="fas fa-user-tie"></i>
                <span>Candidate Portal</span>
            </div>
            
            <h2>Join Student Council Elections</h2>
            <p>Register as a candidate to lead your campus community. Make a difference and shape the future of student governance through our secure election platform.</p>
            
            <ul class="benefits-list">
                <li><i class="fas fa-user-check"></i> Verified Candidate Registration</li>
                <li><i class="fas fa-vote-yea"></i> Secure Digital Voting System</li>
                <li><i class="fas fa-chart-line"></i> Real-time Campaign Analytics</li>
                <li><i class="fas fa-users"></i> Direct Voter Engagement Tools</li>
                <li><i class="fas fa-bullhorn"></i> Comprehensive Campaign Management</li>
            </ul>
            
            <div class="campaign-badge">
                <i class="fas fa-shield-check"></i>
                <span>Official Election Platform</span>
            </div>
        </div>
        
        <!-- Right Form Panel -->
        <div class="form-section">
            <div class="form-header">
                <h1>Candidate Registration</h1>
                <p>Complete the form below to register</p>
            </div>
            
            <form action="candidatereg" method="post">
                <div class="form-row">
                    <!-- Student Name Field -->
                    <div class="form-group">
                        <label>Student Name</label>
                        <div class="input-with-icon">
                            <input type="text" name="name" class="form-control" required 
                                   placeholder="Enter your full name">
                            <i class="fas fa-user input-icon"></i>
                        </div>
                    </div>
                    
                    <!-- Register Number Field -->
                    <div class="form-group">
                        <label>Register Number</label>
                        <div class="input-with-icon">
                            <input type="text" name="regno" class="form-control" required 
                                   placeholder="Enter your register number">
                            <i class="fas fa-id-card input-icon"></i>
                        </div>
                    </div>
                </div>
                
                <div class="form-row">
                    <!-- Mobile Number Field -->
                    <div class="form-group">
                        <label>Mobile Number</label>
                        <div class="input-with-icon">
                            <input type="tel" name="mobile" class="form-control"
                                   placeholder="Enter 10-digit mobile number" pattern="[0-9]{10}"
                                   maxlength="10" title="Mobile number must be 10 digits" required>
                            <i class="fas fa-phone input-icon"></i>
                        </div>
                    </div>
                    
                    <!-- Email Field -->
                    <div class="form-group">
                        <label>Email Address</label>
                        <div class="input-with-icon">
                            <input type="email" name="email" class="form-control" required 
                                   placeholder="Enter your email address">
                            <i class="fas fa-envelope input-icon"></i>
                        </div>
                    </div>
                </div>
                
                <!-- Department Field -->
                <div class="form-group">
                    <label>Department</label>
                    <div class="input-with-icon">
                        <select name="department" class="form-control" required>
                            <option value="">Select Department</option>
                            <option>CSE</option>
                            <option>IT</option>
                            <option>ECE</option>
                            <option>EEE</option>
                            <option>Mechanical</option>
                            <option>Civil</option>
                        </select>
                        <i class="fas fa-building input-icon"></i>
                    </div>
                </div>
                
                <div class="form-row">
                    <!-- Password Field -->
                    <div class="form-group">
                        <label>Password</label>
                        <div class="input-with-icon">
                            <input type="password" name="password" id="password" class="form-control"
                                   placeholder="Enter password (min 6 characters)" minlength="6" required>
                            <i class="fas fa-lock input-icon"></i>
                        </div>
                    </div>
                    
                    <!-- Confirm Password Field -->
                    <div class="form-group">
                        <label>Confirm Password</label>
                        <div class="input-with-icon">
                            <input type="password" name="confirmPassword" id="confirmPassword" 
                                   class="form-control" placeholder="Re-enter password" minlength="6" required>
                            <i class="fas fa-lock input-icon"></i>
                        </div>
                        <small id="passwordMatch" style="display:none;color:#e74c3c;margin-top:5px;">
                            <i class="fas fa-exclamation-circle"></i> Passwords do not match
                        </small>
                    </div>
                </div>
                
                <!-- Submit Button -->
                <button type="submit" class="btn-submit">
                    Register as Candidate <i class="fas fa-user-plus"></i>
                </button>
                
                <!-- Login Link -->
                <div class="login-link">
                    Already have an account? <a href="candidatelog.jsp">Login here</a>
                </div>
            </form>
        </div>
    </div>
    
    <script>
        // Password match validation
        const passwordInput = document.getElementById('password');
        const confirmPasswordInput = document.getElementById('confirmPassword');
        const passwordMatch = document.getElementById('passwordMatch');
        
        function checkPasswordMatch() {
            if (passwordInput.value && confirmPasswordInput.value) {
                if (passwordInput.value !== confirmPasswordInput.value) {
                    passwordMatch.style.display = 'block';
                    confirmPasswordInput.style.borderColor = '#e74c3c';
                } else {
                    passwordMatch.style.display = 'none';
                    confirmPasswordInput.style.borderColor = '#2ecc71';
                }
            } else {
                passwordMatch.style.display = 'none';
                confirmPasswordInput.style.borderColor = '#e1e5ee';
            }
        }
        
        passwordInput.addEventListener('input', checkPasswordMatch);
        confirmPasswordInput.addEventListener('input', checkPasswordMatch);
        
        // Input focus effects
        document.querySelectorAll('.form-control').forEach(input => {
            input.addEventListener('focus', function() {
                this.parentElement.querySelector('.input-icon').style.color = 'var(--secondary)';
                this.style.borderColor = 'var(--secondary)';
            });
            
            input.addEventListener('blur', function() {
                this.parentElement.querySelector('.input-icon').style.color = '#666';
                if (this !== confirmPasswordInput || !passwordMatch.style.display || passwordMatch.style.display === 'none') {
                    this.style.borderColor = '#e1e5ee';
                }
            });
        });
        
        // Form validation on submit
        document.querySelector('form').addEventListener('submit', function(e) {
            const password = passwordInput.value;
            const confirmPassword = confirmPasswordInput.value;
            
            if (password !== confirmPassword) {
                e.preventDefault();
                passwordMatch.style.display = 'block';
                confirmPasswordInput.style.borderColor = '#e74c3c';
                confirmPasswordInput.focus();
                return false;
            }
            
            if (password.length < 6) {
                e.preventDefault();
                alert('Password must be at least 6 characters long');
                passwordInput.focus();
                return false;
            }
            
            return true;
        });
        
        // Mobile number validation
        const mobileInput = document.querySelector('input[name="mobile"]');
        mobileInput.addEventListener('input', function() {
            this.value = this.value.replace(/[^0-9]/g, '');
        });
    </script>
</body>
</html>