<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Secure Online Voting System</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #2c3e50;
            --secondary: #3498db;
            --accent: #e74c3c;
            --light: #ecf0f1;
            --dark: #2c3e50;
            --success: #2ecc71;
            --warning: #f39c12;
            --gradient: linear-gradient(135deg, #3498db, #2c3e50);
            --shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            --transition: all 0.3s ease;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            line-height: 1.6;
            color: var(--dark);
            background-color: #f9f9f9;
        }

        
        header {
            background: var(--gradient);
            color: white;
            padding: 1rem 0;
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 1000;
            box-shadow: var(--shadow);
        }

        .container {
            width: 90%;
            max-width: 1200px;
            margin: 0 auto;
        }

        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            font-size: 1.8rem;
            font-weight: 700;
            display: flex;
            align-items: center;
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
            margin-left: 2rem;
        }

        .nav-links a {
            color: white;
            text-decoration: none;
            font-weight: 500;
            transition: var(--transition);
            padding: 0.5rem 0;
            position: relative;
        }

        .nav-links a:after {
            content: '';
            position: absolute;
            width: 0;
            height: 2px;
            bottom: 0;
            left: 0;
            background-color: white;
            transition: var(--transition);
        }

        .nav-links a:hover:after {
            width: 100%;
        }

        .mobile-menu {
            display: none;
            font-size: 1.5rem;
            cursor: pointer;
        }

       
        .hero {
            background: var(--gradient);
            color: white;
            padding: 10rem 0 6rem;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .hero:before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxMDAlIiBoZWlnaHQ9IjEwMCUiPjxkZWZzPjxwYXR0ZXJuIGlkPSJwYXR0ZXJuIiB3aWR0aD0iNDAiIGhlaWdodD0iNDAiIHBhdHRlcm5Vbml0cz0idXNlclNwYWNlT25Vc2UiIHBhdHRlcm5UcmFuc2Zvcm09InJvdGF0ZSg0NSkiPjxyZWN0IHdpZHRoPSIyMCIgaGVpZ2h0PSIyMCIgZmlsbD0icmdiYSgyNTUsMjU1LDI1NSwwLjA1KSIvPjwvcGF0dGVybj48L2RlZnM+PHJlY3QgZmlsbD0idXJsKCNwYXR0ZXJuKSIgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSIvPjwvc3ZnPg==');
        }

        .hero-content {
            position: relative;
            z-index: 1;
            max-width: 800px;
            margin: 0 auto;
        }

        .hero h1 {
            font-size: 3.5rem;
            margin-bottom: 1.5rem;
            font-weight: 700;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2);
        }

        .hero p {
            font-size: 1.2rem;
            margin-bottom: 2.5rem;
            opacity: 0.9;
        }

        .user-options {
            display: flex;
            justify-content: center;
            gap: 2rem;
            flex-wrap: wrap;
        }

        .option-card {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-radius: 10px;
            padding: 2rem;
            width: 280px;
            text-align: center;
            transition: var(--transition);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .option-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.2);
        }

        .option-icon {
            font-size: 3rem;
            margin-bottom: 1rem;
            color: var(--light);
        }

        .option-card h3 {
            font-size: 1.5rem;
            margin-bottom: 1rem;
        }

        .option-card p {
            font-size: 0.9rem;
            margin-bottom: 1.5rem;
            opacity: 0.8;
        }

        .btn {
            display: inline-block;
            background: white;
            color: var(--primary);
            padding: 0.8rem 1.5rem;
            border-radius: 50px;
            text-decoration: none;
            font-weight: 600;
            transition: var(--transition);
            border: none;
            cursor: pointer;
            box-shadow: var(--shadow);
        }

        .btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 7px 15px rgba(0, 0, 0, 0.2);
        }

        .btn-primary {
            background: var(--accent);
            color: white;
        }

        
        .features {
            padding: 6rem 0;
            background: white;
        }

        .section-title {
            text-align: center;
            margin-bottom: 3rem;
        }

        .section-title h2 {
            font-size: 2.5rem;
            color: var(--primary);
            margin-bottom: 1rem;
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

        .section-title p {
            color: #666;
            max-width: 600px;
            margin: 0 auto;
        }

        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
        }

        .feature-card {
            background: white;
            border-radius: 10px;
            padding: 2rem;
            box-shadow: var(--shadow);
            transition: var(--transition);
            text-align: center;
            border-top: 4px solid var(--secondary);
        }

        .feature-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
        }

        .feature-icon {
            font-size: 2.5rem;
            color: var(--secondary);
            margin-bottom: 1.5rem;
        }

        .feature-card h3 {
            font-size: 1.3rem;
            margin-bottom: 1rem;
            color: var(--primary);
        }

        .feature-card p {
            color: #666;
        }

        
        .security {
            padding: 6rem 0;
            background: var(--light);
        }

        .security-content {
            display: flex;
            align-items: center;
            gap: 4rem;
        }

        .security-text {
            flex: 1;
        }

        .security-image {
            flex: 1;
            text-align: center;
        }

        .security-image img {
            max-width: 100%;
            border-radius: 10px;
            box-shadow: var(--shadow);
        }

        .security-list {
            list-style: none;
            margin: 2rem 0;
        }

        .security-list li {
            margin-bottom: 1rem;
            display: flex;
            align-items: flex-start;
        }

        .security-list i {
            color: var(--success);
            margin-right: 10px;
            margin-top: 5px;
        }

        
        footer {
            background: var(--primary);
            color: white;
            padding: 4rem 0 2rem;
        }

        .footer-content {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
            margin-bottom: 3rem;
        }

        .footer-column h3 {
            font-size: 1.3rem;
            margin-bottom: 1.5rem;
            position: relative;
            padding-bottom: 10px;
        }

        .footer-column h3:after {
            content: '';
            position: absolute;
            width: 40px;
            height: 3px;
            background: var(--secondary);
            bottom: 0;
            left: 0;
        }

        .footer-links {
            list-style: none;
        }

        .footer-links li {
            margin-bottom: 0.8rem;
        }

        .footer-links a {
            color: #bbb;
            text-decoration: none;
            transition: var(--transition);
        }

        .footer-links a:hover {
            color: white;
            padding-left: 5px;
        }

        .social-links {
            display: flex;
            gap: 1rem;
            margin-top: 1.5rem;
        }

        .social-links a {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 40px;
            height: 40px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
            color: white;
            transition: var(--transition);
        }

        .social-links a:hover {
            background: var(--secondary);
            transform: translateY(-3px);
        }

        .copyright {
            text-align: center;
            padding-top: 2rem;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            color: #bbb;
            font-size: 0.9rem;
        }

        
        @media (max-width: 992px) {
            .hero h1 {
                font-size: 2.8rem;
            }
            
            .security-content {
                flex-direction: column;
            }
        }

        @media (max-width: 768px) {
            .nav-links {
                display: none;
                position: absolute;
                top: 100%;
                left: 0;
                width: 100%;
                background: var(--primary);
                flex-direction: column;
                padding: 1rem 0;
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
                display: block;
                padding: 1rem;
            }

            .mobile-menu {
                display: block;
            }

            .hero h1 {
                font-size: 2.2rem;
            }

            .user-options {
                flex-direction: column;
                align-items: center;
            }
        }

        @media (max-width: 576px) {
            .hero {
                padding: 8rem 0 4rem;
            }
            
            .hero h1 {
                font-size: 1.8rem;
            }
            
            .option-card {
                width: 100%;
                max-width: 300px;
            }
        }
    </style>
