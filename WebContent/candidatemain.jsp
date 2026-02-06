<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="dbcon.dbconn"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<%
    String loginSuccess = (String) session.getAttribute("loginSuccess");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Candidate Portal - Election Campaign</title>
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
        
       
        header {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            padding: 20px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 20px rgba(0, 0, 0, 0.1);
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 1000;
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
        }
        
        .nav-links li {
            margin-left: 25px;
        }
        
        .nav-links a {
            color: white;
            text-decoration: none;
            font-weight: 500;
            padding: 8px 16px;
            border-radius: 50px;
            transition: var(--transition);
            display: flex;
            align-items: center;
            font-size: 0.95rem;
        }
        
        .nav-links a i {
            margin-right: 8px;
        }
        
        .nav-links a:hover {
            background: rgba(255, 255, 255, 0.2);
            transform: translateY(-2px);
        }
        
        .nav-links a.selected {
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
        
        .mobile-menu {
            display: none;
            font-size: 1.5rem;
            cursor: pointer;
        }
        
        
        .hero {
            padding: 180px 40px 100px;
            text-align: center;
            max-width: 1200px;
            margin: 0 auto;
        }
        
        .hero h1 {
            font-size: 3.5rem;
            margin-bottom: 20px;
            font-weight: 700;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2);
            animation: fadeInUp 1s ease-out;
        }
        
        .hero p {
            font-size: 1.3rem;
            margin-bottom: 40px;
            max-width: 700px;
            margin-left: auto;
            margin-right: auto;
            opacity: 0.9;
            animation: fadeInUp 1s ease-out 0.2s both;
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
        
        .cta-buttons {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-bottom: 60px;
            animation: fadeInUp 1s ease-out 0.4s both;
        }
        
        .btn {
            padding: 15px 30px;
            border-radius: 50px;
            text-decoration: none;
            font-weight: 600;
            font-size: 1.1rem;
            transition: var(--transition);
            display: flex;
            align-items: center;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }
        
        .btn-primary {
            background: white;
            color: var(--primary);
        }
        
        .btn-primary:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.3);
        }
        
        .btn-secondary {
            background: rgba(255, 255, 255, 0.2);
            color: white;
            border: 2px solid white;
        }
        
        .btn-secondary:hover {
            background: white;
            color: var(--primary);
            transform: translateY(-5px);
        }
        
        .btn i {
            margin-right: 10px;
        }
        
        
        .features {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 30px;
            max-width: 1200px;
            margin: 0 auto 80px;
            padding: 0 40px;
        }
        
        .feature-card {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            padding: 30px;
            text-align: center;
            transition: var(--transition);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }
        
        .feature-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.2);
        }
        
        .feature-icon {
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
        
        .feature-card h3 {
            font-size: 1.5rem;
            margin-bottom: 15px;
        }
        
        .feature-card p {
            opacity: 0.9;
            line-height: 1.6;
        }
        
       
        .quick-actions {
            max-width: 1200px;
            margin: 0 auto 80px;
            padding: 0 40px;
        }
        
        .section-title {
            text-align: center;
            margin-bottom: 40px;
        }
        
        .section-title h2 {
            font-size: 2.5rem;
            margin-bottom: 15px;
            position: relative;
            display: inline-block;
        }
        
        .section-title h2:after {
            content: '';
            position: absolute;
            width: 70px;
            height: 4px;
            background: var(--secondary);
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            border-radius: 2px;
        }
        
        .action-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 25px;
        }
        
        .action-card {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            padding: 25px;
            text-align: center;
            transition: var(--transition);
            border: 1px solid rgba(255, 255, 255, 0.2);
            cursor: pointer;
            text-decoration: none;
            color: white;
        }
        
        .action-card:hover {
            transform: translateY(-5px);
            background: rgba(255, 255, 255, 0.15);
        }
        
        .action-card i {
            font-size: 2.5rem;
            margin-bottom: 15px;
            color: var(--secondary);
        }
        
        .action-card h3 {
            font-size: 1.3rem;
            margin-bottom: 10px;
        }
        
        .action-card p {
            opacity: 0.9;
            font-size: 0.9rem;
        }
        
        
        .stats {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            margin: 0 40px 80px;
            border-radius: 15px;
            padding: 50px 30px;
            display: flex;
            justify-content: space-around;
            text-align: center;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }
        
        .stat-item h2 {
            font-size: 3rem;
            margin-bottom: 10px;
            font-weight: 700;
        }
        
        .stat-item p {
            font-size: 1.1rem;
            opacity: 0.9;
        }
        
        
        footer {
            background: rgba(0, 0, 0, 0.2);
            padding: 40px;
            text-align: center;
            margin-top: 60px;
        }
        
        .footer-content {
            max-width: 1200px;
            margin: 0 auto;
        }
        
        .footer-content p {
            opacity: 0.7;
            margin-bottom: 20px;
        }
        
        .campaign-badge {
            display: inline-flex;
            align-items: center;
            background: rgba(46, 204, 113, 0.1);
            padding: 10px 20px;
            border-radius: 50px;
            margin-top: 15px;
        }
        
        .campaign-badge i {
            margin-right: 8px;
            color: var(--success);
        }
        
        
        @media (max-width: 992px) {
            .hero h1 {
                font-size: 2.8rem;
            }
            
            .stats {
                flex-direction: column;
                gap: 30px;
            }
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
        
        
        @media (max-width: 768px) {
            header {
                padding: 15px 20px;
            }
            
            .nav-links {
                display: none;
                position: absolute;
                top: 100%;
                left: 0;
                width: 100%;
                background: rgba(44, 62, 80, 0.95);
                backdrop-filter: blur(10px);
                flex-direction: column;
                padding: 20px 0;
                box-shadow: 0 5px 10px rgba(0, 0, 0, 0.1);
            }
            
            .nav-links.active {
                display: flex;
            }
            
            .nav-links li {
                margin: 0;
                text-align: center;
            }
            
            .nav-links a {
                padding: 15px;
                justify-content: center;
            }
            
            .mobile-menu {
                display: block;
            }
            
            .hero {
                padding: 150px 20px 80px;
            }
            
            .hero h1 {
                font-size: 2.2rem;
            }
            
            .cta-buttons {
                flex-direction: column;
                align-items: center;
            }
            
            .btn {
                width: 100%;
                max-width: 300px;
                justify-content: center;
            }
            
            .features, .quick-actions {
                padding: 0 20px;
            }
            
            .stats {
                margin: 0 20px 60px;
            }
        }
        
        @media (max-width: 576px) {
            .hero h1 {
                font-size: 1.8rem;
            }
            
            .hero p {
                font-size: 1.1rem;
            }
        }
    </style>
</head>



<body>
   
   
    <header>
        <div class="logo">
            <i class="fas fa-user-tie"></i>
            <span>Candidate Portal</span>
        </div>
        
        <div class="mobile-menu">
            <i class="fas fa-bars"></i>
        </div>
        
        <ul class="nav-links">
            <li><a href="index.jsp" class="selected"><i class="fas fa-home"></i> Home</a></li>
            <li><a href="candiateapply.jsp"><i class="fas fa-file-alt"></i> Application </a></li>
            <li><a href="approval.jsp"><i class="fas fa-check-circle"></i> Accepted</a></li>
            <li><a href="vcount.jsp"><i class="fas fa-chart-bar"></i> Vote Count</a></li>
            <li><a href="candidatelog.jsp"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
        </ul>
    </header>

   <% if (loginSuccess != null) { %>
    <div class="success-message">
        <i class="fas fa-check-circle"></i>
        <%= loginSuccess %>
    </div>
<%
    session.removeAttribute("loginSuccess"); // IMPORTANT
} %>
    <section class="hero">
        <h1>Welcome to Your Campaign Hub</h1>
        <p>Manage your election campaign, track your progress, and connect with voters through our comprehensive candidate platform.</p>
        
        <div class="cta-buttons">
            <a href="candiateapply.jsp" class="btn btn-primary">
                <i class="fas fa-file-alt"></i> View Applications
            </a>
            <a href="vcount.jsp" class="btn btn-secondary">
                <i class="fas fa-chart-line"></i> Check Vote Count
            </a>
        </div>
    </section>

    
    <section class="features">
        <div class="feature-card">
            <div class="feature-icon">
                <i class="fas fa-bullhorn"></i>
            </div>
            <h3>Campaign Management</h3>
            <p>Access powerful tools to manage your election campaign, schedule events, and track voter engagement.</p>
        </div>
        
        <div class="feature-card">
            <div class="feature-icon">
                <i class="fas fa-chart-pie"></i>
            </div>
            <h3>Real-time Analytics</h3>
            <p>Monitor your campaign performance with detailed analytics and voter sentiment tracking.</p>
        </div>
        
        <div class="feature-card">
            <div class="feature-icon">
                <i class="fas fa-users"></i>
            </div>
            <h3>Voter Outreach</h3>
            <p>Connect directly with voters and build meaningful relationships through our engagement platform.</p>
        </div>
    </section>

    
    <section class="quick-actions">
        <div class="section-title">
            <h2>Quick Actions</h2>
            <p>Access frequently used campaign management tools</p>
        </div>
        
        <div class="action-grid">
            <a href="candiateapply.jsp" class="action-card">
                <i class="fas fa-file-contract"></i>
                <h3>Application Status</h3>
                <p>Check and manage your candidate application status and updates</p>
            </a>
            
            <a href="#" class="action-card">
                <i class="fas fa-check-double"></i>
                <h3>Approval Status</h3>
                <p>View your approval status and election commission verification</p>
            </a>
            
            <a href="#" class="action-card">
                <i class="fas fa-poll"></i>
                <h3>Vote Analytics</h3>
                <p>Monitor real-time vote counts and constituency performance</p>
            </a>
            
            <a href="#" class="action-card">
                <i class="fas fa-calendar-alt"></i>
                <h3>Campaign Calendar</h3>
                <p>Schedule and manage your election campaign events</p>
            </a>
        </div>
    </section>

   

    
    <footer>
        <div class="footer-content">
            <p>Candidate Election Portal &copy; 2025. Empowering democratic participation.</p>
            <div class="campaign-badge">
                <i class="fas fa-shield-check"></i>
                <span>Official Campaign Platform</span>
            </div>
        </div>
    </footer>

    <script>
        
        document.querySelector('.mobile-menu').addEventListener('click', function() {
            document.querySelector('.nav-links').classList.toggle('active');
        });

       
        document.querySelectorAll('.nav-links a').forEach(link => {
            link.addEventListener('click', () => {
                document.querySelector('.nav-links').classList.remove('active');
            });
        });

        
        window.addEventListener('scroll', function() {
            const header = document.querySelector('header');
            if (window.scrollY > 100) {
                header.style.background = 'rgba(44, 62, 80, 0.95)';
            } else {
                header.style.background = 'rgba(255, 255, 255, 0.1)';
            }
        });

    
        function animateStats() {
            const statItems = document.querySelectorAll('.stat-item h2');
            statItems.forEach(stat => {
                const target = stat.textContent;
                if (!isNaN(target)) {
                    let current = 0;
                    const increment = parseInt(target) / 50;
                    const timer = setInterval(() => {
                        current += increment;
                        if (current >= parseInt(target)) {
                            stat.textContent = target;
                            clearInterval(timer);
                        } else {
                            stat.textContent = Math.floor(current);
                        }
                    }, 30);
                }
            });
        }

        
        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    animateStats();
                    observer.unobserve(entry.target);
                }
            });
        });

        observer.observe(document.querySelector('.stats'));
    </script>
</body>
</html>