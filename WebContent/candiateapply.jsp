<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="dbcon.dbconn"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.Base64"%>

<%
    // Fetch session data
    String name = session.getAttribute("candidateName").toString();
    String email = session.getAttribute("candidateEmail").toString();
    String dept = session.getAttribute("dept").toString();
    String rollNo = session.getAttribute("candidateRegno").toString();
    String mobile = session.getAttribute("smobile").toString();
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Candidate Application - Election Portal</title>
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
}

.main-container {
    max-width: 1200px;
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
}

.btn-back:hover {
    background: rgba(255, 255, 255, 0.3);
    transform: translateY(-2px);
    color: white;
}

.content-wrapper {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 30px;
}

@media (max-width: 968px) {
    .content-wrapper {
        grid-template-columns: 1fr;
    }
}

.application-section, .applications-section {
    background: rgba(255, 255, 255, 0.95);
    border-radius: 20px;
    padding: 30px;
    box-shadow: var(--shadow);
    backdrop-filter: blur(10px);
    animation: fadeInUp 0.8s ease-out;
}

.section-title {
    font-size: 1.8rem;
    color: var(--primary);
    margin-bottom: 25px;
    text-align: center;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 10px;
}

.section-title i {
    color: var(--secondary);
}

.alert {
    padding: 15px 20px;
    border-radius: 10px;
    margin-bottom: 25px;
    text-align: center;
    font-weight: 500;
}

.alert-danger {
    background: rgba(231, 76, 60, 0.1);
    border-left: 4px solid var(--accent);
    color: #c0392b;
}

.form-group {
    margin-bottom: 25px;
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
    padding: 15px 20px;
    border: 2px solid #e1e5ee;
    border-radius: 10px;
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

#output_image {
    width: 100%;
    max-height: 200px;
    object-fit: contain;
    display: none;
    margin-top: 15px;
    border-radius: 8px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    border: 1px solid #e1e5ee;
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
    box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
    width: 100%;
}

.btn-submit:hover {
    transform: translateY(-3px);
    box-shadow: 0 8px 20px rgba(102, 126, 234, 0.6);
}

.btn-submit i {
    margin-left: 10px;
    transition: var(--transition);
}

.btn-submit:hover i {
    transform: translateX(5px);
}

.applications-title {
    font-size: 1.5rem;
    color: var(--primary);
    margin-bottom: 25px;
    display: flex;
    align-items: center;
    gap: 10px;
}

.applications-table {
    width: 100%;
    background: white;
    border-radius: 10px;
    overflow: hidden;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
}

.applications-table th {
    background: linear-gradient(45deg, var(--primary), var(--secondary));
    color: white;
    padding: 15px;
    text-align: left;
    font-weight: 600;
}

.applications-table td {
    padding: 15px;
    border-bottom: 1px solid #e1e5ee;
    vertical-align: middle;
}

.applications-table tr:hover {
    background: rgba(52, 152, 219, 0.05);
}

.candidate-image {
    width: 80px;
    height: 60px;
    border-radius: 8px;
    object-fit: cover;
    border: 2px solid #e1e5ee;
}

.btn-form {
    background: var(--success);
    color: white;
    border: none;
    padding: 8px 15px;
    border-radius: 6px;
    font-weight: 500;
    transition: var(--transition);
    text-decoration: none;
    display: inline-block;
}

.btn-form:hover {
    background: #27ae60;
    transform: translateY(-2px);
    color: white;
}

.no-applications {
    text-align: center;
    padding: 40px 20px;
    color: #666;
}

.no-applications i {
    font-size: 3rem;
    margin-bottom: 15px;
    opacity: 0.5;
}

.security-notice {
    background: rgba(52, 152, 219, 0.1);
    border: 1px solid rgba(52, 152, 219, 0.3);
    border-radius: 10px;
    padding: 15px;
    margin-top: 20px;
    text-align: center;
}

.security-notice i {
    color: var(--secondary);
    margin-right: 8px;
}

.progress-bar {
    height: 6px;
    background: #e1e5ee;
    border-radius: 3px;
    margin-top: 10px;
    overflow: hidden;
    display: none;
}

.progress-fill {
    height: 100%;
    background: var(--success);
    width: 0%;
    transition: width 0.3s ease;
}

@keyframes fadeInUp {
    from { opacity: 0; transform: translateY(30px); }
    to { opacity: 1; transform: translateY(0); }
}
</style>
</head>