</head>
<body>
   
    <header>
        <div class="container">
            <nav class="navbar">
                <div class="logo">
                    <i class="fas fa-vote-yea"></i>
                    <span>SecureVote</span>
                </div>
                <ul class="nav-links">
                    <li><a href="#home">Home</a></li>
                    <li><a href="#features">Features</a></li>
                    <li><a href="#security">Security</a></li>
                    <li><a href="#about">About</a></li>
                    <li><a href="#contact">Contact</a></li>
                </ul>
                <div class="mobile-menu">
                    <i class="fas fa-bars"></i>
                </div>
            </nav>
        </div>
    </header>

   
    <section class="hero" id="home">
        <div class="container">
            <div class="hero-content">
                <h1>Secure Online Voting System</h1>
                <p>Cast your vote securely from anywhere with our state-of-the-art digital voting platform. Ensuring transparency, security, and accessibility for all.</p>
                
                <div class="user-options">
                    <div class="option-card">
                        <div class="option-icon">
                            <i class="fas fa-user-check"></i>
                        </div>
                        <h3>Student</h3>
                        <p>Access the voting portal to cast your ballot securely and conveniently.</p>
                        <a href="voterlogin.jsp" class="btn btn-primary">Voter Login</a>
                    </div>
                    
                    <div class="option-card">
                        <div class="option-icon">
                            <i class="fas fa-landmark"></i>
                        </div>
                        <h3>College  Management</h3>
                        <p>Manage elections, monitor results, and ensure electoral integrity.</p>
                        <a href="eclogin.jsp" class="btn btn-primary">EC Login</a>
                    </div>
                    
                    <div class="option-card">
                        <div class="option-icon">
                            <i class="fas fa-user-tie"></i>
                        </div>
                        <h3>Candidate</h3>
                        <p>Register as a candidate and track your election performance.</p>
                        <a href="candidatelog.jsp" class="btn btn-primary">Candidate Login</a>
                    </div>
                </div>
            </div>
        </div>
    </section>

   
    <section class="features" id="features">
        <div class="container">
            <div class="section-title">
                <h2>Key Features</h2>
                <p>Our platform offers a comprehensive set of features designed to make voting secure, accessible, and efficient.</p>
            </div>
            
            <div class="features-grid">
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-shield-alt"></i>
                    </div>
                    <h3>Advanced Security</h3>
                    <p>End-to-end encryption and multi-factor authentication ensure your vote remains secure and anonymous.</p>
                </div>
                
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-mobile-alt"></i>
                    </div>
                    <h3>Blockchain Technology</h3>
                    <p>Votes are securely stored in Ethereum Blockchain for the voting records are immutable ledger.</p>
                </div>
                
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-chart-bar"></i>
                    </div>
                    <h3>Real-time Results</h3>
                    <p>View election results in real-time with our advanced analytics and visualization tools.</p>
                </div>
                
               
            </div>
        </div>
    </section>


    <section class="security" id="security">
        <div class="container">
            <div class="section-title">
                <h2>Security & Integrity</h2>
                <p>We employ multiple layers of security to protect the integrity of every vote.</p>
            </div>
            
            <div class="security-content">
                <div class="security-text">
                    <h3>Protecting Democratic Processes</h3>
                    <p>Our online voting system is built with security as the foundation. We understand the critical importance of protecting the democratic process and ensuring that every vote is counted accurately and securely.</p>
                    
                    <ul class="security-list">
                        <li>
                            <i class="fas fa-check-circle"></i>
                            <div>
                                <strong>End-to-End Encryption</strong>
                                <p>All votes are encrypted from the moment they are cast until they are counted.</p>
                            </div>
                        </li>
                        <li>
                            <i class="fas fa-check-circle"></i>
                            <div>
                                <strong>Blockchain Technology</strong>
                                <p>Utilizing distributed ledger technology to create an immutable record of all votes.</p>
                            </div>
                        </li>
                        <li>
                            <i class="fas fa-check-circle"></i>
                            <div>
                                <strong>Multi-Factor Authentication</strong>
                                <p>Multiple verification steps to ensure only eligible voters can participate.</p>
                            </div>
                        </li>
                        <li>
                            <i class="fas fa-check-circle"></i>
                            <div>
                                <strong>Anonymous Voting</strong>
                                <p>Votes are completely anonymous and cannot be traced back to individual voters.</p>
                            </div>
                        </li>
                    </ul>
                    
                    <a href="#" class="btn btn-primary">Learn More About Security</a>
                </div>
                
                <div class="security-image">
                    <!-- Placeholder for security illustration -->
                    <div style="background: var(--gradient); height: 300px; border-radius: 10px; display: flex; align-items: center; justify-content: center; color: white; font-size: 1.2rem;">
                        <i class="fas fa-lock" style="font-size: 4rem; margin-right: 1rem;"></i>
                        <div>
                            <h3>Secure Voting</h3>
                            <p>Advanced encryption technology</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

   
    <footer id="contact">
        <div class="container">
            <div class="footer-content">
                <div class="footer-column">
                    <h3>SecureVote</h3>
                    <p>Providing secure, transparent, and accessible online voting solutions for modern democracies.</p>
                    <div class="social-links">
                        <a href="#"><i class="fab fa-facebook-f"></i></a>
                        <a href="#"><i class="fab fa-twitter"></i></a>
                        <a href="#"><i class="fab fa-linkedin-in"></i></a>
                        <a href="#"><i class="fab fa-instagram"></i></a>
                    </div>
                </div>
                
                <div class="footer-column">
                    <h3>Quick Links</h3>
                    <ul class="footer-links">
                        <li><a href="#home">Home</a></li>
                        <li><a href="#features">Features</a></li>
                        <li><a href="#security">Security</a></li>
                        <li><a href="#about">About Us</a></li>
                        <li><a href="#contact">Contact</a></li>
                    </ul>
                </div>
                
                <div class="footer-column">
                    <h3>User Portals</h3>
                    <ul class="footer-links">
                        <li><a href="voterlogin.jsp">Voter Login</a></li>
                        <li><a href="eclogin.jsp">Election Commission</a></li>
                        <li><a href="candidatelog.jsp">Candidate Portal</a></li>
                        <li><a href="#">Voter Registration</a></li>
                        <li><a href="#">Election Results</a></li>
                    </ul>
                </div>
                
                <div class="footer-column">
                    <h3>Contact Us</h3>
                    <ul class="footer-links">
                        <li><i class="fas fa-map-marker-alt"></i> India</li>
                        <li><i class="fas fa-phone"></i> +91 1234567890</li>
                        <li><i class="fas fa-envelope"></i> india@securevote.com</li>
                    </ul>
                </div>
            </div>
            
            <div class="copyright">
                <p>&copy; 2025 SecureVote Online Voting System. All rights reserved.</p>
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

        
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function(e) {
                e.preventDefault();
                
                const targetId = this.getAttribute('href');
                if(targetId === '#') return;
                
                const targetElement = document.querySelector(targetId);
                if(targetElement) {
                    window.scrollTo({
                        top: targetElement.offsetTop - 80,
                        behavior: 'smooth'
                    });
                }
            });
        });
    </script>
</body>
</html>