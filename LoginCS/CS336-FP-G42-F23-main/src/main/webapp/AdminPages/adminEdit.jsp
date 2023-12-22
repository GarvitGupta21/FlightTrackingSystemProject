<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>User edit</title>
</head>
<body>
	
    
    <%
	    String User_name = request.getParameter("User_name");
	    String Password = request.getParameter("Password");
	    String type = request.getParameter("type");
	    
	    out.println("<table border='1'>");
	    out.println("<tr><th>Username</th><th>Password</th><th>Account Type</th>");

        out.println("<tr>");
        out.println("<td>" + User_name + "</td>");
        out.println("<td>" + Password + "</td>");
        out.println("<td>" + type + "</td>");
        out.println("</tr>");
    	out.println("</table>");
	%>
<form action="adminEditAccountSuccess.jsp" method="post">
        <label for="User_name">Type new username here:</label>
        <input type="text" name="User_name" required>
        <input type='hidden' name='Old_User_name' value=<%=User_name %>>
        <br>
        <label for="Password">Type new password here:</label>
        <input type="text" name="Password" required>
        <br>
        <label for="type">Select Account Type:</label>
        <select name="type">
    	<option value="Customer">Customer</option>
    	<option value="Customer Representative">Customer Representative</option>
  		</select>
        <br>
        <input type="submit" value="Edit Account Info">
        <br>
    </form>
<a href='adminAddEditDelete.jsp'>Return to Accounts Page</a>



</body>
</html>