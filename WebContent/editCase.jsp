<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<%@ include file="left.jsp" %>

<div id="col_2">
<%if ((session.getAttribute("login")=="1") && (session.getAttribute("isadmin").toString().equals("1"))){ %>
<h2>Διαχείριση Δεδικασμένων Υποθέσεων</h2>
<img border="0" src="assets/images/spacer.gif"><br>
<%
Connection con=null;

try{
	con=dbpoint.connect();
	Statement stmt=con.createStatement();
	String qString="SELECT * FROM uploads WHERE uploads.key=\'"+request.getParameter("caseId")+"\'";
	ResultSet result=stmt.executeQuery(qString);
	result.next();

%>
<form method="post" action="EditCase" method="post" name="editCase">
<table border="0" align="left">
<tr>
<input type="hidden" name="caseId" value=<% out.println(request.getParameter("caseId")); %>>
<th><h4>* Τίτλος:</h4> </th><th><input type="text" name="title" value="<% out.println(result.getString(2)); %>"></th></tr>
<tr><th><h4>* Περιγραφή:</h4></th> <th><textarea name="description" cols="30" rows="5"><% out.println(result.getString(3)); %></textarea></th></tr>
<tr><th><h4 align="left">* Υποχρεωτικά Πεδία<br><br></h4></th></tr>
<tr align="right"><td>
<div id="col_2">
<ul id="subnav">
<li><a href="#" onclick="document.editCase.submit()">Αλλαγή</a></li>
</ul>
</div>
</td>
</tr>
</table>
</form>
<%
}catch(SQLException e){
	e.printStackTrace();
}finally{
	dbpoint.closedb(con);
}
%>
<%}else{ 
%>
<h3>Η είσοδος επιτρέπεται μόνο στους διαχειριστές.</h3>
<%} %>
</div>
<%@ include file="footer.jsp" %>