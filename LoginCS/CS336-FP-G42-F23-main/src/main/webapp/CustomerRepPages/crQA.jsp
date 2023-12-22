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
    <p>Answer questions asked by customers</p>
    
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
        
        boolean isAnswered = !(rs.getString("Answer_text").equals("Waiting For Answer"));
        if(isAnswered == false){
        	out.println("<td><form action='answerQuestion.jsp' method='post'>");
        	out.println("<input type='hidden' name='Question_Id' value='" + rs.getString("Question_Id") + "'>");
        	out.println("<input type='hidden' name='Question_User_name' value='" + rs.getString("Question_User_name") + "'>");
        	out.println("<input type='hidden' name='Question_text' value='" + rs.getString("Question_text") + "'>");
        	out.println("<input type='submit' value='Answer Question'></form></td>");
        	out.println("</tr>");	
        }
        
        
        
    }

    out.println("</table>");
    con.close();
} catch (SQLException e) {
    e.printStackTrace();
}

%>

</body>
</html>