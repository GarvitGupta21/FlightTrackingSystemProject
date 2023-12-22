<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.text.DecimalFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Reservations</title>
</head>
<body>
    <%
    String criteria = request.getParameter("Criteria");
    String input = request.getParameter("Input");
    String query = String.format("SELECT FlightTicket.Customer_name,Reserves.Id_number, Reserves.Airline_Id, Reserves.Flight_number, Reserves.Class, Reserves.Seat_Number " +
    		"FROM Reserves " +
    		"JOIN FlightTicket ON Reserves.Id_number = FlightTicket.Id_number " +
    		"WHERE ");
    if (criteria.equals("flight number"))
		query+="Reserves.Flight_number = '" +input+ "'";
    else if (criteria.equals("customer name"))
		query+="FlightTicket.Customer_name = '" +input+ "'";
    
    ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
    Statement st = con.createStatement();
    ResultSet rs;
    
    try {
    	rs = st.executeQuery(query);

        out.println("<table border='1'>");
        out.println("<tr><th>Customer Name</th><th>Ticket ID</th><th>Airline</th><th>Flight number</th><th>Class</th><th>Seat Number</th>");

        while (rs.next()) {
            out.println("<tr>");
            out.println("<td>" + rs.getString("FlightTicket.Customer_name") + "</td>");
            out.println("<td>" + rs.getString("Reserves.Id_number") + "</td>");
            out.println("<td>" + rs.getString("Reserves.Airline_Id") + "</td>");
            out.println("<td>" + rs.getString("Reserves.Flight_number") + "</td>");
            out.println("<td>" + rs.getString("Reserves.Class") + "</td>");
            out.println("<td>" + rs.getString("Reserves.Seat_Number") + "</td>");
            out.println("</tr>");
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>
</body>
</html>
