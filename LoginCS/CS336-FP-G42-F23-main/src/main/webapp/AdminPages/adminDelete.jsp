<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>User deletion</title>
</head>
<body>
	
    
    <%
    
    String User_name = request.getParameter("User_name");
    
    try{
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		
		String sql = "DELETE FROM Account WHERE User_name = ?";
		PreparedStatement ps = con.prepareStatement(sql);
			
		ps.setString(1, User_name);
		ps.executeUpdate();	
		
		con.close();
	} catch(SQLException e){
		e.printStackTrace();
	}
	%>

<div>User Successfully Deleted</div>
<a href='adminAddEditDelete.jsp'>Return to Accounts Page</a>



</body>
</html>