package myservs;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

/**
 * Servlet implementation class MakeAdmin
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
