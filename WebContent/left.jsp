<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date,java.text.DateFormat,java.sql.*" %>
<!-- left menu -->
<div id="content" class="clearfix">
    <div id="col_1">
      <%
      Date now = new Date();
      out.println("<h4>"+DateFormat.getInstance().format(now)+"</h4>");
      
      	String url2="jdbc:mysql://127.0.0.1/elawyer?useUnicode=true&characterEncoding=UTF8";
		Connection con3=null;
		Connection con4=null;

		try{
			String driver2="com.mysql.jdbc.Driver";
			Class.forName(driver2).newInstance();
		}catch (Exception e){
			System.out.println("Failed to load the JDBC driver");
		}
		try{
			con3=DriverManager.getConnection(url2,"elawyer","elawyer");
			Statement stmt3=con3.createStatement();
			ResultSet result3=stmt3.executeQuery("SELECT name FROM users");
			int numOfUsers=0;
			while(result3.next()){
				numOfUsers++;
			}
			out.println("<h2>Αριθμός Χρηστών: <b>"+numOfUsers+"</b></h2>");
			
			con4=DriverManager.getConnection(url2,"elawyer","elawyer");
			Statement stmt4=con4.createStatement();
			ResultSet result4=stmt4.executeQuery("SELECT title FROM uploads");
			int numOfUploads=0;
			while (result4.next()){
				numOfUploads++;
			}
			out.println("<h2>On-line άρθρα: <b>"+numOfUploads+"</b></h2>");
		}catch (Exception e){
			e.printStackTrace();
		}finally{
			if (con3 != null){
				try{
					con3.close();
				}catch (Exception e){
					e.printStackTrace();
				}
		
			}
			if (con4 != null){
				try{
					con4.close();
				}catch (Exception e){
					e.printStackTrace();
				}
		
			}
		}
		if (session.getAttribute("login")=="1"){
		out.println("<p>");
		out.println("<p>");%>
    		<h2>Πίνακας Ελέγχου</h2>
     		<h4>Γεια σας, <%out.println(session.getAttribute("name"));%></h4>     	
      		<ul id="subnav">
				<li><a href="logout.jsp" >Έξοδος</a></li>
        		<li><a href="http://www.free-css.com/" >Πίνακας Ελέγχου</a></li>
      		</ul>
      <%} %>
    </div>