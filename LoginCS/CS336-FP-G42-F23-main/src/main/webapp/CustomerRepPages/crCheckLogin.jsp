<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%
String userid = request.getParameter("username");
String pwd = request.getParameter("password");

Class.forName("com.mysql.jdbc.Driver");
ApplicationDB db = new ApplicationDB();	
Connection con = db.getConnection();	

//Check Customer Accounts
Statement st1 = con.createStatement();
ResultSet rs1;
String query = String.format("SELECT * FROM Account WHERE User_name = '%s' and password = '%s' and type = 'Customer Representative'", userid, pwd);
rs1 = st1.executeQuery(query);

if (rs1.next()) {
session.setAttribute("user", userid); // the username will be stored in the session
String accType = rs1.getString("type");
session.setAttribute("type", accType);
out.println("welcome" + userid);
out.println("<a href='../logout.jsp'>Log out</a>");
response.sendRedirect("crSuccess.jsp");
} else {
out.println("Invalid password <a href='crLogin.jsp'>try again</a>");
}

%>