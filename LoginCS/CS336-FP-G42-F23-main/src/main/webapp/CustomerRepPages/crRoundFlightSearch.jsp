<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Search Round Flights</title>
</head>
<body>
    <h2>Welcome to the Round Flights Page</h2>
    <p>You can search for Round flights here:</p>

    <form action="searchRoundFlights.jsp" method="post">
    
    		
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
		
		%>
  		</select>
  		
  		<br>
  		
  		<label for="airline1">Departure Airline:</label>
		<select name="airline1">
    	<option disabled selected>Choose Departure Airline</option>

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
   	 	%>
	</select>
  		
		<br>
		 
        <label for="departureDate">Departure Date:</label>
        <input type="date" name="departureDate">
        <br>
 	
        
        <label for="departureTime1">Optional Departure Time:</label>
        <input type="time" step="1" name="departureTime1" id="departureTime1" >        
        <br>
         
         <br>
        <label for="maxFlightDuration1">Maximum Duration of Departure Flight (in hours):</label>
        <input type="number" name="maxFlightDuration1">
        <br>
        
        <p>Select Maximum Cost for Departure Economy Flight (you can choose Business or First Class prices later):</p>
        <label for="maxFlightCostEcon1">Max Departure Flight Cost:</label>
        <input type="number" name="maxFlightCostEcon1">
        <br>
           <br>
             <br>
        
        <br>
  		
  		<label for="airline2">Return Airline:</label>
		<select name="airline2">
    	<option disabled selected>Choose Return Airline</option>

    	<% 
    	Statement st4 = con.createStatement();
    	ResultSet rs4;
    	rs4 = st4.executeQuery("SELECT Airline_Id FROM Airline");
    
    	// Add an option for any airline
    	out.println("<option value='any'>Any Airline</option>");

    	while(rs4.next()) {
	        out.println(String.format("<option value='%s'>%s</option>", rs4.getString("Airline_Id"), rs4.getString("Airline_Id")));
	    }

    	rs4.close();
    	st4.close();
    	con.close();
   	 	%>
	</select>
	<br>
        
        <label for="arrivalRoundDate">Arrival Back Date:</label>
        <input type="date" name="arrivalRoundDate">
        <br>
        
        <label for="arrivalBackTime">Optional Arrival Back Time:</label>
        <input type="time" step="1" name="arrivalBackTime" id="arrivalBackTime" >        
               <br>
       
        
        <label for="maxFlightDuration2">Maximum Duration of Arrival Flight (in hours):</label>
        <input type="number" name="maxFlightDuration2">
        <br>
        
         <p>Select Maximum Cost for Arrival Economy Flight (you can choose Business or First Class prices later):</p>
        <label for="maxFlightCostEcon2">Max Arrival Flight Cost:</label>
        <input type="number" name="maxFlightCostEcon2">
        <br>
        
    
        
        <p>Please select if you want flexible Dates:</p>
  		<input type="radio" id="html" name="flex_option" value="yes">
  		<label for="yes">YES</label><br>
  		<input type="radio" id="css" name="flex_option" value="no">
  		<label for="no">NO</label><br>

 		<br>
 		<p>Please select how you want to sort the Flights:</p>
  		
		<input type="radio" id="sortPrice" name="flex_option_2" value="sortPrice">
  		<label for="sortPrice">By Total Price</label><br>
		<input type="radio" id="sortDepartureTime" name="flex_option_2" value="sortDepartureTime">
  		<label for="sortDepartureTime">By Departure Time</label><br>
  		<input type="radio" id="sortArrivalTime" name="flex_option_2" value="sortArrivalTime">
  		<label for="sortArrivalTime">By Return Arrival Time</label><br>
		<input type="radio" id="sortDuration" name="flex_option_2" value="sortDuration">
  		<label for="sortDuration">By Combined Duration of Flight</label><br>
 		<br>
        <input type="submit" value="Search Flights">

    </form>

   

    
   
</body>
</html>

