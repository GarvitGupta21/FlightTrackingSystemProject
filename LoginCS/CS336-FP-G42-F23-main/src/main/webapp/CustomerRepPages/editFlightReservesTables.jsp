<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.cs336.pkg.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Edit Flight Reservation Information</title>
</head>
<body>

<%
    // Retrieve parameters from the request
    int reservationId = Integer.parseInt(request.getParameter("reservationId"));
    String customerName = request.getParameter("customerName");
    java.sql.Date purchaseTime = java.sql.Date.valueOf(request.getParameter("purchaseTime"));
    String userName = request.getParameter("userName");
    int bookingFee = Integer.parseInt(request.getParameter("bookingFee"));
    int ticketCost = Integer.parseInt(request.getParameter("ticketCost"));
    String passengerName = request.getParameter("passengerName");
    String flightClass = request.getParameter("class");
    String seatNumber = request.getParameter("seatNumber");
    String flightNumber = request.getParameter("flightNumber");
    String airlineId = request.getParameter("airlineId");
%>

<h2>Edit Flight Reservation Information</h2>

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
    </tr>

    <tr>
        <td><%= reservationId %></td>
        <td><%= customerName %></td>
        <td><%= purchaseTime %></td>
        <td><%= userName %></td>
        <td><%= bookingFee %></td>
        <td><%= ticketCost %></td>
        <td><%= passengerName %></td>
        <td><%= flightClass %></td>
        <td><%= seatNumber %></td>
        <td><%= flightNumber %></td>
        <td><%= airlineId %></td>
    </tr>
</table>

<h2>Edit Form</h2>

<form action="updateFlightReservation.jsp" method="post">
    <input type="hidden" name="reservationId" value="<%= reservationId %>">
    <input type="hidden" name="flightNumber" value="<%= flightNumber %>">
    <input type="hidden" name="airlineId" value="<%= airlineId %>">
	
	<label for="newClass">New Class:</label>
    <input type="text" name="newClass" value="<%= flightClass %>">
    <br>
    
    <label for="newSeatNumber">New Seat Number:</label>
    <input type="text" name="newSeatNumber" value="<%= seatNumber %>">
    <br>

    <input type="submit" value="Update Reservation">
</form>

</body>
</html>
