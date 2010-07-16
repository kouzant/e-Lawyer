package myservs;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

/**
 * Servlet implementation class CheckLogin
 */
public class CheckLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public CheckLogin() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		Auxiliary auxPoint = new Auxiliary();
		String email=request.getParameter("email");
		String paramPassword=request.getParameter("password");
		String password=auxPoint.shaDigest(paramPassword);

		DatabaseMethods point = new DatabaseMethods();
		String[] userCredentials=point.identifyUser(email, password);

		if (userCredentials[0]==null){
			HttpSession userSession=request.getSession(true);
			userSession.setMaxInactiveInterval(10);
			userSession.setAttribute("login", "0");
			userSession.setAttribute("falseLogin", "1");
			//After 3 failed login attempts, login prompt lock for 10 minutes.
			Cookie[] userCookie = request.getCookies();
			if (userCookie!=null){
				for (int i=0;i<userCookie.length;i++){
					Cookie c = userCookie[i];
					if (c.getName().equals("falseLogNum")){
						String strNumOfFalseLog=c.getValue();
						int numOfFalseLogin=auxPoint.integerize(strNumOfFalseLog);
						
						if (numOfFalseLogin>=3){
							long lockStarted=System.currentTimeMillis();
							Long Lobj = new Long(lockStarted);
							if (userSession.getAttribute("lockStarted")==null){
								userSession.setAttribute("lockStarted", Lobj);	
								userSession.setAttribute("lockInit", "1");
							}
							if (userSession.getAttribute("lockInit")=="1"){
								long currentTime=System.currentTimeMillis();
								Object obj=userSession.getAttribute("lockStarted");
						 		String strLockStarted = obj.toString();
						 		long lLockStarted = Long.parseLong(strLockStarted.trim());
						 		
						 		if (currentTime-lLockStarted < 6000){
						 			userSession.setAttribute("hideForm", "1");
						 		}else{
						 			userSession.setAttribute("hideForm", "0");
						 		}
							}
							numOfFalseLogin=1;
						}else{
							long currentTime=System.currentTimeMillis();
							if (userSession.getAttribute("lockStarted")!=null){
								Object obj = userSession.getAttribute("lockStarted");
								String strLockStarted = obj.toString();
								long lLockStarted = Long.parseLong(strLockStarted.trim());

								if (currentTime - lLockStarted < 6000) {
									userSession.setAttribute("hideForm", "1");
								} else {
									userSession.setAttribute("hideForm", "0");
									userSession.setAttribute("lockInit", "0");
								}
							}
							numOfFalseLogin++;
							String strFalseLogin=auxPoint.stringerize(numOfFalseLogin);
							Cookie plusUserCookie = new Cookie("falseLogNum", strFalseLogin);
							response.addCookie(plusUserCookie);
						}
						System.out.println("Name: "+c.getName());
						System.out.println("Value: "+c.getValue());
						break;
					}else{
						Cookie newUserCookie = new Cookie("falseLogNum","1");
						response.addCookie(newUserCookie);
					}
				}	
			}
			
			RequestDispatcher rd=getServletContext().getRequestDispatcher("/login.jsp");
			if(rd!=null){
				rd.forward(request, response);
			}
		}else{
			//Set the session attributes
			HttpSession userSession=request.getSession(true);
			userSession.setMaxInactiveInterval(86400);
			userSession.setAttribute("login", "1");
			userSession.setAttribute("falseLogin", "0");
			userSession.setAttribute("name", userCredentials[1]);
			userSession.setAttribute("surname", userCredentials[2]);
			userSession.setAttribute("email", userCredentials[3]);
			userSession.setAttribute("password", userCredentials[4]);
			userSession.setAttribute("id", userCredentials[5]);
			userSession.setAttribute("telephone", userCredentials[6]);
			userSession.setAttribute("address", userCredentials[7]);
			userSession.setAttribute("postcode", userCredentials[8]);
			userSession.setAttribute("isadmin", userCredentials[9]);
			
			RequestDispatcher rd=getServletContext().getRequestDispatcher("/index.jsp");
			if(rd!=null){
				rd.forward(request, response);
			}
		}

		
	}

}
