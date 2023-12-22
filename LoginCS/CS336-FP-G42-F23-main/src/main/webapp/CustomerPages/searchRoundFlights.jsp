<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.ParseException" %>


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
        String arrivalRoundDate = request.getParameter("arrivalRoundDate");
        String departureTime1 = request.getParameter("departureTime1");
        String maxFlightDuration1 = request.getParameter("maxFlightDuration1");
        String arrivalBackTime = request.getParameter("arrivalBackTime");
        String maxFlightDuration2 = request.getParameter("maxFlightDuration2");
        
        String maxFlightCostEcon1 = request.getParameter("maxFlightCostEcon1");
        String maxFlightCostEcon2 = request.getParameter("maxFlightCostEcon2");
        
        String airline1 = request.getParameter("airline1");
        String airline2 = request.getParameter("airline2");

       
        String flexOption = request.getParameter("flex_option");
        String flexOption_2 = request.getParameter("flex_option_2");


        // Establish database connection and execute the query
        try {
            ApplicationDB db = new ApplicationDB();    
            Connection con = db.getConnection();
            Statement st = con.createStatement();
            ResultSet rs;

            // Construct the query based on search criteria
    
            String query = "SELECT f1.*, f2.*, "
                    + "TIMESTAMPDIFF(HOUR, f1.Departing_Time, f1.Arrival_Time) AS FlightDuration1, "
                    + "TIMESTAMPDIFF(HOUR, f2.Departing_Time, f2.Arrival_Time) AS FlightDuration2, "
                    +"(f1.EconomyClassPrice + f2.EconomyClassPrice) AS CombinedEconomyPrice, " 
                    + "(TIMESTAMPDIFF(HOUR, f1.Departing_Time, f1.Arrival_Time) + TIMESTAMPDIFF(HOUR, f2.Departing_Time, f2.Arrival_Time)) AS CombinedFlightDuration "
                    + "FROM Flight f1, Flight f2 WHERE 1=1";
            
            //String query = "SELECT *, f1.TIMESTAMPDIFF(HOUR, Departing_Time, Arrival_Time) AS FlightDuration FROM Flight WHERE 1=1";


            if (departureAirport != null && !departureAirport.isEmpty()) {
                query += " AND f1.Departure_Airport = '" + departureAirport + "'";
            }

            if (arrivalAirport != null && !arrivalAirport.isEmpty()) {
                query += " AND f1.Arrival_Airport = '" + arrivalAirport + "'";
            }

            if (flexOption.equals("no")) {
                if (departureDate != null && !departureDate.isEmpty()) {
                    query += " AND DATE(f1.Departing_Time) = '" + departureDate + "'";
                    query += " AND DATE(f2.Arrival_Time) = '" + arrivalRoundDate + "'";

                }
            } else {
                if (departureDate != null && !departureDate.isEmpty()) {
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    Date parsedDepartureDate1 = sdf.parse(departureDate);
                    Date parsedArrivalDate2 = sdf.parse(arrivalRoundDate);

                    Calendar calendar1 = Calendar.getInstance();
                    calendar1.setTime(parsedDepartureDate1);
                    calendar1.add(Calendar.DAY_OF_MONTH, -3);
                    Date startDate1 = calendar1.getTime();
                    

                    Calendar calendar2 = Calendar.getInstance();
                    calendar2.setTime(parsedArrivalDate2);
                    calendar2.add(Calendar.DAY_OF_MONTH, -3);
                    Date startDate2 = calendar2.getTime();

                    calendar1.setTime(parsedDepartureDate1);
                    calendar1.add(Calendar.DAY_OF_MONTH, 3);
                    Date endDate1 = calendar1.getTime();
                    
                    calendar2.setTime(parsedArrivalDate2);
                    calendar2.add(Calendar.DAY_OF_MONTH, 3);
                    Date endDate2 = calendar2.getTime();

                    String formattedStartDate1 = sdf.format(startDate1);
                    String formattedEndDate1 = sdf.format(endDate1);
                    
                    String formattedStartDate2 = sdf.format(startDate2);
                    String formattedEndDate2 = sdf.format(endDate2);

                    query += " AND f1.Departing_Time BETWEEN '" + formattedStartDate1 + "' AND '" + formattedEndDate1 + "'";
                    query += " AND f2.Arrival_Time BETWEEN '" + formattedStartDate2 + "' AND '" + formattedEndDate2 + "'";

                }
                
                if (departureTime1 != null && !departureTime1.isEmpty()) {
                    query += " AND TIME(f1.Departing_Time) = '" + departureTime1 + "'";
                }
                
                if (arrivalBackTime != null && !arrivalBackTime.isEmpty()) {
                    query += " AND TIME(f2.Arrival_Time) = '" + arrivalBackTime + "'";
                } 
                
                if (maxFlightDuration1 != null && !maxFlightDuration1.isEmpty()){
    	        	query += " AND TIMESTAMPDIFF(HOUR, f1.Departing_Time, f1.Arrival_Time) <= '" + maxFlightDuration1 + "'";
    	        }
                
                if (maxFlightDuration2 != null && !maxFlightDuration2.isEmpty()){
    	        	query += " AND TIMESTAMPDIFF(HOUR, f2.Departing_Time, f2.Arrival_Time) <= '" + maxFlightDuration2 + "'";
    	        }
                
                if (maxFlightCostEcon1 != null && !maxFlightCostEcon1.isEmpty()) {
                    query += " AND f1.EconomyClassPrice <= '" + maxFlightCostEcon1 + "'";
                }
                
                if (maxFlightCostEcon2 != null && !maxFlightCostEcon2.isEmpty()) {
                    query += " AND f2.EconomyClassPrice <= '" + maxFlightCostEcon2 + "'";
                }
                
                if (airline1 != null && !airline1.isEmpty()) {
    	        	if(!airline1.equals("any")){
                    	query += " AND f1.Airline_Id = '" + airline1 + "'";
    	        	}
    	        }
                
                if (airline2 != null && !airline2.isEmpty()) {
    	        	if(!airline2.equals("any")){
                    	query += " AND f2.Airline_Id = '" + airline2 + "'";
    	        	}
    	        }
                
            }
            
         

            // Specify the conditions for forming a round trip
            query += " AND f1.Arrival_Airport = f2.Departure_Airport AND f1.Departure_Airport = f2.Arrival_Airport";
            		
            if (flexOption_2.equals("sortPrice")){
	        	query += " ORDER BY CombinedEconomyPrice ";
	        }
	        
	        if (flexOption_2.equals("sortArrivalTime")){
	        	query += " ORDER BY f2.Arrival_Time ";
	        }
	        
	        if (flexOption_2.equals("sortDepartureTime")){
	        	query += " ORDER BY f1.Departing_Time ";
	        }
	        
	        if (flexOption_2.equals("sortDuration")){
	        	query += " ORDER BY CombinedFlightDuration ";
	        }  
 
            rs = st.executeQuery(query);

            // Display the results with a button for booking
            out.println("<table border='1'>");
            out.println("<tr><th>Flight 1 Number</th><th>Flight 1 Airline ID</th><th>Flight 1 Aircraft ID</th><th>Flight 1 Departure Airport</th><th>Flight 1 Arrival Airport</th><th>Flight 1 Departing Time</th><th>Flight 1 Arrival Time</th><th>Flight 1 Type</th>" +
                    "<th>Flight 2 Number</th><th>Flight 2 Airline ID</th><th>Flight 2 Aircraft ID</th><th>Flight 2 Departure Airport</th><th>Flight 2 Arrival Airport</th><th>Flight 2 Departing Time</th><th>Flight 2 Arrival Time</th><th>Flight 2 Type</th><th>Combined Duration</th><th>Combined Econ Price</th><th>Book This Round Trip</th></tr>");

            while (rs.next()) {
                out.println("<tr>");
                //
              /*        out.println("<tr>");
                out.println("<td>" + rs.getString("Flight_number") + "</td>");
                out.println("<td>" + rs.getString("Airline_id") + "</td>");
                out.println("<td>" + rs.getString("Departure_Airport") + "</td>");
                out.println("<td>" + rs.getString("Arrival_Airport") + "</td>");
                out.println("<td>" + rs.getString("Departing_Time") + "</td>");
                out.println("<td>" + rs.getString("Arrival_Time") + "</td>");
                out.println("<td>" + rs.getString("Flight_type") + "</td>");
                out.println("<td>" + rs.getString("FlightDuration") + "</td>");
                out.println("<td>" + "$" + rs.getString("EconomyClassPrice") + "</td>"); */
                
                // Flight 1
                out.println("<td>" + rs.getString("f1.Flight_number") + "</td>");
                out.println("<td>" + rs.getString("f1.Airline_id") + "</td>");
                out.println("<td>" + rs.getString("f1.Aircraft_id") + "</td>");
                out.println("<td>" + rs.getString("f1.Departure_Airport") + "</td>");
                out.println("<td>" + rs.getString("f1.Arrival_Airport") + "</td>");
                out.println("<td>" + rs.getString("f1.Departing_Time") + "</td>");
                out.println("<td>" + rs.getString("f1.Arrival_Time") + "</td>");
                //out.println("<td>" + rs.getString("FlightDuration1") + "</td>");

                out.println("<td>" + rs.getString("f1.Flight_type") + "</td>");

                // Flight 2
                out.println("<td>" + rs.getString("f2.Flight_number") + "</td>");
                out.println("<td>" + rs.getString("f2.Airline_id") + "</td>");
                out.println("<td>" + rs.getString("f2.Aircraft_id") + "</td>");
                out.println("<td>" + rs.getString("f2.Departure_Airport") + "</td>");
                out.println("<td>" + rs.getString("f2.Arrival_Airport") + "</td>");
                out.println("<td>" + rs.getString("f2.Departing_Time") + "</td>");
                out.println("<td>" + rs.getString("f2.Arrival_Time") + "</td>");
                //out.println("<td>" + rs.getString("FlightDuration2") + "</td>");


                out.println("<td>" + rs.getString("f2.Flight_type") + "</td>");
                out.println("<td>" + rs.getString("CombinedFlightDuration") + "</td>");
                out.println("<td>" + "$" + rs.getString("CombinedEconomyPrice") + "</td>");



           
             //   
               
                out.println("<td><form action='bookFlightRound.jsp' method='post'>");
                 
                //Send Flight 1 Info 
                out.println("<input type='hidden' name='flightNumber1' value='" + rs.getString("f1.Flight_number") + "'>");
                out.println("<input type='hidden' name='airlineId1' value='" + rs.getString("f1.Airline_id") + "'>");
                out.println("<input type='hidden' name='aircraftId1' value='" + rs.getString("f1.aircraft_Id") + "'>");
                out.println("<input type='hidden' name='departureAirport1' value='" + rs.getString("f1.Departure_Airport") + "'>");
                out.println("<input type='hidden' name='arrivalAirport1' value='" + rs.getString("f1.Arrival_Airport") + "'>");
                out.println("<input type='hidden' name='departingTime1' value='" + rs.getString("f1.Departing_Time") + "'>");
                out.println("<input type='hidden' name='arrivalTime1' value='" + rs.getString("f1.Arrival_Time") + "'>");
                out.println("<input type='hidden' name='flightType1' value='" + rs.getString("f1.Flight_type") + "'>");
                
                out.println("<input type='hidden' name='flightEconCost1' value='" + rs.getString("f1.EconomyClassPrice") + "'>");
                out.println("<input type='hidden' name='flightBizCost1' value='" + rs.getString("f1.BuisnessClassPrice") + "'>");
                out.println("<input type='hidden' name='flightFistClassCost1' value='" + rs.getString("f1.FirstClassPrice") + "'>");
                
                //Send Flight 2 info
                out.println("<input type='hidden' name='flightNumber2' value='" + rs.getString("f2.Flight_number") + "'>");
                out.println("<input type='hidden' name='airlineId2' value='" + rs.getString("f2.Airline_id") + "'>");
                out.println("<input type='hidden' name='aircraftId2' value='" + rs.getString("f2.aircraft_Id") + "'>");
                out.println("<input type='hidden' name='departureAirport2' value='" + rs.getString("f2.Departure_Airport") + "'>");
                out.println("<input type='hidden' name='arrivalAirport2' value='" + rs.getString("f2.Arrival_Airport") + "'>");
                out.println("<input type='hidden' name='departingTime2' value='" + rs.getString("f2.Departing_Time") + "'>");
                out.println("<input type='hidden' name='arrivalTime2' value='" + rs.getString("f2.Arrival_Time") + "'>");
                out.println("<input type='hidden' name='flightType2' value='" + rs.getString("f2.Flight_type") + "'>");
                
                out.println("<input type='hidden' name='flightEconCost2' value='" + rs.getString("f2.EconomyClassPrice") + "'>");
                out.println("<input type='hidden' name='flightBizCost2' value='" + rs.getString("f2.BuisnessClassPrice") + "'>");
                out.println("<input type='hidden' name='flightFistClassCost2' value='" + rs.getString("f2.FirstClassPrice") + "'>");
                
                //submit
                out.println("<input type='submit' value='Book'></form></td>");
                
          
            
                out.println("</tr>");
            }

            out.println("</table>");
            con.close();
        } catch (SQLException | ParseException e) {
            e.printStackTrace();
        }
    %>

</body>
</html>
