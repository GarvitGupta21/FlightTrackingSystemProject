<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add Aircraft</title>
</head>
<body>
	
    
    <%
    
    String aircraft_Id = request.getParameter("Aircraft_Id");
    String airline_Id = request.getParameter("Airline_Id");
    String seats = request.getParameter("seats");
    
    try{
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		
		String sql = "INSERT INTO Aircraft(Aircraft_Id, number_of_seats) VALUES (?, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
			
		ps.setString(1, aircraft_Id);
		ps.setString(2, seats);
		ps.executeUpdate();	
		
		String sql2 = "INSERT INTO Owns(Aircraft_Id, Airline_Id) VALUES (?, ?)";
		PreparedStatement ps2 = con.prepareStatement(sql2);
		
		ps2.setString(1, aircraft_Id);
		ps2.setString(2, airline_Id);
		ps2.executeUpdate();	
		
		con.close();
	} catch(SQLException e){
		e.printStackTrace();
	}
	%>

<div>Aircraft Successfully Added</div>
<a href='crAircrafts.jsp'>Return to Aircrafts Page</a>



</body>
</html>