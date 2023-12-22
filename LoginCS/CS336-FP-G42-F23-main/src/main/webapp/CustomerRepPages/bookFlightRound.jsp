<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Edit Aircraft</title>
</head>


<body>
	
    
    <%
	    String flightNumber1 = request.getParameter("flightNumber1");
	    String airlineId1 = request.getParameter("airlineId1");
	    String departureAirport1 = request.getParameter("departureAirport1");
	    String arrivalAirport1 = request.getParameter("arrivalAirport1");
	    String departingTime1 = request.getParameter("departingTime1");
	    String arrivalTime1 = request.getParameter("arrivalTime1");
	    String flightType1 = request.getParameter("flightType1");
	    
	    String flightEconCost1 = request.getParameter("flightEconCost1");
	   	String flightBizCost1 = request.getParameter("flightBizCost1");
	   	String flightFistClassCost1 = request.getParameter("flightFistClassCost1");
	    
	    String flightNumber2 = request.getParameter("flightNumber2");
	    String airlineId2 = request.getParameter("airlineId2");
	    String departureAirport2 = request.getParameter("departureAirport2");
	    String arrivalAirport2 = request.getParameter("arrivalAirport2");
	    String departingTime2 = request.getParameter("departingTime2");
	    String arrivalTime2 = request.getParameter("arrivalTime2");
	    String flightType2 = request.getParameter("flightType2");
	    
	    String flightEconCost2 = request.getParameter("flightEconCost2");
	   	String flightBizCost2 = request.getParameter("flightBizCost2");
	   	String flightFistClassCost2 = request.getParameter("flightFistClassCost2");
	  
	   	
	
	   	
	   	float economyTicketCost1 = Float.parseFloat(flightEconCost1);
	   	float businessTicketCost1 = Float.parseFloat(flightBizCost1);
	   	float firstTicketCost1 = Float.parseFloat(flightFistClassCost1);
	   	
	   	
	 	float economyTicketCost2 = Float.parseFloat(flightEconCost2);
	   	float businessTicketCost2 = Float.parseFloat(flightBizCost2);
	   	float firstTicketCost2 = Float.parseFloat(flightFistClassCost2);
	   	
		out.println("<h2>Departure Flight Information:</h2>");

	    
	    out.println("<table border='1'>");
	    out.println("<tr><th>Flight Number 1</th><th>Airline Id 1</th><th>Departure Airport 1</th><th>Arrival Airport 1</th><th>Departing Time 1</th><th>Arrival Time 1</th><th>Flight Type 1</th>");

        out.println("<tr>");
        out.println("<td>" + flightNumber1 + "</td>");
        out.println("<td>" + airlineId1 + "</td>");
        out.println("<td>" + departureAirport1 + "</td>");
        out.println("<td>" + departingTime1 + "</td>");
        out.println("<td>" + arrivalAirport1 + "</td>");
        out.println("<td>" + arrivalTime1 + "</td>");
        out.println("<td>" + flightType1 + "</td>");
        
        out.println("</tr>");
    	out.println("</table>");
    	out.println("<br>");
    	
		out.println("<h2>Return Flight Information:</h2>");

	    out.println("<table border='1'>");
	    out.println("<tr><th>Flight Number 2</th><th>Airline Id 2</th><th>Departure Airport 2</th><th>Arrival Airport 2</th><th>Departing Time 2</th><th>Arrival Time 2</th><th>Flight Type 2</th>");

        out.println("<tr>");
        out.println("<td>" + flightNumber2 + "</td>");
        out.println("<td>" + airlineId2 + "</td>");
        out.println("<td>" + departureAirport2 + "</td>");
        out.println("<td>" + departingTime2 + "</td>");
        out.println("<td>" + arrivalAirport2 + "</td>");
        out.println("<td>" + arrivalTime2 + "</td>");
        out.println("<td>" + flightType2 + "</td>");
        
        out.println("</tr>");
    	out.println("</table>");
    	out.println("<br>");
    	
    	
    
    	
    	int bookingFee1 = 20;
    
    	if(flightType1.equals("International")){
    		economyTicketCost1 += 50;
    	}
    	if(flightType1.equals("International")){
    		businessTicketCost1 += 50;
    	}
    	if(flightType1.equals("International")){
    		firstTicketCost1 += 50;
    	}
    	
    	int bookingFee2 = 20;
    	
    	
    	if(flightType1.equals("International")){
    		economyTicketCost2 += 50;
    	}
    	if(flightType1.equals("International")){
    		businessTicketCost2 += 50;
    	}
    	if(flightType1.equals("International")){
    		firstTicketCost2 += 50;
    	}
    	
		out.println("<h2>Departure Ticket Information:</h2>");

    	
    	out.println("<table border='1'>");
  	    out.println("<tr><th>Booking Fee 1</th><th>Ticket Cost(Economy) 1</th><th>Ticket Cost(Business) 1</th><th>Ticket Cost(First-Class) 1</th>");
  	  	out.println("<tr>");
  	  	out.println("<td>" + bookingFee1 + "</td>");
      	out.println("<td>" + economyTicketCost1 + "</td>");
      	out.println("<td>" + businessTicketCost1 + "</td>");
      	out.println("<td>" + firstTicketCost1 + "</td>");
      	out.println("</tr>");
  		out.println("</table>");
  		out.println("<br>");
  		
		out.println("<h2>Return Ticket Information:</h2>");

  		out.println("<table border='1'>");
  	    out.println("<tr><th>Booking Fee 2</th><th>Ticket Cost(Economy) 2</th><th>Ticket Cost(Business) 2</th><th>Ticket Cost(First-Class) 2</th>");
  	  	out.println("<tr>");
  	  	out.println("<td>" + bookingFee2 + "</td>");
      	out.println("<td>" + economyTicketCost2 + "</td>");
      	out.println("<td>" + businessTicketCost2 + "</td>");
      	out.println("<td>" + firstTicketCost2 + "</td>");
      	out.println("</tr>");
  		out.println("</table>");
  		out.println("<br>");
	
	int firstRows1;
	int firstSeatsInRow1;
	int businessRows1;
	int businessSeatsInRow1;
	int economyRows1;
	int economySeatsInRow1;
	
	int firstRows2;
	int firstSeatsInRow2;
	int businessRows2;
	int businessSeatsInRow2;
	int economyRows2;
	int economySeatsInRow2;
	
	
	

	try{
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		
		String sql = "SELECT firstRows, firstSeatsInRow, businessRows, businessSeatsInRow, economyRows, economySeatsInRow FROM Flight as f, Aircraft as a, Aircraft_Model as m WHERE f.Flight_number = ? AND f.Airline_Id = ? AND f.Aircraft_Id = a.Aircraft_Id AND a.Model_Id = m.Model_Id";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs; 
		
		ps.setString(1, flightNumber1);
		ps.setString(2, airlineId1);
	
		rs = ps.executeQuery();	
		
		rs.next();
		firstRows1 = rs.getInt("firstRows");
		firstSeatsInRow1 = rs.getInt("firstSeatsInRow");
		businessRows1 = rs.getInt("businessRows");
		businessSeatsInRow1 = rs.getInt("businessSeatsInRow");
		economyRows1 = rs.getInt("economyRows");
		economySeatsInRow1 = rs.getInt("economySeatsInRow");
		
		out.println("<script>");
	    out.println("var firstRows = " + firstRows1 + ";");
	    out.println("var firstSeatsInRow = " + firstSeatsInRow1 + ";");
	    out.println("var businessRows = " + businessRows1 + ";");
	    out.println("var businessSeatsInRow = " + businessSeatsInRow1 + ";");
	    out.println("var economyRows = " + economyRows1 + ";");
	    out.println("var economySeatsInRow = " + economySeatsInRow1 + ";");
	    out.println("</script>");
				
		con.close();
	} catch(SQLException e){
		e.printStackTrace();
	}
	
	try{
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		
		String sql = "SELECT firstRows, firstSeatsInRow, businessRows, businessSeatsInRow, economyRows, economySeatsInRow FROM Flight as f, Aircraft as a, Aircraft_Model as m WHERE f.Flight_number = ? AND f.Airline_Id = ? AND f.Aircraft_Id = a.Aircraft_Id AND a.Model_Id = m.Model_Id";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs; 
		
		ps.setString(1, flightNumber1);
		ps.setString(2, airlineId1);
	
		rs = ps.executeQuery();	
		
		rs.next();
		firstRows2 = rs.getInt("firstRows");
		firstSeatsInRow2 = rs.getInt("firstSeatsInRow");
		businessRows2 = rs.getInt("businessRows");
		businessSeatsInRow2 = rs.getInt("businessSeatsInRow");
		economyRows2 = rs.getInt("economyRows");
		economySeatsInRow2 = rs.getInt("economySeatsInRow");
		
		out.println("<script>");
	    out.println("var firstRows = " + firstRows2 + ";");
	    out.println("var firstSeatsInRow = " + firstSeatsInRow2 + ";");
	    out.println("var businessRows = " + businessRows2 + ";");
	    out.println("var businessSeatsInRow = " + businessSeatsInRow2 + ";");
	    out.println("var economyRows = " + economyRows2 + ";");
	    out.println("var economySeatsInRow = " + economySeatsInRow2 + ";");
	    out.println("</script>");
				
		con.close();
	} catch(SQLException e){
		e.printStackTrace();
	}
	
	
	%>

	<h2>Book Your Departure Ticket:</h2>
		<form name="buyTicket1" action="bookDirectRoundSuccess.jsp" method="post">
	        <label for="ticketType1">Select Departure Ticket Type:</label>
	        <select name="ticketType1">
	    	<option value="economy">Economy</option>
	    	<option value="business">Business</option>
	    	<option value="first">First-Class</option>
	  		</select>
	        <br>
	        <label for="rowNumber1">Type Departure Row Number:</label>
	        <input type="text" name="rowNumber1" required>
	        <label for="seatLetter1">Select Departure Seat Letter:</label>
	        <select name="seatLetter1">
	    	<option value="A">A</option>
	    	<option value="B">B</option>
	    	<option value="C">C</option>
	    	<option value="D">D</option>
	    	<option value="E">E</option>
	    	<option value="F">F</option>
	  		</select>
	        <br>
	        <label for="passName">Type Passenger Name:</label>
	        <input type="text" name="passName" required>
	        <input type='hidden' name='bookingFee1' value=<%=bookingFee1 %>>
	        <input type='hidden' name='firstCost1' value=<%=firstTicketCost1 %>>
	        <input type='hidden' name='businessCost1' value=<%=businessTicketCost1 %>>
	        <input type='hidden' name='economyCost1' value=<%=economyTicketCost1 %>>
	        <input type='hidden' name='airlineId1' value=<%=airlineId1 %>>
	        <input type='hidden' name='flightNumber1' value=<%=flightNumber1 %>>
	        
	        
	        <br>
	     <br>
	      <h2>Book Your Return Ticket:</h2>
	     <br>
	        <label for="ticketType2">Select Return Ticket Type:</label>
	        <select name="ticketType2">
	    	<option value="economy">Economy</option>
	    	<option value="business">Business</option>
	    	<option value="first">First-Class</option>
	  		</select>
	        <br>
	        <label for="rowNumber2">Type Return Row Number:</label>
	        <input type="text" name="rowNumber2" required>
	        <label for="seatLetter2">Select Return Seat Letter:</label>
	        <select name="seatLetter2">
	    	<option value="A">A</option>
	    	<option value="B">B</option>
	    	<option value="C">C</option>
	    	<option value="D">D</option>
	    	<option value="E">E</option>
	    	<option value="F">F</option>
	  		</select>
	        <br>
	        <input type='hidden' name='firstCost2' value=<%=firstTicketCost2 %>>
	        <input type='hidden' name='businessCost2' value=<%=businessTicketCost2 %>>
	        <input type='hidden' name='economyCost2' value=<%=economyTicketCost2 %>>
	       	<input type='hidden' name='airlineId2' value=<%=airlineId2 %>>
	       	<input type='hidden' name='flightNumber2' value=<%=flightNumber2 %>>
	       	
	        
	        <input type="submit" value="Buy Ticket">
	        <br>
	        <label for="customerUserName">Select Customer Username:</label>
	    <select name="customerUserName">
        <%
            // Assuming you have a method to retrieve customer usernames from the database
            ApplicationDB dbCustomerUserNames = new ApplicationDB();
            Connection conCustomerUserNames = dbCustomerUserNames.getConnection();
            Statement stCustomerUserNames = conCustomerUserNames.createStatement();
            ResultSet rsCustomerUserNames = stCustomerUserNames.executeQuery("SELECT User_name FROM Account WHERE type = 'Customer'");

            while (rsCustomerUserNames.next()) {
                out.println("<option value='" + rsCustomerUserNames.getString("User_name") + "'>" + rsCustomerUserNames.getString("User_name") + "</option>");
            }

            conCustomerUserNames.close();
        %>
    </select>
	    </form>
	<a href='searchFlights.jsp'>Return to Flight Search Page</a>
</body>

	
</html>