<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*,java.util.*,com.cs336.pkg.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Select User Page</title>
</head>
<body>

<%
    try {
        // Establish the connection
        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();
        Statement stmt = con.createStatement();
        ResultSet rs;

        // Query to retrieve user names from the Customer table
        String query = "SELECT user_name FROM Customer";
        rs = stmt.executeQuery(query);
%>

    <h2>Select User</h2>
    <form action="editReservation.jsp" method="post">
        <label for="userName">Select User:</label>
        <select name="userName">
            <option disabled selected>Choose User</option>
            <% while (rs.next()) { %>
                <option value="<%= rs.getString("user_name") %>">
                    <%= rs.getString("user_name") %>
                </option>
            <% } %>
        </select>

        <br>
        <input type="submit" value="Submit">
    </form>

<%
    // Close resources
    rs.close();
    stmt.close();
    con.close();
} catch (SQLException e) {
    e.printStackTrace();
}
%>

</body>
</html>
