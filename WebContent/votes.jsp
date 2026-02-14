<%-- <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
   <%@page import="java.io.FileInputStream" %>
    <%@page import="java.io.IOException" %>
    <%@page import="java.io.PrintWriter" %>
    <%@page import="javax.swing.JDialog" %>
    <%@page import="javax.swing.JOptionPane" %>
    <%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement" %>
<%@ page import="dbcon.dbconn" %>
<%@ page import="java.sql.*"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<% String status="Voted"; 
String id=request.getParameter("email");%>
<%
String key1=request.getParameter("fkeyl");

System.out.println("download0000000000000000000===="+key1);
System.out.println("download0000000000000000000===="+id);


  
JOptionPane joptionpane =new JOptionPane("CLICK OK");


JDialog jdialog= joptionpane.createDialog("Alert");

jdialog.setAlwaysOnTop(true);

jdialog.show();

String newkey =JOptionPane.showInputDialog("Enter Your Vote Key");

Connection con;
con=dbconn.create();
if(newkey.equals(key1))

	try{
		String key="";
		Statement st=con.createStatement();
		st.executeUpdate("UPDATE `studentvoute`.`voteid` set votekey='"+key+"' where studentmail='"+id+"' ");
		System.out.println("download0000000000000000000===="+id);
		response.sendRedirect("faceauthentication.jsp?id=" + id);
	}
	
catch(Exception e)
{
	e.printStackTrace();
}




else
{
System.out.println("failed");
	
	JOptionPane.showMessageDialog(null, "Sorry Your key is wrong");
	
	response.sendRedirect("Error.jsp");
}		


%>



</body>
</html> --%>


<%@ page import="java.sql.*" %>
<%@ page import="dbcon.dbconn" %>

<%
String id = request.getParameter("email");
String key1 = request.getParameter("fkeyl");
String enteredKey = request.getParameter("voteKey");

if (enteredKey != null) {

    Connection con = null;
    try {
        con = dbconn.create();

        if (enteredKey.equals(key1)) {

            String key = "";
            PreparedStatement ps = con.prepareStatement(
                "UPDATE studentvoute.voteid SET votekey=? WHERE studentmail=?"
            );
            ps.setString(1, key);
            ps.setString(2, id);
            ps.executeUpdate();

            response.sendRedirect("faceauthentication.jsp?id=" + id);

        } else {
%>
            <script>
                alert("Sorry! Your Vote Key is wrong.");
            </script>
<%
        }

    } catch (Exception e) {
        e.printStackTrace();
    }
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Vote Key Verification</title>

<style>
body {
    margin: 0;
    padding: 0;
    font-family: Arial, sans-serif;
    background: linear-gradient(to right, #1e3c72, #2a5298);
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
}

.container {
    background: #ffffff;
    padding: 40px;
    width: 400px;
    border-radius: 10px;
    box-shadow: 0 10px 25px rgba(0,0,0,0.2);
    text-align: center;
}

h2 {
    margin-bottom: 25px;
    color: #1e3c72;
}

input[type="text"] {
    width: 90%;
    padding: 12px;
    margin: 15px 0;
    border-radius: 6px;
    border: 1px solid #ccc;
    font-size: 16px;
}

button {
    width: 100%;
    padding: 12px;
    border: none;
    border-radius: 6px;
    background-color: #1e3c72;
    color: white;
    font-size: 16px;
    cursor: pointer;
    transition: 0.3s;
}

button:hover {
    background-color: #2a5298;
}

.footer {
    margin-top: 20px;
    font-size: 13px;
    color: #777;
}
</style>

</head>
<body>

<div class="container">
    <h2>Vote Key Verification</h2>

    <form method="post">
        <input type="hidden" name="email" value="<%=id%>">
        <input type="hidden" name="fkeyl" value="<%=key1%>">

        <input type="text" name="voteKey" placeholder="Enter Your Vote Key" required>

        <button type="submit">Verify & Continue</button>
    </form>

    <div class="footer">
        Secure Online Voting System
    </div>
</div>

</body>
</html>
