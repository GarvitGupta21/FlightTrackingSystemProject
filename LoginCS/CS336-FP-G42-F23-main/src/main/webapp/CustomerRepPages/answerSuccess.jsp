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
		String Question_Id = request.getParameter("Question_Id");
		String username = (String)session.getAttribute("user");
		String Answer_text = request.getParameter("Answer_text");
		 
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
			
		
		String sql = "UPDATE QA SET Answer_User_name = ?, Answer_text = ? WHERE Question_Id = ?";
		PreparedStatement ps = con.prepareStatement(sql);
			
		ps.setString(1, username);
		ps.setString(2, Answer_text);
		ps.setString(3, Question_Id);
		ps.executeUpdate();
    			
	   	con.close();
		
	%>

<a href='crQA.jsp'>Question Successfully Answered!</a>



</body>
</html>