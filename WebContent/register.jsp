<%@ include file="header.jsp" %>
<%@ include file="left.jsp" %>
<div id="col_1">
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
<%} %>
<form method="post" action="Register">
<table border="0" align="left">
<tr>
<th><h2>* Όνομα:</h2> </th><th><input type="text" name="name" value="<%if (session.getAttribute("name")!=null) out.println(session.getAttribute("name"));%>"></th></tr>
<tr><th><h2>* Επίθετο:</h2></th> <th><input type="text" name="surname" value="<%if (session.getAttribute("surname")!=null) out.println(session.getAttribute("surname"));%>"></th></tr>
<tr><th><h2>* Ηλ. Ταχυδρομίο:</h2></th> <th><input type="text" name="email" value="<%if (session.getAttribute("email")!=null) out.println(session.getAttribute("email"));%>"></th></tr>
<tr><th><h2>* Κωδικός:</h2></th> <th><input type="password" name="password"></th></tr>
<tr><th><h2>* Επανάληψη Κωδικού:</h2></th> <th><input type="password" name="repass"></th></tr>
<tr><th><h2>Τηλέφωνο:</h2></th> <th><input type="text" name="telephone" value="<%if (session.getAttribute("telephone")!=null) out.println(session.getAttribute("telephone"));%>"></th></tr>
<tr><th><h2>Διεύθυνση:</h2></th> <th><input type="text" name="address" value="<%if (session.getAttribute("address")!=null) out.println(session.getAttribute("address"));%>"></th></tr>
<tr><th><h2>Ταχ. Κωδικός:</h2></th> <th><input type="text" name="postcode" value="<%if (session.getAttribute("postcode")!=null) out.println(session.getAttribute("postcode"));%>"></th></tr>
</table>
<h4 align="left">* Υποχρεωτικά Πεδία</h4><br>
<input type="submit" value="Go!">
</form>
</div>
<%@ include file="footer.jsp" %>