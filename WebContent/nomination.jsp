<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="dbcon.dbconn"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nominate Candidate</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
    .btn-approve {
    background: #2ecc71;
    color: white;
    padding: 8px 14px;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    font-size: 14px;
}

.btn-reject {
    background: #e74c3c;
    color: white;
    padding: 8px 14px;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    font-size: 14px;
}

.btn-approve:hover { background: #27ae60; }
.btn-reject:hover { background: #c0392b; }

.status.Approved { color: #27ae60; font-weight: 600; }
.status.Rejected { color: #e74c3c; font-weight: 600; }
.status.Pending { color: #f39c12; font-weight: 600; }
    
        /* Basic styling similar to candidateapply.jsp */
        body {font-family:'Poppins',sans-serif; background: linear-gradient(135deg, #667eea, #764ba2); color:#333; padding:20px;}
        .container {max-width:1200px; margin:0 auto;}
        h1 {color:white; margin-bottom:20px;}
        .btn-back {background: rgba(255,255,255,0.2); padding:10px 20px; border-radius:8px; color:white; text-decoration:none; display:inline-block; margin-bottom:20px;}
        .form-section, .list-section {background:white; padding:25px; border-radius:15px; box-shadow:0 5px 15px rgba(0,0,0,0.1); margin-bottom:30px;}
        .form-group {margin-bottom:20px;}
        label {display:block; font-weight:500; margin-bottom:8px;}
        input, select, textarea {width:100%; padding:12px; border-radius:8px; border:1px solid #ccc;}
        .btn-submit {background:#3498db; color:white; padding:15px 25px; border:none; border-radius:8px; cursor:pointer;}
        .btn-submit:hover {background:#2980b9;}
        table {width:100%; border-collapse:collapse; margin-top:20px;}
        th, td {padding:12px; border:1px solid #ccc; text-align:left;}
        th {background:#3498db; color:white;}
        .candidate-image {width:80px; height:60px; object-fit:cover; border-radius:5px;}
        .alert {padding:12px 20px; border-radius:8px; margin-bottom:20px;}
        .alert-danger {background:#f8d7da; color:#721c24;}
        .alert-success {background:#d4edda; color:#155724;}
    </style>
</head>
<%
/*     String nominatorEmail = (String) session.getAttribute("candidateEmail");
    if(nominatorEmail == null){
        response.sendRedirect("login.jsp");
        return;
    } */
%>
<body>
<div class="container">
    <a href="candidates.jsp" class="btn-back"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>
    <h1><i class="fas fa-user-plus"></i> Nominate Candidate</h1>

    <div class="form-section">
        <% if (request.getAttribute("errorMessage") != null) { %>
            <div class="alert alert-danger"><%= request.getAttribute("errorMessage") %></div>
        <% } %>
        <% if (request.getAttribute("successMessage") != null) { %>
            <div class="alert alert-success"><%= request.getAttribute("successMessage") %></div>
        <% } %>

        
    </div>

    <div class="list-section">
        <h2><i class="fas fa-list"></i> Nominated Candidates</h2>
        <table>
            <thead>
                <tr>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Roll No</th>
                    <th>Department</th>
                    <th>Student Id</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
            <%
                Connection con = dbconn.create();       
                PreparedStatement ps = con.prepareStatement("SELECT * FROM nominatecandidate WHERE status = ?");
                	ps.setString(1, "Pending");

                ResultSet rs = ps.executeQuery();
                boolean hasData = false;
                while(rs.next()){
                    hasData = true;
                    byte[] blobImage = rs.getBytes("student_id_photo");
            %>
                <tr>
    <td><%=rs.getString("class_department")%></td>
    <td><%=rs.getString("roll_number")%></td>
    <td><%=rs.getString("email")%></td>
    <td><%=rs.getString("mobile")%></td>
    <td>
        <% if(blobImage != null){ 
            String base64 = Base64.getEncoder().encodeToString(blobImage);
        %>
            <img src="data:image/jpeg;base64,<%=base64%>" class="candidate-image">
        <% } else { %>
            <i class="fas fa-user"></i>
        <% } %>
    </td>
    <!-- ACTION BUTTONS -->
    <td>
        <% if("Pending".equalsIgnoreCase(rs.getString("status"))){ %>
            <form action="canapprove.jsp" method="post" style="display:flex; gap:8px;">
                <input type="hidden" name="id" value="<%=rs.getInt("id")%>">

                <button type="submit" name="action" value="approve" class="btn-approve">
                    <i class="fas fa-check"></i> Approve
                </button>

                <button type="submit" name="action" value="reject" class="btn-reject">
                    <i class="fas fa-times"></i> Reject
                </button>
            </form>
        <% } else { %>
            <span>-</span>
        <% } %>
    </td>
</tr>

            <% } 
                if(!hasData){ %>
                    <tr><td colspan="6" style="text-align:center;">No candidates nominated yet</td></tr>
            <% } 
                rs.close();
                ps.close();
                con.close();
            %>
            </tbody>
        </table>
    </div>
</div>

<script>
function validateForm(){
    const name = document.querySelector('input[name="name"]').value.trim();
    const email = document.querySelector('input[name="email"]').value.trim();
    const roll = document.querySelector('input[name="roll"]').value.trim();
    const dept = document.querySelector('input[name="dept"]').value.trim();
    if(!name || !email || !roll || !dept){
        alert("All fields are required.");
        return false;
    }
    return true;
}
</script>
</body>
</html>
