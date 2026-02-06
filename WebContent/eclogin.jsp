<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Election Commission Login - Secure Portal</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
   
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/material-design-iconic-font/2.2.0/css/material-design-iconic-font.min.css">
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
            --gradient: linear-gradient(135deg, #1a2a3a, #2c3e50);
            --shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
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
        
        .wrapper {
            background: white;
            border-radius: 20px;
            box-shadow: var(--shadow);
            overflow: hidden;
            width: 100%;
            max-width: 1000px;
            display: flex;
            min-height: 600px;
        }
        
        .inner {
            display: flex;
            width: 100%;
        }
        
        .image-holder {
            flex: 1;
            background: var(--gradient);
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
        
        .image-holder::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxMDAlIiBoZWlnaHQ9IjEwMCUiPjxkZWZzPjxwYXR0ZXJuIGlkPSJwYXR0ZXJuIiB3aWR0aD0iNDAiIGhlaWdodD0iNDAiIHBhdHRlcm5Vbml0cz0idXNlclNwYWNlT25Vc2UiIHBhdHRlcm5UcmFuc2Zvcm09InJvdGF0ZSg0NSkiPjxyZWN0IHdpZHRoPSIyMCIgaGVpZ2h0PSIyMCIgZmlsbD0icmdiYSgyNTUsMjU1LDI1NSwwLjA1KSIvPjwvcGF0dGVybj48L2RlZnM+PHJlY3QgZmlsbD0idXJsKCNwYXR0ZXJuKSIgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSIvPjwvc3ZnPg==');
        }
        
        .image-content {
            z-index: 1;
            max-width: 400px;
        }
        
        .image-holder img {
            max-width: 100%;
            border-radius: 10px;
            margin-bottom: 30px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            border: 3px solid rgba(255, 255, 255, 0.2);
        }
        
        .image-holder h2 {
            font-size: 1.8rem;
            margin-bottom: 15px;
            font-weight: 600;
        }
        
        .image-holder p {
            font-size: 1rem;
            opacity: 0.9;
            line-height: 1.6;
            margin-bottom: 25px;
        }
        
        .features-list {
            list-style: none;
            text-align: left;
            margin-top: 20px;
        }
        
        .features-list li {
            margin-bottom: 15px;
            display: flex;
            align-items: flex-start;
        }
        
        .features-list i {
            color: var(--light);
            margin-right: 10px;
            margin-top: 3px;
        }
        
        form {
            flex: 1;
            padding: 60px 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        
        .form-header {
            text-align: center;
            margin-bottom: 40px;
        }
        
        .form-header h3 {
            color: var(--primary);
            font-size: 2.2rem;
            margin-bottom: 10px;
            position: relative;
            padding-bottom: 15px;
            font-weight: 700;
        }
        
        .form-header h3:after {
            content: '';
            position: absolute;
            width: 70px;
            height: 4px;
            background: var(--secondary);
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            border-radius: 2px;
        }
        
        .form-header p {
            color: #666;
            font-size: 1rem;
            margin-top: 10px;
        }
        
        .form-wrapper {
            position: relative;
            margin-bottom: 25px;
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
        
        .form-wrapper i {
            position: absolute;
            top: 50%;
            left: 20px;
            transform: translateY(-50%);
            color: #a0a0a0;
            font-size: 1.2rem;
            transition: var(--transition);
        }
        
        .form-control:focus + i {
            color: var(--secondary);
        }
        
        button {
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
            margin-top: 10px;
            box-shadow: 0 5px 15px rgba(44, 62, 80, 0.4);
        }
        
        button:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(44, 62, 80, 0.6);
        }
        
        button i {
            margin-left: 10px;
            transition: var(--transition);
        }
        
        button:hover i {
            transform: translateX(5px);
        }
        
        .security-badge {
            background: rgba(46, 204, 113, 0.1);
            border: 1px solid rgba(46, 204, 113, 0.3);
            border-radius: 10px;
            padding: 15px;
            margin-top: 25px;
            text-align: center;
        }
        
        .security-badge h4 {
            color: var(--success);
            font-size: 1rem;
            margin-bottom: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .security-badge h4 i {
            margin-right: 8px;
        }
        
        .security-badge p {
            font-size: 0.85rem;
            color: #666;
            margin: 0;
        }
        
        
        .alert {
            padding: 12px 20px;
            border-radius: 10px;
            margin-bottom: 20px;
            display: none;
            text-align: center;
            font-weight: 500;
        }
        
        .alert-error {
            background: rgba(231, 76, 60, 0.1);
            border-left: 4px solid var(--accent);
            color: #c0392b;
        }
        
        
        @media (max-width: 768px) {
            .inner {
                flex-direction: column;
            }
            
            .image-holder {
                padding: 30px 20px;
            }
            
            .image-holder img {
                max-width: 200px;
            }
            
            form {
                padding: 40px 30px;
            }
            
            .form-header h3 {
                font-size: 1.8rem;
            }
        }
    </style>
</head>

<body>
    <div class="wrapper">
        <div class="inner">
            <div class="image-holder">
                <div class="image-content">
                   
                    <h2>Election Commission Portal</h2>
                    <p>Secure access to election management system for authorized personnel only.</p>
                    
                    <ul class="features-list">
                        <li>
                            <i class="fas fa-shield-alt"></i>
                            <span>Advanced security protocols</span>
                        </li>
                        <li>
                            <i class="fas fa-chart-bar"></i>
                            <span>Real-time election analytics</span>
                        </li>
                        <li>
                            <i class="fas fa-users-cog"></i>
                            <span>Voter management system</span>
                        </li>
                        <li>
                            <i class="fas fa-file-alt"></i>
                            <span>Comprehensive reporting tools</span>
                        </li>
                    </ul>
                </div>
            </div>
            
            <form action="eclog" method="post">
                <div class="form-header">
                    <h3>Commission Login</h3>
                    <p>Enter your credentials to access the secure portal</p>
                </div>
                
               
                <div id="alert" class="alert alert-error">
                    <i class="fas fa-exclamation-circle"></i> Invalid username or password. Please verify your credentials.
                </div>
                
                <div class="form-wrapper">
                    <input type="text" placeholder="Username" name="name" class="form-control" required>
                    <i class="zmdi zmdi-account"></i>
                </div>
                
                <div class="form-wrapper">
                    <input type="password" placeholder="Password" name="pass" class="form-control" required>
                    <i class="zmdi zmdi-lock"></i>
                </div>
                
                <button type="submit">
                    Access Portal
                    <i class="zmdi zmdi-arrow-right"></i>
                </button>
                
                <div class="security-badge">
                    <h4><i class="fas fa-shield-check"></i> Secure Authentication</h4>
                    <p>This portal is protected with advanced encryption and security measures</p>
                </div>
            </form>
        </div>
    </div>

    <script>
        
        document.addEventListener('DOMContentLoaded', function() {
            const urlParams = new URLSearchParams(window.location.search);
            if (urlParams.has('error') && urlParams.get('error') === 'user_not_found') {
                document.getElementById('alert').style.display = 'block';
            }
        });

       
        const inputs = document.querySelectorAll('.form-control');
        inputs.forEach(input => {
            input.addEventListener('focus', function() {
                this.parentElement.querySelector('i').style.color = 'var(--secondary)';
            });
            
            input.addEventListener('blur', function() {
                if (!this.value) {
                    this.parentElement.querySelector('i').style.color = '#a0a0a0';
                }
            });
        });

        
        document.querySelector('form').addEventListener('submit', function(e) {
            const btn = document.querySelector('button');
            btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Authenticating...';
            btn.disabled = true;
            
            
            setTimeout(function() {
                btn.innerHTML = 'Access Portal <i class="zmdi zmdi-arrow-right"></i>';
                btn.disabled = false;
            }, 2000);
        });
    </script>
</body>
</html>