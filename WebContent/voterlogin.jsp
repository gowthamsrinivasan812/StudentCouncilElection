<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Student Login - Secure Online Portal</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/material-design-iconic-font/2.2.0/css/material-design-iconic-font.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --primary: #2c3e50;
            --secondary: #3498db;
            --accent: #e74c3c;
            --light: #ecf0f1;
            --dark: #2c3e50;
            --success: #2ecc71;
            --gradient: linear-gradient(135deg, #3498db, #2c3e50);
            --shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            --transition: all 0.3s ease;
        }
        
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Poppins', sans-serif; }
        body { background: var(--gradient); display: flex; justify-content: center; align-items: center; min-height: 100vh; padding: 20px; }
        a { text-decoration: none; color: var(--secondary); transition: var(--transition); }
        a:hover { color: var(--accent); }
        .wrapper { background: white; border-radius: 20px; box-shadow: var(--shadow); overflow: hidden; width: 100%; max-width: 1000px; display: flex; min-height: 600px; }
        .inner { display: flex; width: 100%; }
        .image-holder { flex: 1; background: var(--gradient); display: flex; flex-direction: column; justify-content: center; align-items: center; padding: 40px; color: white; text-align: center; position: relative; overflow: hidden; }
        .image-holder:before { content: ''; position: absolute; top: 0; left: 0; width: 100%; height: 100%; background: url('data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxMDAlIiBoZWlnaHQ9IjEwMCUiPjxkZWZzPjxwYXR0ZXJuIGlkPSJwYXR0ZXJuIiB3aWR0aD0iNDAiIGhlaWdodD0iNDAiIHBhdHRlcm5Vbml0cz0idXNlclNwYWNlT25Vc2UiIHBhdHRlcm5UcmFuc2Zvcm09InJvdGF0ZSg0NSkiPjxyZWN0IHdpZHRoPSIyMCIgaGVpZ2h0PSIyMCIgZmlsbD0icmdiYSgyNTUsMjU1LDI1NSwwLjA1KSIvPjwvcGF0dGVybj48L2RlZnM+PHJlY3QgZmlsbD0idXJsKCNwYXR0ZXJuKSIgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSIvPjwvc3ZnPg=='); }
        .image-holder img { max-width: 100%; border-radius: 10px; margin-bottom: 30px; box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2); z-index: 1; }
        .image-holder h2 { font-size: 1.8rem; margin-bottom: 15px; z-index: 1; }
        .image-holder p { font-size: 1rem; opacity: 0.9; max-width: 300px; z-index: 1; }
        form { flex: 1; padding: 60px 40px; display: flex; flex-direction: column; justify-content: center; }
        h3 { color: var(--primary); font-size: 2rem; margin-bottom: 10px; text-align: center; position: relative; padding-bottom: 15px; }
        h3:after { content: ''; position: absolute; width: 70px; height: 4px; background: var(--secondary); bottom: 0; left: 50%; transform: translateX(-50%); border-radius: 2px; }
        .subtitle { text-align: center; color: #666; margin-bottom: 30px; font-size: 1rem; }
        .form-wrapper { position: relative; margin-bottom: 25px; }
        .form-control { width: 100%; padding: 15px 20px 15px 50px; border: 2px solid #e1e5ee; border-radius: 10px; font-size: 1rem; transition: var(--transition); background: white; color: var(--dark); }
        .form-control:focus { outline: none; border-color: var(--secondary); box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.2); }
        .form-wrapper i { position: absolute; top: 50%; left: 20px; transform: translateY(-50%); color: #a0a0a0; font-size: 1.2rem; transition: var(--transition); }
        .form-control:focus + i { color: var(--secondary); }
        button { background: var(--gradient); color: white; border: none; border-radius: 10px; padding: 15px; font-size: 1.1rem; font-weight: 600; cursor: pointer; transition: var(--transition); display: flex; align-items: center; justify-content: center; margin-top: 10px; box-shadow: 0 5px 15px rgba(52, 152, 219, 0.4); }
        button:hover { transform: translateY(-3px); box-shadow: 0 8px 20px rgba(52, 152, 219, 0.6); }
        button i { margin-left: 10px; transition: var(--transition); }
        button:hover i { transform: translateX(5px); }
        .register-link { text-align: center; margin-top: 25px; font-size: 0.95rem; }
        .register-link a { font-weight: 600; }
        .alert { padding: 12px 20px; border-radius: 10px; margin-bottom: 20px; display: none; }
        .alert-error { background: rgba(231, 76, 60, 0.1); border-left: 4px solid var(--accent); color: #c0392b; }
        @media (max-width: 768px) {
            .inner { flex-direction: column; }
            .image-holder { padding: 30px 20px; }
            .image-holder img { max-width: 200px; }
            form { padding: 40px 30px; }
        }
    </style>
</head>

<body>
    <div class="wrapper">
        <div class="inner">
            <div class="image-holder">
                <h2>Welcome Back, Student</h2>
                <p>Login securely to access your student portal and course information.</p>
            </div>
            
            <form action="studentlog" method="post">
                <h3>Student Login</h3>
                <p class="subtitle">Enter your details to access the portal</p>
                
                <div id="alert" class="alert alert-error">
                    User not found. Please register first.
                </div>
                
                <div class="form-wrapper">
                    <input type="text" placeholder="E-Mail Address" name="email" class="form-control" required>
                    <i class="zmdi zmdi-email"></i>
                </div>
                
                <div class="form-wrapper">
                    <input type="password" placeholder="Password" name="password" class="form-control" required>
                    <i class="zmdi zmdi-lock"></i>
                </div>
                
                <button type="submit">
                    Login
                    <i class="zmdi zmdi-arrow-right"></i>
                </button>
                
                <div class="register-link">
                    New student? <a href="voterreg.jsp">Register here</a>
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
    </script>
</body>
</html>
