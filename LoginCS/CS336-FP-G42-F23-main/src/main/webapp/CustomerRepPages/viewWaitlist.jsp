<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.cs336.pkg.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>View Waitlist</title>
</head>
<body>

<%
    // Retrieve parameters from the request
    String airlineId = request.getParameter("Airline_Id");
	int Flight_number = Integer.parseInt(request.getParameter("Flight_number"));


    
    try {
        // Establish the connection
        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();
        Statement stmt = con.createStatement();
        ResultSet rs;

        String query = "SELECT * FROM Waitlist WHERE Flight_number = ? AND Airline_Id = ?";
        PreparedStatement preparedStatement = con.prepareStatement(query);
        preparedStatement.setInt(1, Flight_number);
        preparedStatement.setString(2, airlineId);
        rs = preparedStatement.executeQuery();
%>

<h2>Waitlist Information</h2>
<table border='1'>
	<tr>
		<th>Airline Id</th>
		<th>Flight Number</th>
	</tr>
	<tr>
		<th><%= airlineId %></th>
		<th><%= Flight_number %></th>
	</tr>
</table>

<br></br>

<table border='1'>
    <tr>
        <th>Username</th>
    </tr>

    <% while (rs.next()) { %>
        <tr>
            <td><%= rs.getString("User_name") %></td>
        </tr>
    <% } %>

</table>

<%
    // Close resources
    rs.close();
    stmt.close();
    con.close();
} catch (SQLException e) {
    e.printStackTrace();
}
%>

<br>
<a href='crFlights.jsp'>Return to Flights Page</a>
</body>
</html>
