<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Edit Flight Success</title>
</head>
<body>

<%
    String flight_number = request.getParameter("Flight_number");
    String airline_Id = request.getParameter("Airline_Id");
    String aircraft_Id = request.getParameter("Aircraft_Id");
    String departure_Airport = request.getParameter("Departure_Airport");
    String arrival_Airport = request.getParameter("Arrival_Airport");
    String departing_Time = request.getParameter("Departing_Time");
    String arrival_Time = request.getParameter("Arrival_Time");
    String flight_type = request.getParameter("Flight_type");

    ApplicationDB db = new ApplicationDB();    
    Connection con = db.getConnection();

    String sql = "UPDATE Flight SET Airline_Id = ?, Aircraft_Id = ?, Departure_Airport = ?, Arrival_Airport = ?, Departing_Time = ?, Arrival_Time = ?, Flight_type = ? WHERE Flight_number = ?";
    PreparedStatement ps = con.prepareStatement(sql);

    ps.setString(1, airline_Id);
    ps.setString(2, aircraft_Id);
    ps.setString(3, departure_Airport);
    ps.setString(4, arrival_Airport);
    ps.setString(5, departing_Time);
    ps.setString(6, arrival_Time);
    ps.setString(7, flight_type);
    ps.setString(8, flight_number);
    ps.executeUpdate();

    con.close();
%>

<a href='crFlights.jsp'>Flight Information Updated</a>

</body>
</html>
