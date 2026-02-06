<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="dbcon.dbconn"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <title>Manage Candidates - Election Commission</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --primary: #2c3e50;
            --secondary: #3498db;
            --accent: #e74c3c;
            --success: #2ecc71;
            --warning: #f39c12;
            --light: #ecf0f1;
            --dark: #2c3e50;
            --gradient: linear-gradient(135deg, #1a2a3a, #2c3e50);
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
        
        
        header {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            padding: 20px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 20px rgba(0, 0, 0, 0.1);
        }
        
        .logo {
            display: flex;
            align-items: center;
            font-size: 1.8rem;
            font-weight: 700;
        }
        
        .logo i {
            margin-right: 10px;
            color: var(--light);
        }
        
        .nav-links {
            display: flex;
            list-style: none;
            gap: 15px;
        }
        
        .nav-links a {
            color: white;
            text-decoration: none;
            font-weight: 500;
            padding: 10px 20px;
            border-radius: 50px;
            transition: var(--transition);
            display: flex;
            align-items: center;
            font-size: 0.95rem;
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }
        
        .nav-links a i {
            margin-right: 8px;
        }
        
        .nav-links a:hover {
            background: rgba(255, 255, 255, 0.2);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }
        
        .nav-links a.active {
            background: white;
            color: var(--primary);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }
        
        .badge {
            background: var(--accent);
            color: white;
            border-radius: 50px;
            padding: 2px 8px;
            font-size: 0.8rem;
            margin-left: 8px;
            font-weight: 600;
        }
        
        
        .hero {
            padding: 60px 40px 40px;
            text-align: center;
            max-width: 1200px;
            margin: 0 auto;
        }
        
        .hero h1 {
            font-size: 3rem;
            margin-bottom: 15px;
            font-weight: 700;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2);
        }
        
        .hero p {
            font-size: 1.2rem;
            margin-bottom: 40px;
            max-width: 600px;
            margin-left: auto;
            margin-right: auto;
            opacity: 0.9;
        }
        
       
        .dashboard-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 30px;
            max-width: 1200px;
            margin: 0 auto 60px;
            padding: 0 40px;
        }
        
        .card {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            padding: 30px;
            text-align: center;
            transition: var(--transition);
            border: 1px solid rgba(255, 255, 255, 0.2);
            cursor: pointer;
        }
        
        .card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.2);
            background: rgba(255, 255, 255, 0.15);
        }
        
        .card-icon {
            width: 80px;
            height: 80px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            font-size: 2rem;
            color: white;
        }
        
        .card h3 {
            font-size: 1.5rem;
            margin-bottom: 15px;
            font-weight: 600;
        }
        
        .card p {
            opacity: 0.9;
            line-height: 1.6;
            margin-bottom: 20px;
        }
        
        .count {
            font-size: 3rem;
            font-weight: 700;
            margin: 15px 0;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
        }
        
        .card-apply .card-icon { background: rgba(52, 152, 219, 0.3); }
        .card-nomination .card-icon { background: rgba(46, 204, 113, 0.3); }
        .card-eligible .card-icon { background: rgba(155, 89, 182, 0.3); }
        
        .btn {
            display: inline-block;
            padding: 12px 25px;
            background: rgba(255, 255, 255, 0.2);
            color: white;
            text-decoration: none;
            border-radius: 50px;
            font-weight: 600;
            transition: var(--transition);
            border: 2px solid rgba(255, 255, 255, 0.3);
        }
        
        .btn:hover {
            background: white;
            color: var(--primary);
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
        }
        
        
        .features {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 25px;
            max-width: 1200px;
            margin: 0 auto 80px;
            padding: 0 40px;
        }
        
        .feature {
            background: rgba(255, 255, 255, 0.05);
            border-radius: 15px;
            padding: 25px;
            text-align: center;
            border: 1px solid rgba(255, 255, 255, 0.1);
        }
        
        .feature i {
            font-size: 2.5rem;
            margin-bottom: 15px;
            color: var(--secondary);
        }
        
        .feature h4 {
            font-size: 1.2rem;
            margin-bottom: 10px;
            font-weight: 600;
        }
        
        .feature p {
            opacity: 0.8;
            font-size: 0.9rem;
            line-height: 1.5;
        }
        
       
        footer {
            background: rgba(0, 0, 0, 0.2);
            padding: 30px 40px;
            text-align: center;
            margin-top: 60px;
        }
        
        .footer-content {
            max-width: 1200px;
            margin: 0 auto;
        }
        
        .footer-content p {
            opacity: 0.7;
            margin-bottom: 15px;
        }
        
        .security-badge {
            display: inline-flex;
            align-items: center;
            background: rgba(46, 204, 113, 0.1);
            padding: 8px 20px;
            border-radius: 50px;
        }
        
        .security-badge i {
            margin-right: 8px;
            color: var(--success);
        }
        
       
        @media (max-width: 768px) {
            header {
                padding: 15px 20px;
                flex-direction: column;
                gap: 15px;
            }
            
            .nav-links {
                flex-wrap: wrap;
                justify-content: center;
            }
            
            .nav-links a {
                font-size: 0.85rem;
                padding: 8px 15px;
            }
            
            .hero {
                padding: 40px 20px 20px;
            }
            
            .hero h1 {
                font-size: 2.2rem;
            }
            
            .dashboard-cards, .features {
                padding: 0 20px;
                grid-template-columns: 1fr;
            }
        }
        
        @media (max-width: 480px) {
            .hero h1 {
                font-size: 1.8rem;
            }
            
            .hero p {
                font-size: 1rem;
            }
            
            .count {
                font-size: 2.5rem;
            }
        }
    </style>
