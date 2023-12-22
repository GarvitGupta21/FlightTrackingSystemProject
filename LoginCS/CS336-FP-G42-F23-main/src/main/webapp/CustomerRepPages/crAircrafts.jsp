<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>View/Change Aircraft Info</title>
</head>
<body>
    <h2>View/Change Aircraft Info</h2>
    <%
    try {
        ApplicationDB db = new ApplicationDB();    
        Connection con = db.getConnection();
        Statement st = con.createStatement();
        ResultSet rs;

        // Customize the query based on your database schema
        String query = String.format("SELECT * FROM Owns as o INNER JOIN Aircraft as a on o.Aircraft_Id = a.Aircraft_Id INNER JOIN Aircraft_model as m on a.Model_Id = m.Model_Id");

        rs = st.executeQuery(query);

        out.println("<table border='1'>");
        out.println("<tr><th>Aircraft ID</th><th>Airline ID</th><th>Number of Seats</th>");

        while (rs.next()) {
            out.println("<tr>");
            out.println("<td>" + rs.getString("o.Aircraft_Id") + "</td>");
            out.println("<td>" + rs.getString("o.Airline_Id") + "</td>");

            int numberOfSeats = rs.getInt("m.firstRows") * rs.getInt("m.firstSeatsInRow") + rs.getInt("m.businessRows") * rs.getInt("m.businessSeatsInRow") + rs.getInt("m.economyRows") * rs.getInt("m.economySeatsInRow");
            out.println("<td>" + numberOfSeats + "</td>");

            out.println("<td><form action='editAircraft.jsp' method='post'>");
            out.println("<input type='hidden' name='Aircraft_Id' value='" + rs.getString("o.Aircraft_Id") + "'>");
            out.println("<input type='hidden' name='Airline_Id' value='" + rs.getString("o.Airline_Id") + "'>");
            out.println("<input type='hidden' name='seats' value='" + numberOfSeats + "'>");

            out.println("<input type='hidden' name='Model_Id' value='" + rs.getString("m.Model_Id") + "'>");

            out.println("<input type='submit' value='Edit'></form></td>");

            out.println("<td><form action='deleteAircraft.jsp' method='post'>");
            out.println("<input type='hidden' name='Aircraft_Id' value='" + rs.getString("o.Aircraft_Id") + "'>");
            out.println("<input type='submit' value='Delete'></form></td>");
            out.println("</tr>");

        }

        out.println("</table>");
        con.close();
    } catch (SQLException e) {
        e.printStackTrace();
    }
    %>

    <br>
    <div><b>Add Aircraft:</b></div>
    <form action="addAircraft.jsp" method="post">
        <label for="Aircraft_Id">Type Aircraft Id here:</label>
        <input type="text" name="Aircraft_Id" required>
        <br>
        <label for="Airline_Id">Type Airline Id here:</label>
        <input type="text" name="Airline_Id" required>
        <br>
        <label for="Model_Id">Select Model ID:</label>
        <select name="Model_Id" required>
            <%
                // Populate the dropdown with Model IDs from the database
                ApplicationDB dbModels = new ApplicationDB();
                Connection conModels = dbModels.getConnection();
                Statement stModels = conModels.createStatement();
                ResultSet rsModels = stModels.executeQuery("SELECT Model_Id FROM Aircraft_model");

                while (rsModels.next()) {
                    out.println("<option value='" + rsModels.getString("Model_Id") + "'>" + rsModels.getString("Model_Id") + "</option>");
                }

                conModels.close();
            %>
        </select>
        <br>
        <input type="submit" value="Add Aircraft">
    </form>

<br></br>
<a href='crHomepage.jsp'>Return to Homepage</a>

</body>
</html>
