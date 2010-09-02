<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<%@ include file="left.jsp" %>


<div id="col_2">
<%if ((session.getAttribute("login")=="1") && (session.getAttribute("isadmin").toString().equals("1"))){ %>
<h2>Διαχείριση Χρηστών</h2>
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
int disabledUsers=0;
int enabledUsers=0;
int totalEntries;
String qString;
try{
	
	
	//Actual page preview
	con3=dbpoint.connect();
	Statement stmt3=con3.createStatement();
	ResultSet result3;
	if(request.getParameter("enableSearch")!=null){
		String searchString=request.getParameter("searchString");
		qString="SELECT count(*) FROM users WHERE name LIKE \'"+searchString+"\' OR surname LIKE \'"+searchString+"\' OR email LIKE \'"+searchString+"\'";
		result3=stmt3.executeQuery(qString);
	}else{
		qString="SELECT count(*) FROM users";
		result3=stmt3.executeQuery(qString);
	}
	result3.next();
	totalEntries=result3.getInt(1);
	if (totalEntries==0){%>
		<div align="center">
		<font color="red"><u>Δεν βρέθηκε εγγραφή με τα κριτήρια που δώσατε.</u></font><br>
		</div><%
	}
	
	totalEntries=totalEntries+19;
	int pageNumber=0;
	int totalPages=0;
	int i;
	int entriesPerPage=20;
	if (request.getParameter("pageNumber")!=null){
		pageNumber=Integer.parseInt(request.getParameter("pageNumber"));
	}else{
		pageNumber=1;
	}
	totalPages=(totalEntries/entriesPerPage);
	int offset=(pageNumber-1)*entriesPerPage;
	
	con4=dbpoint.connect();
	Statement stmt4=con4.createStatement();
	ResultSet result4;
	if(request.getParameter("searchString")!=null){
		String searchString=request.getParameter("searchString");
		qString="SELECT * FROM users WHERE name LIKE \'"+searchString+"\' OR surname LIKE \'"+searchString+"\' OR email LIKE \'"+searchString+"\' ORDER BY enabled ASC LIMIT "+offset+","+entriesPerPage;
		result4=stmt4.executeQuery(qString);
	}else{
		qString="SELECT * FROM users ORDER BY enabled ASC LIMIT "+offset+", "+entriesPerPage;
		result4=stmt4.executeQuery(qString);
	}
	
	while(result4.next()){
		if(result4.getInt(12)==0){
			disabledUsers++;
		}else{
			enabledUsers++;
		}
	}
	
	result4.beforeFirst();
	%><div align="right">[<%
		for(i=1;i<=totalPages;i++){
	    	if(i==pageNumber){
	        	out.println(i);
	        }else{
	            %>&nbsp;<a href="preview.jsp?pageNumber=<%= i %>"><%= i %></a>&nbsp;<%
	        }
	     }
	%>]</div>
	<u>Ανενεργοί Χρήστες</u>
	<div align="center">
	<table class="projects">
	<%
	int disCounter=1;
	System.out.println(disabledUsers);
	boolean disControl=true;
	boolean enControl=true;
	while(result4.next()){
		if((disabledUsers==0) && (disControl==true)){
			disControl=false;
			%><div align="center">---</div>
			</table>
			<u>Ενεργοί Χρήστες</u>
			<table class="projects">
			<%
		}
		%>
		<tr><td><% out.println(result4.getString(2)); %></td><td><% out.println(result4.getString(3)); %></td><td><% out.println(result4.getString(4)); %></td></tr>
		<% 
		if((disCounter==disabledUsers) && (disabledUsers!=0)){%>
			</table>
			<u>Ενεργοί Χρήστες</u>
			<table class="projects"><%
		}
		if((enabledUsers==0) && (enControl==true)){
			enControl=false;
			%><div align="center">---</div><%
		}
		if(disabledUsers>0){
			disCounter++;
		}
		
	}%>
	</table>
	</div>
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