<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@ include file="header.jsp" %>
<%@ include file="left.jsp" %>
<div id="col_2">
<h2>Δεδικασμένες Υποθέσεις</h2>
<img border="0" src="assets/images/spacer.gif"><br><br>
<form method="post">
<input type="hidden" id="buttonPushed">

<%
String url="jdbc:mysql://127.0.0.1/elawyer?useUnicode=true&characterEncoding=UTF8";
Connection con=null;
Connection con2=null;

try{
	String driver="com.mysql.jdbc.Driver";
	Class.forName(driver).newInstance();
}catch (Exception e){
	System.out.println("Failed to load the JDBC driver");
}
try{
	con=DriverManager.getConnection(url,"elawyer","elawyer");
	Statement stmt=con.createStatement();
	ResultSet result=stmt.executeQuery("SELECT title,description,location,userid FROM uploads");
	while(result.next()){%>
	<h3><%out.print(result.getString(1));%></h3>
	<blockquote><%out.print(result.getString(2)); %></blockquote>
	<%con2=DriverManager.getConnection(url,"elawyer","elawyer");
	Statement stmt2=con2.createStatement();
	ResultSet result2=stmt2.executeQuery("SELECT name,surname FROM users WHERE id='"+result.getString(4)+"'");
	while (result2.next()){%><b><%
	out.print(result2.getString(1));
	out.print("&nbsp;");
	out.print(result2.getString(2)); %></b>
	
	<%}
	}
}catch (Exception e){
	e.printStackTrace();
}finally{
	if (con != null){
		try{
			con.close();
		}catch (Exception e){
			e.printStackTrace();
		}
		
	}
	if (con2 != null){
		try{
			con2.close();
		}catch (Exception e){
			e.printStackTrace();
		}
		
	}
}
%>

</form>
</div>
<%@ include file="footer.jsp" %>