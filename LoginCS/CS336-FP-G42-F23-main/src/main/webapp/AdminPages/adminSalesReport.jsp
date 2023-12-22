<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Sales Report</title>
</head>
<body>
	<form action="adminSalesReportSuccess.jsp" method="post">
        <select name="Month">
    	    <option value="1">January</option>
		    <option value="2">February</option>
		    <option value="3">March</option>
		    <option value="4">April</option>
		    <option value="5">May</option>
		    <option value="6">June</option>
		    <option value="7">July</option>
		    <option value="8">August</option>
		    <option value="9">September</option>
		    <option value="10">October</option>
		    <option value="11">November</option>
		    <option value="12">December</option>
        </select>
        <br>
        <input type="submit" value="Select Month">
    </form>
</body>
</html>