<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<%@ include file="left.jsp" %>

<% session.setAttribute("login","0"); %>
<div id="col_2">
<br><br>
<h3> Αποσυνδεθήκατε επιτυχώς. Σας περιμένουμε πάλι σύντομα.</h3>
</div>
<!--PROGRESS BAR-->
<script type="text/javascript">
CallJS('Demo()');
delayRedirect();
</script>
<!--PROGRESS BAR-->
<%@ include file="footer.jsp" %>