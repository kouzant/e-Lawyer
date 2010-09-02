<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<%@ include file="left.jsp" %>
<div id="col_2">
<%if (session.getAttribute("login")=="1"){ %>
<h2>Διαγραφή project</h2>
<img border="0" src="assets/images/spacer.gif"><br><br>

<%
Connection con=null;
try{
	con=dbpoint.connect();
	Statement stmt=con.createStatement();
	ResultSet result;
	result=stmt.executeQuery("SELECT path FROM pfiles WHERE fileName=\'"+request.getParameter("fileName")+"\'");
	ArrayList<String> delProjects = new ArrayList<String>();
	while(result.next()){
		delProjects.add(result.getString(1));
	}
	int listSize=delProjects.size();
	System.out.println("Files to be deleted: "+listSize);
	System.out.println("First file: "+delProjects.get(0));
	for(int i=0;i<listSize;i++){
		System.out.println("Now deleting file: "+delProjects.get(i));
		File f=new File(delProjects.get(i));
		boolean success=f.delete();
		if(!success){
			System.out.println("File was not deleted");
		}else{
			System.out.println("File deleted");
		}
	}
	
}catch(SQLException e){
	e.printStackTrace();
}finally{
	dbpoint.closedb(con);
}

try{
	con=dbpoint.connect();
	Statement stmt=con.createStatement();
	int result;
	result=stmt.executeUpdate("DELETE FROM pfiles WHERE fileName='"+request.getParameter("fileName")+"'");
	if (result>0){
		session.setAttribute("projectDelete","1");
	}else{
		session.setAttribute("projectDelete", "0");
	}
}catch(SQLException e){
	e.printStackTrace();
}finally{
	dbpoint.closedb(con);
}

if(session.getAttribute("projectDelete")=="1"){
%>
<br><br>
<div align="center">
<font color=green>Το project διεγράφη.</font>
<%}else if(session.getAttribute("projectDelete")=="0"){%>
<font color=red>Το project δεν βρέθηκε ή υπήρξε πρόβλημα στη βάση. Επικοινωνήστε με τον διαχειριστή.</font>
<%} %>

</div>
<%}else{ 
%>
<h3>Η είσοδος επιτρέπεται μόνο σε εγγεγραμμένα μέλη.</h3>
<%} %>
</div>
<%@ include file="footer.jsp" %>