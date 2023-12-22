<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.text.DecimalFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Sales Report</title>
</head>
<body>
    <%
    String month = request.getParameter("Month");
    DecimalFormat COSTFORMATTED = new DecimalFormat("$###,###,##0.00");
    int totalTickets = 0;
    double totalRevenue = 0.0;
    int totalFirstTickets = 0;
    int totalBusinessTickets = 0;
    int totalEconomyTickets = 0;
    double totalFirstRevenue = 0;
    double totalBusinessRevenue = 0;
    double totalEconomyRevenue = 0;
try {
    ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();

    // Customize the query based on your database schema
    String query = String.format("SELECT Class, Booking_Fee, Ticket_Cost " +
    		"FROM FlightTicket " +
    		"JOIN Reserves ON Reserves.Id_number = FlightTicket.Id_number " +
    		"JOIN Flight ON Reserves.Flight_number = Flight.Flight_number " +
    		"WHERE MONTH(Flight.Departing_Time) = " +month);
    
	ResultSet rs;
	PreparedStatement ps = con.prepareStatement(query);
	//ps.setString(1, month);
    rs = ps.executeQuery(query);

    out.println("<table border='1'>");
    out.println("<tr><th>Class</th><th>Total Tickets</th><th>Total Revenue</th>");
    
    
    
    while (rs.next()) {
    	totalTickets++;
    	double ticketCost = rs.getFloat("Booking_Fee") + rs.getFloat("Ticket_Cost");
    	totalRevenue+=ticketCost;
    	switch(rs.getString("Class")){
    	case "first":
    		totalFirstTickets++;
    		totalFirstRevenue+=ticketCost;
    		break;
    	case "business":
    		totalBusinessTickets++;
    		totalBusinessRevenue+=ticketCost;
    		break;
    	case "economy":
    		totalEconomyTickets++;
    		totalEconomyRevenue+=ticketCost;
    		break;
    	}
    }
    out.println("<tr>");
    out.println("<td>All</td>");
    out.println("<td>" + totalTickets + "</td>");
    out.println("<td>" + COSTFORMATTED.format(totalRevenue) + "</td>");
   	out.println("</tr>");
        
   	out.println("<tr>");
    out.println("<td>First</td>");
    out.println("<td>" + totalFirstTickets + "</td>");
    out.println("<td>" + COSTFORMATTED.format(totalFirstRevenue) + "</td>");
   	out.println("</tr>");
   	
   	out.println("<tr>");
    out.println("<td>Business</td>");
    out.println("<td>" + totalBusinessTickets + "</td>");
    out.println("<td>" + COSTFORMATTED.format(totalBusinessRevenue) + "</td>");
   	out.println("</tr>");
	
   	out.println("<tr>");
    out.println("<td>Economy</td>");
    out.println("<td>" + totalEconomyTickets + "</td>");
    out.println("<td>" + COSTFORMATTED.format(totalEconomyRevenue) + "</td>");
   	out.println("</tr>");
   	
    out.println("</table>");
    con.close();
} catch (SQLException e) {
    e.printStackTrace();
}
%>
</body>
</html>