<body>
<div class="main-container">

    <div class="header-section">
        <h1 class="page-title"><i class="fas fa-user-tie"></i> Candidate Application</h1>
        <a href="candidatemain.jsp" class="btn-back"><i class="fas fa-arrow-left"></i> Back</a>
    </div>

    <div class="content-wrapper">

        <!-- Application Form -->
        <div class="application-section">
            <h2 class="section-title"><i class="fas fa-file-signature"></i> Application Form</h2>

            <% if(request.getAttribute("errorMessage") != null){ %>
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-circle"></i> <%=request.getAttribute("errorMessage") %>
                </div>
            <% } %>

            <form method="post" action="candidateapply" enctype="multipart/form-data" onsubmit="return validateForm()">

                <div class="form-group">
                    <label>Class / Department</label>
                    <input type="text" name="Class" value="<%=dept%>" class="form-control readonly-field" readonly>
                </div>

                <div class="form-group">
                    <label>Roll Number</label>
                    <input type="text" name="roll" value="<%=rollNo%>" class="form-control readonly-field" readonly>
                </div>

                <div class="form-group">
                    <label>Email</label>
                    <input type="email" name="email" value="<%=email%>" class="form-control readonly-field" readonly>
                </div>

                <div class="form-group">
                    <label>Mobile</label>
                    <input type="text" name="mobile" value="<%=mobile%>" class="form-control" maxlength="10" required pattern="\d{10}" oninput="validateMobile(this)">
                    <small id="mobileError" style="color: var(--accent); display:none;">Please enter a valid 10-digit number</small>
                </div>

                <div class="form-group">
                    <label>Upload Student ID</label>
                    <div class="file-upload-container" id="fileUploadContainer">
                        <div class="file-upload-icon"><i class="fas fa-cloud-upload-alt"></i></div>
                        <div class="file-upload-text">
                            <h4>Upload Your Student ID</h4>
                            <p>JPG, PNG files only • Max size 5MB</p>
                            <span style="padding:8px 20px; background: var(--secondary); color:white; border-radius:5px;">Choose File</span>
                        </div>
                        <input type="file" class="file-input" name="file" accept="image/*" onchange="preview_image(event)" required>
                    </div>
                    <div class="progress-bar" id="progressBar"><div class="progress-fill" id="progressFill"></div></div>
                    <img id="output_image"/>
                </div>

                <button type="submit" class="btn-submit"><i class="fas fa-paper-plane"></i> Submit Application</button>
            </form>

            <div class="security-notice"><i class="fas fa-shield-alt"></i> Your documents are encrypted and securely stored.</div>
        </div>

        <!-- Application History -->
        <div class="applications-section">
            <h2 class="applications-title"><i class="fas fa-history"></i> Application History</h2>
            <table class="applications-table">
                <thead>
                    <tr>
                        <th>Department</th>
                        <th>Mobile</th>
                        <th>Roll Number</th>
                        <th>ID Photo</th>
                        <th>Action</th>
                    </tr>
                </thead>
           <tbody>
<%
    try {
        Connection con = dbconn.create();
        PreparedStatement ps = con.prepareStatement(
            "SELECT * FROM candidatereg WHERE email=? AND status=?"
        );
        ps.setString(1, email);
        ps.setString(2, "Accepted");
        ResultSet rs = ps.executeQuery();

        boolean hasApplications = false;

        while (rs.next()) {

        	PreparedStatement ps1 = con.prepareStatement(
        		    "SELECT * FROM nominatecandidate WHERE email=? AND status <> ?"
        		);
        		ps1.setString(1, email);
        		ps1.setString(2, "Eligible");

            ResultSet rs1 = ps1.executeQuery();

            while (rs1.next()) {
                hasApplications = true;
                byte[] img = rs1.getBytes("student_id_photo");
%>
<tr>
    <td><%= rs1.getString("class_department") %></td>
    <td><%= rs1.getString("mobile") %></td>
    <td><%= rs1.getString("roll_number") %></td>
    <td>
        <% if (img != null) { %>
            <img src="data:image/jpeg;base64,<%= Base64.getEncoder().encodeToString(img) %>"
                 class="candidate-image"/>
        <% } else { %>
            No Image
        <% } %>
    </td>
    <td>
        <a href="candidateapp.jsp?email=<%= rs1.getString(3) %>
                 &ass=<%= rs1.getString(2) %>
                 &dis=<%= rs1.getString(1) %>
                 &mobile=<%= rs1.getString(4) %>"
           class="btn-form">
            <i class="fas fa-edit"></i> Form
        </a>
    </td>
</tr>
<%
            }
            rs1.close();
            ps1.close();
        }

        if (!hasApplications) {
%>
<tr>
    <td colspan="5" class="no-applications">
        <i class="fas fa-inbox"></i> No Applications Found
    </td>
</tr>
<%
        }

        rs.close();
        ps.close();
        con.close();

    } catch (Exception e) {
        e.printStackTrace();
    }
%>
</tbody>

            </table>
        </div>

    </div>
</div>

<script>
function preview_image(event){
    var file = event.target.files[0];
    if(!file) return;

    var progressBar = document.getElementById('progressBar');
    var progressFill = document.getElementById('progressFill');
    progressBar.style.display='block';
    var progress=0;
    var interval = setInterval(function(){
        progress +=10;
        progressFill.style.width = progress+'%';
        if(progress>=100){
            clearInterval(interval);
            progressBar.style.display='none';
            var reader = new FileReader();
            reader.onload = function(){
                var output = document.getElementById('output_image');
                output.src = reader.result;
                output.style.display='block';
            }
            reader.readAsDataURL(file);
        }
    },50);
}

function validateMobile(input){
    const mobileError = document.getElementById('mobileError');
    if(/^\d{10}$/.test(input.value)){
        mobileError.style.display='none';
        input.style.borderColor='var(--success)';
    } else {
        mobileError.style.display='block';
        input.style.borderColor='var(--accent)';
    }
}

function validateForm(){
    const mobileInput = document.querySelector('input[name="mobile"]');
    const fileInput = document.querySelector('input[type="file"]');
    if(!/^\d{10}$/.test(mobileInput.value)){
        alert("Please enter a valid 10-digit mobile number.");
        mobileInput.focus();
        return false;
    }
    if(!fileInput.files || fileInput.files.length===0){
        alert("Please upload your Student ID.");
        return false;
    }
    return true;
}
</script>
</body>
</html>
