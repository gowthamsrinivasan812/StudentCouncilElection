<%-- <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Enter Assembly - Election Commission</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #1e3c72;
            --secondary: #2a5298;
            --accent: #4fc3f7;
            --success: #4caf50;
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
            color: white;
            min-height: 100vh;
            padding: 20px;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        
        .main-container {
            max-width: 600px;
            width: 100%;
            margin: 0 auto;
        }
        
        .header-section {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(15px);
            border-radius: 20px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            border: 1px solid rgba(255, 255, 255, 0.2);
            animation: fadeInDown 0.8s ease-out;
            text-align: center;
        }
        
        .page-title {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 10px;
            background: linear-gradient(45deg, #fff, var(--accent));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            text-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 15px;
        }
        
        .page-subtitle {
            font-size: 1.1rem;
            opacity: 0.9;
            margin-bottom: 15px;
        }
        
        .form-container {
            background: rgba(255, 255, 255, 0.08);
            backdrop-filter: blur(15px);
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            border: 1px solid rgba(255, 255, 255, 0.2);
            animation: fadeInUp 0.8s ease-out 0.2s both;
        }
        
        .form-header {
            text-align: center;
            margin-bottom: 30px;
        }
        
        .form-title {
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }
        
        .form-title i {
            color: var(--accent);
        }
        
        .form-description {
            opacity: 0.8;
            font-size: 0.95rem;
        }
        
        .form-group {
            margin-bottom: 25px;
        }
        
        .form-label {
            display: block;
            margin-bottom: 10px;
            font-weight: 500;
            font-size: 1rem;
            opacity: 0.9;
        }
        
        .input-with-icon {
            position: relative;
        }
        
        .form-input {
            width: 100%;
            background: rgba(255, 255, 255, 0.1);
            border: 2px solid rgba(255, 255, 255, 0.2);
            border-radius: 12px;
            padding: 15px 20px;
            color: white;
            font-size: 1rem;
            transition: all 0.3s ease;
            backdrop-filter: blur(10px);
        }
        
        .form-input::placeholder {
            color: rgba(255, 255, 255, 0.7);
        }
        
        .form-input:focus {
            outline: none;
            border-color: var(--accent);
            box-shadow: 0 0 0 3px rgba(79, 195, 247, 0.3);
            background: rgba(255, 255, 255, 0.15);
        }
        
        .input-icon {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--accent);
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
            background: linear-gradient(45deg, var(--accent), #29b6f6);
            border: none;
            padding: 15px 30px;
            border-radius: 12px;
            color: white;
            font-weight: 600;
            font-size: 1rem;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            box-shadow: 0 4px 15px rgba(41, 182, 246, 0.4);
            cursor: pointer;
            flex: 1;
            justify-content: center;
            min-width: 150px;
        }
        
        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(41, 182, 246, 0.6);
        }
        
        .btn-back {
            background: rgba(255, 255, 255, 0.1);
            border: 2px solid rgba(255, 255, 255, 0.3);
            padding: 15px 30px;
            border-radius: 12px;
            color: white;
            font-weight: 600;
            font-size: 1rem;
            transition: all 0.3s ease;
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
            background: rgba(255, 255, 255, 0.2);
            transform: translateY(-2px);
            color: white;
        }
        
        .info-section {
            background: rgba(255, 255, 255, 0.05);
            border-radius: 12px;
            padding: 20px;
            margin-top: 25px;
            border-left: 4px solid var(--accent);
        }
        
        .info-title {
            font-size: 1rem;
            font-weight: 600;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .info-title i {
            color: var(--accent);
        }
        
        .info-content {
            font-size: 0.9rem;
            opacity: 0.8;
            line-height: 1.5;
        }
        
       
        @keyframes fadeInDown {
            from {
                opacity: 0;
                transform: translateY(-30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
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
        
       
        @media (max-width: 768px) {
            .main-container {
                max-width: 100%;
                padding: 10px;
            }
            
            .header-section {
                padding: 25px 20px;
            }
            
            .page-title {
                font-size: 2rem;
            }
            
            .form-container {
                padding: 30px 25px;
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
                font-size: 1.8rem;
            }
            
            .form-container {
                padding: 25px 20px;
            }
            
            .form-title {
                font-size: 1.3rem;
            }
        }
    </style>
</head>

<body>
    <div class="main-container">
        
        <div class="header-section">
            <h1 class="page-title">
                <i class="fas fa-landmark"></i>
                Assembly Entry
            </h1>
            <p class="page-subtitle">Enter assembly details to view constituency information</p>
        </div>

       
        <div class="form-container">
            <div class="form-header">
                <h2 class="form-title">
                    <i class="fas fa-edit"></i>
                    Assembly Information
                </h2>
                <p class="form-description">Please enter the assembly ward name to proceed</p>
            </div>

            <form action="eccount.jsp" method="post">
                <div class="form-group">
                    <label class="form-label">
                        <i class="fas fa-map-marker-alt"></i>
Department Name                    </label>
                    <div class="input-with-icon">
                        <input type="text" 
                               class="form-input" 
                               placeholder="Enter  Department name" 
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
                        Enter the exact  Department name as registered in the system. 
                        This will help retrieve accurate constituency data and voting statistics.
                    </p>
                </div>

                <div class="form-actions">
                    <a href="ecmain.jsp" class="btn-back">
                        <i class="fas fa-arrow-left"></i>
                        Back
                    </a>
                    <button type="submit" class="btn-submit">
                        <i class="fas fa-search"></i>
                        Search Department
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
                assemblyInput.style.borderColor = 'var(--accent)';
                return false;
            }
        });
        
       
        const assemblyInput = document.querySelector('input[name="ass"]');
        assemblyInput.addEventListener('focus', function() {
            this.style.borderColor = 'var(--accent)';
            this.style.boxShadow = '0 0 0 3px rgba(79, 195, 247, 0.3)';
        });
        
        assemblyInput.addEventListener('blur', function() {
            this.style.boxShadow = 'none';
        });
    </script>
</body>
</html> --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="dbcon.dbconn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Election Commission | Candidate Summary</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
    :root {
        --dark-bg: #0f172a;
        --darker-bg: #0a0f1f;
        --card-bg: #1e293b;
        --hover-bg: #2d3748;
        --primary: #3b82f6;
        --primary-hover: #2563eb;
        --secondary: #8b5cf6;
        --success: #10b981;
        --success-light: rgba(16, 185, 129, 0.1);
        --warning: #f59e0b;
        --danger: #ef4444;
        --text-primary: #f1f5f9;
        --text-secondary: #cbd5e1;
        --text-muted: #94a3b8;
        --border-color: #334155;
        --shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.5);
        --shadow-lg: 0 10px 25px -3px rgba(0, 0, 0, 0.7);
        --radius: 12px;
        --radius-sm: 8px;
        --transition: all 0.3s ease;
    }
    
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }
    
    body {
        background: var(--dark-bg);
        color: var(--text-primary);
        font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', system-ui, sans-serif;
        min-height: 100vh;
        padding: 20px;
        line-height: 1.6;
    }
    
    .container {
        max-width: 1400px;
        margin: 0 auto;
    }
    
    /* Back Button */
    .back-btn {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        background: var(--card-bg);
        color: var(--text-secondary);
        border: 1px solid var(--border-color);
        padding: 12px 20px;
        border-radius: var(--radius-sm);
        text-decoration: none;
        font-weight: 500;
        font-size: 15px;
        transition: var(--transition);
        margin-bottom: 25px;
        cursor: pointer;
    }
    
    .back-btn:hover {
        background: var(--hover-bg);
        color: var(--text-primary);
        transform: translateX(-3px);
        border-color: var(--primary);
    }
    
    /* Header */
    .header {
        background: linear-gradient(135deg, var(--card-bg) 0%, rgba(30, 41, 59, 0.95) 100%);
        border-radius: var(--radius);
        padding: 30px;
        margin-bottom: 25px;
        box-shadow: var(--shadow);
        border-left: 4px solid var(--success);
        position: relative;
        overflow: hidden;
        backdrop-filter: blur(10px);
    }
    
    .header::before {
        content: '';
        position: absolute;
        top: 0;
        right: 0;
        width: 200px;
        height: 200px;
        background: radial-gradient(circle, rgba(16, 185, 129, 0.1) 0%, transparent 70%);
        pointer-events: none;
    }
    
    .header-content {
        display: flex;
        justify-content: space-between;
        align-items: center;
        flex-wrap: wrap;
        gap: 20px;
    }
    
    .header-text h1 {
        font-size: 32px;
        font-weight: 700;
        background: linear-gradient(to right, var(--text-primary), var(--success));
        -webkit-background-clip: text;
        background-clip: text;
        color: transparent;
        margin-bottom: 8px;
        display: flex;
        align-items: center;
        gap: 12px;
    }
    
    .header-text p {
        color: var(--text-secondary);
        font-size: 16px;
        max-width: 600px;
    }
    
    /* Stats Cards */
    .stats-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
        gap: 20px;
        margin-bottom: 30px;
    }
    
    .stat-card {
        background: var(--card-bg);
        border-radius: var(--radius);
        padding: 25px;
        text-align: center;
        transition: var(--transition);
        border: 1px solid transparent;
        position: relative;
        overflow: hidden;
    }
    
    .stat-card:hover {
        transform: translateY(-5px);
        border-color: var(--primary);
        box-shadow: var(--shadow-lg);
    }
    
    .stat-card::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 4px;
        background: linear-gradient(to right, var(--primary), var(--secondary));
    }
    
    .stat-icon {
        width: 48px;
        height: 48px;
        background: rgba(16, 185, 129, 0.1);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto 15px;
        font-size: 20px;
        color: var(--success);
    }
    
    .stat-number {
        font-size: 36px;
        font-weight: 700;
        margin-bottom: 5px;
        color: var(--text-primary);
    }
    
    .stat-label {
        color: var(--text-muted);
        font-size: 14px;
        font-weight: 500;
        text-transform: uppercase;
        letter-spacing: 1px;
    }
    
    /* Search Section */
    .search-section {
        background: var(--card-bg);
        border-radius: var(--radius);
        padding: 25px;
        margin-bottom: 30px;
        box-shadow: var(--shadow);
        display: flex;
        justify-content: space-between;
        align-items: center;
        flex-wrap: wrap;
        gap: 20px;
    }
    
    .search-box {
        flex: 1;
        max-width: 500px;
        position: relative;
    }
    
    .search-box i {
        position: absolute;
        left: 18px;
        top: 50%;
        transform: translateY(-50%);
        color: var(--text-muted);
        z-index: 2;
    }
    
    .search-box input {
        width: 100%;
        padding: 14px 20px 14px 50px;
        background: var(--darker-bg);
        border: 1px solid var(--border-color);
        border-radius: var(--radius-sm);
        color: var(--text-primary);
        font-size: 15px;
        transition: var(--transition);
        position: relative;
    }
    
    .search-box input:focus {
        outline: none;
        border-color: var(--primary);
        box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.2);
    }
    
    .search-hint {
        color: var(--text-muted);
        font-size: 13px;
        margin-top: 8px;
        display: flex;
        align-items: center;
        gap: 6px;
    }
    
    /* Table Container */
    .table-container {
        background: var(--card-bg);
        border-radius: var(--radius);
        overflow: hidden;
        box-shadow: var(--shadow-lg);
        margin-bottom: 30px;
    }
    
    .table-header {
        background: rgba(30, 41, 59, 0.95);
        padding: 25px;
        border-bottom: 1px solid var(--border-color);
        display: flex;
        justify-content: space-between;
        align-items: center;
        flex-wrap: wrap;
        gap: 15px;
        backdrop-filter: blur(10px);
    }
    
    .table-header h2 {
        font-size: 22px;
        font-weight: 600;
        display: flex;
        align-items: center;
        gap: 12px;
    }
    
    /* Table */
    .data-table {
        width: 100%;
        border-collapse: collapse;
    }
    
    .data-table thead {
        background: rgba(15, 23, 42, 0.8);
        backdrop-filter: blur(10px);
    }
    
    .data-table th {
        padding: 20px;
        text-align: left;
        font-weight: 600;
        color: var(--text-secondary);
        border-bottom: 1px solid var(--border-color);
        font-size: 14px;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        position: sticky;
        top: 0;
        background: rgba(15, 23, 42, 0.95);
    }
    
    .data-table td {
        padding: 20px;
        border-bottom: 1px solid var(--border-color);
        color: var(--text-primary);
        transition: var(--transition);
    }
    
    .data-table tbody tr {
        transition: var(--transition);
    }
    
    .data-table tbody tr:hover {
        background: var(--hover-bg);
    }
    
    /* Department Tags */
    .dept-tag {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        padding: 8px 16px;
        border-radius: 20px;
        font-size: 13px;
        font-weight: 600;
        background: rgba(59, 130, 246, 0.1);
        color: var(--primary);
        border: 1px solid rgba(59, 130, 246, 0.3);
    }
    
    .dept-cse { background: rgba(16, 185, 129, 0.1); color: var(--success); border-color: rgba(16, 185, 129, 0.3); }
    .dept-it { background: rgba(139, 92, 246, 0.1); color: var(--secondary); border-color: rgba(139, 92, 246, 0.3); }
    .dept-ece { background: rgba(245, 158, 11, 0.1); color: var(--warning); border-color: rgba(245, 158, 11, 0.3); }
    .dept-mech { background: rgba(239, 68, 68, 0.1); color: var(--danger); border-color: rgba(239, 68, 68, 0.3); }
    .dept-civil { background: rgba(6, 182, 212, 0.1); color: #06b6d4; border-color: rgba(6, 182, 212, 0.3); }
    .dept-eee { background: rgba(236, 72, 153, 0.1); color: #ec4899; border-color: rgba(236, 72, 153, 0.3); }
    
    /* Vote Count Badge */
    .vote-badge {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        padding: 8px 16px;
        border-radius: 20px;
        font-size: 14px;
        font-weight: 600;
        background: var(--success-light);
        color: var(--success);
        border: 1px solid rgba(16, 185, 129, 0.3);
    }
    
    .vote-badge i {
        font-size: 12px;
    }
    
    /* View Button */
    .view-btn {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        padding: 10px 20px;
        background: var(--primary);
        color: white;
        border: none;
        border-radius: var(--radius-sm);
        font-weight: 500;
        font-size: 14px;
        cursor: pointer;
        transition: var(--transition);
        text-decoration: none;
    }
    
    .view-btn:hover {
        background: var(--primary-hover);
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(59, 130, 246, 0.3);
    }
    
    .view-btn i {
        font-size: 12px;
    }
    
    /* Footer */
    .footer {
        text-align: center;
        padding: 30px;
        color: var(--text-muted);
        font-size: 14px;
        background: var(--card-bg);
        border-radius: var(--radius);
        box-shadow: var(--shadow);
        margin-top: 30px;
    }
    
    .footer-links {
        display: flex;
        justify-content: center;
        gap: 25px;
        margin-top: 15px;
    }
    
    .footer-links a {
        color: var(--text-secondary);
        text-decoration: none;
        transition: var(--transition);
        display: flex;
        align-items: center;
        gap: 6px;
    }
    
    .footer-links a:hover {
        color: var(--primary);
    }
    
    /* Empty State */
    .empty-state {
        text-align: center;
        padding: 60px 20px;
        color: var(--text-muted);
    }
    
    .empty-state i {
        font-size: 48px;
        margin-bottom: 20px;
        opacity: 0.5;
    }
    
    .empty-state h3 {
        font-size: 20px;
        margin-bottom: 10px;
        color: var(--text-secondary);
    }
    
    /* Responsive Design */
    @media (max-width: 1200px) {
        .header-content {
            flex-direction: column;
            align-items: flex-start;
        }
        
        .stats-grid {
            grid-template-columns: repeat(2, 1fr);
        }
    }
    
    @media (max-width: 768px) {
        body {
            padding: 15px;
        }
        
        .header, .search-section, .table-container {
            padding: 20px;
        }
        
        .stats-grid {
            grid-template-columns: 1fr;
        }
        
        .search-section {
            flex-direction: column;
        }
        
        .search-box {
            max-width: 100%;
        }
        
        .table-header {
            flex-direction: column;
            align-items: flex-start;
        }
        
        .data-table {
            display: block;
            overflow-x: auto;
        }
        
        .footer-links {
            flex-direction: column;
            gap: 15px;
        }
    }
    
    /* Animations */
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
    
    .data-table tbody tr {
        animation: fadeIn 0.5s ease-out;
    }
    
    /* Scrollbar Styling */
    ::-webkit-scrollbar {
        width: 8px;
        height: 8px;
    }
    
    ::-webkit-scrollbar-track {
        background: var(--darker-bg);
        border-radius: 4px;
    }
    
    ::-webkit-scrollbar-thumb {
        background: var(--border-color);
        border-radius: 4px;
    }
    
    ::-webkit-scrollbar-thumb:hover {
        background: var(--primary);
    }
</style>
</head>
<body>
    <div class="container">
        <!-- Back Button -->
        <button class="back-btn" onclick="goBack()">
            <i class="fas fa-arrow-left"></i> Back to Dashboard
        </button>
        
        <!-- Header -->
        <header class="header">
            <div class="header-content">
                <div class="header-text">
                    <h1><i class="fas fa-landmark"></i> Election Commission</h1>
                    <p>Candidate Summary & Vote Analytics - Monitor election results and candidate performance</p>
                </div>
            </div>
        </header>
        
        <!-- Statistics Cards -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-users"></i>
                </div>
                <div class="stat-number" id="totalCandidates">0</div>
                <div class="stat-label">Total Candidates</div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-vote-yea"></i>
                </div>
                <div class="stat-number" id="totalVotes">0</div>
                <div class="stat-label">Total Votes</div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-chart-line"></i>
                </div>
                <div class="stat-number" id="avgVotes">0</div>
                <div class="stat-label">Avg Votes/Candidate</div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-trophy"></i>
                </div>
                <div class="stat-number" id="leadingVotes">0</div>
                <div class="stat-label">Leading Votes</div>
            </div>
        </div>
        
        <!-- Search Section -->
        <div class="search-section">
            <div class="search-box">
                <i class="fas fa-search"></i>
                <input type="text" id="searchInput" placeholder="Search candidates by name, email, department, or roll number...">
                <div class="search-hint">
                    <i class="fas fa-info-circle"></i> You can search by any field in the table
                </div>
            </div>
        </div>
        
        <!-- Table Container -->
        <div class="table-container">
            <div class="table-header">
                <h2><i class="fas fa-chart-bar"></i> Candidate Vote Summary</h2>
                <div class="table-actions">
                    <button class="action-btn" onclick="refreshData()">
                        <i class="fas fa-sync-alt"></i> Refresh Data
                    </button>
                </div>
            </div>
            
            <table class="data-table" id="votesTable">
                <thead>
                    <tr>
                        <th>Candidate Roll Number</th>
                        <th>Candidate Email</th>
                        <th>Department</th>
                        
                        <th>Total Votes</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                <%
                Connection con = null;
                PreparedStatement ps = null;
                ResultSet rs = null;
                int totalCandidates = 0;
                int totalVotesSum = 0;
                int maxVotes = 0;
                boolean hasData = false;
                
                try {
                    con = dbconn.create();
                    ps = con.prepareStatement(
                        "SELECT crollnum, cemail, dept, course, COUNT(*) AS totalVotes " +
                        "FROM studentvoute.votes " +
                        "GROUP BY crollnum, cemail, dept, course"
                    );
                    rs = ps.executeQuery();
                    
                    while (rs.next()) {
                        hasData = true;
                        totalCandidates++;
                        int votes = rs.getInt("totalVotes");
                        totalVotesSum += votes;
                        if (votes > maxVotes) maxVotes = votes;
                        
                        String dept = rs.getString("dept");
                        String deptClass = "dept-cse";
                        if(dept != null) {
                            dept = dept.toLowerCase();
                            if(dept.contains("it")) deptClass = "dept-it";
                            else if(dept.contains("ece") || dept.contains("electronic")) deptClass = "dept-ece";
                            else if(dept.contains("mech")) deptClass = "dept-mech";
                            else if(dept.contains("civil")) deptClass = "dept-civil";
                            else if(dept.contains("eee") || dept.contains("electrical")) deptClass = "dept-eee";
                        }
                        %>
                        <tr class="candidate-row">
                            <td>
                                <strong><i class="fas fa-id-card" style="color: var(--primary); margin-right: 8px;"></i>
                                <%= rs.getString("crollnum") %></strong>
                            </td>
                            <td>
                                <i class="fas fa-envelope" style="margin-right: 8px; color: var(--text-muted);"></i>
                                <%= rs.getString("cemail") %>
                            </td>
                            <td>
                                <span class="dept-tag <%= deptClass %>">
                                    <i class="fas fa-graduation-cap"></i>
                                    <%= rs.getString("dept") %>
                                </span>
                            </td>
                            
                            <td>
                                <span class="vote-badge">
                                    <i class="fas fa-vote-yea"></i>
                                    <strong><%= votes %></strong> votes
                                </span>
                            </td>
                            <td>
                                <form action="candidate_department_votes.jsp" method="get" style="display: inline;">
                                    <input type="hidden" name="cemail" value="<%= rs.getString("cemail") %>">
                                    <button type="submit" class="view-btn">
                                        <i class="fas fa-eye"></i> View Details
                                    </button>
                                </form>
                            </td>
                        </tr>
                <%
                    }
                } catch(Exception e) {
                    e.printStackTrace();
                } finally {
                    if(rs != null) try { rs.close(); } catch(Exception e) {}
                    if(ps != null) try { ps.close(); } catch(Exception e) {}
                    if(con != null) try { con.close(); } catch(Exception e) {}
                }
                %>
                
                <% if(!hasData) { %>
                    <tr>
                        <td colspan="6">
                            <div class="empty-state">
                                <i class="fas fa-chart-pie"></i>
                                <h3>No Election Data Found</h3>
                                <p>No votes have been cast yet. Election results will appear here.</p>
                            </div>
                        </td>
                    </tr>
                <% } %>
                </tbody>
            </table>
        </div>
        
        <!-- Footer -->
        <footer class="footer">
            <p>&copy; <%= new java.text.SimpleDateFormat("yyyy").format(new java.util.Date()) %> Student Voting System | Election Commission Portal</p>
            <div class="footer-links">
                <a href="#"><i class="fas fa-file-export"></i> Export Results</a>
                <a href="#"><i class="fas fa-shield-alt"></i> Audit Log</a>
                <a href="#"><i class="fas fa-headset"></i> Commission Support</a>
            </div>
        </footer>
    </div>

    <script>
        // Initialize statistics
        document.addEventListener('DOMContentLoaded', function() {
            updateStatistics();
            initializeSearch();
        });
        
        function updateStatistics() {
            // Update all statistics
            document.getElementById('totalCandidates').textContent = <%= totalCandidates %>;
            document.getElementById('totalVotes').textContent = <%= totalVotesSum %>;
            
            // Calculate average votes
            const avgVotes = <%= totalCandidates > 0 ? totalVotesSum / totalCandidates : 0 %>;
            document.getElementById('avgVotes').textContent = avgVotes.toFixed(1);
            
            document.getElementById('leadingVotes').textContent = <%= maxVotes %>;
        }
        
        function initializeSearch() {
            const searchInput = document.getElementById('searchInput');
            if(searchInput) {
                searchInput.addEventListener('input', function() {
                    const searchTerm = this.value.toLowerCase();
                    const rows = document.querySelectorAll('.candidate-row');
                    let visibleCount = 0;
                    
                    rows.forEach(row => {
                        const text = row.textContent.toLowerCase();
                        if(text.includes(searchTerm)) {
                            row.style.display = '';
                            visibleCount++;
                        } else {
                            row.style.display = 'none';
                        }
                    });
                    
                    // Show/hide empty state
                    const emptyState = document.querySelector('.empty-state');
                    if (emptyState && emptyState.closest('tr')) {
                        if (visibleCount === 0 && searchTerm !== '') {
                            emptyState.closest('tr').style.display = '';
                            emptyState.innerHTML = `
                                <i class="fas fa-search"></i>
                                <h3>No Results Found</h3>
                                <p>No candidates match your search for "${searchTerm}"</p>
                            `;
                        } else if (visibleCount === 0) {
                            emptyState.closest('tr').style.display = '';
                            emptyState.innerHTML = `
                                <i class="fas fa-chart-pie"></i>
                                <h3>No Election Data Found</h3>
                                <p>No votes have been cast yet. Election results will appear here.</p>
                            `;
                        } else {
                            emptyState.closest('tr').style.display = 'none';
                        }
                    }
                });
            }
            
            // Add row hover effects
            const tableRows = document.querySelectorAll('.candidate-row');
            tableRows.forEach(row => {
                row.addEventListener('mouseenter', function() {
                    this.style.transform = 'scale(1.01)';
                    this.style.boxShadow = '0 10px 25px rgba(0, 0, 0, 0.3)';
                });
                
                row.addEventListener('mouseleave', function() {
                    this.style.transform = 'scale(1)';
                    this.style.boxShadow = 'none';
                });
            });
        }
        
        // Back button function
        function goBack() {
        	window.location.href = 'ecmain.jsp';
        }
        
        // Refresh data function
        function refreshData() {
            const refreshBtn = document.querySelector('.action-btn');
            const originalContent = refreshBtn.innerHTML;
            refreshBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Refreshing...';
            refreshBtn.disabled = true;
            
            setTimeout(() => {
                window.location.reload();
            }, 1000);
        }
        
        // Highlight highest votes
        document.addEventListener('DOMContentLoaded', function() {
            setTimeout(() => {
                const voteBadges = document.querySelectorAll('.vote-badge strong');
                let maxVotes = 0;
                let maxElements = [];
                
                voteBadges.forEach(badge => {
                    const votes = parseInt(badge.textContent);
                    if (votes > maxVotes) {
                        maxVotes = votes;
                        maxElements = [badge];
                    } else if (votes === maxVotes && votes > 0) {
                        maxElements.push(badge);
                    }
                });
                
                // Highlight max votes
                maxElements.forEach(badge => {
                    badge.closest('.vote-badge').style.background = 'rgba(245, 158, 11, 0.2)';
                    badge.closest('.vote-badge').style.borderColor = 'rgba(245, 158, 11, 0.4)';
                    badge.closest('.vote-badge').style.color = 'var(--warning)';
                    badge.closest('.vote-badge').innerHTML = '<i class="fas fa-crown"></i> <strong>' + maxVotes + '</strong> votes (Leading)';
                });
            }, 500);
        });
        
        // Add smooth scrolling
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function(e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if(target) {
                    target.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                }
            });
        });
    </script>
</body>
</html>