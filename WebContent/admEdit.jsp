<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<%@ include file="left.jsp" %>


<div id="col_2">
<% if ((session.getAttribute("login")=="1") && (session.getAttribute("isadmin").toString().equals("1"))){ %>
<h2>Αλλαγή στοιχείων χρήστη</h2>
<img border="0" src="assets/images/spacer.gif"><br>
<%
Connection con=null;
try{
	con=dbpoint.connect();
	Statement stmt=con.createStatement();
	ResultSet result;
	String qString="SELECT * FROM users WHERE id=\'"+request.getParameter("id")+"\'";
	result=stmt.executeQuery(qString);
	result.next();
	session.setAttribute("userInitId",result.getString(7));
	%>
	<form method="post" action="AdminChangeData" name="admedit">
	<table border="0" align="left">
	<tr>
	<th><h4>* Όνομα:</h4> </th><th><input type="text" name="name" value="<%out.println(result.getString(2));%>"></th></tr>
	<tr><th><h4>* Επίθετο:</h4></th> <th><input type="text" name="surname" value="<%out.println(result.getString(3));%>"></th></tr>
	<tr><th><h4>* Ηλ. Ταχυδρομίο:</h4></th> <th><input type="text" name="email" value="<%out.println(result.getString(4));%>"></th></tr>
	<tr><th><h4>&nbsp;&nbsp;Τηλέφωνο:</h4></th> <th><input type="text" name="telephone" value="<%out.println(result.getInt(8));%>"></th></tr>
	<tr><th><h4>&nbsp;&nbsp;Διεύθυνση:</h4></th> <th><input type="text" name="address" value="<%out.println(result.getString(9));%>"></th></tr>
	<tr><th><h4>&nbsp;&nbsp;Ταχ. Κωδικός:</h4></th> <th><input type="text" name="postcode" value="<%out.println(result.getString(10));%>"></th></tr>
	<tr><th><h4>&nbsp;&nbsp;Κατάσταση:</h4></th><th><input type="radio" name="state" value="1" <% if(result.getInt(12)==1) out.println("checked"); %>>&nbsp;Ενεργός</th></tr>
	<tr><th></th><th><input type="radio" name="state" value="0" <% if(result.getInt(12)==0) out.println("checked"); %>>&nbsp;Ανενεργός</th></tr>
	<tr><th><h4 align="left">* Υποχρεωτικά Πεδία</h4></th></tr>
<tr align="center"><td>
<ul id="subnav">
<li><a href="#" onclick="document.admedit.submit()">Αλλαγή</a></li>
</ul>
</td>
</tr>	</table>
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