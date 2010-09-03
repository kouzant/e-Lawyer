package myservs;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

/**
 * Servlet implementation class UserDel
 */
public class UserDel extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	static public boolean deleteDirectory(File path) {
	    if( path.exists() ) {
	      File[] files = path.listFiles();
	      for(int i=0; i<files.length; i++) {
	         if(files[i].isDirectory()) {
	           deleteDirectory(files[i]);
	         }
	         else {
	           files[i].delete();
	         }
	      }
	    }
	    return( path.delete() );
	  }

       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserDel() {
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
		
		String userId=request.getParameter("userId").toString();
		String initId=request.getParameter("initId").toString();
		
		DatabaseMethods dbPoint=new DatabaseMethods();
		HttpSession userSession=request.getSession();
		
		dbPoint.deleteUser(userId, initId);
		
		String userPath=getServletContext().getRealPath("/uploads").concat("/").concat(initId);
		System.out.println("userPath: "+userPath);
		File file=new File(userPath);
		deleteDirectory(file);
		
		userSession.setAttribute("userDelete", "1");
		
		RequestDispatcher rd=getServletContext().getRequestDispatcher("/admUsers.jsp");
		if(rd!=null){
			rd.forward(request, response);
		}
	}

}
