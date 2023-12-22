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
	    String question_text = request.getParameter("question_text");
	    String username = (String)session.getAttribute("user");
 
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
			
		Statement st2 = con.createStatement();
		ResultSet rs2;
		rs2 = st2.executeQuery("SELECT COUNT(*) FROM QA");
		rs2.next();
		int questionId = rs2.getInt("COUNT(*)") + 1;
			
		
		String sql = "INSERT INTO QA (Question_Id, Question_User_name, Question_Text, Answer_User_name, Answer_Text) VALUES (?, ?, ?, 'Waiting for Answer', 'Waiting For Answer')";
		PreparedStatement ps = con.prepareStatement(sql);
			
		ps.setInt(1, questionId);
		ps.setString(2, username);
		ps.setString(3, question_text);
		ps.executeUpdate();
    			
	
	   	con.close();
		
	%>

<div>Your question has been posted!</div>
<a href='customerQA.jsp'>Return to Question Board</a>



</body>
</html>