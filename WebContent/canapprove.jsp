<%@ page import="java.sql.*" %>
<%@ page import="dbcon.dbconn" %>

<%
    String id = request.getParameter("id");
    String action = request.getParameter("action");

    String status = "";
    if("approve".equals(action)){
        status = "Approved";
    } else if("reject".equals(action)){
        status = "Rejected";
    }

    Connection con = dbconn.create();
    PreparedStatement ps = con.prepareStatement(
        "UPDATE nominatecandidate SET status=? WHERE id=?"
    );
    ps.setString(1, status);
    ps.setInt(2, Integer.parseInt(id));
    ps.executeUpdate();

    ps.close();
    con.close();

    response.sendRedirect("nomination.jsp");
%>
