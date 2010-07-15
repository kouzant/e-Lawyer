<%@ include file="header.jsp" %>
<%@ include file="left.jsp" %>
<div id="col_1">
<form method="post" action="CheckLogin">
<table border="0" align="left">
<tr>
<th><h2>E-mail:</h2> </th><th><input type="text" name="email"></th></tr>
<tr><th><h2>Password:</h2></th> <th><input type="password" name="password"></th></tr>
<tr><th><input type="submit" value="Go!"></th><th><input type="reset" value="Reset"></th></tr>
</table>
</form>
</div>
<%@ include file="footer.jsp" %>