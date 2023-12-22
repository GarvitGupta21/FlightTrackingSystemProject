<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, com.cs336.pkg.ApplicationDB" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Flight List for Airport</title>
</head>
<body>

<%
    // Get the selected airport code from the form submission
    String selectedAirportCode = request.getParameter("selectedAirportCode");

    // Validate the selected airport code
    if (selectedAirportCode != null && !selectedAirportCode.isEmpty()) {
        try {
            ApplicationDB db = new ApplicationDB();
            Connection con = db.getConnection();

            // Query to retrieve departing flights
            String departingQuery = "SELECT * FROM Flight WHERE Departure_Airport = ?";
            PreparedStatement departingStatement = con.prepareStatement(departingQuery);
            departingStatement.setString(1, selectedAirportCode);
            ResultSet departingResult = departingStatement.executeQuery();

            // Query to retrieve arriving flights
            String arrivingQuery = "SELECT * FROM Flight WHERE Arrival_Airport = ?";
            PreparedStatement arrivingStatement = con.prepareStatement(arrivingQuery);
            arrivingStatement.setString(1, selectedAirportCode);
            ResultSet arrivingResult = arrivingStatement.executeQuery();

%>

            <h2>Flights Departing from <%= selectedAirportCode %></h2>
            <table border='1'>
                <tr>
                    <th>Flight Number</th>
                    <th>Departing Time</th>
                    <th>Arrival Airport</th>
                </tr>
                <% while (departingResult.next()) { %>
                    <tr>
                        <td><%= departingResult.getInt("Flight_number") %></td>
                        <td><%= departingResult.getDate("Departing_Time") %></td>
                        <td><%= departingResult.getString("Arrival_Airport") %></td>
                    </tr>
                <% } %>
            </table>

            <h2>Flights Arriving at <%= selectedAirportCode %></h2>
            <table border='1'>
                <tr>
                    <th>Flight Number</th>
                    <th>Arrival Time</th>
                    <th>Departure Airport</th>
                </tr>
                <% while (arrivingResult.next()) { %>
                    <tr>
                        <td><%= arrivingResult.getInt("Flight_number") %></td>
                        <td><%= arrivingResult.getDate("Arrival_Time") %></td>
                        <td><%= arrivingResult.getString("Departure_Airport") %></td>
                    </tr>
                <% } %>
            </table>

<%
            // Close the database connection
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("An error occurred while processing the request.");
        }
    }

    // Get all airports from the database for populating the dropdown
    try {
        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();
        Statement statement = con.createStatement();
        ResultSet airportsResult = statement.executeQuery("SELECT * FROM Airport");

        // Display the form with the airport dropdown
%>
        <form action="showAirportFlights.jsp" method="post">
            <label for="selectedAirportCode">Select Airport:</label>
            <select name="selectedAirportCode">
                <% while (airportsResult.next()) { %>
                    <option value="<%= airportsResult.getString("Airport_Id") %>" <% if (selectedAirportCode != null && selectedAirportCode.equals(airportsResult.getString("Airport_Id"))) out.println("selected"); %> >
                        <%= airportsResult.getString("Airport_Id") %> - <%= airportsResult.getString("Airport_Name") %>
                    </option>
                <% } %>
            </select>
            <input type="submit" value="Submit">
        </form>

<%
        // Close the database connection
        con.close();
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("An error occurred while retrieving airport data.");
    }
%>

<a href='crHomepage.jsp'>Return to Homepage</a>
<br></br>

</body>
</html>
