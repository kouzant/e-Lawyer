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
			Boolean valid=false;
			
			if (userCredentials[0]==null){
				valid=false;
			}else{
				valid=true;
			}
			
			System.out.println(valid);
			if(!valid){
				PrintWriter out=response.getWriter();
				out.println("Wrong username or password");
			}else{
				HttpSession userSession=request.getSession(true);
				userSession.setMaxInactiveInterval(10);
				userSession.setAttribute("email", email);
				RequestDispatcher rd=getServletContext().getRequestDispatcher("/index.jsp");
				if(rd!=null){
					rd.forward(request, response);
				}
			}
		
	}

}
