<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US" lang="en-US">
<head>
<title>e-Lawyer</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="assets/css/common.css" />

</head>
<body>

<!--PROGRESS BAR-->
<style>
<!--
.hide { position:absolute; visibility:hidden; }
.show { position:absolute; visibility:visible; }
-->
.divAuthor {
    position:relative;
    top:10px;
    left:370px;
    }
    
table.projects {
	border-width: 0px 0px 0px 0px;
	border-spacing: 0px;
	border-style: none none none none;
	border-color: gray gray gray gray;
	border-collapse: separate;
	background-color: rgb(255, 255, 240);
}
table.projects th {
	border-width: 1px 1px 1px 1px;
	padding: 1px 1px 1px 1px;
	border-style: inset inset inset inset;
	border-color: red red red red;
	background-color: white;
	-moz-border-radius: 3px 3px 3px 3px;
}
table.projects td {
	border-width: 1px 1px 1px 1px;
	padding: 1px 1px 1px 1px;
	border-style: inset inset inset inset;
	border-color: red red red red;
	background-color: white;
	-moz-border-radius: 3px 3px 3px 3px;
}

</style>

<SCRIPT LANGUAGE="JavaScript">

//Progress Bar script- by Todd King (tking@igpp.ucla.edu)
//Modified by JavaScript Kit for NS6, ability to specify duration
//Visit JavaScript Kit (http://javascriptkit.com) for script

var duration=3 // Specify duration of progress bar in seconds
var _progressWidth = 50;	// Display width of progress bar.

var _progressBar = "|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||"
var _progressEnd = 5;
var _progressAt = 0;


// Create and display the progress dialog.
// end: The number of steps to completion
function ProgressCreate(end) {
	// Initialize state variables
	_progressEnd = end;
	_progressAt = 0;

	// Move layer to center of window to show
	if (document.all) {	// Internet Explorer
		progress.className = 'show';
		progress.style.left = (document.body.clientWidth/2) - (progress.offsetWidth/2);
		progress.style.top = document.body.scrollTop+(document.body.clientHeight/2) - (progress.offsetHeight/2);
	} else if (document.layers) {	// Netscape
		document.progress.visibility = true;
		document.progress.left = (window.innerWidth/2) - 100+"px";
		document.progress.top = pageYOffset+(window.innerHeight/2) - 40+"px";
	} else if (document.getElementById) {	// Netscape 6+
		document.getElementById("progress").className = 'show';
		document.getElementById("progress").style.left = (window.innerWidth/2)- 100+"px";
		document.getElementById("progress").style.top = pageYOffset+(window.innerHeight/2) - 40+"px";
	}

	ProgressUpdate();	// Initialize bar
}

// Hide the progress layer
function ProgressDestroy() {
	// Move off screen to hide
	if (document.all) {	// Internet Explorer
		progress.className = 'hide';
	} else if (document.layers) {	// Netscape
		document.progress.visibility = false;
	} else if (document.getElementById) {	// Netscape 6+
		document.getElementById("progress").className = 'hide';
	}
}

// Increment the progress dialog one step
function ProgressStepIt() {
	_progressAt++;
	if(_progressAt > _progressEnd) _progressAt = _progressAt % _progressEnd;
	ProgressUpdate();
}

// Update the progress dialog with the current state
function ProgressUpdate() {
	var n = (_progressWidth / _progressEnd) * _progressAt;
	if (document.all) {	// Internet Explorer
		var bar = dialog.bar;
 	} else if (document.layers) {	// Netscape
		var bar = document.layers["progress"].document.forms["dialog"].bar;
		n = n * 0.55;	// characters are larger
	} else if (document.getElementById){
                var bar=document.getElementById("bar")
        }
	var temp = _progressBar.substring(0, n);
	bar.value = temp;
}

// Demonstrate a use of the progress dialog.
function Demo() {
	ProgressCreate(10);
	window.setTimeout("Click()", 100);
}

function Click() {
	if(_progressAt >= _progressEnd) {
		ProgressDestroy();
		return;
	}
	ProgressStepIt();
	window.setTimeout("Click()", (duration-1)*1000/10);
}

function CallJS(jsStr) { //v2.0
  return eval(jsStr)
}

</script>

<SCRIPT LANGUAGE="JavaScript">

// Create layer for progress dialog
document.write("<span id=\"progress\" class=\"hide\">");
	document.write("<FORM name=dialog id=dialog>");
	document.write("<TABLE border=2  bgcolor=\"#B84C4C\">");
	document.write("<TR><TD ALIGN=\"center\">");
	document.write("Περιμένετε...<BR>");
	document.write("<input type=text name=\"bar\" id=\"bar\" size=\"" + _progressWidth/2 + "\"");
	if(document.all||document.getElementById) 	// Microsoft, NS6
		document.write(" bar.style=\"color:navy;\">");
	else	// Netscape
		document.write(">");
	document.write("</TD></TR>");
	document.write("</TABLE>");
	document.write("</FORM>");
document.write("</span>");
ProgressDestroy();	// Hides

function redirect(){
	window.location = "index.jsp"
}
function delayRedirect(){
	setTimeout("redirect()",2400);
}
</script>
<!--PROGRESS BAR-->

<!-- Make visible search field at search.jsp -->
<script language=javascript type='text/javascript'>
function hidediv() {
if (document.getElementById) { // DOM3 = IE5, NS6
document.getElementById('searchDiv').style.visibility = 'hidden';
}
else {
if (document.layers) { // Netscape 4
document.hideShow.visibility = 'hidden';
}
else { // IE 4
document.all.hideShow.style.visibility = 'hidden';
}
}
}

function showdiv() {
if (document.getElementById) { // DOM3 = IE5, NS6
document.getElementById('searchDiv').style.visibility = 'visible';
}
else {
if (document.layers) { // Netscape 4
document.hideShow.visibility = 'visible';
}
else { // IE 4
document.all.hideShow.style.visibility = 'visible';
}
}
}
</script> 
<!-- Top menu -->
<div id="wrapper">
  <div id="header"> <a href="index.jsp"><img src="assets/images/logo_header.gif" alt="" width="203" height="102" class="logo" /></a> </div>
  <ul id="nav">
    <li><a href="index.jsp">Αρχική</a></li>
    <li><a href="preview.jsp">Προβολή</a></li>
    <%request.setCharacterEncoding("UTF-8"); 
    if (session.getAttribute("login")=="1"){%>
    <li><a href="publish.jsp">Δημοσίευση Δεδικασμένου</a></li>
    <li><a href="projects.jsp">Τα projects μου</a></li>
    <%if(session.getAttribute("isadmin").toString().equals("1")){%>
    <li><a href="admin.jsp">Διαχείριση</a></li>
    <%} %>
    <%}else{ %>
    <li><a href="register.jsp">Εγγραφή</a></li>
    <%} %>
  </ul>
  