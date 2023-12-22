<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Calendar" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add Flight Confirmation</title>
</head>
<body>
	
    
    <%
    
    String flight_number = request.getParameter("Flight_number");
    String airline_Id = request.getParameter("Airline_Id");
    String aircraft_Id = request.getParameter("Aircraft_Id");
    String departureAirport = request.getParameter("departureAirport");
    String arrivalAirport = request.getParameter("arrivalAirport");
    String departureDateStr = request.getParameter("departureDate");
    String arrivalDateStr = request.getParameter("arrivalDate");
    String flightType = request.getParameter("flightType");
    String firstClassPrice = request.getParameter("firstClassPrice");
    String businessClassPrice = request.getParameter("buisnessClassPrice");
    String economyClassPrice = request.getParameter("economyClassPrice");
    
    try{
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        java.util.Date parsedDepartureDate = dateFormat.parse(departureDateStr);
        java.sql.Date departureDate = new java.sql.Date(parsedDepartureDate.getTime());

        java.util.Date parsedArrivalDate = dateFormat.parse(arrivalDateStr);
        java.sql.Date arrivalDate = new java.sql.Date(parsedArrivalDate.getTime());
        
        String sql = "INSERT INTO Flight(Flight_number, Airline_Id, Aircraft_Id, Departure_Airport, Arrival_Airport, Departing_Time, Arrival_Time, Flight_type, FirstClassPrice, BuisnessClassPrice, EconomyClassPrice VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement ps = con.prepareStatement(sql);
            
        ps.setInt(1, Integer.parseInt(flight_number));
        ps.setString(2, airline_Id);
        ps.setInt(3, Integer.parseInt(aircraft_Id));
        ps.setString(4, departureAirport);
        ps.setString(5, arrivalAirport);
        ps.setDate(6, departureDate);
        ps.setDate(7, arrivalDate);
        ps.setString(8, flightType);
        ps.setFloat(9, Float.parseFloat(firstClassPrice));
        ps.setFloat(10, Float.parseFloat(businessClassPrice));
        ps.setFloat(11, Float.parseFloat(economyClassPrice));
        
        ps.executeUpdate();    
        
        con.close();
	} catch(SQLException e){
		e.printStackTrace();
	}
	%>

<div>Flight Successfully Added</div>
<a href='crFlights.jsp'>Return to Flights Page</a>



</body>
</html>