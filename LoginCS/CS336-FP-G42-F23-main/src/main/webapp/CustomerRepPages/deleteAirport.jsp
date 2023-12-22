<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Airport Deletion Confirmation</title>
</head>
<body>
	
    
    <%
    
    String Airport_Id = request.getParameter("Airport_ID");
    
    try{
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		
		String sql = "DELETE FROM Airport WHERE Airport_Id = ?";
		PreparedStatement ps = con.prepareStatement(sql);
			
		ps.setString(1, Airport_Id);
		ps.executeUpdate();	
		
		con.close();
	} catch(SQLException e){
		e.printStackTrace();
	}
	%>

<div>Airport Successfully Deleted</div>
<a href='crAirports.jsp'>Return to Airports Page</a>



</body>
</html>