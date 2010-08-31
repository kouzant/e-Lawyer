<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@ include file="header.jsp" %>
<%@ include file="left.jsp" %>

<% 

Connection con=null;
Connection con3=null;
int totalEntries;

try{
	con3=dbpoint.connect();
	Statement stmt3=con3.createStatement();
	ResultSet result3;
	result3=stmt3.executeQuery("SELECT count(*) FROM pfiles WHERE fileName='"+request.getParameter("project")+"'");
	result3.next();
	totalEntries=result3.getInt(1);
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
	
	con=dbpoint.connect();
	Statement stmt=con.createStatement();
	ResultSet result;
	result=stmt.executeQuery("SELECT  * FROM pfiles WHERE fileName='"+request.getParameter("project")+"' LIMIT "+offset+","+entriesPerPage);
	result.next();
%>
<div id="col_2">
<h2><% out.println(result.getString(2)); result.beforeFirst(); %></h2>
<img border="0" src="assets/images/spacer.gif"><br>
<%
%><div align="right">[<%
	for(i=1;i<=totalPages;i++){
    	if(i==pageNumber){
        	out.println(i);
        }else{
        	%>&nbsp;<a href="myProject.jsp?pageNumber=<%= i %>"><%= i %></a>&nbsp;<%
        }
     }
%>]</div><%

while(result.next()){%>
	<table border="0" align="center">
	<tr><td><b>Έκδοση: </b><% out.println(result.getInt(4)); %></td><td><a href="<%out.print(result.getString(5));%>">[Download]</a></td></tr>
	</table>
	<blockquote><u><b>Σχόλιο: </b></u><br><% out.println(result.getString(3)); %></blockquote>
	<hr>
	
<%}
%><div align="right">[<%
	for(i=1;i<=totalPages;i++){
		if(i==pageNumber){
			out.println(i);
		}else{
			%>&nbsp;<a href="myProject.jsp?pageNumber=<%= i %>"><%= i %></a>&nbsp;<%
		}
	}
%>]</div><%
}catch(SQLException e){
	e.printStackTrace();
}finally{
	dbpoint.closedb(con);
}
%>

</div>
<%@ include file="footer.jsp" %>