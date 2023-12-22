<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Edit Flight</title>
</head>
<body>
    
    <%
        String flight_number = request.getParameter("Flight_number");
        String airline_Id = request.getParameter("Airline_Id");
        String aircraft_Id = request.getParameter("Aircraft_Id");
        String departure_Airport = request.getParameter("Departure_Airport");
        String arrival_Airport = request.getParameter("Arrival_Airport");
        String departing_Time = request.getParameter("Departing_Time");
        String arrival_Time = request.getParameter("Arrival_Time");
        String flight_type = request.getParameter("Flight_type");
    
        out.println("<table border='1'>");
        out.println("<tr><th>Flight Number</th><th>Airline ID</th><th>Aircraft ID</th><th>Departure Airport</th><th>Arrival Airport</th><th>Departure Time</th><th>Arrival Time</th><th>Flight Type</th>");

        out.println("<tr>");
        out.println("<td>" + flight_number + "</td>");
        out.println("<td>" + airline_Id + "</td>");
        out.println("<td>" + aircraft_Id + "</td>");
        out.println("<td>" + departure_Airport + "</td>");
        out.println("<td>" + arrival_Airport + "</td>");
        out.println("<td>" + departing_Time + "</td>");
        out.println("<td>" + arrival_Time + "</td>");
        out.println("<td>" + flight_type + "</td>");
        out.println("</tr>");
        out.println("</table>");
    %>
    
    <form action="editFlightSuccess.jsp" method="post">
    <label for="Flight_number">Flight Number:</label>
    <input type="text" name="Flight_number" value="<%= flight_number %>" required readonly>
    <br>
    
    <label for="Airline_Id">Airline_Id:</label>
    <select name="Airline_Id">
        <option disabled selected>Choose Airline Id</option>
        <%
            ApplicationDB db2 = new ApplicationDB();    
            Connection con2 = db2.getConnection(); 
            
            Statement st2 = con2.createStatement();
            ResultSet rs2;
            rs2 = st2.executeQuery("SELECT Airline_Id FROM Airline");
                    
            while(rs2.next()){
                String selected = (rs2.getString("Airline_Id").equals(airline_Id)) ? "selected" : "";
                out.println(String.format("<option value='%s' %s>%s</option>", rs2.getString("Airline_Id"), selected, rs2.getString("Airline_Id")));
            };
            
            con2.close();
        %>
    </select>
    <br>
    
    <label for="Aircraft_Id">Aircraft Id:</label>
    <input type="text" name="Aircraft_Id" value="<%= aircraft_Id %>" required>
    <br>
    
    <label for="Departure_Airport">Departure Airport:</label>
    <select name="Departure_Airport">
        <option disabled selected>Choose Departure Airport</option>
        <%
            ApplicationDB db4 = new ApplicationDB();    
            Connection con4 = db4.getConnection(); 
            
            Statement st4 = con4.createStatement();
            ResultSet rs4;
            rs4 = st4.executeQuery("SELECT Airport_Id FROM Airport");
                    
            while(rs4.next()){
                String selected = (rs4.getString("Airport_Id").equals(departure_Airport)) ? "selected" : "";
                out.println(String.format("<option value='%s' %s>%s</option>", rs4.getString("Airport_Id"), selected, rs4.getString("Airport_Id")));
            };
            
            con4.close();
        %>
    </select>
    <br>
    
    <label for="Arrival_Airport">Arrival Airport:</label>
    <select name="Arrival_Airport">
        <option disabled selected>Choose Arrival Airport</option>
        <%
            ApplicationDB db5 = new ApplicationDB();    
            Connection con5 = db5.getConnection(); 
            
            Statement st5 = con5.createStatement();
            ResultSet rs5;
            rs5 = st5.executeQuery("SELECT Airport_Id FROM Airport");
                    
            while(rs5.next()){
                String selected = (rs5.getString("Airport_Id").equals(arrival_Airport)) ? "selected" : "";
                out.println(String.format("<option value='%s' %s>%s</option>", rs5.getString("Airport_Id"), selected, rs5.getString("Airport_Id")));
            };
            
            con5.close();
        %>
    </select>
    <br>
    
    <label for="Departing_Time">Departure Date:</label>
    <input type="date" name="Departing_Time" value="<%= departing_Time %>" required>
    <br>
    
    <label for="Arrival_Time">Arrival Date:</label>
    <input type="date" name="Arrival_Time" value="<%= arrival_Time %>" required>
    <br>
    
    <label for="Flight_type">Choose Flight Type</label>
    <select name="Flight_type">
        <option disabled selected>Choose Flight Type</option>
        <option value="Domestic" <%= "Domestic".equals(flight_type) ? "selected" : "" %>>Domestic</option>
        <option value="International" <%= "International".equals(flight_type) ? "selected" : "" %>>International</option>
    </select>
    <br>
    
    <input type="submit" value="Edit Flight Info">
</form>

<a href='crFlights.jsp'>Return to Flights Page</a>


</body>
</html>
