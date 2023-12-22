<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.text.DecimalFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Revenue Summary</title>
</head>
<body>
    <%
    DecimalFormat COSTFORMATTED = new DecimalFormat("$###,###,##0.00");
    double totalRevenue = 0.0;
    String criteria = request.getParameter("Criteria");
    String input = request.getParameter("Input");
    String query = String.format("SELECT Booking_Fee, Ticket_Cost " +
    		"FROM FlightTicket " +
    		"JOIN Reserves ON Reserves.Id_number = FlightTicket.Id_number " +
    		"WHERE ");
    if (criteria.equals("flight number"))
		query+="Reserves.Flight_number = '" +input+ "'";
    else if (criteria.equals("customer name"))
		query+="FlightTicket.Customer_name = '" +input+ "'";
    else if (criteria.equals("airline"))
		query+="Reserves.Airline_Id = '" +input+ "'";
    
    try {
    	
    	ApplicationDB db = new ApplicationDB();	
    	Connection con = db.getConnection();
        Statement st = con.createStatement();
        ResultSet rs;
        
    	rs = st.executeQuery(query);

    	while (rs.next()) {
        	double ticketCost = rs.getFloat("Booking_Fee") + rs.getFloat("Ticket_Cost");
        	totalRevenue+=ticketCost;
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    
    if (criteria.equals("flight number"))
    	out.println("Flight # " +input+ " generated " +COSTFORMATTED.format(totalRevenue));
    else if (criteria.equals("customer name"))
    	out.println("Customer " +input+ " generated " +COSTFORMATTED.format(totalRevenue));
    else if (criteria.equals("airline"))
    	out.println("Airline with ID " +input+ " generated " +COSTFORMATTED.format(totalRevenue));
%>
</body>
</html>
