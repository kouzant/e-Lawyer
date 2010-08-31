<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<%@ include file="left.jsp" %>
<div id="col_2">
<h2>Διαγραφή project</h2>
<img border="0" src="assets/images/spacer.gif"><br><br>

<%
Connection con=null;
try{
	con=dbpoint.connect();
	Statement stmt=con.createStatement();
	int result;
	result=stmt.executeUpdate("DELETE FROM pfiles WHERE fileName='"+request.getParameter("fileName")+"'");
	if (result>0){
		session.setAttribute("projectDelete","1");
	}else{
		session.setAttribute("projectDelete", "0");
	}
}catch(SQLException e){
	e.printStackTrace();
}finally{
	dbpoint.closedb(con);
}

if(session.getAttribute("projectDelete")=="1"){
%>
<br><br>
<div align="center">
<font color=green>Το project διεγράφη.</font>
<%}else if(session.getAttribute("projectDelete")=="0"){%>
<font color=red>Το project δεν βρέθηκε ή υπήρξε πρόβλημα στη βάση. Επικοινωνήστε με τον διαχειριστή.</font>
<%} %>

</div>
</div>
<%@ include file="footer.jsp" %>