<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<%@ include file="left.jsp" %>
<div id="col_2">
<h2>Ενημέρωση project</h2>
<img border="0" src="assets/images/spacer.gif"><br><br>
<%if (session.getAttribute("fileUpload")=="1"){%>
<font color=green>Το αρχείο ανέβηκε επιτυχώς.</font>
<%
session.setAttribute("fileUpload","0");
}
if (session.getAttribute("fieldsEmpty")=="1"){%>
<font color=red>Συμπληρώστε όλα τα απαιτούμενα πεδία.</font>
<%session.setAttribute("fieldsEmpty","0"); } 
if (session.getAttribute("uploadPfiledbError")=="1"){%>
<font color=red>Database Error. Επικοινωνήστε με τον διαχειριστή.</font>
<%session.setAttribute("uploadPfiledbError","0"); } %>
<form method="post" action="AddProject" enctype="multipart/form-data">
<table border="0" align="left">
<tr>
<th><h4></h4> </th><th><input type="hidden" name="title" value="<% out.println(request.getAttribute("title")); %>"></th></tr>
<tr><th><h4>* Σχόλιο:</h4></th> <th><textarea name="comment" cols="30" rows="5"></textarea></th></tr>
<tr><th><h4>* Αρχείο:</h4></th> <th><input type="file" name="file"></th></tr>
<tr><th><h4 align="left">* Υποχρεωτικά Πεδία</h4></th></tr>
<tr><th><input type="submit" value="" style="background:url(assets/images/upload.png);width:70px;height:25px;border:0;"></th></tr>
</table>
</form>
</div>
<%@ include file="footer.jsp" %>