<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Revenue Summary</title>
</head>
<body>
	Revenue Summary by Flight Number
	<form action="adminRevenueSummarySuccess.jsp" method="post">
        <input type="hidden" name="Criteria" value="flight number" />
        <label for="Input">Type Flight Number Here:</label>
        <input type="text" name="Input" required>
        <br>
        <br>
        <input type="submit" value="Get Revenue Summary">
    </form>
    <br>
    Revenue Summary by Customer Name
	<form action="adminRevenueSummarySuccess.jsp" method="post">
        <input type="hidden" name="Criteria" value="customer name" />
        <label for="Input">Type Customer Name Here:</label>
        <input type="text" name="Input" required>
        <br>
        <br>
        <input type="submit" value="Get Revenue Summary">
    </form>
    <br>
    Revenue Summary by Airline
	<form action="adminRevenueSummarySuccess.jsp" method="post">
        <input type="hidden" name="Criteria" value="airline" />
		<select name="Input">
		<option disabled selected>Choose Airline:</option>
    	<%
    	ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection(); 
		
		Statement st = con.createStatement();
		ResultSet rs;
		rs = st.executeQuery("SELECT Airline_Id FROM Airline");
				
		while(rs.next()){
			out.println(String.format("<option value='%s'>%s</option>", rs.getString("Airline_Id"), rs.getString("Airline_Id")));
		};
		%>
		</select>
        <br>
        <input type="submit" value="Get Revenue Summary">
    </form>
</body>
</html>