<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Edit Aircraft</title>
</head>
<body>
    
    <%
        String aircraft_Id = request.getParameter("Aircraft_Id");
        String airline_Id = request.getParameter("Airline_Id");
        String model_Id = request.getParameter("Model_Id"); // Updated parameter name for Model ID
        
        out.println("<table border='1'>");
        out.println("<tr><th>Aircraft_Id</th><th>Airline_Id</th><th>Model ID</th>");

        out.println("<tr>");
        out.println("<td>" + aircraft_Id + "</td>");
        out.println("<td>" + airline_Id + "</td>");
        out.println("<td>" + model_Id + "</td>"); // Display Model ID instead of seats
        out.println("</tr>");
        out.println("</table>");
    %>
    
    <form action="editAircraftSuccess.jsp" method="post">
        <label for="Airline_Id">Select new Airline:</label>
        <select name="Airline_Id" required>
            <%
                // Populate the dropdown with Airline IDs from the database
                ApplicationDB dbAirlines = new ApplicationDB();
                Connection conAirlines = dbAirlines.getConnection();
                Statement stAirlines = conAirlines.createStatement();
                ResultSet rsAirlines = stAirlines.executeQuery("SELECT DISTINCT Airline_Id FROM Owns");

                while (rsAirlines.next()) {
                    // Select the current Airline ID if it matches the existing value
                    String selected = (rsAirlines.getString("Airline_Id").equals(airline_Id)) ? "selected" : "";
                    out.println("<option value='" + rsAirlines.getString("Airline_Id") + "' " + selected + ">" + rsAirlines.getString("Airline_Id") + "</option>");
                }

                conAirlines.close();
            %>
        </select>
        <br>
        <label for="Model_Id">Select new Model ID:</label> <!-- Updated label for Model ID -->
        <select name="Model_Id" required>
            <%
                // Populate the dropdown with Model IDs from the database
                ApplicationDB dbModels = new ApplicationDB();
                Connection conModels = dbModels.getConnection();
                Statement stModels = conModels.createStatement();
                ResultSet rsModels = stModels.executeQuery("SELECT Model_Id FROM Aircraft_model");

                while (rsModels.next()) {
                    // Select the current Model ID if it matches the existing value
                    String selected = (rsModels.getString("Model_Id").equals(model_Id)) ? "selected" : "";
                    out.println("<option value='" + rsModels.getString("Model_Id") + "' " + selected + ">" + rsModels.getString("Model_Id") + "</option>");
                }

                conModels.close();
            %>
        </select>
        <br>
        <!-- Add hidden fields to store existing values -->
        <input type='hidden' name='old_aircraft_id' value='<%=aircraft_Id %>'>
        <input type='hidden' name='old_airline_id' value='<%=airline_Id %>'>
        <input type='hidden' name='old_model_id' value='<%=model_Id %>'> <!-- Updated hidden field for old Model ID -->
        
        <br>
        <input type="submit" value="Edit Aircraft Info">
        <br>
    </form>
    
    <a href='crAircrafts.jsp'>Return to Aircrafts Page</a>

</body>
</html>
