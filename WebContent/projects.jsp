<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<%@ include file="left.jsp" %>
<div id="col_2">
<%if (session.getAttribute("login")=="1"){ %>
<h2>Τα projects μου</h2>
<img border="0" src="assets/images/spacer.gif"><br><br>

<div align="center">
<a href="addProject.jsp">Προσθήκη νέου project</a>
</div>
<br>
<hr>

<%
Connection con=null;
try{
	con=dbpoint.connect();
	Statement stmt=con.createStatement();
	ResultSet result;
	result=stmt.executeQuery("SELECT  title,fileName FROM pfiles WHERE owner='"+session.getAttribute("initId")+"'  GROUP BY fileName");
	
	while(result.next()){%>
		<table border="0">
		<tr><td><ul><li><a href="myProject.jsp?project=<%out.println(result.getString(2));%>"><% out.println(result.getString(1)); %></a></li></ul></td><td><a href="addMore.jsp?title=<% out.println(result.getString(1)); %>"><img src="assets/images/add_16.png"></a></td><td><a href="delProject.jsp?fileName=<% out.println(result.getString(2)); %>"><img src="assets/images/close_16.png"></a></td></tr>
		</table>
	<%}
}catch(SQLException e){
	e.printStackTrace();
}finally{
	dbpoint.closedb(con);
}
%>
<%}else{ 
%>
<h3>Η είσοδος επιτρέπεται μόνο σε εγγεγραμμένα μέλη.</h3>
<%} %>
</div>
<%@ include file="footer.jsp" %>