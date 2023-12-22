<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Delete Flights Confirmation</title>
</head>
<body>
	
    
    <%
    
    String flight_number = request.getParameter("Flight_number");
    String airlineId = request.getParameter("Airline_Id");
    
    try{
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		
		String sql = "DELETE FROM Flight WHERE flight_number = ? AND Airline_Id = ?";
		PreparedStatement ps = con.prepareStatement(sql);
			
		ps.setString(1, flight_number);
		ps.setString(2, airlineId);

		ps.executeUpdate();	
		
		con.close();
	} catch(SQLException e){
		e.printStackTrace();
	}
	%>

<div>Flight Successfully Deleted</div>
<a href='crFlights.jsp'>Return to Flights Page</a>



</body>
</html>