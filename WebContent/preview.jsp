<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@ include file="header.jsp" %>
<%@ include file="left.jsp" %>

<div id="col_2">
<h2>Δεδικασμένες Υποθέσεις</h2>
<img border="0" src="assets/images/spacer.gif"><br>
<a href="javascript:showdiv()">Αναζήτηση</a>

<form method="post">
<input type="hidden" id="buttonPushed">

<div id="searchDiv" style="visibility:hidden;">
<form method="post" action="preview.jsp">
<input type="hidden" name="enableSearch">
Λέξη κλειδί: <input type="text" name="searchString">
<input type="submit" value="Search">
</form>
</div>
<%
Connection con=null;
Connection con3=null;
Connection con4=null;
int totalEntries;

try{
	con=dbpoint.connect();
	Statement stmt=con.createStatement();
	ResultSet result;
	if(request.getParameter("enableSearch")!=null){
		String searchString=request.getParameter("searchString");
		result=stmt.executeQuery("SELECT count(*) FROM uploads WHERE title LIKE \'%"+searchString+"%\' OR description LIKE \'%"+searchString+"%\'");
	}else{
		result=stmt.executeQuery("SELECT count(*) FROM uploads");
	}
	result.next();
	totalEntries=result.getInt(1);
	if(totalEntries==0){%>
	<div align="center">
	<font color="red"><u>Δεν βρέθηκε εγγραφή με τα κριτήρια που δώσατε.</u></font><br>
	</div>
	<%}
	totalEntries=totalEntries+5;
	
	int pageNumber=0;
	int totalPages=0;
	int i;
	int entriesPerPage=6;
	if (request.getParameter("pageNumber")!=null){
		pageNumber=Integer.parseInt(request.getParameter("pageNumber"));
	}else{
		pageNumber=1;
	}
	totalPages=(totalEntries/entriesPerPage);
	int offset=(pageNumber-1)*entriesPerPage;
	con3=dbpoint.connect();
	Statement stmt3=con3.createStatement();
	ResultSet result3;
	if(request.getParameter("searchString")!=null){
		String searchString=request.getParameter("searchString");
		result3=stmt3.executeQuery("SELECT title,description,location,userid FROM uploads WHERE title LIKE \'%"+searchString+"%\' OR description LIKE \'%"+searchString+"%\' LIMIT "+offset+","+entriesPerPage);
		
	}else{
		result3=stmt3.executeQuery("SELECT title,description,location,userid FROM uploads LIMIT "+offset+","+entriesPerPage);
	}
	
	%><div align="right">[<%
	for(i=1;i<=totalPages;i++){
		if(i==pageNumber){
			out.println(i);
		}else{
			%>&nbsp;<a href="search.jsp?pageNumber=<%= i %>"><%= i %></a>&nbsp;<%
		}
	}
	%>]</div><%
	
	while(result3.next()){%>
	<br>
	<table border="0" align="center">
	<tr><th><h3><%out.print(result3.getString(1));%></h3></th><th><a href="<%out.print(result3.getString(3));%>">[Download]</a></th></tr>
	</table>
	<blockquote><%out.print(result3.getString(2)); %></blockquote>
	<%con4=dbpoint.connect();
	Statement stmt4=con4.createStatement();
	ResultSet result4=stmt4.executeQuery("SELECT name,surname FROM users WHERE id='"+result3.getString(4)+"'");
	while (result4.next()){%><div class="divAuthor"><b><%
	out.print(result4.getString(1));
	out.print("&nbsp;");
	out.print(result4.getString(2)); }%></b></div><p><hr>
	
	<%
	}
	%><p><p><div align="right">[<%
	for(i=1;i<=totalPages;i++){
		if(i==pageNumber){
	    	out.println(i);
	    }else{
	        %>&nbsp;<a href="search.jsp?pageNumber=<%= i %>"><%= i %></a>&nbsp;<%
	    }
	}
	%>]</div><%
}catch (Exception e){
	e.printStackTrace();
}finally{
	dbpoint.closedb(con);
	dbpoint.closedb(con3);
	dbpoint.closedb(con4);
}
%>

</form>
</div>
<%@ include file="footer.jsp" %>