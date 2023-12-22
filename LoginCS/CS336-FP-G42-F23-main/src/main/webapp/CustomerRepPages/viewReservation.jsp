<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.cs336.pkg.*"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>View Reservation Information</title>
</head>
<body>

<%
	List<String> classList = new ArrayList<>();
    // Retrieve parameters from the request
    int reservationId = Integer.parseInt(request.getParameter("reservationId"));
    String customerName = request.getParameter("customerName");
    java.sql.Date purchaseTime = java.sql.Date.valueOf(request.getParameter("purchaseTime"));
    String userName = request.getParameter("userName");
    int bookingFee = Integer.parseInt(request.getParameter("bookingFee"));
    int ticketCost = Integer.parseInt(request.getParameter("ticketCost"));
    String passengerName = request.getParameter("passengerName");
    String resTime = request.getParameter("resTime");

    try {
        // Establish the connection
        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();
        Statement stmt = con.createStatement();
        ResultSet rs;
        ResultSet rs2;


        // Query to retrieve related information from the "Reserves" table
        String query = "SELECT * FROM Reserves as r INNER JOIN Flight as f ON r.Airline_Id = f.Airline_Id AND r.Flight_number = f.Flight_number WHERE Id_number = ?";
        PreparedStatement preparedStatement = con.prepareStatement(query);
        preparedStatement.setInt(1, reservationId);
        rs = preparedStatement.executeQuery();
%>

<h2>Reservation Information</h2>

<table border='1'>
    <tr>
        <th>Reservation ID</th>
        <th>Customer Name</th>
        <th>Purchase Time</th>
        <th>User Name</th>
        <th>Booking Fee</th>
        <th>Ticket Cost</th>
        <th>Passenger Name</th>
        <th>Class</th>
        <th>Seat Number</th>
        <th>Flight Number</th>
        <th>Airline Id</th>
        <th>Departure_Airport</th>
        <th>Arrival_Airport</th>
        <th>Departing_Time</th>
        <th>Arrival_Time</th>
        <th>Flight_type</th>
    </tr>

    <% while (rs.next()) { %>
        <% classList.add(rs.getString("Class")); %>
        <tr>
            <td><%= reservationId %></td>
            <td><%= customerName %></td>
            <td><%= purchaseTime %></td>
            <td><%= userName %></td>
            <td><%= bookingFee %></td>
            <td><%= ticketCost %></td>
            <td><%= passengerName %></td>
            <td><%= rs.getString("Class") %></td>
            <td><%= rs.getString("Seat_Number") %></td>
            <td><%= rs.getString("Flight_number") %></td>
        	<td><%= rs.getString("Airline_Id") %></td>
        	<td><%= rs.getString("Departure_Airport") %></td>
            <td><%= rs.getString("Arrival_Airport") %></td>
            <td><%= rs.getString("Departing_Time") %></td>
        	<td><%= rs.getString("Arrival_Time") %></td>
        	<td><%= rs.getString("Flight_type") %></td>
        </tr>
  

	<% 
	}
    %>
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
         
</body>
</html>
