<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Q/A Board</title>
</head>
<body>
	<h2>Welcome to the Q/A Board</h2>
    <p>You can post questions and browse previously asked questions/answers</p>
    
    <%
	try {
    ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
    Statement st = con.createStatement();
    ResultSet rs;

    // Customize the query based on your database schema
    String query = String.format("SELECT * FROM QA");

    rs = st.executeQuery(query);

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
	<br></br>
    <form action="postQuestion.jsp" method="post">
        <label for="question_text">Type your question here:</label>
        <input type="text" name="question_text" required>
        <input type="submit" value="Post Question">
        <br>
    </form>
    
    <br></br>
    <form action="searchQuestion.jsp" method="post">
        <label for="keyword">Type your search keyword here:</label>
        <input type="text" name="keyword" required>
        <input type="submit" value="Search Q/A Board">
        <br>
    </form>

</body>
</html>