<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*,java.util.*,com.cs336.pkg.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>User Reservation Information</title>
</head>
<body>

<%
    // Get the submitted user_name from the previous form
    String userName = request.getParameter("userName");

    try {
        // Establish the connection
        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();

        // Query to retrieve reservation information for the selected user
        ResultSet rs;
        String query = "SELECT DISTINCT ft.* FROM FlightTicket as ft INNER JOIN Reserves as r ON ft.Id_Number = r.Id_Number INNER JOIN Flight as f ON r.Flight_number = f.Flight_number AND r.Airline_Id = f.Airline_Id WHERE User_name = ? AND f.departing_time < current_timestamp()";
        		
        PreparedStatement preparedStatement = con.prepareStatement(query);
        preparedStatement.setString(1, userName);
        rs = preparedStatement.executeQuery();
        
        ResultSet rs2;
        String query2 = "SELECT DISTINCT ft.* FROM FlightTicket as ft INNER JOIN Reserves as r ON ft.Id_Number = r.Id_Number INNER JOIN Flight as f ON r.Flight_number = f.Flight_number AND r.Airline_Id = f.Airline_Id WHERE User_name = ? AND f.departing_time > current_timestamp();";
        PreparedStatement ps2 = con.prepareStatement(query2);
        ps2.setString(1, userName);
        rs2 = ps2.executeQuery();
%>

    <h2>User Reservation Information for <%= userName %></h2>
	
	<div>Past Reservations</div>
    <% if (rs.next()) { %>
        <table border='1'>
            <tr>
                <th>Reservation ID</th>
                <th>Customer Name</th>
                <th>Purchase Time</th>
                <th>User Name</th>
                <th>Booking Fee</th>
                <th>Ticket Cost</th>
                <th>Passenger Name</th>
                <th>Action</th>
            </tr>
            
            <% do { %>
                <tr>
                    <td><%= rs.getInt("ft.Id_number") %></td>
                    <td><%= rs.getString("ft.Customer_name") %></td>
                    <td><%= rs.getDate("ft.Purchase_time_date") %></td>
                    <td><%= rs.getString("ft.User_name") %></td>
                    <td><%= rs.getInt("ft.Booking_Fee") %></td>
                    <td><%= rs.getInt("ft.Ticket_Cost") %></td>
                    <td><%= rs.getString("ft.Passenger_Name") %></td>
                    <td>
                        <form action="viewReservation.jsp" method="post">
                            <input type="hidden" name="reservationId" value="<%= rs.getInt("ft.Id_number") %>">
                            <input type="hidden" name="customerName" value="<%= rs.getString("ft.Customer_name") %>">
                            <input type="hidden" name="purchaseTime" value="<%= rs.getDate("ft.Purchase_time_date") %>">
                            <input type="hidden" name="userName" value="<%= rs.getString("ft.User_name") %>">
                            <input type="hidden" name="bookingFee" value="<%= rs.getInt("ft.Booking_Fee") %>">
                            <input type="hidden" name="ticketCost" value="<%= rs.getInt("ft.Ticket_Cost") %>">
                            <input type="hidden" name="passengerName" value="<%= rs.getString("ft.Passenger_Name") %>">
                            <input type="hidden" name="resTime" value="past">
                            <input type="submit" value="View More Information">
                        </form>
                    </td>
                </tr>
            <% } while (rs.next()); %>

        </table>
    <% } else { %>
        <p>No past reservations found for <%= userName %>.</p>
    <% } %>
    
    
    <br></br>
    <div>Future Reservations</div>
    <% if (rs2.next()) { %>
        <table border='1'>
            <tr>
                <th>Reservation ID</th>
                <th>Customer Name</th>
                <th>Purchase Time</th>
                <th>User Name</th>
                <th>Booking Fee</th>
                <th>Ticket Cost</th>
                <th>Passenger Name</th>
                <th>Action</th>
            </tr>
            
            <% do { %>
                <tr>
                    <td><%= rs2.getInt("ft.Id_number") %></td>
                    <td><%= rs2.getString("ft.Customer_name") %></td>
                    <td><%= rs2.getDate("ft.Purchase_time_date") %></td>
                    <td><%= rs2.getString("ft.User_name") %></td>
                    <td><%= rs2.getInt("ft.Booking_Fee") %></td>
                    <td><%= rs2.getInt("ft.Ticket_Cost") %></td>
                    <td><%= rs2.getString("ft.Passenger_Name") %></td>
                    <td>
                        <form action="viewReservation.jsp" method="post">
                            <input type="hidden" name="reservationId" value="<%= rs2.getInt("ft.Id_number") %>">
                            <input type="hidden" name="customerName" value="<%= rs2.getString("ft.Customer_name") %>">
                            <input type="hidden" name="purchaseTime" value="<%= rs2.getDate("ft.Purchase_time_date") %>">
                            <input type="hidden" name="userName" value="<%= rs2.getString("ft.User_name") %>">
                            <input type="hidden" name="bookingFee" value="<%= rs2.getInt("ft.Booking_Fee") %>">
                            <input type="hidden" name="ticketCost" value="<%= rs2.getInt("ft.Ticket_Cost") %>">
                            <input type="hidden" name="passengerName" value="<%= rs2.getString("ft.Passenger_Name") %>">
                            <input type="hidden" name="resTime" value="future">
                            <input type="submit" value="View More Information">
                        </form>
                    </td>
                </tr>
            <% } while (rs2.next()); %>

        </table>
    <% } else { %>
        <p>No future reservations found for <%= userName %>.</p>
    <% } %>

<%
    // Close resources
    con.close();
} catch (SQLException e) {
    e.printStackTrace();
}
%>

</body>
</html>
