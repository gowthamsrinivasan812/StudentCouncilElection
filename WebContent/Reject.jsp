<%@ page import="dbcon.dbconn" %>
<%@page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.*"%>
<%
String id=request.getParameter("email");
String status="Rejected";



try{
	Connection con=dbconn.create();
	Statement st=con.createStatement();
	st.executeUpdate("UPDATE studentvoute.nominatecandidate set statuss='"+status+"' where email='"+id+"' ");
	
	response.sendRedirect("Nominationview.jsp?valid");
}

catch(Exception e){
	response.sendRedirect("error.jsp?inval id");
System.out.println(e);
}
%>