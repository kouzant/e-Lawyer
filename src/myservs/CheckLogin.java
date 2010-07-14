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
		String username=request.getParameter("username");
		String password=request.getParameter("password");
		
		Boolean valid=true;
		
		if(!valid){
			PrintWriter out=response.getWriter();
			out.println("Wrong username or password");
		}else{
			HttpSession userSession=request.getSession(true);
			userSession.setAttribute("username", username);
			RequestDispatcher rd=getServletContext().getRequestDispatcher("/index.jsp");
			if(rd!=null){
				rd.forward(request, response);
			}
		}
	}

}
