<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="dbcon.dbconn" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Student Election Commission</title>

<style>
    body {
        margin: 0;
        font-family: "Segoe UI", Arial, sans-serif;
        background-color: #f2f4f7;
    }

    /* Header */
    .header {
        background-color: #1f3c88;
        color: white;
        padding: 15px;
        text-align: center;
    }

    .header h1 {
        margin: 0;
        font-size: 26px;
    }

    .header p {
        margin: 5px 0 0;
        font-size: 14px;
    }

    /* Container */
    .container {
        width: 85%;
        margin: 30px auto;
        background-color: white;
        padding: 25px;
        border-radius: 8px;
        box-shadow: 0px 0px 10px rgba(0,0,0,0.1);
    }

    h2 {
        text-align: center;
        color: #1f3c88;
        margin-bottom: 20px;
    }

    /* Table */
    table {
        width: 100%;
        border-collapse: collapse;
    }

    table thead {
        background-color: #1f3c88;
        color: white;
    }

    table th, table td {
        padding: 12px;
        text-align: center;
        border-bottom: 1px solid #ddd;
    }

    table tr:hover {
        background-color: #f1f5ff;
    }

    /* Status badge */
    .status {
        padding: 5px 12px;
        border-radius: 20px;
        font-size: 13px;
        color: white;
        background-color: #f39c12;
    }

    /* Footer */
    .footer {
        text-align: center;
        margin-top: 20px;
        font-size: 13px;
        color: #555;
    }
</style>

</head>
<body>

<!-- Header -->
<div class="header">
    <h1>Student Election Commission</h1>
    <p>Official Election Schedule & Monitoring System</p>
</div>

<!-- Content -->
<div class="container">
    <h2>Election Schedule</h2>

    <table>
        <thead>
            <tr>
                <th>S.No</th>
                <th>Election Name</th>
                <th>Election Date</th>
            </tr>
        </thead>

        <tbody>
        <%
            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            int count = 1;

            try {
                con = dbconn.create();
                String sql = "SELECT * FROM election_date";
                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();

                while (rs.next()) {
        %>
            <tr>
                <td><%= count++ %></td>
                <td><%= rs.getString("Electionname") %></td>
                <td><%= rs.getString("ElectionDate") %></td>
             
            </tr>
        <%
                }
            } catch (Exception e) {
                out.println("<tr><td colspan='4'>Error loading data</td></tr>");
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (ps != null) ps.close();
                    if (con != null) con.close();
                } catch (Exception e) {}
            }
        %>
        </tbody>
    </table>
</div>

<!-- Footer -->
<div class="footer">
    © 2025 Student Election Commission | Secure & Transparent Voting System
</div>

</body>
</html>
