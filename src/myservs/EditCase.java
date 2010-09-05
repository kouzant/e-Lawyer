package myservs;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

/**
 * Servlet implementation class EditCase
 */
public class EditCase extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditCase() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		
		HttpSession userSession=request.getSession();
		DatabaseMethods dbPoint=new DatabaseMethods();
		
		if(Integer.parseInt(userSession.getAttribute("isadmin").toString())==1){
			if (request.getParameter("title").isEmpty()
					|| request.getParameter("description").isEmpty()) {
				userSession.setAttribute("emptyCaseEdit", "1");
			} else {
				int success = dbPoint.updateCases(
						Integer.parseInt(request.getParameter("caseId")),
						request.getParameter("title"),
						request.getParameter("description"));
				if (success != 0) {
					userSession.setAttribute("EditCase", "1");
				} else {
					userSession.setAttribute("EditCase", "0");
				}
			}
		}
		RequestDispatcher rd=getServletContext().getRequestDispatcher("/admCase.jsp");
		if(rd!=null){
			rd.forward(request, response);
		}
	}

}
