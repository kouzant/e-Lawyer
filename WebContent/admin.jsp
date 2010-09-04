<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<%@ include file="left.jsp" %>
<div id="col_2">
<%if ((session.getAttribute("login")=="1") && (session.getAttribute("isadmin").toString().equals("1"))){ %>
<h2>Διαχειριστικό Panel</h2>
<img border="0" src="assets/images/spacer.gif"><br>
<div align="center">
<ul id="subnav">
<li><a href="admUsers.jsp"><h3>Διαχείριση Χρηστών</h3></a></li><br>
<li><a href="admCase.jsp"><h3>Διαχείριση Δεδικασμένων Υποθέσεων</h3></a></li>
</ul>
</div>
<%}else{ 
%>
<h3>Η είσοδος επιτρέπεται μόνο στους διαχειριστές.</h3>
<%} %>
</div>
<%@ include file="footer.jsp" %>