<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.Base64" %>
<%@page import="dbcon.dbconn"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Candidate Nomination - Election Portal</title>
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
        
        .nomination-container {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            box-shadow: var(--shadow);
            padding: 40px;
            width: 100%;
            max-width: 900px;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.3);
            animation: fadeInUp 0.8s ease-out;
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
            font-size: 2.2rem;
            font-weight: 700;
            color: var(--primary);
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        .page-title i {
            color: var(--secondary);
        }
        
        .btn-back {
            background: rgba(44, 62, 80, 0.1);
            border: 2px solid var(--primary);
            padding: 10px 20px;
            border-radius: 10px;
            color: var(--primary);
            font-weight: 600;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
        }
        
        .btn-back:hover {
            background: var(--primary);
            color: white;
            transform: translateY(-2px);
        }
        
        .form-section {
            margin-bottom: 30px;
        }
        
        .section-title {
            font-size: 1.5rem;
            color: var(--primary);
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid var(--light);
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .section-title i {
            color: var(--secondary);
        }
        
        .form-row {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            margin-bottom: 20px;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: var(--primary);
            font-weight: 500;
            font-size: 0.95rem;
        }
        
        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e1e5ee;
            border-radius: 8px;
            font-size: 1rem;
            transition: var(--transition);
            background: white;
            color: var(--dark);
        }
        
        .readonly-field {
            background-color: #f8f9fa;
            color: #6c757d;
            border-color: #e1e5ee;
        }
        
        .form-control:focus {
            outline: none;
            border-color: var(--secondary);
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.2);
        }
        
        .candidate-image-container {
            text-align: center;
            padding: 20px;
            background: rgba(52, 152, 219, 0.05);
            border-radius: 10px;
            border: 2px dashed #e1e5ee;
        }
        
        .candidate-image {
            max-width: 200px;
            height: auto;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            border: 3px solid white;
        }
        
        .no-image {
            padding: 40px 20px;
            color: #666;
            text-align: center;
        }
        
        .no-image i {
            font-size: 3rem;
            margin-bottom: 10px;
            opacity: 0.5;
        }
        
        .declaration-section {
            background: rgba(46, 204, 113, 0.05);
            border-radius: 10px;
            padding: 25px;
            margin: 25px 0;
            border-left: 4px solid var(--success);
        }
        
        .declaration-text {
            color: #2c3e50;
            font-style: italic;
            line-height: 1.6;
            margin-bottom: 15px;
        }
        
        .declaration-warning {
            color: #e74c3c;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 0.9rem;
        }
        
        .file-upload-container {
            border: 2px dashed #e1e5ee;
            border-radius: 10px;
            padding: 25px;
            text-align: center;
            transition: var(--transition);
            cursor: pointer;
            position: relative;
        }
        
        .file-upload-container:hover {
            border-color: var(--secondary);
            background: rgba(52, 152, 219, 0.05);
        }
        
        .file-upload-icon {
            font-size: 2.5rem;
            color: var(--secondary);
            margin-bottom: 15px;
        }
        
        .file-upload-text h4 {
            color: var(--primary);
            margin-bottom: 8px;
        }
        
        .file-upload-text p {
            color: #666;
            font-size: 0.9rem;
            margin-bottom: 15px;
        }
        
        .file-input {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            opacity: 0;
            cursor: pointer;
        }
        
        .btn-submit {
            background: var(--gradient);
            color: white;
            border: none;
            border-radius: 10px;
            padding: 15px 30px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            margin: 30px auto 0;
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
            min-width: 200px;
        }
        
        .btn-submit:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(102, 126, 234, 0.6);
        }
        
        .security-notice {
            background: rgba(52, 152, 219, 0.05);
            border-radius: 10px;
            padding: 15px;
            margin-top: 25px;
            text-align: center;
            font-size: 0.9rem;
            color: #666;
        }
        
        .security-notice i {
            color: var(--secondary);
            margin-right: 8px;
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
            .nomination-container {
                padding: 25px;
            }
            
            .page-title {
                font-size: 1.8rem;
            }
            
            .header-section {
                flex-direction: column;
                align-items: flex-start;
            }
            
            .form-row {
                grid-template-columns: 1fr;
            }
        }
        
        @media (max-width: 480px) {
            body {
                padding: 10px;
            }
            
            .nomination-container {
                padding: 20px;
            }
            
            .page-title {
                font-size: 1.5rem;
            }
            
            .section-title {
                font-size: 1.3rem;
            }
        }
    </style>
</head>

<%
    String email = session.getAttribute("candidateEmail").toString();
String dept=session.getAttribute("dept").toString();
    String mobile = session.getAttribute("smobile").toString();

    
    String imageUrl = "";
    try {
        Connection con;
        con = dbconn.create();
        PreparedStatement ps = con.prepareStatement("SELECT student_id_photo_url FROM nominatecandidate WHERE email=?");
        ps.setString(1, email);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
        	imageUrl = rs.getString("student_id_photo_url");
        }
        rs.close();
        ps.close();
        con.close();
    } catch (Exception e) {
        out.println("Error: " + e);
    }
%>

