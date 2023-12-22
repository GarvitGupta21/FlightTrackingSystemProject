<%
if ((session.getAttribute("user") == null)) {
%>
You are not logged in<br/>
<a href="../allLogins.jsp">Please Login</a>
<%} else {
%>
Welcome <%=session.getAttribute("user")%> <br/>
You are on a <%=session.getAttribute("type")%> account <br/>
<a href='adminHomepage.jsp'>Home Page</a>
<a href='../logout.jsp'>Log out</a>
<%
}
%>