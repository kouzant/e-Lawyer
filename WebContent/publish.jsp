<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<%@ include file="left.jsp" %>
<%if (session.getAttribute("login")=="1"){ %>
<div id="col_2">
<h2>Δημοσίευση Δεδικασμένης Υπόθεσης.</h2><br><br>
<%if (session.getAttribute("fileUpload")=="1"){%>
<font color=green>Το αρχείο ανέβηκε επιτυχώς.</font>
<%
session.setAttribute("fileUpload","0");
}
if (session.getAttribute("uploadFieldsEmpty")=="1"){%>
<font color=red>Συμπληρώστε όλα τα απαιτούμενα πεδία.</font>
<% } %>
<form method="post" action="Publish" method="post" enctype="multipart/form-data">
<table border="0" align="left">
<tr>
<input type="hidden" name="hiddenfield1" value="ok">
<th><h4>* Τίτλος:</h4> </th><th><input type="text" name="title"></th></tr>
<tr><th><h4>* Περιγραφή:</h4></th> <th><input type="text" name="description"></th></tr>
<tr><th><h4>* Αρχείο (σε μορφή pdf):</h4></th> <th><input type="file" name="file"></th></tr>
<tr><th><h4 align="left">* Υποχρεωτικά Πεδία</h4></th></tr>
<tr><th><input type="submit" value="Go!"></th></tr>
</table>
</form>
<br>
<%}else{ %>
<h3>Η είσοδος επιτρέπεται μόνο σε εγγεγραμμένα μέλη.</h3>
<%} %>

</div>
<%@ include file="footer.jsp" %>