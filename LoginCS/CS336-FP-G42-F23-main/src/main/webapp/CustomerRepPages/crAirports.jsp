<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>View/Change Airport Info</title>
</head>
<body>
	<h2>View/Change Airport Info</h2>
    <%
try {
    ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
    Statement st = con.createStatement();
    ResultSet rs;

    // Customize the query based on your database schema
    String query = String.format("SELECT * FROM Airport");

    rs = st.executeQuery(query);

    // Display the QA board
    out.println("<table border='1'>");
    out.println("<tr><th>Airport ID</th><th>Airport Name</th>");

    while (rs.next()) {
        out.println("<tr>");
        out.println("<td>" + rs.getString("Airport_ID") + "</td>");
        out.println("<td>" + rs.getString("Airport_Name") + "</td>");

        
        out.println("<td><form action='editAirport.jsp' method='post'>");
    	out.println("<input type='hidden' name='Airport_ID' value='" + rs.getString("Airport_ID") + "'>");
    	out.println("<input type='hidden' name='Airport_Name' value='" + rs.getString("Airport_Name") + "'>");
    	out.println("<input type='submit' value='Edit'></form></td>");
    	
    	out.println("<td><form action='deleteAirport.jsp' method='post'>");
    	out.println("<input type='hidden' name='Airport_ID' value='" + rs.getString("Airport_ID") + "'>");
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
	<div><b>Add Airport:</b></div>
    <form action="addAirport.jsp" method="post">
        <label for="Airport_Id">Type Airport Id here:</label>
        <input type="text" name="Airport_Id" required>
        <br>
        <label for="Airport_Id">Type Airport Name here:</label>
        <input type="text" name="Airport_Name" required>
        <br>
        <input type="submit" value="Add Airport">
    </form>

<br></br>
<a href='crHomepage.jsp'>Return to Homepage</a>


</body>
</html>