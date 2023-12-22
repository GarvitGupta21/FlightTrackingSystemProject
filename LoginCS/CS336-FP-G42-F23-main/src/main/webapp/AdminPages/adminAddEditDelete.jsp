<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add Edit or Delete Users</title>
</head>
<body>
	<h2>Add Edit or Delete Users</h2>
    <%
try {
    ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
    Statement st = con.createStatement();
    ResultSet rs;

    // Customize the query based on your database schema
    String query = String.format("SELECT * FROM Account WHERE type != 'Admin' ");

    rs = st.executeQuery(query);

    out.println("<table border='1'>");
    out.println("<tr><th>Username</th><th>Password</th><th>Account Type</th><th>Edit</th><th>Delete</th>");

    while (rs.next()) {
        out.println("<tr>");
        out.println("<td>" + rs.getString("User_name") + "</td>");
        out.println("<td>" + rs.getString("Password") + "</td>");
        out.println("<td>" + rs.getString("type") + "</td>");
        
        out.println("<td><form action='adminEdit.jsp' method='post'>");
    	out.println("<input type='hidden' name='User_name' value='" + rs.getString("User_name") + "'>");
    	out.println("<input type='hidden' name='Password' value='" + rs.getString("Password") + "'>");
    	out.println("<input type='hidden' name='type' value='" + rs.getString("type") + "'>");
    	out.println("<input type='submit' value='Edit'></form></td>");
    	
    	out.println("<td><form action='adminDelete.jsp' method='post'>");
    	out.println("<input type='hidden' name='User_name' value='" + rs.getString("User_name") + "'>");
    	out.println("<input type='submit' value='Delete'></form></td>");
    	out.println("</tr>");
        
    }

    out.println("</table>");
    con.close();
} catch (SQLException e) {
    e.printStackTrace();
}
%>

	<br>
	<div><b>Add User:</b></div>
    <form action="addAccount.jsp" method="post">
        <label for="User_name">Type Username Here:</label>
        <input type="text" name="User_name" required>
        <br>
        <label for="Password">Type Password Here:</label>
        <input type="text" name="Password" required>
        <br>
        <label for="type">Select Account Type:</label>
        <select name="type">
    	<option value="Customer">Customer</option>
    	<option value="Customer Representative">Customer Representative</option>
  		</select>
        <br>
        <input type="submit" value="Add User">
    </form>


</body>
</html>