<html>
 <%@page import="java.util.*" %>
<link rel="stylesheet" href="css1/bootstrap.min.css">
<head>
  <title>Form Validation</title>
  <Style>
body{
background-image:url("image/24.jpg");
background-size:cover;
}

#sig-canvas {
  border: 2px dotted #CCCCCC;
  border-radius: 15px;
  cursor: crosshair;
}
</Style>
  
</head>
<% String email=request.getParameter("email");
String ass=request.getParameter("ass");
String dis=request.getParameter("dis");
String mobile=request.getParameter("mobile");
String pic=request.getParameter("pic");%>
<body>
<form action="nomination" method="post" enctype="multipart/form-data"><br>
<h3>
complainer Details </h3>
  <div class="form-row">
    <div class="form-group col-md-6">
      <label for="inputEmail4">Candidate image</label>
      <img  src="candidate/<%=pic %>" width="100px" height="80px" alt="Card image cap">
            <input type="hidden" class="form-control" id="inputPassword4" name="pic" value="<%=pic %>"  placeholder="Enter Email Address" readonly>
      
    </div>
    <div class="form-group col-md-6">
      <label for="inputPassword4">Email:</label>
      <input type="email" class="form-control" id="inputPassword4" name="email"  value="<%=email %>" placeholder="Enter Email Address" readonly>
    </div>
  </div>
  <div class="form-group">
    <label for="inputAddress"></label>
    <input type="text" class="form-control" id="inputAddress" name="add"  value="<%=dis %>" placeholder="Ex 1234 Main St" readonly>
  </div>
  
     <div class="form-row">
    <div class="form-group col-md-4">
      <label for="inputCity">Full Name</label>
      <input type="text" name="doc" value="<%=ass %>" class="form-control" id="inputCity" readonly>
    </div>
   
    <div class="form-group col-md-4">
      <label for="inputZip">Contact Number</label>
      <input type="number" name="number" value="<%=mobile %>" class="form-control" id="inputZip" readonly>
    </div>
 
  
         </div>
  
    <h3>Candidate declaration</h3>
   I am aware that making a statement or declaration which is false and which I know or believe to be false or do not believe to be true, is
  punishable under Section 31 of the Representation of the People Act, 1950 (43 of 1950).
  

 
  
  <div class="form-row">
    <div class="form-group col-md-6">
      <label for="inputCity">Candidate Name</label>
      <input type="text" name="type" class="form-control" id="inputCity" required>
    </div>
    </div>
     <div class="form-row">
    <div class="form-group col-md-6">
      <label for="inputCity">Date </label>
      <input type="date" name="street" class="form-control" id="inputCity" required>
    </div>
  </div>
  
  
   <div class="row">
			<div class="col-md-12">
			      <label for="inputCity">Signature </label>
			
		 		<canvas id="sig-canvas" name="photo" width="620" height="160">
		 		
		 		</canvas>
		 	</div>
		</div>
	
      
        
<center><br>
  <button type="submit" class="btn btn-primary">SUBMIT </button>
  </center>
</form>
</body>


</html>