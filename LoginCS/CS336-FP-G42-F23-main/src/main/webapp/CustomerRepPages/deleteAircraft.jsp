<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Aircraft Deletion Confirmation</title>
</head>
<body>
	
    
    <%
    
    String aircraft_Id = request.getParameter("Aircraft_Id");
    
    try{
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		
		String sql = "DELETE FROM Aircraft WHERE Aircraft_Id = ?";
		PreparedStatement ps = con.prepareStatement(sql);
			
		ps.setString(1, aircraft_Id);
		ps.executeUpdate();	
		
		con.close();
	} catch(SQLException e){
		e.printStackTrace();
	}
	%>

<div>Aircraft Successfully Deleted</div>
<a href='crAircrafts.jsp'>Return to Aircrafts Page</a>



</body>
</html>