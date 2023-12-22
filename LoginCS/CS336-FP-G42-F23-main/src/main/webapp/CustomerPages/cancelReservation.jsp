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
    
    String reservationId = request.getParameter("reservationId");
    
    try{
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		
		String sql = "DELETE FROM FlightTicket WHERE Id_number = ?";
		PreparedStatement ps = con.prepareStatement(sql);
			
		ps.setString(1, reservationId);
		ps.executeUpdate();		
		
		con.close();
	} catch(SQLException e){
		e.printStackTrace();
	}
	%>

<div>Reservation Deleted Successfully</div>
<a href='customerHomepage.jsp'>Return to Home Page</a>



</body>
</html>