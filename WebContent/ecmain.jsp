<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Election Commission Portal - Secure Election Management</title>
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
        
        .security-badge {
            display: inline-flex;
            align-items: center;
            background: rgba(46, 204, 113, 0.1);
            padding: 10px 20px;
            border-radius: 50px;
            margin-top: 15px;
        }
        
        .security-badge i {
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
            <i class="fas fa-landmark"></i>
            <span>Election Commission</span>
        </div>
        
        <div class="mobile-menu">
            <i class="fas fa-bars"></i>
        </div>
        
        <ul class="nav-links">
            <li><a href="index.jsp" class="selected"><i class="fas fa-home"></i> Home</a></li>
            <li><a href="candidates.jsp"><i class="fas fa-user-tie"></i> Candidates</a></li>
            <li><a href="Voters.jsp"><i class="fas fa-users"></i> Voters</a></li>
            <li><a href="allcandidatereg.jsp"><i class="fas fa-list"></i> Candidate List</a></li>      
            <li><a href="ecvote.jsp"><i class="fas fa-chart-bar"></i> Vote Count</a></li>
            <li><a href="eclogin.jsp"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
        </ul>
    </header>
    <section class="hero">
        <h1>Election Commission Portal</h1>
        <p>Secure platform for managing elections, monitoring voter registration, and ensuring electoral integrity with advanced administrative tools.</p>
        
        <div class="cta-buttons">
            <a href="#" class="btn btn-primary">
                <i class="fas fa-chart-bar"></i> View Live Results
            </a>
            <a href="candidates.jsp" class="btn btn-secondary">
                <i class="fas fa-user-tie"></i> Manage Candidates
            </a>
        </div>
    </section>

   
    <section class="features">
        <div class="feature-card">
            <div class="feature-icon">
                <i class="fas fa-shield-alt"></i>
            </div>
            <h3>Secure Platform</h3>
            <p>Advanced encryption and multi-layer security protocols to protect election data and ensure integrity.</p>
        </div>
        
        <div class="feature-card">
            <div class="feature-icon">
                <i class="fas fa-chart-line"></i>
            </div>
            <h3>Real-time Analytics</h3>
            <p>Live monitoring of voter turnout, candidate performance, and election statistics with detailed reporting.</p>
        </div>
        
        <div class="feature-card">
            <div class="feature-icon">
                <i class="fas fa-users-cog"></i>
            </div>
            <h3>Voter Management</h3>
            <p>Comprehensive voter registration system with verification and database management capabilities.</p>
        </div>
    </section>

    

  
    <section class="quick-actions">
        <div class="section-title">
            <h2>Quick Actions</h2>
            <p>Access frequently used administrative functions</p>
        </div>
        
        <div class="action-grid">
            <a href="candidates.jsp" class="action-card">
                <i class="fas fa-user-plus"></i>
                <h3>Add Candidate</h3>
                <p>Register new candidates for upcoming elections</p>
            </a>
            
            <a href="#" class="action-card">
                <i class="fas fa-user-check"></i>
                <h3>Verify Voters</h3>
                <p>Review and verify voter registration applications</p>
            </a>
            
            <a href="#" class="action-card">
                <i class="fas fa-poll"></i>
                <h3>View Results</h3>
                <p>Monitor real-time election results and statistics</p>
            </a>
            
            <a href="#" class="action-card">
                <i class="fas fa-list-ol"></i>
                <h3>Candidate List</h3>
                <p>Manage and update candidate information</p>
            </a>
        </div>
    </section>

    
    <footer>
        <div class="footer-content">
            <p>Official Election Commission Portal &copy; 2025. All rights reserved.</p>
            <div class="security-badge">
                <i class="fas fa-shield-check"></i>
                <span>Secure Government Portal</span>
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
                const target = parseInt(stat.textContent);
                let current = 0;
                const increment = target / 50;
                const timer = setInterval(() => {
                    current += increment;
                    if (current >= target) {
                        stat.textContent = target + (stat.textContent.includes('+') ? '+' : '');
                        clearInterval(timer);
                    } else {
                        stat.textContent = Math.floor(current) + (stat.textContent.includes('+') ? '+' : '');
                    }
                }, 30);
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