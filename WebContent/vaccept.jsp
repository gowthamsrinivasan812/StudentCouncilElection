<%@ page import="dbcon.dbconn" %>
<%@page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.*"%>
<%@ page import="mail.mail1"%>
<%



String email=request.getParameter("email");


String status="Accepted";
try{
	Connection con=dbconn.create();
	Statement st=con.createStatement();
	st.executeUpdate("UPDATE `studentvoute`.`voteid` set status='"+status+"' where studentmail='"+email+"' ");
	
	response.sendRedirect("Voters.jsp");
}
catch(Exception e){
	response.sendRedirect("error.jsp?inval id");
System.out.println(e);
}
%>