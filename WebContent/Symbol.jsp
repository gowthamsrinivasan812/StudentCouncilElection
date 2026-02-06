<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="css/bootstrap.min.css">
<title>Insert title here</title>
</head>
<% String pic=request.getParameter("dis");
String email=request.getParameter("email");
%>
<body>


  <div class="container">
  
    <h3 style="font-weight: bold; text-align: center;margin-top: 10px">SYMBOL FORM</h3><br>
  
    <form method="post" action="symboladd" enctype="multipart/form-data">
     <div class="row">
       <div class="card col-sm-5" style="padding-bottom:10px;background-image: radial-gradient(circle, #578574, #50a175, #5cbc68, #7ad54e, #a8eb12);;color:#fff;padding:10px;margin-left:30%;width: 38em;margin-bottom: 25px">
        <div class="form-group">
          <label for="full_name" style="color:#fff;"> Candidate pic</label>
          <img  src="candidate/<%=pic %>" width="190px" height="100px" alt="Card image cap">
          <input type="hidden" class="form-control" id="full_name" placeholder="Enter Full Name" name="pname"  value="<%=pic%>" required>
        </div><br>
        <div class="form-group">
          <label for="email"  style="color:#fff;">Candidate Email</label>
          <input type="text" class="form-control" id="email" placeholder="Enter Email"  name="pemail" value="<%=email%>" required>
          
        </div><br>
       
        <div class="form-group">
          <label for="card_photo"  style="color:#fff;">Add Report File :</label>
          <input type="file" class="form-control" placeholder="Enter password" name="filename" required>
        </div>
        <br>
        <center><button  class="btn btn-primary btn-block"  style="width:50%;" onclick="return Validate()">Submit</button></center><br>
               
      </div>
    </div>
</form>
</div>
</body>
</html>