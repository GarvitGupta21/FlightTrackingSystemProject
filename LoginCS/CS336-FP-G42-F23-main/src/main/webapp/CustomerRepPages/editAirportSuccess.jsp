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
		String old_Airport_Id = request.getParameter("Old_Airline_Id");
		String airport_Id = request.getParameter("Airport_Id");
		String airport_Name = request.getParameter("Airport_Name");
		 
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
			
		String sql = "UPDATE Airport SET Airport_Id = ?, Airport_Name = ? WHERE Airport_Id = ?";
		PreparedStatement ps = con.prepareStatement(sql);
			
		ps.setString(1, airport_Id);
		ps.setString(2, airport_Name);
		ps.setString(3, old_Airport_Id);
		ps.executeUpdate();
    			
	   	con.close();
		
	%>

<a href='crAirports.jsp'>Airport Info Changed</a>



</body>
</html>