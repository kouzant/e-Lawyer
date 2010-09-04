<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<%@ include file="left.jsp" %>


<div id="col_2">
<%if ((session.getAttribute("login")=="1") && (session.getAttribute("isadmin").toString().equals("1"))){ %>
<h2>Διαχείριση Δεδικασμένων Υποθέσεων</h2>
<img border="0" src="assets/images/spacer.gif"><br>
<%if(session.getAttribute("caseDelete")=="0"){
	%>
	<font color="red"><u>Η διαγραφή απέτυχε. Επικοινωνήστε με το διαχειριστή.</u></font><br><%
	session.setAttribute("caseDelete","-1");
}else if(session.getAttribute("caseDelete")=="1"){%>
	<font color="green"><u>Η διαγραφή ολοκληρώθηκαι επιτυχώς.</u></font><br>
	<%
	session.setAttribute("caseDelete","-1");
}%>
<a href="javascript:showdiv()">Αναζήτηση</a>

<form method="post">
<input type="hidden" id="buttonPushed">

<div id="searchDiv" style="visibility:hidden;">
<form method="post" action="admCase.jsp">
<input type="hidden" name="enableSearch">
Λέξη κλειδί: <input type="text" name="searchString">
<input type="submit" value="Search">
</form>
</div>
<%
Connection con=null;
int totalEntries;
String qString;
try{
	con=dbpoint.connect();
	Statement stmt=con.createStatement();
	ResultSet result;
	if(request.getParameter("enableSearch")!=null){
		String searchString=request.getParameter("enableSearch").toString();
		qString="SELECT count(*) FROM uploads WHERE title LIKE \'"+searchString+"\' OR description LIKE \'"+searchString+"\'";
		result=stmt.executeQuery(qString);
	}else{
		qString="SELECT count(*) FROM uploads";
		result=stmt.executeQuery(qString);
	}
	result.next();
	totalEntries=result.getInt(1);
	totalEntries=totalEntries+19;

	int pageNumber=0;
	int totalPages=0;
	int i;
	int entriesPerPage=20;
	if(request.getParameter("pageNumber")!=null){
		pageNumber=Integer.parseInt(request.getParameter("pageNumber").toString());
	}else{
		pageNumber=1;
	}
	
	totalPages=(totalEntries/entriesPerPage);
	int offset=(pageNumber-1)*entriesPerPage;
	
	if(request.getParameter("enableSearch")!=null){
		String searchString=request.getParameter("searchString");
		qString="SELECT * FROM uploads WHERE title LIKE \'"+searchString+"' OR description LIKE \'"+searchString+"\' LIMIT "+offset+", "+entriesPerPage;
		result=stmt.executeQuery(qString);
	}else{
		qString="SELECT * FROM uploads LIMIT "+offset+", "+entriesPerPage;
		result=stmt.executeQuery(qString);
	}
	
	%><div align="right">[<%
	for(i=1;i<=totalPages;i++){
		if(i==pageNumber){
	    	out.println(i);
		}else{
			%>&nbsp;<a href="admCase.jsp?pageNumber=<%= i %>"><%= i %></a>&nbsp;<%
	    }
	}
	%>]</div>
	
	<div align="center">
	<table class="projects">
	<tr align="center"><th>Τίτλος</th><th>Περιγραφή</th><th>Αλλαγή</th><th>Διαγραφή</th></tr>
	<%
	while(result.next()){%>
		<tr align="center"><td><% out.println(result.getString(2)); %></td><td><% out.println(result.getString(3)); %></td><td><a href="editCase.jsp?caseId=<% out.println(result.getInt(1));%>"><img src="assets/images/tools_16.png"></a></td><td><a href="CaseDel?caseId=<% out.println(result.getInt(1)); %>"><img src="assets/images/close_16.png"></a></td></tr>
	<%}
		%>
	</table>
	</div>	
	<div align="right">[<%
		for(i=1;i<=totalPages;i++){
	    	if(i==pageNumber){
	        	out.println(i);
	        }else{
	            %>&nbsp;<a href="admCase.jsp?pageNumber=<%= i %>"><%= i %></a>&nbsp;<%
	        }
	     }
	%>]</div>
<%}catch(SQLException e){
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