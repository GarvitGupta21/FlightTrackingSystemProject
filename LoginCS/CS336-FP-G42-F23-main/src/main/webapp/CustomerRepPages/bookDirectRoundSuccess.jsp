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
		String ticketType1 = request.getParameter("ticketType1");
		String firstCost1 = request.getParameter("firstCost1");
		String businessCost1 = request.getParameter("businessCost1");
		String economyCost1 = request.getParameter("economyCost1");
		String rowNumber1 = request.getParameter("rowNumber1");
		String seatLetter1 = request.getParameter("seatLetter1");
		String flightNumber1 = request.getParameter("flightNumber1");
		String airlineId1 = request.getParameter("airlineId1");
		
		String ticketType2 = request.getParameter("ticketType2");		
		String firstCost2 = request.getParameter("firstCost2");
		String businessCost2 = request.getParameter("businessCost2");
		String economyCost2 = request.getParameter("economyCost2");
		String rowNumber2 = request.getParameter("rowNumber2");
		String seatLetter2 = request.getParameter("seatLetter2");
		String flightNumber2 = request.getParameter("flightNumber2");
		String airlineId2 = request.getParameter("airlineId2");


		String bookingFee = request.getParameter("bookingFee1");
		String passName = request.getParameter("passName");
		String user_name = request.getParameter("customerUserName");
		
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
			
			if(ticketType1.equals("first")){
				ps.setFloat(6, Float.parseFloat(firstCost1));
			} else if (ticketType1.equals("business")){
				ps.setFloat(6, Float.parseFloat(businessCost1));
			} else {
				ps.setFloat(6, Float.parseFloat(economyCost1));
			}	
			ps.setString(7, passName);
			ps.executeUpdate();	
			
			String sql2 = "INSERT INTO Reserves(Id_number, Seat_Number, Flight_number, Airline_Id, Class) VALUES (?, ?, ?, ?, ?)";
			PreparedStatement ps2 = con.prepareStatement(sql2);
			ps2.setInt(1, ticketId);
			ps2.setString(2, rowNumber1 + seatLetter1);
			ps2.setInt(3, Integer.parseInt(flightNumber1));
			ps2.setString(4, airlineId1);
			ps2.setString(5, ticketType1);
			ps2.executeUpdate();	
			
			
			String sql5 = "INSERT INTO Reserves(Id_number, Seat_Number, Flight_number, Airline_Id, Class) VALUES (?, ?, ?, ?, ?)";
			PreparedStatement ps5 = con.prepareStatement(sql5);
			ps5.setInt(1, ticketId);
			ps5.setString(2, rowNumber2 + seatLetter2);
			ps5.setInt(3, Integer.parseInt(flightNumber2));
			ps5.setString(4, airlineId2);
			ps5.setString(5, ticketType2);
			ps5.executeUpdate();	
			
			con.close();
			out.println("<a href='crHomepage.jsp'>Flight Reserved!</a>");

			
		} catch(SQLException e){
			e.printStackTrace();
			out.println("<a href='crHomepage.jsp'>Issue Booking Seat (Seat May Already be Booked)!</a>");

		}
		
	%>



</body>
</html>