<%@ include file="header.jsp" %>
<%@ include file="left.jsp" %>

<div id="col_1">
<form method="post" action="CheckLogin">
<%
	if (session.getAttribute("falselogin") == "1") {
%>
<font color="red"><u>Λανθασμένα στοιχεία εισόδου.</u></font> <%
 	}
 	if (session.getAttribute("lockedLogin") == "1") {
 		Object obj=session.getAttribute("lockedTimed");
 		String strLockStart = obj.toString();
 		try {
 			long lLockStart = Long.parseLong(strLockStart.trim());
 			long startTime = System.currentTimeMillis();
 			String lockedLogin = (String) session.getAttribute("lockedLogin");
 			long diffLock = startTime - lLockStart;
 			if (diffLock < 1800000) {
 %> Thn gamhses!!!!!!!!<%
 	}
 		} catch (NumberFormatException e) {
 			e.printStackTrace();
 		}
 	}
 %>


<table border="0" align="left">
<tr>
<th><h2>E-mail:</h2> </th><th><input type="text" name="email"></th></tr>
<tr><th><h2>Password:</h2></th> <th><input type="password" name="password"></th></tr>
<tr><th><input type="submit" value="Go!"></th><th><input type="reset" value="Reset"></th></tr>
</table>
</form>
</div>
<%@ include file="footer.jsp" %>