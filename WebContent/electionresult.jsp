<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Enter Assembly - Voter Portal</title>
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
        
        .main-container {
            max-width: 600px;
            width: 100%;
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
        
        .form-container {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 40px;
            box-shadow: var(--shadow);
            backdrop-filter: blur(10px);
            animation: fadeInUp 0.8s ease-out;
        }
        
        .form-header {
            text-align: center;
            margin-bottom: 30px;
        }
        
        .form-title {
            color: var(--primary);
            font-size: 2.2rem;
            margin-bottom: 10px;
            position: relative;
            padding-bottom: 15px;
        }
        
        .form-title:after {
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
        
        .form-description {
            color: #666;
            font-size: 1rem;
        }
        
        .form-group {
            margin-bottom: 25px;
        }
        
        .form-label {
            display: block;
            margin-bottom: 8px;
            color: var(--primary);
            font-weight: 500;
            font-size: 0.95rem;
        }
        
        .input-with-icon {
            position: relative;
        }
        
        .form-input {
            width: 100%;
            padding: 15px 20px;
            border: 2px solid #e1e5ee;
            border-radius: 10px;
            font-size: 1rem;
            transition: var(--transition);
            background: white;
            color: var(--dark);
        }
        
        .form-input::placeholder {
            color: #95a5a6;
        }
        
        .form-input:focus {
            outline: none;
            border-color: var(--secondary);
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.2);
        }
        
        .input-icon {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--secondary);
            font-size: 1.1rem;
        }
        
        .form-actions {
            display: flex;
            gap: 15px;
            justify-content: space-between;
            margin-top: 30px;
            flex-wrap: wrap;
        }
        
        .btn-submit {
            background: var(--gradient);
            color: white;
            border: none;
            border-radius: 10px;
            padding: 16px 32px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            display: flex;
            align-items: center;
            gap: 8px;
            box-shadow: 0 5px 15px rgba(52, 152, 219, 0.4);
            flex: 1;
            justify-content: center;
            min-width: 150px;
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
        
        .btn-back {
            background: red;
            border: 2px solid rgba(255, 255, 255, 0.3);
            padding: 15px 30px;
            border-radius: 12px;
            color: white;
            font-weight: 600;
            font-size: 1rem;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
            cursor: pointer;
            flex: 1;
            justify-content: center;
            min-width: 150px;
        }
        
        .btn-back:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: translateY(-2px);
            color: white;
        }
        
        .info-section {
            background: rgba(52, 152, 219, 0.1);
            border: 1px solid rgba(52, 152, 219, 0.3);
            border-radius: 10px;
            padding: 20px;
            margin-top: 25px;
            text-align: center;
        }
        
        .info-title {
            font-size: 1rem;
            font-weight: 600;
            margin-bottom: 10px;
            color: var(--primary);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }
        
        .info-title i {
            color: var(--secondary);
        }
        
        .info-content {
            font-size: 0.9rem;
            color: #666;
            line-height: 1.5;
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
            .main-container {
                max-width: 100%;
                padding: 10px;
            }
            
            .page-title {
                font-size: 2.2rem;
            }
            
            .form-container {
                padding: 30px 25px;
            }
            
            .form-title {
                font-size: 1.8rem;
            }
            
            .form-actions {
                flex-direction: column;
            }
            
            .btn-submit, .btn-back {
                width: 100%;
            }
        }
        
        @media (max-width: 480px) {
            body {
                padding: 10px;
            }
            
            .page-title {
                font-size: 2rem;
            }
            
            .form-container {
                padding: 25px 20px;
            }
            
            .form-title {
                font-size: 1.6rem;
            }
        }
    </style>
</head>

<body>
    <div class="main-container">
        
        <div class="header-section">
            <h1 class="page-title">
                <i class="fas fa-landmark"></i>
                Department Search
            </h1>
            <p class="page-subtitle">Enter Department details to view constituency information</p>
        </div>

        
        <div class="form-container">
            <div class="form-header">
                <h1 class="form-title">Department Information</h1>
                <p class="form-description">Please enter the Department ward name to proceed</p>
            </div>

            <form action="uccount.jsp" method="post">
                <div class="form-group">
                    <label class="form-label">
                        <i class="fas fa-map-marker-alt"></i>
                        Department  Name
                    </label>
                    <div class="input-with-icon">
                        <input type="text" 
                               class="form-input" 
                               placeholder="Enter Department name" 
                               name="ass" 
                               required
                               autocomplete="off">
                        <i class="fas fa-building input-icon"></i>
                    </div>
                </div>

                <div class="info-section">
                    <h4 class="info-title">
                        <i class="fas fa-info-circle"></i>
                        Important Information
                    </h4>
                    <p class="info-content">
                        Enter the exact Department  name as registered in the system. 
                        This will help retrieve accurate constituency data and voting statistics.
                    </p>
                </div>

                <div class="form-actions">
                    <a href="votermain.jsp" class="btn-back">
                        <i class="fas fa-arrow-left"></i>
                        Back to Dashboard
                    </a>
                    <button type="submit" class="btn-submit">
                        Search Department
                        <i class="fas fa-search"></i>
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script>
      
        window.addEventListener('load', function() {
            document.body.style.opacity = 1;
        });
        
        document.body.style.opacity = 0;
        document.body.style.transition = 'opacity 0.5s ease';
        
       
        document.querySelector('form').addEventListener('submit', function(e) {
            const assemblyInput = document.querySelector('input[name="ass"]');
            if (!assemblyInput.value.trim()) {
                e.preventDefault();
                assemblyInput.focus();
                assemblyInput.style.borderColor = 'var(--secondary)';
                return false;
            }
        });
        
       
        const assemblyInput = document.querySelector('input[name="ass"]');
        assemblyInput.addEventListener('focus', function() {
            this.style.borderColor = 'var(--secondary)';
            this.style.boxShadow = '0 0 0 3px rgba(52, 152, 219, 0.2)';
        });
        
        assemblyInput.addEventListener('blur', function() {
            this.style.boxShadow = 'none';
        });
    </script>
</body>
</html>