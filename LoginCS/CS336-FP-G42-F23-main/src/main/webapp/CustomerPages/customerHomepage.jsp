<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">	
<title>Insert title here</title>
</head>
<body>

	Welcome to Home Page
	<br>
	<a href='customerFlightSearch.jsp'>Search Direct Flights</a>
	<br>
	<a href='customerRoundFlightSearch.jsp'>Search Round Flights</a>
	<br>
	<form action="customerReservations.jsp" method="post">
		<input type="hidden" name="userName" value="<%= (String)session.getAttribute("user") %>"> 
		<input type="submit" value="View Reservations">
	</form>
	<a href='customerQA.jsp'>Q/A Board</a>
	
	<br>
	Alerts:
	<br>
	<%
	String query = String.format("SELECT Waitlist.Flight_number, Waitlist.Airline_Id "+
			"FROM Waitlist "+
			"JOIN Flight on Waitlist.Flight_number = Flight.Flight_number "+
			"JOIN Aircraft on Flight.Aircraft_id = Aircraft.Aircraft_id "+
			"JOIN Aircraft_Model on Aircraft.Model_Id = Aircraft_Model.Model_Id "+
			"WHERE (SELECT COUNT(*) FROM (SELECT * FROM Reserves where Reserves.Flight_number = Flight.Flight_number AND Reserves.Airline_Id = Flight.Airline_Id) As Subquery) "+ 
			"< (Aircraft_Model.firstRows * firstSeatsInRow + Aircraft_Model.businessRows * businessSeatsInRow + Aircraft_Model.economyRows * economySeatsInRow)");
	
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
    Statement st = con.createStatement();
    ResultSet rs;
    try {	
    	rs = st.executeQuery(query);

        while (rs.next()) {
            out.println(rs.getString("Waitlist.Airline_Id")+" Flight #" +rs.getString("Waitlist.Flight_number")+" has a reservation available.<br>");
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
	%>
</body>
</html>