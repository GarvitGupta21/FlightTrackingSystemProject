<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>


<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Flight Search Results</title>
</head>
<body>

    <h2>Flight Search Results</h2>

    <%
        // Retrieve the search results from the request object

        String departureAirport = request.getParameter("departureAirport");
        String arrivalAirport = request.getParameter("arrivalAirport");
        String departureDate = request.getParameter("departureDate");
        String departureTime = request.getParameter("departureTime");
       	String arrivalTime = request.getParameter("arrivalTime");
       	String maxFlightDuration = request.getParameter("maxFlightDuration");
		String airline = request.getParameter("airline");
		String maxFlightCostEcon = request.getParameter("maxFlightCostEcon");
		
        String flexOption = request.getParameter("flex_option");
        String flexOption_2 = request.getParameter("flex_option_2");
		
		
		       
        // Establish database connection and execute the query
        try {
            ApplicationDB db = new ApplicationDB();    
            Connection con = db.getConnection();
            Statement st = con.createStatement();
            ResultSet rs;

            // Construct the query based on search criteria
            String query = "SELECT *, TIMESTAMPDIFF(HOUR, Departing_Time, Arrival_Time) AS FlightDuration FROM Flight WHERE 1=1";


            if (departureAirport != null && !departureAirport.isEmpty()) {
                query += " AND Departure_Airport = '" + departureAirport + "'";
            }

            if (arrivalAirport != null && !arrivalAirport.isEmpty()) {
                query += " AND Arrival_Airport = '" + arrivalAirport + "'";
            }
          
	        if (flexOption.equals("no")){
            	if (departureDate != null && !departureDate.isEmpty()) {
                	query += " AND DATE(Departing_Time) = '" + departureDate + "'";
           		}
            }else{
            	if (departureDate != null && !departureDate.isEmpty()) {
            	    // Parse the input date to a Java Date object
            	    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            	    Date parsedDepartureDate = sdf.parse(departureDate);
            	    
            	    // Calculate the date range (+/- 3 days)
            	    Calendar calendar = Calendar.getInstance();
            	    calendar.setTime(parsedDepartureDate);
            	    calendar.add(Calendar.DAY_OF_MONTH, -3);
            	    Date startDate = calendar.getTime();
            	    
            	    calendar.setTime(parsedDepartureDate);
            	    calendar.add(Calendar.DAY_OF_MONTH, 3);
            	    Date endDate = calendar.getTime();
            	    
            	    // Format the dates for SQL comparison
            	    String formattedStartDate = sdf.format(startDate);
            	    String formattedEndDate = sdf.format(endDate);
            	    
            	    // Construct the query with date range condition
            	    query += " AND Departing_Time BETWEEN '" + formattedStartDate + "' AND '" + formattedEndDate + "'";
            	}
	
            }
	       
	        if (departureTime != null && !departureTime.isEmpty()) {	
                query += " AND TIME(Departing_Time) = '" + departureTime + "'";
            }
	        
	        
	        if (arrivalTime != null && !arrivalTime.isEmpty()) {
                query += " AND TIME(Arrival_Time) = '" + arrivalTime + "'";
            } 
	        
	        
	        if (maxFlightDuration != null && !maxFlightDuration.isEmpty()){
	        	
	        	query += " AND TIMESTAMPDIFF(HOUR, Departing_Time, Arrival_Time) <= '" + maxFlightDuration + "'";
	        }
	        
	        if (airline != null && !airline.isEmpty()) {
	        	if(!airline.equals("any")){
                	query += " AND Airline_Id = '" + airline + "'";
	        	}
	        }
	        
	        if (maxFlightCostEcon != null && !maxFlightCostEcon.isEmpty()) {
                query += " AND EconomyClassPrice <= '" + maxFlightCostEcon + "'";
            }
	        
	        if (flexOption_2.equals("sortPrice")){
	        	query += "ORDER BY EconomyClassPrice ASC";
	        }
	        
	        if (flexOption_2.equals("sortArrivalTime")){
	        	query += "ORDER BY Arrival_Time ASC";
	        }
	        
	        if (flexOption_2.equals("sortDepartureTime")){
	        	query += "ORDER BY Departing_Time ASC";
	        }
	        
	        if (flexOption_2.equals("sortDuration")){
	        	query += "ORDER BY FlightDuration ASC";
	        }
	        
	        
            rs = st.executeQuery(query);

            // Display the results with a button for booking
            out.println("<table border='1'>");
            out.println("<tr><th>Flight Number</th><th>Airline ID</th><th>Departure Airport</th><th>Arrival Airport</th><th>Departing Time</th><th>Arrival Time</th><th>Flight Type</th><th>Flight Duration (hours)</th><th>Economy Cost</th><th>Book This Flight</th></tr>");

            while (rs.next()) {
                out.println("<tr>");
                out.println("<td>" + rs.getString("Flight_number") + "</td>");
                out.println("<td>" + rs.getString("Airline_id") + "</td>");
                out.println("<td>" + rs.getString("Departure_Airport") + "</td>");
                out.println("<td>" + rs.getString("Arrival_Airport") + "</td>");
                out.println("<td>" + rs.getString("Departing_Time") + "</td>");
                out.println("<td>" + rs.getString("Arrival_Time") + "</td>");
                out.println("<td>" + rs.getString("Flight_type") + "</td>");
                out.println("<td>" + rs.getString("FlightDuration") + "</td>");
                out.println("<td>" + "$" + rs.getString("EconomyClassPrice") + "</td>");
                
                

                // Booking Button Stuff
                out.println("<td><form action='bookFlight.jsp' method='post'>");
                out.println("<input type='hidden' name='flightNumber' value='" + rs.getString("Flight_number") + "'>");
                out.println("<input type='hidden' name='airlineId' value='" + rs.getString("Airline_id") + "'>");
                out.println("<input type='hidden' name='aircraftId' value='" + rs.getString("aircraft_Id") + "'>");
                out.println("<input type='hidden' name='departureAirport' value='" + rs.getString("Departure_Airport") + "'>");
                out.println("<input type='hidden' name='arrivalAirport' value='" + rs.getString("Arrival_Airport") + "'>");
                out.println("<input type='hidden' name='departingTime' value='" + rs.getString("Departing_Time") + "'>");
                out.println("<input type='hidden' name='arrivalTime' value='" + rs.getString("Arrival_Time") + "'>");

                out.println("<input type='hidden' name='flightType' value='" + rs.getString("Flight_type") + "'>");
                out.println("<input type='hidden' name='flightEconCost' value='" + rs.getString("EconomyClassPrice") + "'>");
                out.println("<input type='hidden' name='flightBizCost' value='" + rs.getString("BuisnessClassPrice") + "'>");
                out.println("<input type='hidden' name='flightFistClassCost' value='" + rs.getString("FirstClassPrice") + "'>");


                out.println("<input type='submit' value='Book'></form></td>");
                out.println("</tr>");
            }

            out.println("</table>");
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    %>

</body>
</html>
