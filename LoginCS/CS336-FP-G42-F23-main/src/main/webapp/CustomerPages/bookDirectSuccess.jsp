<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.sql.Date" %>
<%@ page import="java.util.Calendar" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Edit Aircraft</title>
</head>
<body>

<%
		String ticketType = request.getParameter("ticketType");
		String bookingFee = request.getParameter("bookingFee");
		String firstCost = request.getParameter("firstCost");
		String businessCost = request.getParameter("businessCost");
		String economyCost = request.getParameter("economyCost");
		String rowNumber = request.getParameter("rowNumber");
		String seatLetter = request.getParameter("seatLetter");
		String passName = request.getParameter("passName");
		String user_name = (String) session.getAttribute("user");
		String flightNumber = request.getParameter("flightNumber");
		String airlineId = request.getParameter("airlineId");

		try{
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			
			String sql = "INSERT INTO FlightTicket(Id_number, Customer_name	, Purchase_time_date, User_name, Booking_Fee, Ticket_Cost, Passenger_Name) VALUES (?, ?, ?, ?, ?, ?, ?)";
			PreparedStatement ps = con.prepareStatement(sql);
			
			Statement st2 = con.createStatement();
			ResultSet rs2;
			rs2 = st2.executeQuery("SELECT COUNT(*) as count FROM FlightTicket");
			rs2.next();
			int ticketId = rs2.getInt("count") + 1;
			
			Statement st3 = con.createStatement();
			ResultSet rs3;
			
			String sql3 = "SELECT Customer_Name FROM Customer WHERE User_name = ?";
			
			PreparedStatement ps3 = con.prepareStatement(sql3);
			
			ps3.setString(1, user_name);
			rs3 = ps3.executeQuery();
			rs3.next();
			String customerName = rs3.getString("Customer_Name"); 
			
			
			java.util.Date utilDate = Calendar.getInstance().getTime();

		    // Convert java.util.Date to java.sql.Date
		    Date currentDate = new Date(utilDate.getTime());
		    
			ps.setInt(1, ticketId);
			ps.setString(2, customerName);
			ps.setDate(3, currentDate);
			ps.setString(4, user_name);
			ps.setFloat(5, Float.parseFloat(bookingFee));
			
			if(ticketType.equals("first")){
				ps.setFloat(6, Float.parseFloat(firstCost));
			} else if (ticketType.equals("business")){
				ps.setFloat(6, Float.parseFloat(businessCost));
			} else {
				ps.setFloat(6, Float.parseFloat(economyCost));
			}	
			ps.setString(7, passName);
			ps.executeUpdate();	
			
			String sql2 = "INSERT INTO Reserves(Id_number, Seat_Number, Flight_number, Airline_Id, Class) VALUES (?, ?, ?, ?, ?)";
			PreparedStatement ps2 = con.prepareStatement(sql2);
			ps2.setInt(1, ticketId);
			ps2.setString(2, rowNumber + seatLetter);
			ps2.setInt(3, Integer.parseInt(flightNumber));
			ps2.setString(4, airlineId);
			ps2.setString(5, ticketType);
			ps2.executeUpdate();	
			
			con.close();
			
			out.println("<a href='customerHomepage.jsp'>Flight Reserved!</a>");
			
		} catch(SQLException e){
			out.println("<a href='customerHomepage.jsp'>Issue Booking Seat (Seat May Already be Booked)!</a>");
			e.printStackTrace();
		}
		
	%>





</body>
</html>