<!-- left menu -->
<div id="content" class="clearfix">
    <div id="col_1">
      
      <%if (session.getAttribute("login")=="1"){%>
      <h2>Πίνακας Ελέγχου</h2><br>
      <h4>Γεια σας, <%out.println(session.getAttribute("name"));%></h4>     	
      <ul id="subnav">
		<li><a href="logout.jsp" >Έξοδος</a></li>
        <li><a href="http://www.free-css.com/" >Πίνακας Ελέγχου</a></li>
      </ul>
      <%}%>
      <h2>Γνωμικά<h2>
      Malakies.
    </div>