<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>View/Change Flights Info</title>
</head>
<body>
	<h2>View/Change Flights Info</h2>
    <%
try {
    ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
    Statement st = con.createStatement();
    ResultSet rs;

    // Customize the query based on your database schema
    String query = String.format("SELECT * FROM Flight");

    rs = st.executeQuery(query);

    // Display the QA board
    out.println("<table border='1'>");
    out.println("<tr><th>Flight Number</th><th>Airline ID</th><th>Aircraft ID</th><th>Departure Airport</th><th>Arrival Airport</th><th>Departure Time</th><th>Arrival Time</th><th>Flight Type</th>");

    while (rs.next()) {
        out.println("<tr>");
        out.println("<td>" + rs.getString("Flight_number") + "</td>");
        out.println("<td>" + rs.getString("Airline_Id") + "</td>");
        out.println("<td>" + rs.getString("Aircraft_Id") + "</td>");
        out.println("<td>" + rs.getString("Departure_Airport") + "</td>");
        out.println("<td>" + rs.getString("Arrival_Airport") + "</td>");
        out.println("<td>" + rs.getString("Departing_Time") + "</td>");
        out.println("<td>" + rs.getString("Arrival_Time") + "</td>");
        out.println("<td>" + rs.getString("Flight_type") + "</td>");
    
        out.println("<td><form action='editFlight.jsp' method='post'>");
    	out.println("<input type='hidden' name='Flight_number' value='" + rs.getString("Flight_number") + "'>");
    	out.println("<input type='hidden' name='Airline_Id' value='" + rs.getString("Airline_Id") + "'>");
    	out.println("<input type='hidden' name='Aircraft_Id' value='" + rs.getString("Aircraft_Id") + "'>");
    	out.println("<input type='hidden' name='Departure_Airport' value='" + rs.getString("Departure_Airport") + "'>");
    	out.println("<input type='hidden' name='Arrival_Airport' value='" + rs.getString("Arrival_Airport") + "'>");
    	out.println("<input type='hidden' name='Departing_Time' value='" + rs.getString("Departing_Time") + "'>");
    	out.println("<input type='hidden' name='Arrival_Time' value='" + rs.getString("Arrival_Time") + "'>");
    	out.println("<input type='hidden' name='Flight_type' value='" + rs.getString("Flight_type") + "'>");
    	out.println("<input type='submit' value='Edit'></form></td>");
    	
    	out.println("<td><form action='deleteFlight.jsp' method='post'>");
    	out.println("<input type='hidden' name='Flight_number' value='" + rs.getString("Flight_number") + "'>");
    	out.println("<input type='hidden' name='Airline_Id' value='" + rs.getString("Airline_Id") + "'>");
    	out.println("<input type='submit' value='Delete'></form></td>");
    	
    	out.println("<td><form action='viewWaitlist.jsp' method='post'>");
    	out.println("<input type='hidden' name='Flight_number' value='" + rs.getString("Flight_number") + "'>");
    	out.println("<input type='hidden' name='Airline_Id' value='" + rs.getString("Airline_Id") + "'>");
    	out.println("<input type='submit' value='View Waitlist'></form></td>");
    	out.println("</tr>");
        
    }

    out.println("</table>");
    con.close();
} catch (SQLException e) {
    e.printStackTrace();
}
%>

	<br>
	<div><b>Add Flight:</b></div>
    <form action="addFlight.jsp" method="post">
        <label for="Flight_number">Type Flight Number here:</label>
        <input type="text" name="Flight_number" required>
        <br>
        
        <label for="Airline_Id">Airline_Id:</label>
		<select name="Airline_Id">
		<option disabled selected>Choose Airline Id</option>
		
    	<%
    	
    	ApplicationDB db2 = new ApplicationDB();	
		Connection con2 = db2.getConnection(); 
		
		Statement st2 = con2.createStatement();
		ResultSet rs2;
		rs2 = st2.executeQuery("SELECT Airline_Id FROM Airline");
				
		while(rs2.next()){
			out.println(String.format("<option value='%s'>%s</option>", rs2.getString("Airline_Id"), rs2.getString("Airline_Id")));
		};
		
		%>
  		</select>
  		<br>
  		
        
        <label for="Aircraft_Id">Aircraft Id:</label>
        <input type="text" name="Aircraft_Id" required>
        <br>
        
        
        <label for="departureAirport">Departure Airport:</label>
		<select name="departureAirport">
		<option disabled selected>Choose Departure Airport</option>
		
    	<%
    	
		Statement st4 = con2.createStatement();
		ResultSet rs4;
		rs4 = st4.executeQuery("SELECT Airport_Id FROM Airport");
				
		while(rs4.next()){
			out.println(String.format("<option value='%s'>%s</option>", rs4.getString("Airport_Id"), rs4.getString("Airport_Id")));
		};
		
		%>
  		</select>
  		<br>


        <label for="arrivalAirport">Arrival Airport:</label>
		<select name="arrivalAirport">
		<option disabled selected>Choose Arrival Airport</option>
    	<%
    	
    	Statement st5 = con2.createStatement();
		ResultSet rs5;
		rs5 = st5.executeQuery("SELECT Airport_Id FROM Airport");
		while(rs5.next()){
			out.println(String.format("<option value='%s'>%s</option>", rs5.getString("Airport_Id"), rs5.getString("Airport_Id")));
		};
		
		con2.close();
		
		%>
		</select>
		<br>
        <label for="departureDate">Departure Date:</label>
        <input type="date" name="departureDate">
        <br>
        <label for="arrivalDate">Arrival Date:</label>
        <input type="date" name="arrivalDate">
        <br>
        <label for="flightType">Choose Flight Type</label>
        <select name="flightType">
		<option disabled selected>Choose Flight Type</option>
		<option value="Domestic">Domestic</option>
    	<option value="International">International</option>
		</select>
		<br>
		<label for="firstClassPrice">First Class Price:</label>
        <input type="text" name="firstClassPrice">
        <br>
        <label for="businessClassPrice">Business Class Price:</label>
        <input type="text" name="businessClassPrice">
        <br>
        <label for="economyClassPrice">Economy Class Price:</label>
        <input type="text" name="economyClassPrice">
        <br>
        <input type="submit" value="Add Aircraft">
    </form>
<br></br>
<a href='crHomepage.jsp'>Return to Homepage</a>

</body>
</html>