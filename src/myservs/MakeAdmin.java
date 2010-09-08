package myservs;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

/**
 * Administration servlet implementation class which switches states of a user 
 * between administrator or regular user.
 */
public class MakeAdmin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MakeAdmin() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * Parses the user id from the url and if the user is already administrator, becomes user
	 * and vice versa. Then redirects request and response to admUsers.jsp
	 * @see DatabaseMethods#makeAdmin(String)
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		
		DatabaseMethods dbPoint = new DatabaseMethods();
		HttpSession userSession=request.getSession();
		
		if(Integer.parseInt(userSession.getAttribute("isadmin").toString())==1){
			String userId = request.getParameter("userId").toString();
			int success = dbPoint.makeAdmin(userId);

			if (success != 0) {
				userSession.setAttribute("makeAdmin", "1");
			} else {
				userSession.setAttribute("makeAdmin", "0");
			}
		}
		RequestDispatcher rd=getServletContext().getRequestDispatcher("/admUsers.jsp");
		if(rd!=null){
			rd.forward(request, response);
		}
	}

}
