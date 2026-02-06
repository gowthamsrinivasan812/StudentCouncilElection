<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Election Results - Candidate Portal</title>
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
            color: #333;
            min-height: 100vh;
            padding: 20px;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        
        .main-container {
            max-width: 800px;
            width: 100%;
            margin: 0 auto;
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
            color: white;
            font-size: 2.5rem;
            font-weight: 700;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
        }
        
        .btn-back {
            background: rgba(255, 255, 255, 0.2);
            border: 2px solid rgba(255, 255, 255, 0.3);
            padding: 12px 25px;
            border-radius: 12px;
            color: white;
            font-weight: 600;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
            backdrop-filter: blur(10px);
            cursor: pointer;
        }
        
        .btn-back:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: translateY(-2px);
            color: white;
        }
        
        .form-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 40px;
            box-shadow: var(--shadow);
            backdrop-filter: blur(10px);
            animation: fadeInUp 0.8s ease-out;
        }
        
        .card-title {
            font-size: 1.8rem;
            color: var(--primary);
            margin-bottom: 30px;
            text-align: center;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }
        
        .card-title i {
            color: var(--secondary);
        }
        
        .form-description {
            text-align: center;
            color: #666;
            margin-bottom: 30px;
            font-size: 1rem;
            line-height: 1.6;
        }
        
        .form-group {
            margin-bottom: 25px;
        }
        
        .form-row {
            display: grid;
            grid-template-columns: 1fr;
            gap: 20px;
        }
        
        @media (min-width: 768px) {
            .form-row {
                grid-template-columns: 1fr 1fr;
            }
        }
        
        .input-with-icon {
            position: relative;
        }
        
        .form-input {
            width: 100%;
            padding: 15px 20px;
            border: 2px solid #e1e5ee;
            border-radius: 12px;
            font-size: 1rem;
            transition: var(--transition);
            background: white;
            color: var(--dark);
            font-weight: 500;
        }
        
        .form-input::placeholder {
            color: #95a5a6;
            font-weight: 400;
        }
        
        .form-input:focus {
            outline: none;
            border-color: var(--secondary);
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.2);
            transform: translateY(-2px);
        }
        
        .input-icon {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--secondary);
            font-size: 1.1rem;
        }
        
        .form-label {
            display: block;
            margin-bottom: 8px;
            color: var(--primary);
            font-weight: 600;
            font-size: 0.95rem;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .form-label i {
            color: var(--secondary);
            font-size: 0.9rem;
        }
        
        .btn-submit {
            background: linear-gradient(45deg, var(--success), #27ae60);
            color: white;
            border: none;
            border-radius: 12px;
            padding: 16px 32px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 20px auto 0;
            box-shadow: 0 5px 15px rgba(46, 204, 113, 0.4);
            width: 100%;
            max-width: 300px;
        }
        
        .btn-submit:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(46, 204, 113, 0.6);
        }
        
        .btn-submit i {
            margin-left: 10px;
            transition: var(--transition);
        }
        
        .btn-submit:hover i {
            transform: translateX(5px);
        }
        
        .info-section {
            background: rgba(52, 152, 219, 0.1);
            border: 1px solid rgba(52, 152, 219, 0.3);
            border-radius: 12px;
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
        
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.02); }
            100% { transform: scale(1); }
        }
        
        .pulse {
            animation: pulse 2s infinite;
        }
        
        
        @media (max-width: 768px) {
            .header-section {
                flex-direction: column;
                text-align: center;
            }
            
            .page-title {
                font-size: 2rem;
            }
            
            .form-card {
                padding: 30px 25px;
            }
            
            .card-title {
                font-size: 1.5rem;
            }
        }
        
        @media (max-width: 480px) {
            body {
                padding: 15px;
            }
            
            .page-title {
                font-size: 1.8rem;
            }
            
            .form-card {
                padding: 25px 20px;
            }
            
            .btn-back {
                width: 100%;
                justify-content: center;
            }
        }
    </style>
</head>
<body>
    <div class="main-container">
       
        <div class="header-section">
            <h1 class="page-title">
                <i class="fas fa-chart-line"></i>
                Election Results
            </h1>
            <a href="candidatemain.jsp" class="btn-back">
                <i class="fas fa-arrow-left"></i>
                Go Back
            </a>
        </div>

        
        <div class="form-card">
            <h2 class="card-title">
                <i class="fas fa-search"></i>
                Check Election Results
            </h2>
            
            <p class="form-description">
                Enter your candidate details to view the election results and voting statistics for your constituency.
            </p>

            <form action="count.jsp" method="post">
                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">
                            <i class="fas fa-user-tie"></i>
                            Candidate Name
                        </label>
                        <div class="input-with-icon">
                            <input type="text" 
                                   class="form-input" 
                                   placeholder="Enter candidate name" 
                                   name="cname" 
                                   required
                                   autocomplete="off">
                            <i class="fas fa-user input-icon"></i>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">
                            <i class="fas fa-landmark"></i>
                            Department
                        </label>
                        <div class="input-with-icon">
                            <input type="text" 
                                   class="form-input" 
                                   placeholder="Enter  Department Name" 
                                   name="ass" 
                                   required
                                   autocomplete="off">
                            <i class="fas fa-building input-icon"></i>
                        </div>
                    </div>
                </div>
                <button type="submit" class="btn-submit pulse">
                    <i class="fas fa-chart-bar"></i>
                    View Results
                </button>
            </form>

            <div class="info-section">
                <h4 class="info-title">
                    <i class="fas fa-info-circle"></i>
                    Important Information
                </h4>
                <p class="info-content">
                    Enter your exact candidate details as registered in the system to access accurate election results 
                    and voting statistics for your constituency.
                </p>
            </div>
        </div>
    </div>

    <script>
       
        window.addEventListener('load', function() {
            document.body.style.opacity = 1;
        });
        
        document.body.style.opacity = 0;
        document.body.style.transition = 'opacity 0.5s ease';
        
       
        const formInputs = document.querySelectorAll('.form-input');
        
        formInputs.forEach(input => {
            input.addEventListener('focus', function() {
                this.style.borderColor = 'var(--secondary)';
                this.style.boxShadow = '0 0 0 3px rgba(52, 152, 219, 0.2)';
            });
            
            input.addEventListener('blur', function() {
                this.style.boxShadow = 'none';
            });
        });
        
        
        document.querySelector('form').addEventListener('submit', function(e) {
            const inputs = this.querySelectorAll('input[required]');
            let valid = true;
            
            inputs.forEach(input => {
                if (!input.value.trim()) {
                    valid = false;
                    input.style.borderColor = 'var(--accent)';
                }
            });
            
            if (!valid) {
                e.preventDefault();
                alert('Please fill in all required fields.');
            }
        });
    </script>
</body>
</html>