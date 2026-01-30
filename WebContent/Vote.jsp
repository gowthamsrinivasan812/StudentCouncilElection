<%-- 
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="dbcon.dbconn"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="Servlet.LocalDate"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Voting Portal - Secure Online Voting</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="css/bootstrap.min.css">
<style>
:root {
	--primary: #2c3e50;
	--secondary: #3498db;
	--accent: #e74c3c;
	--success: #2ecc71;
	--light: #ecf0f1;
	--dark: #2c3e50;
	--gradient: linear-gradient(135deg, #3498db, #2c3e50);
	--shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
	--transition: all 0.3s ease;
}

* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: 'Poppins', sans-serif;
}

body {
	background: var(--gradient);
	min-height: 100vh;
	padding: 20px;
	position: relative;
	overflow-x: hidden;
}

body::before {
	content: '';
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background:
		url('data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxMDAlIiBoZWlnaHQ9IjEwMCUiPjxkZWZzPjxwYXR0ZXJuIGlkPSJwYXR0ZXJuIiB3aWR0aD0iNDAiIGhlaWdodD0iNDAiIHBhdHRlcm5Vbml0cz0idXNlclNwYWNlT25Vc2UiIHBhdHRlcm5UcmFuc2Zvcm09InJvdGF0ZSg0NSkiPjxyZWN0IHdpZHRoPSIyMCIgaGVpZ2h0PSIyMCIgZmlsbD0icmdiYSgyNTUsMjU1LDI1NSwwLjA1KSIvPjwvcGF0dGVybj48L2RlZnM+PHJlY3QgZmlsbD0idXJsKCNwYXR0ZXJuKSIgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSIvPjwvc3ZnPg==');
	z-index: -1;
}

.video-background {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	z-index: -2;
	opacity: 0.1;
}

video {
	object-fit: cover;
	width: 100%;
	height: 100%;
}

.main-container {
	max-width: 1200px;
	margin: 0 auto;
}

.header-section {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 30px;
	flex-wrap: wrap;
	gap: 20px;
}

.page-title {
	color: white;
	font-size: 2.5rem;
	font-weight: 700;
	text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
}

.btn-back {
	background: rgba(255, 255, 255, 0.2);
	border: 2px solid rgba(255, 255, 255, 0.3);
	padding: 12px 25px;
	border-radius: 12px;
	color: white;
	font-weight: 600;
	transition: var(--transition);
	display: inline-flex;
	align-items: center;
	gap: 8px;
	text-decoration: none;
	backdrop-filter: blur(10px);
	cursor: pointer;
}

.btn-back:hover {
	background: rgba(255, 255, 255, 0.3);
	transform: translateY(-2px);
	color: white;
}

.election-date-banner {
	background: rgba(255, 255, 255, 0.95);
	border-radius: 15px;
	padding: 20px;
	margin-bottom: 30px;
	text-align: center;
	box-shadow: var(--shadow);
	backdrop-filter: blur(10px);
	border-left: 5px solid var(--success);
}

.election-date-banner h4 {
	color: var(--primary);
	font-size: 1.3rem;
	margin-bottom: 10px;
	display: flex;
	align-items: center;
	justify-content: center;
	gap: 10px;
}

.election-date-banner span {
	color: var(--accent);
	font-weight: 700;
}

.voting-card {
	background: rgba(255, 255, 255, 0.95);
	border-radius: 20px;
	padding: 30px;
	box-shadow: var(--shadow);
	backdrop-filter: blur(10px);
	margin-bottom: 30px;
}

.card-title {
	font-size: 1.8rem;
	color: var(--primary);
	margin-bottom: 25px;
	text-align: center;
	display: flex;
	align-items: center;
	justify-content: center;
	gap: 10px;
}

.card-title i {
	color: var(--secondary);
}

.voting-table {
	width: 100%;
	background: white;
	border-radius: 15px;
	overflow: hidden;
	box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
	border: none;
}

.voting-table thead {
	background: linear-gradient(45deg, var(--primary), var(--secondary));
}

.voting-table th {
	color: white;
	padding: 20px 15px;
	text-align: center;
	font-weight: 600;
	font-size: 1rem;
	border: none;
	text-transform: uppercase;
	letter-spacing: 0.5px;
}

