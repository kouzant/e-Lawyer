<%@ include file="header.jsp" %>
<%@ include file="left.jsp" %>

<div id="col_2">
<form method="post" action="CheckLogin">
<%
	if (session.getAttribute("falseLogin") == "1") {
%>
<font color="red"><u>Λανθασμένα στοιχεία εισόδου.</u></font><br> <%
 	}%>

<table border="0" align="left">
<tr>
<th><h4><b>E-mail:</b></h4> </th><th><input type="text" name="email"></th></tr>
<tr><th><h4><b>Password:</b></h4></th> <th><input type="password" name="password"></th></tr>
<tr><th><input type="submit" value="Go!"></th><th><input type="reset" value="Reset"></th></tr>
</table>
</form>
</div>

<%@ include file="footer.jsp" %>