<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Question Post Confirmation</title>
</head>
<body>

<%
		String Old_User_name = request.getParameter("Old_User_name");
		String User_name = request.getParameter("User_name");
		String Password = request.getParameter("Password");
		String type = request.getParameter("type");
		 
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
			
		String sql = "UPDATE Account SET User_name = ?, Password = ?,  type = ? WHERE User_name = ?";
		PreparedStatement ps = con.prepareStatement(sql);
			
		ps.setString(1, User_name);
		ps.setString(2, Password);
		ps.setString(3, type);
		ps.setString(4, Old_User_name);
		ps.executeUpdate();
    			
	   	con.close();
		
	%>

<a href='adminAddEditDelete.jsp'>Account Info Changed</a>



</body>
</html>