.voting-table td {
	padding: 20px 15px;
	border-bottom: 1px solid #e1e5ee;
	vertical-align: middle;
	text-align: center;
	border: none;
	font-weight: 500;
	color: var(--dark);
}

.voting-table tbody tr {
	transition: var(--transition);
	background: white;
}

.voting-table tbody tr:hover {
	background: rgba(52, 152, 219, 0.08);
	transform: translateY(-2px);
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
}

.district-badge, .assembly-badge {
	background: linear-gradient(45deg, #3498db, #2980b9);
	color: white;
	padding: 8px 15px;
	border-radius: 20px;
	font-weight: 500;
	font-size: 0.9rem;
	display: inline-block;
}

.assembly-badge {
	background: linear-gradient(45deg, #9b59b6, #8e44ad);
}

.vote-key {
	background: linear-gradient(45deg, #e74c3c, #c0392b);
	color: white;
	padding: 8px 15px;
	border-radius: 20px;
	font-weight: 600;
	font-size: 0.9rem;
	display: inline-block;
	letter-spacing: 1px;
}

.btn-vote {
	background: linear-gradient(45deg, var(--success), #27ae60);
	color: white;
	border: none;
	padding: 12px 25px;
	border-radius: 10px;
	font-weight: 600;
	cursor: pointer;
	transition: var(--transition);
	display: inline-flex;
	align-items: center;
	gap: 8px;
	text-decoration: none;
	box-shadow: 0 4px 15px rgba(46, 204, 113, 0.4);
}

.btn-vote:hover {
	transform: translateY(-3px);
	box-shadow: 0 6px 20px rgba(46, 204, 113, 0.6);
	color: white;
}

.empty-state {
	text-align: center;
	padding: 60px 20px;
	color: #7f8c8d;
}

.empty-state i {
	font-size: 4rem;
	margin-bottom: 20px;
	opacity: 0.4;
}

.empty-state h4 {
	font-size: 1.5rem;
	margin-bottom: 10px;
	color: var(--primary);
}

.empty-state p {
	font-size: 1rem;
	max-width: 500px;
	margin: 0 auto;
}

.security-notice {
	background: rgba(52, 152, 219, 0.1);
	border: 1px solid rgba(52, 152, 219, 0.3);
	border-radius: 10px;
	padding: 15px;
	margin-top: 20px;
	text-align: center;
	font-size: 0.9rem;
}

.security-notice i {
	color: var(--secondary);
	margin-right: 8px;
}

@
keyframes fadeInUp {from { opacity:0;
	transform: translateY(30px);
}

to {
	opacity: 1;
	transform: translateY(0);
}

}
.voting-card {
	animation: fadeInUp 0.8s ease-out;
}

@
keyframes pulse { 0% {
	transform: scale(1);
}

50
%
{
transform
:
scale(
1.05
);
}
100
%
{
transform
:
scale(
1
);
}
}
.pulse {
	animation: pulse 2s infinite;
}

@media ( max-width : 768px) {
	.header-section {
		flex-direction: column;
		text-align: center;
	}
	.page-title {
		font-size: 2rem;
	}
	.voting-table {
		display: block;
		overflow-x: auto;
	}
	.voting-table th, .voting-table td {
		padding: 15px 10px;
		font-size: 0.9rem;
	}
}
</style>
</head>

<%
    String email = session.getAttribute("studentEmail").toString();
    String pattern = "yyyy-MM-dd";
    SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
    String date = simpleDateFormat.format(new Date());
    System.out.println(date);
%>

<body>
	<div class="video-background">
		<video autoplay loop muted playsinline>
			<source src="image/video (2).mp4" type="video/mp4">
		</video>
	</div>

	<div class="main-container">

		<div class="header-section">
			<h1 class="page-title">
				<i class="fas fa-vote-yea"></i> Voting Portal
			</h1>
			<button onclick="goBack()" class="btn-back">
				<i class="fas fa-arrow-left"></i> Go Back
			</button>
		</div>


		<div class="election-date-banner">
			<h4>
				<i class="fas fa-calendar-alt"></i> Election <span>Date</span>
				<%
                    Connection con = dbconn.create();
                    PreparedStatement ps = con.prepareStatement("SELECT * FROM `studentvoute`.`voteid` where status='Allot' and Edate='" + date + "' and stuentmail='" + email + "'");
                    ResultSet rs = ps.executeQuery();
                    if (rs.next()) {
                        String dates = rs.getString(7);
                %>
				<%= dates %>
				<%
                    }
                    rs.close();
                    ps.close();
                %>
			</h4>
			<p>Cast your vote securely and help shape the future!</p>
		</div>


		<div class="voting-card">
			<h2 class="card-title">
				<i class="fas fa-list-ol"></i> Available Elections
			</h2>

			<div class="table-responsive">
				<table class="voting-table">
					<thead>
						<tr>
							<th>District</th>
							<th>Assembly Ward</th>
							<th>Vote Key</th>
							<th>Vote Here!!</th>
						</tr>
					</thead>
					<tbody>
						<%
                            ps = con.prepareStatement("SELECT * FROM `vote`.`voteid` where status='Allot' and edate='" + date + "' and email='" + email + "'");
                            rs = ps.executeQuery();
                            
                            boolean hasElections = false;
                            while (rs.next()) {
                                hasElections = true;
                                String pic = rs.getString(1);
                                String dates = rs.getString(7);
                        %>
						<tr>
							<td><span class="district-badge"> <i
									class="fas fa-map-marker-alt"></i> <%= rs.getString(1) %>
							</span></td>
							<td><span class="assembly-badge"> <i
									class="fas fa-landmark"></i> <%= rs.getString(2) %>
							</span></td>
							<td><span class="vote-key"> <i class="fas fa-key"></i>
									<%= rs.getString(8) %>
							</span></td>
							<td><a
								href="votes.jsp?fkeyl=<%= rs.getString(8) %>&&email=<%= rs.getString(3) %>"
								class="btn-vote"> <i class="fas fa-check-circle"></i> Vote
									Now
							</a></td>
						</tr>
						`<%
                            }
                            
                            if (!hasElections) {
                        %>
						<tr>
							<td colspan="4">
								<div class="empty-state">
									<i class="fas fa-inbox"></i>
									<h4>No Elections Available</h4>
									<p>There are no active elections for you to vote in at the
										moment.</p>
								</div>
							</td>
						</tr>
						<%
                            }
                            rs.close();
                            ps.close();
                            con.close();
                        %>
					</tbody>
				</table>
			</div>

			<div class="security-notice">
				<i class="fas fa-shield-alt"></i> <span>Secure Voting:</span> Your
				vote is encrypted and completely anonymous. The system ensures one
				vote per person.
			</div>
		</div>
	</div>

	<script>
        function goBack() {
            window.history.back();
        }
        
        
        document.addEventListener('DOMContentLoaded', function() {
            const rows = document.querySelectorAll('.voting-table tbody tr');
            rows.forEach((row, index) => {
                row.style.animationDelay = `${index * 0.1}s`;
            });
        });
        
        
        window.addEventListener('load', function() {
            document.body.style.opacity = 1;
        });
        
        document.body.style.opacity = 0;
        document.body.style.transition = 'opacity 0.5s ease';
    </script>
</body>
</html>

 --%>
 
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="dbcon.dbconn"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="Servlet.LocalDate"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Voting Portal - Secure Online Voting</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <style>
        :root {
            --primary: #2c3e50;
            --secondary: #3498db;
            --accent: #e74c3c;
            --success: #2ecc71;
            --light: #ecf0f1;
            --dark: #2c3e50;
            --gradient: linear-gradient(135deg, #3498db, #2c3e50);
            --shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            --transition: all 0.3s ease;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }
        
        body {
            background: var(--gradient);
            min-height: 100vh;
            padding: 20px;
            position: relative;
            overflow-x: hidden;
        }
        
        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxMDAlIiBoZWlnaHQ9IjEwMCUiPjxkZWZzPjxwYXR0ZXJuIGlkPSJwYXR0ZXJuIiB3aWR0aD0iNDAiIGhlaWdodD0iNDAiIHBhdHRlcm5Vbml0cz0idXNlclNwYWNlT25Vc2UiIHBhdHRlcm5UcmFuc2Zvcm09InJvdGF0ZSg0NSkiPjxyZWN0IHdpZHRoPSIyMCIgaGVpZ2h0PSIyMCIgZmlsbD0icmdiYSgyNTUsMjU1LDI1NSwwLjA1KSIvPjwvcGF0dGVybj48L2RlZnM+PHJlY3QgZmlsbD0idXJsKCNwYXR0ZXJuKSIgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSIvPjwvc3ZnPg==');
            z-index: -1;
        }
        
        .video-background {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -2;
            opacity: 0.1;
        }
        
        video {
            object-fit: cover;
            width: 100%;
            height: 100%;
        }
        
        .main-container {
            max-width: 1200px;
            margin: 0 auto;
        }
        
        .header-section {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            flex-wrap: wrap;
            gap: 20px;
        }
        
        .page-title {
            color: white;
            font-size: 2.5rem;
            font-weight: 700;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
        }
        
        .btn-back {
            background: rgba(255, 255, 255, 0.2);
            border: 2px solid rgba(255, 255, 255, 0.3);
            padding: 12px 25px;
            border-radius: 12px;
            color: white;
            font-weight: 600;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
            backdrop-filter: blur(10px);
            cursor: pointer;
        }
        
        .btn-back:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: translateY(-2px);
            color: white;
        }
        
        .election-date-banner {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 30px;
            text-align: center;
            box-shadow: var(--shadow);
            backdrop-filter: blur(10px);
            border-left: 5px solid var(--success);
        }
        
        .election-date-banner h4 {
            color: var(--primary);
            font-size: 1.3rem;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }
        
        .election-date-banner span {
            color: var(--accent);
            font-weight: 700;
        }
        
        .voting-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 30px;
            box-shadow: var(--shadow);
            backdrop-filter: blur(10px);
            margin-bottom: 30px;
        }
        
        .card-title {
            font-size: 1.8rem;
            color: var(--primary);
            margin-bottom: 25px;
            text-align: center;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }
        
        .card-title i {
            color: var(--secondary);
        }
        
        .voting-table {
            width: 100%;
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
            border: none;
        }
        
        .voting-table thead {
            background: linear-gradient(45deg, var(--primary), var(--secondary));
        }
        
        .voting-table th {
            color: white;
            padding: 20px 15px;
            text-align: center;
            font-weight: 600;
            font-size: 1rem;
            border: none;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .voting-table td {
            padding: 20px 15px;
            border-bottom: 1px solid #e1e5ee;
            vertical-align: middle;
            text-align: center;
            border: none;
            font-weight: 500;
            color: var(--dark);
        }
        
        .voting-table tbody tr {
            transition: var(--transition);
            background: white;
        }
        
        .voting-table tbody tr:hover {
            background: rgba(52, 152, 219, 0.08);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        
        .district-badge, .assembly-badge {
            background: linear-gradient(45deg, #3498db, #2980b9);
            color: white;
            padding: 8px 15px;
            border-radius: 20px;
            font-weight: 500;
            font-size: 0.9rem;
            display: inline-block;
        }
        
        .assembly-badge {
            background: linear-gradient(45deg, #9b59b6, #8e44ad);
        }
        
        .vote-key {
            background: linear-gradient(45deg, #e74c3c, #c0392b);
            color: white;
            padding: 8px 15px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.9rem;
            display: inline-block;
            letter-spacing: 1px;
        }
        
        .btn-vote {
            background: linear-gradient(45deg, var(--success), #27ae60);
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 10px;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
            box-shadow: 0 4px 15px rgba(46, 204, 113, 0.4);
        }
        
        .btn-vote:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(46, 204, 113, 0.6);
            color: white;
        }
        
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #7f8c8d;
        }
        
        .empty-state i {
            font-size: 4rem;
            margin-bottom: 20px;
            opacity: 0.4;
        }
        
        .empty-state h4 {
            font-size: 1.5rem;
            margin-bottom: 10px;
            color: var(--primary);
        }
        
        .empty-state p {
            font-size: 1rem;
            max-width: 500px;
            margin: 0 auto;
        }
        
        .security-notice {
            background: rgba(52, 152, 219, 0.1);
            border: 1px solid rgba(52, 152, 219, 0.3);
            border-radius: 10px;
            padding: 15px;
            margin-top: 20px;
            text-align: center;
            font-size: 0.9rem;
        }
        
        .security-notice i {
            color: var(--secondary);
            margin-right: 8px;
        }
        
        
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .voting-card {
            animation: fadeInUp 0.8s ease-out;
        }
        
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }
        
        .pulse {
            animation: pulse 2s infinite;
        }
        
        @media (max-width: 768px) {
            .header-section {
                flex-direction: column;
                text-align: center;
            }
            
            .page-title {
                font-size: 2rem;
            }
            
            .voting-table {
                display: block;
                overflow-x: auto;
            }
            
            .voting-table th,
            .voting-table td {
                padding: 15px 10px;
                font-size: 0.9rem;
            }
        }
    </style>
</head>

<%
    String email = session.getAttribute("studentEmail").toString();
    String pattern = "yyyy-MM-dd";
    SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
    String date = simpleDateFormat.format(new Date());
    System.out.println(date);
%>

<body>
    <div class="video-background">
        <video autoplay loop muted playsinline>
            <source src="image/video (2).mp4" type="video/mp4">
        </video>
    </div>

    <div class="main-container">
       
        <div class="header-section">
            <h1 class="page-title">
                <i class="fas fa-vote-yea"></i>
                Voting Portal
            </h1>
            <button onclick="goBack()" class="btn-back">
                <i class="fas fa-arrow-left"></i>
                Go Back
            </button>
        </div>

        
        <div class="election-date-banner">
            <h4>
                <i class="fas fa-calendar-alt"></i>
                Election <span>Date</span>
                <%
                    Connection con = dbconn.create();
                    PreparedStatement ps = con.prepareStatement("SELECT * FROM `studentvoute`.`voteid` where status='Allot' and Edate='" + date + "' and studentmail='" + email + "'");
                    ResultSet rs = ps.executeQuery();
                    if (rs.next()) {
                        String dates = rs.getString(7);
                %>
                <%= dates %>
                <%
                    }
                    rs.close();
                    ps.close();
                %>
            </h4>
            <p>Cast your vote securely and help shape the future!</p>
        </div>

       
        <div class="voting-card">
            <h2 class="card-title">
                <i class="fas fa-list-ol"></i>
                Available Elections
            </h2>
            
            <div class="table-responsive">
                <table class="voting-table">
                    <thead>
                        <tr>
                            
                            <th>Voter Name</th>
                            <th>Voter Mail</th>
                            <th>Vote Key</th>
                            <th>Vote Here!!</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            ps = con.prepareStatement("SELECT * FROM `studentvoute`.`voteid` where status='Allot' and Edate='" + date + "' and studentmail='" + email + "'");
                            rs = ps.executeQuery();
                            
                            boolean hasElections = false;
                            while (rs.next()) {
                                hasElections = true;
                                String pic = rs.getString(1);
                                String dates = rs.getString(7);
                        %>
                        <tr>
                            <td>
                                <span class="district-badge">
                                    <%= rs.getString(2) %>
                                </span>
                            </td>
                            <td>
                                <span class="assembly-badge">
                                    <%= rs.getString(3) %>
                                </span>
                            </td>
                            <td>
                                <span class="vote-key">
                                    <i class="fas fa-key"></i>
                                    <%= rs.getString(7) %>
                                </span>
                            </td>
                            <td>
                                <a href="votes.jsp?fkeyl=<%= rs.getString(7) %>&&email=<%= rs.getString(3) %>" 
                                   class="btn-vote">
                                    <i class="fas fa-check-circle"></i>
                                    Vote Now
                                </a>
                            </td>
                        </tr>
                        <%
                            }
                            
                            if (!hasElections) {
                        %>
                        <tr>
                            <td colspan="4">
                                <div class="empty-state">
                                    <i class="fas fa-inbox"></i>
                                    <h4>No Elections Available</h4>
                                    <p>There are no active elections for you to vote in at the moment.</p>
                                </div>
                            </td>
                        </tr>
                        <%
                            }
                            rs.close();
                            ps.close();
                            con.close();
                        %>
                    </tbody>
                </table>
            </div>

            <div class="security-notice">
                <i class="fas fa-shield-alt"></i>
                <span>Secure Voting:</span> Your vote is encrypted and completely anonymous. The system ensures one vote per person.
            </div>
        </div>
    </div>

    <script>
        function goBack() {
            window.history.back();
        }
        
        
        document.addEventListener('DOMContentLoaded', function() {
            const rows = document.querySelectorAll('.voting-table tbody tr');
            rows.forEach((row, index) => {
                row.style.animationDelay = `${index * 0.1}s`;
            });
        });
        
        
        window.addEventListener('load', function() {
            document.body.style.opacity = 1;
        });
        
        document.body.style.opacity = 0;
        document.body.style.transition = 'opacity 0.5s ease';
    </script>
</body>
</html>
 