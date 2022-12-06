<!DOCTYPE html>
<html>
<head>
<title>All Employees</title>
</head>
<body>

<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>

<%
	String userName = (String) session.getAttribute("authenticatedUser");
%>

<%

String sql = "select firstName, lastName, uuid, u.kuuid, clearanceLevel FROM keyCards k JOIN users u on k.kuuid = u.kuuid";

try 
{	
	out.println("<h3>All users</h3>");
	
	getConnection();
	Statement stmt = con.createStatement(); 
	stmt.execute("USE orders");

	PreparedStatement pstmt = con.prepareStatement(sql);
	ResultSet rst = pstmt.executeQuery();
	
	while(rst.next())
	{
		out.println("<table class=\"table\" border=\"1\">");

		out.println("<tr><th>First Name</th><td>"+rst.getString(1)+"</td></tr>");
		out.println("<tr><th>Last Name</th><td>"+rst.getString(2)+"</td></tr>");
		out.println("<tr><th>User ID</th><td>"+rst.getString(3)+"</td></tr>");
		String x = rst.getString(4);
		String[] keypart = x.split("-");
		out.println("<tr><th>Key ID</th><td>"+ "Key starting with: " + keypart[0]+"</td></tr>");
		out.println("<tr><th>Clearance Level</th><td>"+rst.getString(5)+"</td></tr>");
		out.println("</table>");
	}
}
catch (SQLException ex) 
{ 	out.println(ex); 
}
finally
{	
	closeConnection();	
}
%>

</body>
</html>

