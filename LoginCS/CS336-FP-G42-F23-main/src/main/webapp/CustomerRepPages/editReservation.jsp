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
        Statement stmt = con.createStatement();
        ResultSet rs;

        // Query to retrieve reservation information for the selected user
        String query = "SELECT * FROM FlightTicket WHERE User_name = ?";
        PreparedStatement preparedStatement = con.prepareStatement(query);
        preparedStatement.setString(1, userName);
        rs = preparedStatement.executeQuery();
%>

    <h2>User Reservation Information for <%= userName %></h2>

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
                    <td><%= rs.getInt("Id_number") %></td>
                    <td><%= rs.getString("Customer_name") %></td>
                    <td><%= rs.getDate("Purchase_time_date") %></td>
                    <td><%= rs.getString("User_name") %></td>
                    <td><%= rs.getInt("Booking_Fee") %></td>
                    <td><%= rs.getInt("Ticket_Cost") %></td>
                    <td><%= rs.getString("Passenger_Name") %></td>
                    <td>
                        <form action="viewReservation.jsp" method="post">
                            <input type="hidden" name="reservationId" value="<%= rs.getInt("Id_number") %>">
                            <input type="hidden" name="customerName" value="<%= rs.getString("Customer_name") %>">
                            <input type="hidden" name="purchaseTime" value="<%= rs.getDate("Purchase_time_date") %>">
                            <input type="hidden" name="userName" value="<%= rs.getString("User_name") %>">
                            <input type="hidden" name="bookingFee" value="<%= rs.getInt("Booking_Fee") %>">
                            <input type="hidden" name="ticketCost" value="<%= rs.getInt("Ticket_Cost") %>">
                            <input type="hidden" name="passengerName" value="<%= rs.getString("Passenger_Name") %>">
                            <input type="submit" value="View More Information">
                        </form>
                    </td>
                </tr>
            <% } while (rs.next()); %>

        </table>
    <% } else { %>
        <p>No reservations found for <%= userName %>.</p>
    <% } %>

<%
    // Close resources
    rs.close();
    stmt.close();
    con.close();
} catch (SQLException e) {
    e.printStackTrace();
}
%>

</body>
</html>
