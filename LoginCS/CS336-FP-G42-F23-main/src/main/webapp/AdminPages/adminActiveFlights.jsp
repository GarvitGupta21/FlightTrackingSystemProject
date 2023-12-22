<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Active Flights</title>
</head>
<body>
	<%
	String query = String.format("SELECT Airline_Id, Flight_number, COUNT(DISTINCT(Id_number)) AS Count "+
								"FROM Reserves "+
								"GROUP BY Airline_Id, Flight_number "+
								"HAVING COUNT(DISTINCT(Id_number)) = (" +
								"SELECT MAX(Count) "+
    							"FROM (SELECT Airline_Id, Flight_number, COUNT(DISTINCT(Id_number)) as Count FROM Reserves GROUP BY Airline_Id, Flight_number) AS Subquery)");
	int ticketsSold = 0;
	try {
    	ApplicationDB db = new ApplicationDB();	
    	Connection con = db.getConnection();
        Statement st = con.createStatement();
        ResultSet rs;
        
    	rs = st.executeQuery(query);
		out.println("Below is/are the flight(s) with the most tickets sold:<br><br>");
		
    	while (rs.next()) {
    		ticketsSold = rs.getInt("Count");
    		out.println(rs.getString("Airline_Id")+" Flight #" +rs.getString("Flight_number")+"<br>");
        }
    	out.println("<br>They (each) sold: " +ticketsSold+ " tickets each.");
    } catch (SQLException e) {
        e.printStackTrace();
    }
	%>
</body>
</html>