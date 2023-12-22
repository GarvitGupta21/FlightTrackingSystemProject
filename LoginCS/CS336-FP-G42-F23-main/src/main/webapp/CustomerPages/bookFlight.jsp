<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Book Flight</title>
</head>


<body>
	
    
    <%
	    String flightNumber = request.getParameter("flightNumber");
	    String airlineId = request.getParameter("airlineId");
	    String departureAirport = request.getParameter("departureAirport");
	    String arrivalAirport = request.getParameter("arrivalAirport");
	    String departingTime = request.getParameter("departingTime");
	    String arrivalTime = request.getParameter("arrivalTime");
	    String flightType = request.getParameter("flightType");
	   	String flightEconCost = request.getParameter("flightEconCost");
	   	String flightBizCost = request.getParameter("flightBizCost");
	   	String flightFistClassCost = request.getParameter("flightFistClassCost");
	   	
	   	float economyTicketCost = Float.parseFloat(flightEconCost);
	   	float businessTicketCost = Float.parseFloat(flightBizCost);
	   	float firstTicketCost = Float.parseFloat(flightFistClassCost);
    	float bookingFee = 20;
    	



	    out.println("<table border='1'>");
	    out.println("<tr><th>Flight Number</th><th>Airline Id</th><th>Departure Airport</th><th>Arrival Airport</th><th>Departing Time</th><th>Arrival Time</th><th>Flight Type</th>");

        out.println("<tr>");
        out.println("<td>" + flightNumber + "</td>");
        out.println("<td>" + airlineId + "</td>");
        out.println("<td>" + departureAirport + "</td>");
        out.println("<td>" + departingTime + "</td>");
        out.println("<td>" + arrivalAirport + "</td>");
        out.println("<td>" + arrivalTime + "</td>");
        out.println("<td>" + flightType + "</td>");
        
        out.println("</tr>");
    	out.println("</table>");
    	out.println("<br>");
    	
 
    	
    	out.println("<table border='1'>");
  	    out.println("<tr><th>Booking Fee</th><th>Ticket Cost(Economy)</th><th>Ticket Cost(Business)</th><th>Ticket Cost(First-Class)</th>");
  	  	out.println("<tr>");
  	  	out.println("<td>" + "$" + bookingFee + "</td>");
      	out.println("<td>" +  "$" + economyTicketCost + "</td>");
      	out.println("<td>" + "$" + businessTicketCost + "</td>");
      	out.println("<td>" + "$" + firstTicketCost + "</td>");
      	out.println("</tr>");
  		out.println("</table>");
  		out.println("<br>");
	
	int firstRows = 0;
	int firstSeatsInRow = 0;
	int businessRows = 0;
	int businessSeatsInRow = 0;
	int economyRows = 0;
	int economySeatsInRow = 0;

	try{
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		
		String sql = "SELECT firstRows, firstSeatsInRow, businessRows, businessSeatsInRow, economyRows, economySeatsInRow FROM Flight as f, Aircraft as a, Aircraft_Model as m WHERE f.Flight_number = ? AND f.Airline_Id = ? AND f.Aircraft_Id = a.Aircraft_Id AND a.Model_Id = m.Model_Id";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs; 
		
		ps.setString(1, flightNumber);
		ps.setString(2, airlineId);
	
		rs = ps.executeQuery();	
		
		rs.next();
		firstRows = rs.getInt("firstRows");
		firstSeatsInRow = rs.getInt("firstSeatsInRow");
		businessRows = rs.getInt("businessRows");
		businessSeatsInRow = rs.getInt("businessSeatsInRow");
		economyRows = rs.getInt("economyRows");
		economySeatsInRow = rs.getInt("economySeatsInRow");
		
		out.println("<script>");
	    out.println("var firstRows = " + firstRows + ";");
	    out.println("var firstSeatsInRow = " + firstSeatsInRow + ";");
	    out.println("var businessRows = " + businessRows + ";");
	    out.println("var businessSeatsInRow = " + businessSeatsInRow + ";");
	    out.println("var economyRows = " + economyRows + ";");
	    out.println("var economySeatsInRow = " + economySeatsInRow + ";");
	    out.println("</script>");
		con.close();
	} catch(SQLException e){
		e.printStackTrace();
	}
	
	%>
	
	<%
	
	ApplicationDB db3 = new ApplicationDB();	
	Connection con3 = db3.getConnection();
	
	String sql3 = "SELECT Seat_Number FROM Reserves WHERE Flight_number = ? AND Airline_Id = ?";
	PreparedStatement ps3 = con3.prepareStatement(sql3);
	
	ps3.setInt(1, Integer.parseInt(flightNumber));
	ps3.setString(2, airlineId);
	
	ResultSet rs3; 
	rs3 = ps3.executeQuery();
	
	List<String> seatList = new ArrayList<>();

	while(rs3.next()){
		seatList.add(rs3.getString("Seat_Number"));
	}
	
	
	%>
	
	<script>
	
    
	function test(){
		
        
		var ticketType = document.forms["buyTicket"]["ticketType"].value;
        var seatLetter = document.forms["buyTicket"]["seatLetter"].value;
        var row = parseInt(document.forms["buyTicket"]["rowNumber"].value);
        
        if(row > (firstRows + businessRows + economyRows) || row <= 0){
        	alert("Invalid Row Number");
        	return false;
        }
        
        const alphMap = new Map();
        alphMap.set('A', 1);
        alphMap.set('B', 2);
        alphMap.set('C', 3);
        alphMap.set('D', 4);
        alphMap.set('E', 5);
        alphMap.set	('F', 6);
        
        if(ticketType == "first"){
        	if(alphMap.get(seatLetter) > firstSeatsInRow){
        		alert("Invalid Letter For First Class");
        		return false;
        	}
  			    	
        	if(row > firstRows){
        		alert("Invalid Row For First Class");
        		return false;
        	}
        	return true;
        }
        
        if(ticketType == "business"){	
        	
        	if(alphMap.get(seatLetter) > businessSeatsInRow){
        		alert("Invalid Letter For Business Class");
        		return false;
        	}
  	
        	if(row <= firstRows || row > (firstRows+businessRows) ){
        		alert("Invalid Row For Business Class");
        		return false;
        	}
        	return true;
        	
        	
        }
        
        if(ticketType == "economy"){
        	
            
        	if(alphMap.get(seatLetter) > economySeatsInRow){
        		alert("Invalid Letter For Economy Class");
        		return false;
        	}
  
        	if(row <= (firstRows+businessRows) || row > (firstRows+businessRows+economyRows)){
        		alert("Invalid Row For Economy Class");
        		return false;
        	}
        	return true;
        }
        
        alert("Unknown Error Occured Try Again");
        return false;
        }
	
	function returnFalse(){
		alert("False");
		return false;
		
	};

	</script>
	
	<%
	int numberOfSeats = firstRows * firstSeatsInRow + businessRows * businessSeatsInRow + economyRows * economySeatsInRow;
	ApplicationDB db2 = new ApplicationDB();	
	Connection con2 = db2.getConnection();
	
	String sql2 = "SELECT COUNT(*) as Seats_Reserved FROM Reserves WHERE Flight_number = ? AND Airline_Id = ?";
	PreparedStatement ps2 = con2.prepareStatement(sql2);
	ps2.setInt(1, Integer.parseInt(flightNumber));
	ps2.setString(2, airlineId);
	ResultSet rs2; 
	rs2 = ps2.executeQuery();
	
	
	rs2.next();
	int seatsReserved = rs2.getInt("Seats_Reserved");

	if (seatsReserved == numberOfSeats){
	%>
	
	<div>This Flight is Full</div>
	<form name="joinWaitlist" action="joinWaitlist.jsp" method="post">
	<input type='hidden' name='flightNumber' value=<%=flightNumber %>>
	<input type='hidden' name='airlineId' value=<%=airlineId %>>
	<input type='hidden' name='username' value=<%=(String) session.getAttribute("user") %>>
	<input type="submit" value="Join Waitlist">
	</form>
	
	
	<% } else {%>
		<form name="buyTicket" action="bookDirectSuccess.jsp" method="post" onsubmit="return test();">
	        <label for="ticketType">Select Ticket Type:</label>
	        <select name="ticketType">
	    	<option value="first">First-Class</option>
	    	<option value="business">Business</option>
	    	<option value="economy">Economy</option>
	  		</select>
	        <br>
	        <label for="rowNumber">Type Row Number:</label>
	        <input type="text" name="rowNumber" required>
	        <label for="seatLetter">Select Seat Letter:</label>
	        <select name="seatLetter">
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
			<input type='hidden' name='bookingFee' value=<%=bookingFee %>>
	        <input type='hidden' name='firstCost' value=<%=firstTicketCost %>>
	        <input type='hidden' name='businessCost' value=<%=businessTicketCost %>>
	        <input type='hidden' name='economyCost' value=<%=economyTicketCost %>>
	        <input type='hidden' name='flightNumber' value=<%=flightNumber %>>
	        <input type='hidden' name='airlineId' value=<%=airlineId %>>
	        <input type="submit" value="Buy Ticket">
	        <br>
	    </form>
	
	<%
	}
	con2.close();
	%>
	
	<a href='customerHomepage.jsp'>Return to Home Page</a>
</body>

	
</html>