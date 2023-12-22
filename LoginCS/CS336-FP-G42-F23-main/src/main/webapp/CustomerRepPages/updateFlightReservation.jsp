<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.cs336.pkg.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Update Flight Reservation</title>
</head>
<body>

<%
    // Retrieve parameters from the request
    int reservationId = Integer.parseInt(request.getParameter("reservationId"));
    String newSeatNumber = request.getParameter("newSeatNumber");
    String flightNumber = request.getParameter("flightNumber");
    String newflightClass = request.getParameter("newClass");
    String airlineId = request.getParameter("airlineId");
%>

<%
    try {
        // Establish the connection
        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();

        // Update the seat number in the Reserves table
        String updateQuery = "UPDATE Reserves SET Seat_Number = ?, Class = ? WHERE Id_number = ? AND Flight_number = ? AND Airline_Id = ?";
        PreparedStatement updateStatement = con.prepareStatement(updateQuery);
        updateStatement.setString(1, newSeatNumber);
        updateStatement.setString(2, newflightClass);
        updateStatement.setInt(3, reservationId);
        updateStatement.setString(4, flightNumber);
        updateStatement.setString(5, airlineId);
        updateStatement.executeUpdate();
%>

    <h2>Update Successful</h2>
    <p>The seat number and class has been updated successfully.</p>

<%
    // Close resources
    updateStatement.close();
    con.close();
} catch (SQLException e) {
    e.printStackTrace();
}
%>

<a href='crHomepage.jsp'>Return to Homepage</a>
<br></br>
</body>
</html>
