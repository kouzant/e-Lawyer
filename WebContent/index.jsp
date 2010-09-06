<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<%@ include file="left.jsp" %>

    <div id="col_2">
    <%
    if (session.getAttribute("error")=="1"){
    %>
    <font color="red"><u>Συμπληρώστε όλα τα απαραίτητα πεδία.</u></font>
    <%} 
    if (session.getAttribute("error")=="2"){
    %>
    <font color="red"><u>Οι κωδικοί που εισάγατε δεν ταιριάζουν.</u></font>
    <%}
    if (session.getAttribute("error")=="3"){
    %>
    <font color="red"><u>FATAL ERROR: Η εγγραφή στη βάση απέτυχε. Ενημερώστε τον διαχειριστή.</u></font>
    <%}
    if (session.getAttribute("error")=="4"){
    %>
    <font color="red"><u>Ο χρήστης με τα παρακάτω στοιχεία υπάρχει ήδη.</u></font>
    <%}
    if (session.getAttribute("falseLogin") == "1") {
    	%><div align="center">
    	<font color="red"><u>Λανθασμένα στοιχεία εισόδου.</u></font><br> 
    	</div><%
     	}
    if((session.getAttribute("login")=="1") && (session.getAttribute("enabled").toString().equals("0"))){
    	session.setAttribute("login","0");%>
    	<div align="center">
    	<font color="red">Ο λογαριασμός σας δεν έχει ενεργοποιηθεί ακόμα.</font>
    	</div>
    <%}
    		%>
      <h3>Καλώς ήρθατε στο e-Lawyer</h3>
      <p>Το e-Lawyer είναι μία διαδικτυακή πλατφόρμα για την διευκόλυνση των δικηγόρων.
      Κύριος στόχος του είναι η κεντρικοποιημένη και ψηφιακή αποθήκευση δεδικασμένων υποθέσεων
      που θα είναι εύκολα προσπελάσιμες από τον περιηγητή σας.
      <p>Επίσης το e-Lawyer προσφέρει ένα εξελιγμένο σύστημα για αποθήκευση και ενημέρωση των
      εγγράφων σας χωρίζοντας το σε εκδόσεις.
      <p>Ποτέ πλέον δεν θα χρειαστεί να ψάχνετε για δεδικασμένες υποθέσεις σε σκονισμένα ράφια.
      Θα τα έχετε μπροστά σας με τον πλέον σύγχρονο τρόπο.
      <p>Με το e-Lawyer δεν θα χρειαστεί να ανυσηχείτε μήπως χαλάσετε το κείμενο που με τόσο κόπο
      φτιάχνετε ή ακόμα χειρότερα να το διαγράψετε. Πολύ απλά, κάθε φορά που νομίζετε ότι το 
      έγγραφο είναι σωστό, απλώς ενημερώστε τον φάκελό σας στο σύστημα. Σε περίπτωση απώλειας απλά
      κατεβάστε την τελευταία έκδοση ή όποια άλλη θέλετε.
    </div>
    
<%@ include file="footer.jsp" %>