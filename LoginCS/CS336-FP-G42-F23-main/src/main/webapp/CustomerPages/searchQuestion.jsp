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
    String keyword = request.getParameter("keyword");
    String keywordForQuery = "%" + keyword + '%';
    
    try {
        ApplicationDB db = new ApplicationDB();	
    	Connection con = db.getConnection();
        Statement st = con.createStatement();
        ResultSet rs;

        // Customize the query based on your database schema
        String sql = "SELECT * FROM QA WHERE Question_text LIKE ?";
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setString(1, keywordForQuery);
        rs = ps.executeQuery();

        // Display the QA board
        out.println("<table border='1'>");
        out.println("<tr><th>Question#</th><th>Q-User</th><th>Question</th><th>A-User</th><th>Answer</th>");

        while (rs.next()) {
            out.println("<tr>");
            out.println("<td>" + rs.getString("Question_Id") + "</td>");
            out.println("<td>" + rs.getString("Question_User_name") + "</td>");
            out.println("<td>" + rs.getString("Question_text") + "</td>");
            out.println("<td>" + rs.getString("Answer_User_name") + "</td>");
            out.println("<td>" + rs.getString("Answer_text") + "</td>");
        }

        out.println("</table>");
        con.close();
    } catch (SQLException e) {
        e.printStackTrace();
    }
		
	%>

<div>Here are the results for your search using <%=keyword%> as a keyword!</div>
<a href='customerQA.jsp'>Return to Question Board</a>



</body>
</html>