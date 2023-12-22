<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Reservations</title>
</head>
<body>
	Reservations by Flight Number
	<form action="adminReservationsSuccess.jsp" method="post">
        <input type="hidden" name="Criteria" value="flight number" />
        <label for="Input">Type Flight Number Here:</label>
        <input type="text" name="Input" required>
        <br>
        <br>
        <input type="submit" value="Get Reservations">
    </form>
    <br>
    Reservations by Customer Name
	<form action="adminReservationsSuccess.jsp" method="post">
        <input type="hidden" name="Criteria" value="customer name" />
        <label for="Input">Type Customer Name Here:</label>
        <input type="text" name="Input" required>
        <br>
        <br>
        <input type="submit" value="Get Reservations">
    </form>
</body>
</html>