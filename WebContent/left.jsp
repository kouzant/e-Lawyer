<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date,java.text.DateFormat,java.sql.*" %>
<jsp:useBean id="dbpoint" scope="page" class="myservs.DatabaseMethods"/>

<!-- left menu -->
<div id="content" class="clearfix">
    <div id="col_1">
      <%
      Date now = new Date();
      out.println("<h4>"+DateFormat.getInstance().format(now)+"</h4>");
      
		Connection con2=null;
		try{
			con2=dbpoint.connect();
			Statement stmt2=con2.createStatement();
			ResultSet result2=stmt2.executeQuery("SELECT name FROM users");
			int numOfUsers=0;
			while(result2.next()){
				numOfUsers++;
			}
			out.println("<h2>Αριθμός Χρηστών: <b>"+numOfUsers+"</b></h2>");
			dbpoint.closedb(con2);
			con2=dbpoint.connect();
			stmt2=con2.createStatement();
			result2=stmt2.executeQuery("SELECT title FROM uploads");
			int numOfUploads=0;
			while (result2.next()){
				numOfUploads++;
			}
			out.println("<h2>On-line άρθρα: <b>"+numOfUploads+"</b></h2>");
		}catch (Exception e){
			e.printStackTrace();
		}finally{
			dbpoint.closedb(con2);
		}
		if (session.getAttribute("login")=="1"){
		out.println("<p>");
		out.println("<p>");%>
    		<h2>Πίνακας Ελέγχου</h2>
     		<h4>Γεια σας, <%out.println(session.getAttribute("name"));%></h4>     	
      		<ul id="subnav">
				<li><a href="logout.jsp" >Έξοδος</a></li>
        		<li><a href="cpanel.jsp" >Πίνακας Ελέγχου</a></li>
      		</ul>
      <%} %>
    </div>