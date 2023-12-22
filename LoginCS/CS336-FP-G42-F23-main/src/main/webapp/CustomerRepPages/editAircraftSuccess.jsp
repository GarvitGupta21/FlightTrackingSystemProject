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
    
    // Parse model_Id as int
    int model_Id = Integer.parseInt(request.getParameter("Model_Id"));
    
    String old_aircraft_Id = request.getParameter("old_aircraft_id");

    ApplicationDB db = new ApplicationDB();    
    Connection con = db.getConnection();

    // Update only the Model_Id since Aircraft_Id remains unchanged
    String sql = "UPDATE Aircraft SET Model_Id = ? WHERE Aircraft_Id = ?";
    PreparedStatement ps = con.prepareStatement(sql);

    ps.setInt(1, model_Id); // Set as int
    ps.setString(2, old_aircraft_Id);
    ps.executeUpdate();

    // Update other details in the Owns table
    String ownsSql = "UPDATE Owns SET Airline_Id = ? WHERE Aircraft_Id = ?";
    PreparedStatement ownsPs = con.prepareStatement(ownsSql);

    ownsPs.setString(1, airline_Id);
    ownsPs.setString(2, old_aircraft_Id);
    ownsPs.executeUpdate();

    con.close();
%>

<a href='crAircrafts.jsp'>Aircraft Info Changed</a>

</body>
</html>
