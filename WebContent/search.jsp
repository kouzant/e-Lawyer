<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@ include file="header.jsp" %>
<%@ include file="left.jsp" %>

<div id="col_2">
<h2>Δεδικασμένες Υποθέσεις</h2>
<img border="0" src="assets/images/spacer.gif"><br>
<form method="post">
<input type="hidden" id="buttonPushed">

<%
Connection con=null;
Connection con3=null;

try{
	con=dbpoint.connect();
	Statement stmt=con.createStatement();
	ResultSet result=stmt.executeQuery("SELECT title,description,location,userid FROM uploads");
	
	while(result.next()){%>
	<table border="0" align="center">
	<tr><th><h3><%out.print(result.getString(1));%></h3></th><th><a href="<%out.print(result.getString(3));%>">[Download]</a></th></tr>
	</table>
	<blockquote><%out.print(result.getString(2)); %></blockquote>
	<%con3=dbpoint.connect();
	Statement stmt3=con3.createStatement();
	ResultSet result3=stmt3.executeQuery("SELECT name,surname FROM users WHERE id='"+result.getString(4)+"'");
	while (result3.next()){%><div class="divAuthor"><b><%
	out.print(result3.getString(1));
	out.print("&nbsp;");
	out.print(result3.getString(2)); %></b></div>
	
	<%}
	}
}catch (Exception e){
	e.printStackTrace();
}finally{
	dbpoint.closedb(con);
	dbpoint.closedb(con3);
}
%>

</form>
</div>
<%@ include file="footer.jsp" %>