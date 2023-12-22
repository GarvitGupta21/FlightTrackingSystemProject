<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Waitlist Confirmation</title>
</head>
<body>
	
    
    <%
    
    String flightNumber = request.getParameter("flightNumber");
    String username = request.getParameter("username");
    String airlineId = request.getParameter("airlineId");
    
    try{
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		
		String sql = "INSERT INTO Waitlist(User_name, Flight_number, Airline_Id) VALUES (?, ?, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
			
		ps.setString(1, username);
		ps.setInt(2, Integer.parseInt(flightNumber));
		ps.setString(3, airlineId);
		ps.executeUpdate();	
		
		con.close();
	} catch(SQLException e){
		e.printStackTrace();
	}
	%>

<div>Waitlist Successfully Joined</div>
<a href='customerHomepage.jsp'>Return to Home Page</a>



</body>
</html>