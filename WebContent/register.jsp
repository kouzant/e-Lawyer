<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<%@ include file="left.jsp" %>

<div id="col_2">
<%
if(session.getAttribute("email")!=null){%>
<div align="center">
<font color="red"><u>Είστε ήδη εγγεγραμμένος στο σύστημα. Αν χρησιμοποιήτε κοινόχρηστο λογαριασμό και θέλετε όντως να εγγραφήτε, καθαρίστε το Ιστορικό του περιηγητή σας.</u></font>
</div>
<%
}else{
if (session.getAttribute("error")!="0"){%>
<h2>Εγγραφή Νέου Χρήστη</h2>
<img border="0" src="assets/images/spacer.gif"><br><br>
<form method="post" action="Register">
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
<%}else{ 
	out.println("<br><br><div align=\"center\"><font color=green>Η εγγραφή σας ολοκληρώθηκαι επιτυχώς.<br>Αν δεν προωθηθήται αυτόματα, πατήστε <a href=index.jsp>εδώ</a></font>");
%>

<!--PROGRESS BAR-->
<script type="text/javascript">
CallJS('Demo()');
delayRedirect();
</script>
<!--PROGRESS BAR-->
</div>
<%
}
}
%>
</div>
<%@ include file="footer.jsp" %>