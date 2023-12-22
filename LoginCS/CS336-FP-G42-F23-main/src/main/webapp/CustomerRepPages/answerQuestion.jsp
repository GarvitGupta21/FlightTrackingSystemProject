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
	    String Question_Username = request.getParameter("Question_User_name");
	    String Question_text = request.getParameter("Question_text");
	    
	    
	    out.println("<table border='1'>");
	    out.println("<tr><th>Question#</th><th>Q-User</th><th>Question</th>");

        out.println("<tr>");
        out.println("<td>" + Question_Id + "</td>");
        out.println("<td>" + Question_Username + "</td>");
        out.println("<td>" + Question_text + "</td>");
        out.println("</tr>");
    	out.println("</table>");

		
	%>
<form action="answerSuccess.jsp" method="post">
        <label for="Answer_text">Type Your Answer Here:</label>
        <input type="text" name="Answer_text" required>
        <input type='hidden' name='Question_Id' value=<%=Question_Id %>>
        <input type="submit" value="Answer Question">
        <br>
    </form>
<a href='crQA.jsp'>Return to Question Board</a>



</body>
</html>