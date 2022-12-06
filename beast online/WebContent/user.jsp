<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>BEAST ONLINE</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<%@ include file="header.jsp" %>

<%
String uuid = request.getParameter("uuid");

String sql = "select firstName, lastName, uuid, kuuid FROM users where uuid = ?";

try 
{
	getConnection();
	Statement stmt = con.createStatement(); 			
	stmt.execute("USE orders");
	
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setString(1, uuid);			
	
	ResultSet rst = pstmt.executeQuery();
			
	if (!rst.next())
	{
		out.println("Invalid product");
	}
	else
	{		
		out.println("<h2>"+rst.getString(1) + " " + rst.getString(2) +"</h2>");
		
		String uid = rst.getString(3);
		String x = rst.getString(4);
		String[] keypart = x.split("-");

		out.println("<table><tr>");
		out.println("<th>User ID</th><td>" + uid + "</td></tr>"				
				+ "<tr><th>User Key starting with: </th><td>" + keypart[0] + "</td></tr>");
		
		out.println("</table>");
	}
} 
catch (SQLException ex) {
	out.println(ex);
}
finally
{
	closeConnection();
}
%>

</body>
</html>

