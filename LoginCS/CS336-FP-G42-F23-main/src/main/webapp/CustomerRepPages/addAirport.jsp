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
    
    String Airport_Id = request.getParameter("Airport_Id");
    String Airport_Name = request.getParameter("Airport_Name");
    
    try{
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		
		String sql = "INSERT INTO Airport(Airport_Id, Airport_Name) VALUES (?, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
			
		ps.setString(1, Airport_Id);
		ps.setString(2, Airport_Name);
		ps.executeUpdate();	
		
		con.close();
	} catch(SQLException e){
		e.printStackTrace();
	}
	%>

<div>Airport Successfully Added</div>
<a href='crAirports.jsp'>Return to Airports Page</a>



</body>
</html>