<body>
    <div class="nomination-container">
        <% if (request.getAttribute("successMessage") != null) { %>
    <div style="
        background: rgba(46, 204, 113, 0.15);
        border-left: 5px solid #2ecc71;
        padding: 15px 20px;
        border-radius: 10px;
        margin-bottom: 25px;
        color: #27ae60;
        font-weight: 600;
        display: flex;
        align-items: center;
        gap: 10px;
    ">
        <i class="fas fa-check-circle"></i>
        <span><%= request.getAttribute("successMessage") %></span>
    </div>
<% } %>
        
        <div class="header-section">
            <h1 class="page-title">
                <i class="fas fa-file-contract"></i>
                Candidate Nomination Form
            </h1>
            <a href="candiateapply.jsp" class="btn-back">
                <i class="fas fa-arrow-left"></i>
                Back
            </a>
        </div>

        <form action="nomination" method="post" enctype="multipart/form-data">
            <!-- Candidate Details Section -->
            <div class="form-section">
                <h2 class="section-title">
                    <i class="fas fa-user-tie"></i>
                    Candidate Details
                </h2>
                
                <div class="form-row">
                    <div class="form-group">
                        <div class="candidate-image-container">
    <% if (imageUrl != null && !imageUrl.isEmpty()) { %>
        <img src="<%= imageUrl %>"
             class="candidate-image"
             alt="Candidate Photo">
        <p style="margin-top: 10px; color: #666; font-size: 0.9rem;">
            Candidate ID Photo
        </p>
    <% } else { %>
        <div class="no-image">
            <i class="fas fa-user-slash"></i>
            <p>No Image Available</p>
        </div>
    <% } %>
</div>

                        <input type="hidden" name="pic" value="<%= imageUrl %>">
                    </div>
                    
                    <div class="form-group">
                        <label>Email Address</label>
                        <input type="email" class="form-control readonly-field" name="email" value="<%= email %>" readonly>
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label>department</label>
                        <input type="text" class="form-control readonly-field" name="add" value="<%= dept %>" readonly>
                    </div>
                  <%--   
                    <div class="form-group">
                        <label>Assembly Constituency</label>
                        <input type="text" class="form-control readonly-field" name="doc" value="<%= ass %>" readonly>
                    </div> --%>
                    
                    <div class="form-group">
                        <label>Contact Number</label>
                        <input type="text" class="form-control readonly-field" name="number" value="<%= mobile %>" readonly>
                    </div>
                </div>
            </div>

            
            <div class="form-section">
                <h2 class="section-title">
                    <i class="fas fa-gavel"></i>
                    Candidate Declaration
                </h2>
                
                <div class="declaration-section">
                    <p class="declaration-text">
                        "I hereby declare that the information provided in this nomination form is true and correct to the best of my knowledge. 
                        I am aware that making a statement or declaration which is false and which I know to be false is punishable under 
                        Section 31 of the Representation of the People Act, 1950."
                    </p>
                    <div class="declaration-warning">
                        <i class="fas fa-exclamation-triangle"></i>
                        <span>False declarations are punishable by law</span>
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label>Candidate Full Name</label>
                        <input type="text" name="type" class="form-control" placeholder="Enter your full name" required>
                    </div>
                    
                 <!--    <div class="form-group">
                        <label>Political Party Name</label>
                        <input type="text" name="street" class="form-control" placeholder="Enter your party name" required>
                    </div> -->
                </div>
                
                <div class="form-group">
                    <label>Declaration Document Upload</label>
                    <div class="file-upload-container">
                        <div class="file-upload-icon">
                            <i class="fas fa-file-pdf"></i>
                        </div>
                        <div class="file-upload-text">
                            <h4>Upload Declaration Document</h4>
                            <p>PDF files only , Max size 1 MB</p>
                            <span style="padding: 8px 20px; background: var(--secondary); color: white; border-radius: 5px;">
                                Choose PDF File
                            </span>
                        </div>
                        <input type="file" class="file-input" name="file" accept="application/pdf" required>
                    </div>
                </div>
            </div>

           
            <button type="submit" class="btn-submit">
                <i class="fas fa-paper-plane"></i>
                Submit Nomination
            </button>
            
            <div class="security-notice">
                <i class="fas fa-shield-alt"></i>
                <span>All information is securely encrypted and protected</span>
            </div>
        </form>
    </div>

    <script>
        
        document.querySelector('input[type="file"]').addEventListener('change', function(e) {
            const fileName = this.files[0]?.name;
            if (fileName) {
                const uploadText = this.parentElement.querySelector('.file-upload-text h4');
                uploadText.innerHTML = `<i class="fas fa-check-circle" style="color: var(--success);"></i> ${fileName}`;
                
                const uploadContainer = this.parentElement;
                uploadContainer.style.borderColor = 'var(--success)';
                uploadContainer.style.background = 'rgba(46, 204, 113, 0.05)';
            }
        });

        
        document.querySelector('form').addEventListener('submit', function(e) {
            const candidateName = document.querySelector('input[name="type"]');
            const partyName = document.querySelector('input[name="street"]');
            const pdfFile = document.querySelector('input[type="file"]');
            
            if (!candidateName.value.trim()) {
                alert('Please enter your full name');
                candidateName.focus();
                e.preventDefault();
                return;
            }
            
            if (!partyName.value.trim()) {
                alert('Please enter your party name');
                partyName.focus();
                e.preventDefault();
                return;
            }
            
            if (!pdfFile.files.length) {
                alert('Please upload the declaration document');
                e.preventDefault();
                return;
            }
        });
    </script>
</body>
</html>