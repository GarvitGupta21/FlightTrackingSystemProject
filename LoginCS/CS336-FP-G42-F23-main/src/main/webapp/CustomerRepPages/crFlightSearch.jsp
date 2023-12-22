<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Search Direct Flights</title>
</head>
<body>
    <h2>Welcome to the Direct Flights Page</h2>
    <p>You can search for Direct flights here:</p>

    <form action="searchFlights.jsp" method="post">
		
		<label for="departureAirport">Departure Airport:</label>
		<select name="departureAirport">
		<option disabled selected>Choose Departure Airport</option>
    	<%
    	ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection(); 
		
		Statement st = con.createStatement();
		ResultSet rs;
		rs = st.executeQuery("SELECT Airport_Id FROM Airport");
				
		while(rs.next()){
			out.println(String.format("<option value='%s'>%s</option>", rs.getString("Airport_Id"), rs.getString("Airport_Id")));
		};
		
		%>
  		</select>
  		<br>

        <label for="arrivalAirport">Arrival Airport:</label>
		<select name="arrivalAirport">
		<option disabled selected>Choose Arrival Airport</option>
    	<%
    	
    	Statement st2 = con.createStatement();
		ResultSet rs2;
		rs2 = st.executeQuery("SELECT Airport_Id FROM Airport");
		while(rs2.next()){
			out.println(String.format("<option value='%s'>%s</option>", rs2.getString("Airport_Id"), rs2.getString("Airport_Id")));
		};
		
		
		//con.close();
		%>
  		</select>
  		
  		<br>
  		
  		<label for="airline">Airline:</label>
		<select name="airline">
    	<option disabled selected>Choose Airline</option>

    	<% 
    	Statement st3 = con.createStatement();
    	ResultSet rs3;
    	rs3 = st3.executeQuery("SELECT Airline_Id FROM Airline");
    
    	// Add an option for any airline
    	out.println("<option value='any'>Any Airline</option>");

    	while(rs3.next()) {
	        out.println(String.format("<option value='%s'>%s</option>", rs3.getString("Airline_Id"), rs3.getString("Airline_Id")));
	    }

    	rs3.close();
    	st3.close();
    	con.close();
   	 	%>
	</select>
  		
  
  		
		<br>
		 
        <label for="departureDate">Departure Date (Required):</label>
        <input type="date" name="departureDate">
        <br>
        
        <br>
		 
		 
        <label for="departureTime">Optional Departure Time:</label>
        <input type="time" step="1" name="departureTime" id="departureTime" >        
        <br>
        
        <label for="arrivalTime">Optional Arrival Time:</label>
        <input type="time" step="1" name="arrivalTime" id="arrivalTime" >        
       
        <br>
        
        <label for="maxFlightDuration">Max Flight Duration (in hours):</label>
        <input type="number" name="maxFlightDuration">
        <br>
        
        <p>Select Maximum Cost for Economy Flight (you can choose Business or First Class prices later):</p>
        <label for="maxFlightCostEcon">Max Flight Cost:</label>
        <input type="number" name="maxFlightCostEcon">
        <br>
        
        
        <p>Please select if you want flexible Dates:</p>
  		<input type="radio" id="flex_option_yes" name="flex_option" value="yes">
  		<label for="yes">YES</label><br>
  		<input type="radio" id="flex_option_no" name="flex_option" value="no">
  		<label for="no">NO</label><br>

 		<br>
 		
 		<p>Please select how you want to sort the Flights:</p>
  		
		<input type="radio" id="sortPrice" name="flex_option_2" value="sortPrice">
  		<label for="sortPrice">By Price</label><br>
		<input type="radio" id="sortDepartureTime" name="flex_option_2" value="sortDepartureTime">
  		<label for="sortDepartureTime">By Departure Time</label><br>
  		<input type="radio" id="sortArrivalTime" name="flex_option_2" value="sortArrivalTime">
  		<label for="sortArrivalTime">By Arrival Time</label><br>
		<input type="radio" id="sortDuration" name="flex_option_2" value="sortDuration">
  		<label for="sortDuration">By Duration of Flight</label><br>
 		<br>
        <input type="submit" value="Search Flights">
        
        
    </form>

   

    
   
</body>
</html>
