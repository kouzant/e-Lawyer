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
	result=stmt.executeQuery("SELECT  * FROM pfiles WHERE fileName='"+request.getParameter("project")+"' ORDER BY version DESC LIMIT "+offset+","+entriesPerPage);
	result.last();
	session.setAttribute("fileName",result.getString(6));
	result.first();
%>
<div id="col_2">
<%if (session.getAttribute("login")=="1"){ %>
<h2><% out.println(result.getString(1)); result.beforeFirst(); %></h2>
<img border="0" src="assets/images/spacer.gif"><br>
<div align="center">
<%if (session.getAttribute("downloadVersionEmpty")=="1"){%>
<font color=red>Δεν εισάγατε αριθμό έκδοσης.</font>
<%
session.setAttribute("downloadVersionEmpty","0");
}
if (session.getAttribute("versionBiggerReal")=="1"){%>
<font color=red>Η έκδοση που εισάγατε είναι μεγαλύτερη από την καταγεγραμμένη.</font>
<%
session.setAttribute("versionBiggerReal","0");
}
if (session.getAttribute("downloadLink")!=null){%>
<a href="<% out.println(session.getAttribute("downloadLink")); %>">[Download]</a>
<%
session.removeAttribute("downloadLink");
}%>
</div>
<div align="right"><form method="post" action="Download">
Έκδοση: <input type="text" name="fileVersion" size="1"><br>
<input type="submit" value="Download"></form></div><br>
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
	<tr><td><b>Έκδοση: </b><% out.println(result.getInt(3)); %></td></tr>
	</table>
	<blockquote><u><b>Σχόλιο: </b></u><br><% out.println(result.getString(2)); %></blockquote>
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
}else{ 
	%>
	<h3>Η είσοδος επιτρέπεται μόνο σε εγγεγραμμένα μέλη.</h3>
	<%}
}catch(SQLException e){
	e.printStackTrace();
}finally{
	dbpoint.closedb(con);
}%>

</div>
<%@ include file="footer.jsp" %>