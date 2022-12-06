<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>BEAST ONLINE</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="styles.css" rel="stylesheet">
</head>
<body>

	<h1>Search for user using clearance level:</h1>

	<form method="get" action="searchusers.jsp">
	<input type="text" name="clevel" size="50">
	<input type="submit" value="Submit"><input type="reset" value="Reset"> (Enter clearance level)
	</form>
	
	<% 
	try
	{	// Load driver class
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	}
	catch (java.lang.ClassNotFoundException e)
	{
		out.println("ClassNotFoundException: " +e);
	}
		String clevel = request.getParameter("clevel");
		String SQL = "Select firstName, lastName, clearanceLevel, uuid FROM keyCards k JOIN users u on k.kuuid = u.kuuid where clearanceLevel = ?";
	
		try{
		getConnection();
		Statement use = con.createStatement();
		use.execute("Use orders");
		PreparedStatement pstmt = con.prepareStatement(SQL);
		pstmt.setString(1, clevel);
		ResultSet res = pstmt.executeQuery();
		out.println("<table><tr><th> User </th> <th> Clearance Level </th></tr>");
			
		
		while(res.next())
		{
			String uname = res.getString("firstName") + " " + res.getString("lastName");
			int ulevel = res.getInt("clearanceLevel");
			String uid = res.getString("uuid");
					
			out.print("<tr><td><a href=user.jsp?uuid="+ uid +">" +uname + "</a></td>");
			out.print("<td>" + clevel + "</td>");
			out.println("</tr>");
		}
			out.println("</table>");
			
	}
	catch(SQLException ex){
		System.err.println("SQLException: " + ex);
	}
	%>

</body>
</html>

