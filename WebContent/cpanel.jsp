<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<%@ include file="left.jsp" %>

<div id="col_2">
<%
if (session.getAttribute("error")=="1"){
%>
<font color="red"><u>Συμπληρώστε όλα τα απαραίτητα πεδία.</u></font>
<%} 
if (session.getAttribute("error")=="2"){
%>
<font color="red"><u>Οι κωδικοί που εισάγατε δεν ταιριάζουν.</u></font>
<%}
if (session.getAttribute("error")=="3"){
%>
<font color="red"><u>FATAL ERROR: Η εγγραφή στη βάση απέτυχε. Ενημερώστε τον διαχειριστή.</u></font>
<%}
if (session.getAttribute("error")=="4"){
%>
<font color="red"><u>Ο χρήστης με τα παρακάτω στοιχεία υπάρχει ήδη.</u></font>
<%}%>
<h2>Αλλαγή Προσωπικών στοιχείων</h2>
<img border="0" src="assets/images/spacer.gif"><br><br>
<form method="post" action="ChangePersonalData">
<table border="0" align="left">
<tr>
<th><h4>* Όνομα:</h4> </th><th><input type="text" name="name" value="<%if (session.getAttribute("name")!=null) out.println(session.getAttribute("name"));%>"></th></tr>
<tr><th><h4>* Επίθετο:</h4></th> <th><input type="text" name="surname" value="<%if (session.getAttribute("surname")!=null) out.println(session.getAttribute("surname"));%>"></th></tr>
<tr><th><h4>* Ηλ. Ταχυδρομίο:</h4></th> <th><input type="text" name="email" value="<%if (session.getAttribute("email")!=null) out.println(session.getAttribute("email"));%>"></th></tr>
<tr><th><h4>* Κωδικός:</h4></th> <th><input type="password" name="password"></th></tr>
<tr><th><h4>* Επανάληψη Κωδικού:</h4></th> <th><input type="password" name="repass"></th></tr>
<tr><th><h4>&nbsp;&nbsp;Τηλέφωνο:</h4></th> <th><input type="text" name="telephone" value="<%if (session.getAttribute("telephone")!=null) out.println(session.getAttribute("telephone"));%>"></th></tr>
<tr><th><h4>&nbsp;&nbsp;Διεύθυνση:</h4></th> <th><input type="text" name="address" value="<%if (session.getAttribute("address")!=null) out.println(session.getAttribute("address"));%>"></th></tr>
<tr><th><h4>&nbsp;&nbsp;Ταχ. Κωδικός:</h4></th> <th><input type="text" name="postcode" value="<%if (session.getAttribute("postcode")!=null) out.println(session.getAttribute("postcode"));%>"></th></tr>
<tr><th><h4 align="left">* Υποχρεωτικά Πεδία</h4></th></tr>
<tr><th><input type="submit" value="" style="background:url(assets/images/register.png);width:70px;height:25px;border:0;"></th></tr>
</table>
</form>


</div>
<%@ include file="footer.jsp" %>