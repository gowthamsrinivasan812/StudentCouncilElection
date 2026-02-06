<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
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
</html>