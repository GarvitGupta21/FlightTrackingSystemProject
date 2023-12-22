<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Question Post Confirmation</title>
</head>
<body>
    
    <%
        String Airport_Id = request.getParameter("Airport_ID");
        String Airport_Name = request.getParameter("Airport_Name");
        
        out.println("<table border='1'>");
        out.println("<tr><th>Airport_Id</th><th>Airport_Name</th>");

        out.println("<tr>");
        out.println("<td>" + Airport_Id + "</td>");
        out.println("<td>" + Airport_Name + "</td>");
        out.println("</tr>");
        out.println("</table>");
    %>

    <form action="editAirportSuccess.jsp" method="post">
        <label for="Airport_Id">Type new Airport ID here:</label>
        <input type="text" name="Airport_Id" value="<%=Airport_Id %>" required>
        <br>
        <label for="Airport_Name">Type new Airport Name here:</label>
        <input type="text" name="Airport_Name" value="<%=Airport_Name %>" required>
        
        <!-- Add hidden fields to store existing values -->
        <input type='hidden' name='Old_Airport_Id' value='<%=Airport_Id %>'>
        <input type='hidden' name='Old_Airport_Name' value='<%=Airport_Name %>'>
        
        <br>
        <input type="submit" value="Edit Airport Info">
        <br>
    </form>
    
    <a href='crAirports.jsp'>Return to Airports Page</a>

</body>
</html>
