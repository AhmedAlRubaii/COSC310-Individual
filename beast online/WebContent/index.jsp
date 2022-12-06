<!DOCTYPE html>
<html>
<head>
<title>BEAST ONLINE</title>
</head>
<body>
<h1 align="center">B.E.A.S.T &nbsp;&nbsp;&nbsp; ONLINE</h1>

<%
	String userName = (String) session.getAttribute("authenticatedUser");
	if (userName != null){
		out.println("<h3 align=\"center\">Signed in as: "+userName+"</h3>");
		out.println("<h2 align=\"center\"><a href=\"logout.jsp\">Log out</a></h2>");
		out.println("<h2 align=\"center\"><a href=\"searchusers.jsp\">Search users by clearance level</a></h2>");
		out.println("<h2 align=\"center\"><a href=\"allemployees.jsp\">List all employees</a></h2>");

		
		
	}
	else{

		out.println("<h2 align=\"center\"><a href=\"login.jsp\">Login</a></h2>");
	}

%>







</body>
</head>