</head>



<body>
   
    <header>
        <div class="logo">
            <i class="fas fa-landmark"></i>
            <span>Election Commission</span>
        </div>
        
        <ul class="nav-links">
            <li><a href="#" class="active"><i class="fas fa-home"></i> HOME</a></li>
           	<li><a href="canapplicationview.jsp"><i class="fas fa-file-alt"></i> View Applications <span class="badge"></span></a></li>
            <li><a href="Nominationview.jsp"><i class="fas fa-check-circle"></i> Nomination <span class="badge"></span></a></li>
            <li><a href="appointview.jsp"><i class="fas fa-user-check"></i> Eligible <span class="badge"></span></a></li>
            <li><a href="ecmain.jsp"><i class="fas fa-arrow-left"></i> BACK</a></li>
        </ul>
    </header>

   
    <section class="hero">
        <h1>Candidate Management Portal</h1>
        <p>Manage candidate applications, nominations, and eligibility status with comprehensive administrative tools</p>
    </section>

   
    <section class="dashboard-cards">
       <a href="canapplicationview.jsp" class="card card-apply">
            <div class="card-icon">
                <i class="fas fa-file-alt"></i>
            </div>
            <h3>Candidate Applications</h3>
            <p>Review and process new candidate registration applications</p>
           
            <span class="btn">Manage Applications</span>
        </a>
        
        <a href="Nominationview.jsp" class="card card-nomination">
            <div class="card-icon">
                <i class="fas fa-check-circle"></i>
            </div>
            <h3>Nomination Status</h3>
            <p>Monitor and manage candidate nomination approvals</p>
         <span class="btn">View Nominations</span>
        </a>
        
        <a href="appointview.jsp" class="card card-eligible">
            <div class="card-icon">
                <i class="fas fa-user-check"></i>
            </div>
            <h3>Eligible Candidates</h3>
            <p>Final list of approved and eligible candidates for elections</p>
            
           <span class="btn">Check Eligibility</span>
        </a>
    </section>

    
    <section class="features">
        <div class="feature">
            <i class="fas fa-shield-alt"></i>
            <h4>Secure Verification</h4>
            <p>Advanced security protocols for candidate verification and data protection</p>
        </div>
        
        <div class="feature">
            <i class="fas fa-clock"></i>
            <h4>Real-time Updates</h4>
            <p>Live status tracking and instant updates for all candidate applications</p>
        </div>
        
        <div class="feature">
            <i class="fas fa-chart-bar"></i>
            <h4>Analytics Dashboard</h4>
            <p>Comprehensive reporting and analytics for election management</p>
        </div>
        
        <div class="feature">
            <i class="fas fa-users-cog"></i>
            <h4>Bulk Operations</h4>
            <p>Efficient management tools for handling multiple candidates simultaneously</p>
        </div>
    </section>

    
    <footer>
        <div class="footer-content">
            <p>Election Commission Candidate Management System &copy; 2025</p>
            <div class="security-badge">
                <i class="fas fa-shield-check"></i>
                <span>Secure Government Portal</span>
            </div>
        </div>
    </footer>

    <script>
       
        document.querySelectorAll('.card').forEach(card => {
            card.addEventListener('mouseenter', function() {
                this.style.transform = 'translateY(-10px)';
            });
            
            card.addEventListener('mouseleave', function() {
                this.style.transform = 'translateY(0)';
            });
        });

        
        function animateCount(element, target) {
            let current = 0;
            const increment = target / 30;
            const timer = setInterval(() => {
                current += increment;
                if (current >= target) {
                    element.textContent = target;
                    clearInterval(timer);
                } else {
                    element.textContent = Math.floor(current);
                }
            }, 50);
        }

        
        document.addEventListener('DOMContentLoaded', function() {
            const counts = document.querySelectorAll('.count');
            counts.forEach(count => {
                const target = parseInt(count.textContent);
                animateCount(count, target);
            });
        });
    </script>
</body>
</html>