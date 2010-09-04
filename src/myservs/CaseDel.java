package myservs;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.regex.*;

/**
 * Servlet implementation class CaseDel
 */
public class CaseDel extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CaseDel() {
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
		
		int caseId=Integer.parseInt(request.getParameter("caseId"));
		
		int success=dbPoint.caseDelete(caseId);
		
		if(success!=0){
			userSession.setAttribute("caseDelete", "1");
		}else{
			userSession.setAttribute("caseDelete", "0");
		}
		
		RequestDispatcher rd=getServletContext().getRequestDispatcher("/admCase.jsp");
		if(rd!=null){
			rd.forward(request, response);
		}
	}

}
