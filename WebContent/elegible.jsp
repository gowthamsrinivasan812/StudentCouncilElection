<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, java.util.Base64" %>
<%@ page import="dbcon.dbconn" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Candidate Approval - Election Commission</title>
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
            --gradient: linear-gradient(135deg, #1e3c72, #2a5298);
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
        
        .approval-container {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
            padding: 40px;
            width: 100%;
            max-width: 800px;
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
            background: rgba(30, 60, 114, 0.1);
            border: 2px solid var(--primary);
            padding: 10px 20px;
            border-radius: 10px;
            color: var(--primary);
            font-weight: 600;
            transition: all 0.3s ease;
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
        
        .candidate-card {
            background: linear-gradient(135deg, #578574, #50a175, #5cbc68);
            border-radius: 15px;
            padding: 30px;
            margin-bottom: 30px;
            color: white;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
        }
        
        .form-section {
            margin-bottom: 25px;
        }
        
        .section-title {
            font-size: 1.3rem;
            color: var(--primary);
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .section-title i {
            color: var(--secondary);
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: white;
            font-weight: 500;
            font-size: 0.95rem;
        }
        
        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid rgba(255, 255, 255, 0.3);
            border-radius: 8px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: rgba(255, 255, 255, 0.9);
            color: #333;
        }
        
        .readonly-field {
            background: rgba(255, 255, 255, 0.8);
            color: #666;
            border-color: rgba(255, 255, 255, 0.4);
        }
        
        .form-control:focus {
            outline: none;
            border-color: white;
            box-shadow: 0 0 0 3px rgba(255, 255, 255, 0.3);
            background: white;
        }
        
        .candidate-image-container {
            text-align: center;
            padding: 20px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 10px;
            border: 2px dashed rgba(255, 255, 255, 0.4);
            margin-bottom: 20px;
        }
        
        .candidate-image {
            width: 180px;
            height: 180px;
            border-radius: 12px;
            object-fit: cover;
            border: 4px solid white;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }
        
        .no-image {
            padding: 40px 20px;
            color: rgba(255, 255, 255, 0.8);
            text-align: center;
        }
        
        .no-image i {
            font-size: 3rem;
            margin-bottom: 10px;
            opacity: 0.7;
        }
        
        .file-upload-container {
            border: 2px dashed rgba(255, 255, 255, 0.5);
            border-radius: 10px;
            padding: 25px;
            text-align: center;
            transition: all 0.3s ease;
            cursor: pointer;
            position: relative;
            background: rgba(255, 255, 255, 0.1);
            margin-top: 10px;
        }
        
        .file-upload-container:hover {
            border-color: white;
            background: rgba(255, 255, 255, 0.2);
        }
        
        .file-upload-icon {
            font-size: 2.5rem;
            color: white;
            margin-bottom: 15px;
            opacity: 0.9;
        }
        
        .file-upload-text h4 {
            color: white;
            margin-bottom: 8px;
            font-weight: 600;
        }
        
        .file-upload-text p {
            color: rgba(255, 255, 255, 0.9);
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
            background: linear-gradient(45deg, var(--success), #66bb6a);
            color: white;
            border: none;
            border-radius: 10px;
            padding: 15px 30px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            margin: 30px auto 0;
            box-shadow: 0 5px 15px rgba(76, 175, 80, 0.4);
            min-width: 200px;
        }
        
        .btn-submit:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(76, 175, 80, 0.6);
        }
        
        .security-notice {
            background: rgba(255, 255, 255, 0.2);
            border-radius: 10px;
            padding: 15px;
            margin-top: 25px;
            text-align: center;
            font-size: 0.9rem;
            color: rgba(255, 255, 255, 0.9);
            border: 1px solid rgba(255, 255, 255, 0.3);
        }
        
        .security-notice i {
            color: white;
            margin-right: 8px;
        }
        
        .form-row {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 15px;
            margin-bottom: 15px;
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
            .approval-container {
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
            
            .candidate-image {
                width: 150px;
                height: 150px;
            }
        }
        
        @media (max-width: 480px) {
            body {
                padding: 10px;
            }
            
            .approval-container {
                padding: 20px;
            }
            
            .page-title {
                font-size: 1.5rem;
            }
            
            .candidate-card {
                padding: 20px;
            }
        }
    </style>
</head>

<%
String email = request.getParameter("email");

Connection con = dbconn.create();
PreparedStatement ps = con.prepareStatement(
    "SELECT  *  FROM studentvoute.nominatecandidate WHERE email = ?"
);
ps.setString(1, email);

ResultSet rs = ps.executeQuery();

String rollno = "";
String department = "";
String img = "";

if (rs.next()) {
    rollno = rs.getString("roll_number");
    department = rs.getString("class_department");
    email = rs.getString("email");
    img = rs.getString("student_id_photo_url");
}
rs.close();
ps.close();
con.close();
%>


<body>
<div class="approval-container">

    <div class="header-section">
        <h1 class="page-title">
            <i class="fas fa-user-check"></i>
            Student Candidate Approval
        </h1>
        <a href="Nominationview.jsp" class="btn-back">
            <i class="fas fa-arrow-left"></i>
            Back to Nominations
        </a>
    </div>

    <form method="post" action="Eligible" enctype="multipart/form-data">

        <!-- Student Info Card -->
        <div class="candidate-card">
            <h2 class="section-title" style="color:white;">
                <i class="fas fa-user-graduate"></i>
                Student Information
            </h2>

            <!-- Student Photo -->
            <div class="candidate-image-container">
                 <% if (img != null && !img.trim().isEmpty()) { %>
            <img src="<%= img %>" class="candidate-image" />
        <% } else { %>
            No Image
        <% } %>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label>Roll Number</label>
                    <input type="text" class="form-control readonly-field"
                           name="rollno" value="<%= rollno %>" readonly>
                </div>

                <div class="form-group">
                    <label>Department</label>
                    <input type="text" class="form-control readonly-field"
                           name="department" value="<%= department %>" readonly>
                </div>
            </div>

            <div class="form-group">
                <label>Email Address</label>
                <input type="text" class="form-control readonly-field"
                       name="email" value="<%= email %>" readonly>
            </div>
        </div>

        <!-- Symbol Upload -->
        <div class="form-section">
            <h2 class="section-title">
                <i class="fas fa-flag"></i>
                Election Symbol Assignment
            </h2>

            <div class="form-group">
                <label style="color: var(--primary);">Upload Election Symbol</label>
                <div class="file-upload-container">
                    <div class="file-upload-icon">
                        <i class="fas fa-upload"></i>
                    </div>
                    <div class="file-upload-text">
                        <h4>Upload Symbol</h4>
                        <p>JPG / PNG • Recommended 200×200px</p>
                        <span style="padding:8px 20px; background:white; color:#578574;
                                     border-radius:5px; font-weight:600;">
                            Choose Symbol File
                        </span>
                    </div>
                    <input type="file" class="file-input"
                           name="file" required accept="image/*">
                </div>
            </div>
        </div>

        <button type="submit" class="btn-submit">
            <i class="fas fa-check-circle"></i>
            Approve Student Candidate
        </button>

        <div class="security-notice">
            <i class="fas fa-shield-alt"></i>
            <span>Approval will allow the student to contest the election</span>
        </div>

    </form>
</div>

<script>
document.querySelector('input[type="file"]').addEventListener('change', function () {
    const fileName = this.files[0]?.name;
    if (fileName) {
        const uploadText = this.parentElement.querySelector('.file-upload-text h4');
        uploadText.innerHTML =
            `<i class="fas fa-check-circle" style="color:#4CAF50;"></i> ${fileName}`;
    }
});

document.querySelector('form').addEventListener('submit', function(e) {
    if (!document.querySelector('input[type="file"]').files.length) {
        alert('Please upload the election symbol.');
        e.preventDefault();
        return;
    }
    if (!confirm('Approve this student candidate?')) {
        e.preventDefault();
    }
});
</script>
</body>

</html>