<%@ include file="header.jsp" %>
<%@ include file="left.jsp" %>

    <div id="col_2">
    <%if (session.isNew()){
    	out.println("<h2>Welcome newcomer</h2>");
    }else{
    	out.println("<h2>Welcome back</h2>");
    	}%>
      <p class="floatright alignright"><b>Page 1</b><br />
        [ 1, <a href="http://www.free-css.com/">2</a>, <a href="http://www.free-css.com/">3</a>, <a href="http://www.free-css.com/">4</a> ]</p>
      <h1>Example Headline One</h1>
      <p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Integer pede. Aliquam facilisis. Nulla gravida elit at eros. Nunc arcu. In urna velit, gravida ut, venenatis id, suscipit ut, massa. Proin bibendum luctus turpis. Nam porttitor ante ut leo. Integer luctus venenatis sem. Maecenas non ante. Ut semper. Duis vel velit. Ut porta. Etiam rutrum purus at mauris molestie aliquam. Pellentesque ornare. Aenean convallis dictum quam. Etiam sodales magna in mi. Phasellus risus nunc, lacinia sit amet, accumsan sed, blandit et, orci. Nulla id augue et nibh tincidunt convallis. Fusce euismod neque vel sem. Sed et turpis in nisl interdum tincidunt. </p>
      <h2>Example Headline Two</h2>
      <blockquote>This would obviously be an example blockquote. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Integer pede. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Integer pede.</blockquote>
      <h3>Example Headline Three</h3>
      <p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Integer pede. Aliquam facilisis. Nulla gravida elit at eros. Nunc arcu. In urna velit, gravida ut, venenatis id, suscipit ut, massa.</p>
      <p>Proin bibendum luctus turpis. Nam porttitor ante ut leo. Integer luctus venenatis sem. Maecenas non ante. Ut semper. Duis vel velit. Ut porta. Etiam rutrum purus at mauris molestie aliquam. Pellentesque ornare. Aenean convallis dictum quam. Etiam sodales magna in mi. Phasellus risus nunc, lacinia sit amet, accumsan sed, blandit et, orci. Nulla id augue et nibh tincidunt convallis. Fusce euismod neque vel sem. Sed et turpis in nisl interdum tincidunt. </p>
    </div>
    
<%@ include file="footer.jsp" %>