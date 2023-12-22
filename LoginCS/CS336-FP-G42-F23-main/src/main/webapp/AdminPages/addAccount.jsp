<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add Account</title>
</head>
<body>
	
    
    <%
    
    String User_name = request.getParameter("User_name");
    String Password = request.getParameter("Password");
    String type = request.getParameter("type");
    
    try{
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		
		String sql = "INSERT INTO Account(User_name, Password, type) VALUES (?, ?, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
			
		ps.setString(1, User_name);
		ps.setString(2, Password);
		ps.setString(3, type);
		ps.executeUpdate();	
		
		con.close();
	} catch(SQLException e){
		e.printStackTrace();
	}
	%>

<div>Account Successfully Added</div>
<a href='adminAddEditDelete.jsp'>Return to Accounts Page</a>



</body>
</html>