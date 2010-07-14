<!-- left menu -->
<div id="content" class="clearfix">
    <div id="col_1">
      <h2>Information</h2>
      <%if (session.getAttribute("username")!=null){ 
      	out.println("Hello"+session.getAttribute("username"));}%>
      <ul id="subnav">
        <li><a href="http://www.free-css.com/" >Lorem Ipsum</a></li>
        <li><a href="http://www.free-css.com/" >Dylan Butler</a></li>
        <li><a href="http://www.free-css.com/" >Example Three</a></li>
      </ul>
    </div>