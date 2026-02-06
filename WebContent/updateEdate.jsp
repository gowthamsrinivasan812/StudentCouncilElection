<%@ page import="java.sql.*" %>
<%@page import="dbcon.dbconn"%>

<%
    String electionName = request.getParameter("election_name");
    String electionDate = request.getParameter("election_date");

    Connection con = null;
    PreparedStatement ps = null;
    PreparedStatement pst=null;

    try {
    	con=dbconn.create();
        String sql = "INSERT INTO `studentvoute`.`election_date` (ElectionDate,winner,Electionname) VALUES (?, ?, ?)";
        ps = con.prepareStatement(sql);

        // Set values
        ps.setString(1, electionDate);
        ps.setString(2, "pending");
        ps.setString(3, electionName);

        int rows = ps.executeUpdate();

        if (rows > 0) {
            out.println("<h3>Election inserted successfully!</h3>");
           
        } else {
            out.println("<h3>Insert failed.</h3>");
        }  
      
    } catch (Exception e) {
        out.println("<h3>Error: " + e.getMessage() + "</h3>");
    } finally {
        try {
            if (ps != null) ps.close();
            if (con != null) con.close();
        } catch (Exception e) {
            out.println(e.getMessage());
        }
    }
%>
