<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <title>Schedule Election | Student Voting System</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-blue: #4361ee;
            --primary-dark: #3a56d4;
            --secondary-purple: #7209b7;
            --accent-teal: #4cc9f0;
            --success: #06d6a0;
            --warning: #ffd166;
            --danger: #ef476f;
            --dark: #1a1a2e;
            --dark-card: #16213e;
            --light: #f8f9fa;
            --gray: #6c757d;
            --light-gray: #e9ecef;
            --shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            --shadow-lg: 0 20px 50px rgba(0, 0, 0, 0.15);
            --radius: 16px;
            --radius-sm: 10px;
            --transition: all 0.3s ease;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: var(--dark);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: var(--radius);
            box-shadow: var(--shadow-lg);
            width: 100%;
            max-width: 480px;
            padding: 40px;
            position: relative;
            overflow: hidden;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 5px;
            background: linear-gradient(to right, var(--primary-blue), var(--secondary-purple));
        }

        .header {
            text-align: center;
            margin-bottom: 35px;
        }

        .header-icon {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, var(--primary-blue), var(--secondary-purple));
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            box-shadow: 0 10px 20px rgba(67, 97, 238, 0.3);
        }

        .header-icon i {
            font-size: 36px;
            color: white;
        }

        .header h2 {
            font-size: 28px;
            font-weight: 700;
            background: linear-gradient(to right, var(--primary-blue), var(--secondary-purple));
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            margin-bottom: 10px;
        }

        .header p {
            color: var(--gray);
            font-size: 15px;
        }

        .form-group {
            margin-bottom: 25px;
        }

        label {
            display: block;
            margin-bottom: 10px;
            font-weight: 600;
            color: var(--dark);
            font-size: 15px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        label i {
            color: var(--primary-blue);
            width: 20px;
            text-align: center;
        }

        .input-with-icon {
            position: relative;
        }

        .input-with-icon i {
            position: absolute;
            left: 18px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--gray);
            transition: var(--transition);
        }

        input[type="text"],
        input[type="date"] {
            width: 100%;
            padding: 16px 20px 16px 50px;
            border: 2px solid var(--light-gray);
            border-radius: var(--radius-sm);
            font-size: 16px;
            color: var(--dark);
            background: white;
            transition: var(--transition);
        }

        input[type="text"]:focus,
        input[type="date"]:focus {
            outline: none;
            border-color: var(--primary-blue);
            box-shadow: 0 0 0 4px rgba(67, 97, 238, 0.1);
        }

        input[type="text"]:focus + i,
        input[type="date"]:focus + i {
            color: var(--primary-blue);
        }

        input[type="date"] {
            cursor: pointer;
        }

        input[type="submit"] {
            width: 100%;
            padding: 18px;
            background: linear-gradient(to right, var(--primary-blue), var(--secondary-purple));
            color: white;
            border: none;
            border-radius: var(--radius-sm);
            font-size: 18px;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
            margin-top: 10px;
            position: relative;
            overflow: hidden;
        }

        input[type="submit"]:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(67, 97, 238, 0.3);
        }

        input[type="submit"]:active {
            transform: translateY(-1px);
        }

        input[type="submit"]::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: 0.5s;
        }

        input[type="submit"]:hover::before {
            left: 100%;
        }

        .back-link {
            display: block;
            text-align: center;
            margin-top: 25px;
            color: var(--primary-blue);
            text-decoration: none;
            font-weight: 500;
            font-size: 15px;
            transition: var(--transition);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .back-link:hover {
            color: var(--secondary-purple);
            transform: translateX(-5px);
        }

        .status-message {
            padding: 15px;
            border-radius: var(--radius-sm);
            margin-bottom: 20px;
            display: none;
            align-items: center;
            gap: 12px;
            animation: slideIn 0.3s ease;
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .status-message.success {
            background: rgba(6, 214, 160, 0.1);
            color: var(--success);
            border-left: 4px solid var(--success);
            display: flex;
        }

        .status-message.error {
            background: rgba(239, 71, 111, 0.1);
            color: var(--danger);
            border-left: 4px solid var(--danger);
            display: flex;
        }

        .footer {
            text-align: center;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid var(--light-gray);
            color: var(--gray);
            font-size: 14px;
        }

        @media (max-width: 600px) {
            .container {
                padding: 30px 25px;
                margin: 20px;
            }

            .header h2 {
                font-size: 24px;
            }

            .header-icon {
                width: 70px;
                height: 70px;
            }

            .header-icon i {
                font-size: 30px;
            }

            input[type="text"],
            input[type="date"] {
                padding: 14px 16px 14px 45px;
                font-size: 15px;
            }
        }

        /* Optional: Add validation styles */
        input:invalid {
            border-color: var(--danger);
        }

        input:valid {
            border-color: var(--success);
        }

        /* Calendar icon for date input */
        .date-wrapper {
            position: relative;
        }

        .date-wrapper::after {
            content: '\f073';
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
            position: absolute;
            right: 20px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--gray);
            pointer-events: none;
        }
    </style>
</head>

<body>
    <div class="container">
        <div class="header">
            <div class="header-icon">
                <i class="fas fa-calendar-alt"></i>
            </div>
            <h2>Schedule Election</h2>
            <p>Set up voting dates for student council elections</p>
        </div>

        <!-- Display messages if any -->
        <% 
        String success = request.getParameter("success");
        String error = request.getParameter("error");
        
        if(success != null && success.equals("true")) {
        %>
            <div class="status-message success">
                <i class="fas fa-check-circle"></i>
                <span>Election scheduled successfully!</span>
            </div>
        <%
        } else if(error != null) {
        %>
            <div class="status-message error">
                <i class="fas fa-exclamation-triangle"></i>
                <span><%= error %></span>
            </div>
        <%
        }
        %>

        <!-- Form remains exactly the same - only UI updated -->
        <form action="updateEdate.jsp" method="post">
            <div class="form-group">
                <label for="election_name"><i class="fas fa-vote-yea"></i> Election Name</label>
                <div class="input-with-icon">
                    <i class="fas fa-pen"></i>
                    <input type="text" 
                           id="election_name" 
                           name="election_name" 
                           placeholder="e.g., Student Council Election 2024" 
                           required>
                </div>
            </div>

            <div class="form-group">
                <label for="election_date"><i class="fas fa-calendar-day"></i> Election Date</label>
                <div class="input-with-icon">
                    <i class="fas fa-calendar"></i>
                    <input type="date" 
                           id="election_date" 
                           name="election_date" 
                           required>
                </div>
            </div>

            <input type="submit" value="Schedule Election">
        </form>

        <a href="javascript:history.back()" class="back-link">
            <i class="fas fa-arrow-left"></i> Back to Dashboard
        </a>

        <div class="footer">
            <p>&copy; <%= new java.text.SimpleDateFormat("yyyy").format(new java.util.Date()) %> Student Voting System</p>
        </div>
    </div>

    <script>
        // Set minimum date to today
        document.addEventListener('DOMContentLoaded', function() {
            const today = new Date().toISOString().split('T')[0];
            document.getElementById('election_date').min = today;
            
            // Auto-hide messages after 5 seconds
            const messages = document.querySelectorAll('.status-message');
            messages.forEach(message => {
                setTimeout(() => {
                    message.style.opacity = '0';
                    message.style.transform = 'translateY(-20px)';
                    setTimeout(() => {
                        message.style.display = 'none';
                    }, 300);
                }, 5000);
            });

            // Add some interactivity
            const inputs = document.querySelectorAll('input[type="text"], input[type="date"]');
            inputs.forEach(input => {
                input.addEventListener('focus', function() {
                    this.parentElement.style.transform = 'scale(1.02)';
                });
                
                input.addEventListener('blur', function() {
                    this.parentElement.style.transform = 'scale(1)';
                });
            });
        });

        // Form submission animation
        const form = document.querySelector('form');
        form.addEventListener('submit', function(e) {
            const submitBtn = this.querySelector('input[type="submit"]');
            const originalText = submitBtn.value;
            
            submitBtn.value = 'Scheduling...';
            submitBtn.disabled = true;
            
            // Reset after 5 seconds if still on page
            setTimeout(() => {
                submitBtn.value = originalText;
                submitBtn.disabled = false;
            }, 5000);
        });

        // Date validation
        const dateInput = document.getElementById('election_date');
        dateInput.addEventListener('change', function() {
            const selectedDate = new Date(this.value);
            const today = new Date();
            
            if (selectedDate < today) {
                this.style.borderColor = 'var(--danger)';`
                this.style.boxShadow = '0 0 0 4px rgba(239, 71, 111, 0.1)';
            } else {
                this.style.borderColor = 'var(--success)';
                this.style.boxShadow = '0 0 0 4px rgba(6, 214, 160, 0.1)';
            }
        });
    </script>
</body>
</html>