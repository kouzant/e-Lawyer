<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<%@ include file="left.jsp" %>

<div id="col_2">
<%if (session.getAttribute("login")=="1"){ %>
<h2>Δημοσίευση Δεδικασμένης Υπόθεσης</h2>
<img border="0" src="assets/images/spacer.gif"><br><br>
<%if (session.getAttribute("fileUpload")=="1"){%>
<font color=green>Το αρχείο ανέβηκε επιτυχώς.</font>
<%
session.setAttribute("fileUpload","0");
}
if (session.getAttribute("uploadFieldsEmpty")=="1"){%>
<font color=red>Συμπληρώστε όλα τα απαιτούμενα πεδία.</font>
<%session.setAttribute("uploadFieldsEmpty","0"); } 
if (session.getAttribute("notValidContent")=="1"){%>
<font color=red>Το αρχείο δεν έχει τον κατάλληλο τύπο.</font>
<%session.setAttribute("notValidContent","0"); }
if (session.getAttribute("overSize")=="1"){%>
<font color=red>Το μέγεθος του αρχείου σας είναι πολύ μεγαλύτερο από το επιτρεπτό (10MB).</font>
<%session.setAttribute("overSize","0"); } 
if (session.getAttribute("dbFailure")=="1"){%>
<font color=red>Database Error. Επικοινωνήστε με τον διαχειριστή.</font>
<%session.setAttribute("dbFailure","0"); } %>
<form method="post" action="Publish" method="post" enctype="multipart/form-data" name="publish">
<table border="0" align="left">
<tr>
<th><h4>* Τίτλος:</h4> </th><th><input type="text" name="title"></th></tr>
<tr><th><h4>* Περιγραφή:</h4></th> <th><textarea name="description" cols="30" rows="5"></textarea></th></tr>
<tr><th><h4>* Αρχείο (σε μορφή pdf):</h4></th> <th><input type="file" name="file"></th></tr>
<tr><th><h4 align="left">* Υποχρεωτικά Πεδία</h4></th></tr>
<tr align="right"><td>
<ul id="subnav">
<li><a href="#" onclick="document.publish.submit()">Αλλαγή</a></li>
</ul>
</td>
</tr></table>
</form>
<br>
<%}else{ 
%>
<h3>Η είσοδος επιτρέπεται μόνο σε εγγεγραμμένα μέλη.</h3>
<%} %>

</div>
<%@ include file="footer.jsp" %>