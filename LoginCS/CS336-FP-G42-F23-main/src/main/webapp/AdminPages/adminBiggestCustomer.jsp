<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.text.DecimalFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Biggest Customer</title>
</head>
<body>
	<%
	DecimalFormat COSTFORMATTED = new DecimalFormat("$###,###,##0.00");
	String query = String.format("SELECT Customer_Name, SUM(Booking_Fee) + SUM(Ticket_Cost) AS TotalCost "+
								"FROM FlightTicket "+
								"GROUP BY Customer_Name "+
								"HAVING TotalCost = (" +
								"SELECT MAX(TotalCost) "+
    							"FROM (SELECT Customer_Name, SUM(Booking_Fee) + SUM(Ticket_Cost) AS TotalCost FROM FlightTicket GROUP BY Customer_Name) AS Subquery)");
	double revenue = 0.0;
	try {
    	ApplicationDB db = new ApplicationDB();	
    	Connection con = db.getConnection();
        Statement st = con.createStatement();
        ResultSet rs;
        
    	rs = st.executeQuery(query);
		out.println("Below is/are the customer(s) who generated the most revenue:<br><br>");
		
    	while (rs.next()) {
    		revenue = rs.getFloat("TotalCost");
    		out.println(rs.getString("Customer_Name")+"<br>");
        }
    	out.println("<br>They (each) generated " +COSTFORMATTED.format(revenue));
    } catch (SQLException e) {
        e.printStackTrace();
    }
	%>
</body>
</html>