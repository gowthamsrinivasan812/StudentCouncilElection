<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Student Registration - Secure Online System</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<style>
/* Use the same CSS as before */
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
    box-sizing: border-box;
    font-family: 'Poppins', sans-serif;
    margin: 0;
    padding: 0;
}
body {
    background: var(--gradient);
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 100vh;
    padding: 20px;
}
.registration-container {
    display: flex;
    width: 100%;
    max-width: 1000px;
    background: white;
    border-radius: 20px;
    box-shadow: var(--shadow);
    overflow: hidden;
    min-height: 650px;
}
.illustration-section {
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
.illustration-section:before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: url('data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxMDAlIiBoZWlnaHQ9IjEwMCUiPjxkZWZzPjxwYXR0ZXJuIGlkPSJwYXR0ZXJuIiB3aWR0aD0iNDAiIGhlaWdodD0iNDAiIHBhdHRlcm5Vbml0cz0idXNlclNwYWNlT25Vc2UiIHBhdHRlcm5UcmFuc2Zvcm09InJvdGF0ZSg0NSkiPjxyZWN0IHdpZHRoPSIyMCIgaGVpZ2h0PSIyMCIgZmlsbD0icmdiYSgyNTUsMjU1LDI1NSwwLjA1KSIvPjwvcGF0dGVybj48L2RlZnM+PHJlY3QgZmlsbD0idXJsKCNwYXR0ZXJuKSIgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSIvPjwvc3ZnPg==');
}
.illustration-content {
    z-index: 1;
    max-width: 400px;
}
.illustration-section img {
    max-width: 100%;
    margin-bottom: 30px;
    border-radius: 10px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
}
.illustration-section h2 {
    font-size: 1.8rem;
    margin-bottom: 15px;
}
.illustration-section p {
    font-size: 1rem;
    opacity: 0.9;
    line-height: 1.6;
}
.features-list {
    list-style: none;
    margin-top: 30px;
    text-align: left;
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
.form-section {
    flex: 1;
    padding: 50px 40px;
    display: flex;
    flex-direction: column;
    justify-content: center;
}
.form-header {
    text-align: center;
    margin-bottom: 30px;
}
.form-header h1 {
    color: var(--primary);
    font-size: 2.2rem;
    margin-bottom: 10px;
    position: relative;
    padding-bottom: 15px;
}
.form-header h1:after {
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
}
.form-group {
    margin-bottom: 25px;
    position: relative;
}
.form-group label {
    display: block;
    margin-bottom: 8px;
    color: var(--primary);
    font-weight: 500;
    font-size: 0.95rem;
}
.input-with-icon {
    position: relative;
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
.input-icon {
    position: absolute;
    top: 50%;
    left: 20px;
    transform: translateY(-50%);
    color: #a0a0a0;
    font-size: 1.2rem;
    transition: var(--transition);
}
.form-control:focus + .input-icon {
    color: var(--secondary);
}
.error-message {
    color: var(--accent);
    font-size: 0.85rem;
    margin-top: 5px;
    display: none;
}
.btn-submit {
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
    box-shadow: 0 5px 15px rgba(52, 152, 219, 0.4);
    width: 100%;
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
.login-link {
    text-align: center;
    margin-top: 25px;
    font-size: 0.95rem;
    color: #666;
}
.login-link a {
    color: var(--secondary);
    font-weight: 600;
    text-decoration: none;
    transition: var(--transition);
}
.login-link a:hover {
    color: var(--accent);
}
.success-message {
    background: rgba(46, 204, 113, 0.1);
    border-left: 4px solid var(--success);
    color: #27ae60;
    padding: 12px 20px;
    border-radius: 8px;
    margin-bottom: 20px;
    display: none;
}
@media (max-width: 768px) {
    .registration-container {
        flex-direction: column;
    }
    .illustration-section {
        padding: 30px 20px;
    }
    .illustration-section img {
        max-width: 200px;
    }
    .form-section {
        padding: 40px 30px;
    }
    .form-header h1 {
        font-size: 1.8rem;
    }
}
</style>
</head>
<body>

<div class="registration-container">
    <div class="illustration-section">
        <div class="illustration-content">
            <h2>Join Our Academic Community</h2>
            <p>Register now to become a student and access all online academic resources.</p>
            <ul class="features-list">
                <li>
                    <i class="fas fa-shield-alt"></i>
                    <span>Secure and encrypted registration process</span>
                </li>
                <li>
                    <i class="fas fa-user-check"></i>
                    <span>Quick verification and approval</span>
                </li>
                <li>
                    <i class="fas fa-mobile-alt"></i>
                    <span>Access your student portal anytime, anywhere</span>
                </li>
                <li>
                    <i class="fas fa-clock"></i>
                    <span>Registration completed in just a few minutes</span>
                </li>
            </ul>
        </div>
    </div>

    <div class="form-section">
        <div class="form-header">
            <h1>Student Registration</h1>
            <p>Fill in your details to register as a student</p>
        </div>

        <div id="success-message" class="success-message">
            <i class="fas fa-check-circle"></i> Registration successful! You can now login.
        </div>

        <form action="studentreg" method="post" onsubmit="return validateForm()">
            <div class="form-group">
                <label for="name">Full Name</label>
                <div class="input-with-icon">
                    <input type="text" id="name" placeholder="Enter your full name" name="name" class="form-control" required>
                    <i class="fas fa-user input-icon"></i>
                </div>
            </div>

            <div class="form-group">
                <label for="email">Email Address</label>
                <div class="input-with-icon">
                    <input type="email" id="email" placeholder="Enter your email address" name="email" class="form-control" required>
                    <i class="fas fa-envelope input-icon"></i>
                </div>
            </div>

            <div class="form-group">
                <label for="phone-num">Mobile Number</label>
                <div class="input-with-icon">
                    <input type="tel" id="phone-num" name="mobile" placeholder="Enter your 10-digit mobile number" class="form-control" required>
                    <i class="fas fa-phone input-icon"></i>
                </div>
                <span class="error-message" id="phone-error">Please enter a valid 10-digit mobile number</span>
            </div>

            <div class="form-group">
                <label for="course">Course</label>
                <div class="input-with-icon">
                    <select id="course" name="course" onchange="populateSubjects()" class="form-control" required>
                        <option value="">Select your course</option>
                       
                        <option value="CSE">CSE</option>
                        <option value="IT">IT</option>
						<option value="ECE">ECE</option>
						<option value="EEE">EEE</option>
						<option value="Mechanical">Mechanical</option>
						<option value="Civil">Civil</option>
                    </select>
                    <i class="fas fa-book input-icon"></i>
                </div>
            </div>

           
            <div class="form-group">
    <label for="password">Password</label>
    <div class="input-with-icon">
        <input type="password" id="password" placeholder="Enter your password" name="pass" class="form-control" required>
        <i class="fas fa-lock input-icon"></i>
    </div>
    <span class="error-message" id="password-error">Password must be at least 6 characters</span>
</div>
            

            <button type="submit" class="btn-submit">
                Complete Registration
                <i class="fas fa-arrow-right"></i>
            </button>

            <div class="login-link">
                Already registered? <a href="voterlogin.jsp">Login</a>
            </div>
        </form>
    </div>
</div>

<script>
function validateForm() {
    var phoneInput = document.getElementById("phone-num");
    var phoneError = document.getElementById("phone-error");
    var isValid = true;

    phoneError.style.display = "none";

    if (!/^\d{10}$/.test(phoneInput.value)) {
        phoneError.style.display = "block";
        phoneInput.style.borderColor = "var(--accent)";
        isValid = false;
    } else {
        phoneInput.style.borderColor = "#e1e5ee";
    }

    var subjectSelect = document.getElementById("subject");
    if (subjectSelect.value === "") {
        subjectSelect.style.borderColor = "var(--accent)";
        isValid = false;
    } else {
        subjectSelect.style.borderColor = "#e1e5ee";
    }

    return isValid;
}



document.getElementById("phone-num").addEventListener("input", function() {
    var phoneError = document.getElementById("phone-error");
    if (!/^\d{0,10}$/.test(this.value)) {
        this.value = this.value.slice(0, -1);
    }

    if (this.value.length === 10) {
        phoneError.style.display = "none";
        this.style.borderColor = "var(--success)";
    } else if (this.value.length > 0) {
        this.style.borderColor = "var(--accent)";
    } else {
        this.style.borderColor = "#e1e5ee";
    }
});
</script>

</body>
</html>
