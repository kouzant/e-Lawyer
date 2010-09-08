package myservs;

import java.io.*;

import javax.servlet.*;
import javax.servlet.http.*;
import org.apache.commons.io.FileUtils;

/**
 * Servlet implementation class which produces a downloadable file with specific version from any project owned.
 */
public class Download extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String DNL_DIR_PATH = "/uploads/downloads";
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Download() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * Parses the revision number from the form at page myProject.jsp and the specific file from the session.
	 * Removes the trailing revision from the filename and copies it to a downloadable location.
	 * Then returns to myProject.jsp
	 * @see DatabaseMethods#getFileAttributes(String, int)
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		DatabaseMethods dbPoint = new DatabaseMethods();
		HttpSession userSession=request.getSession();
		String fileAttributes[]=new String[7];
		fileAttributes=dbPoint.getFileAttributes(userSession.getAttribute("fileName").toString(), Integer.parseInt(request.getParameter("fileVersion")));

		if(request.getParameter("fileVersion").isEmpty()){
			userSession.setAttribute("downloadVersionEmpty", "1");
		}else{

			int givenVersion=Integer.parseInt(request.getParameter("fileVersion").toString());
			int realVersion=Integer.parseInt(fileAttributes[2]);
		
			if(givenVersion>realVersion){
				userSession.setAttribute("versionBiggerReal", "1");
			}else{
				//DO the stuff
				String fileNoVersion=fileAttributes[6];
				String sourceDir=fileAttributes[3];
				File trgDir = new File(getServletContext().getRealPath(DNL_DIR_PATH), fileNoVersion);
				File srcFile=new File(sourceDir);
				System.out.println("sourceDir: "+sourceDir);
			
				try{
					FileUtils.copyFile(srcFile, trgDir);
					String downloadLink="/e-Lawyer/uploads/downloads/".concat(fileNoVersion);
					userSession.setAttribute("downloadLink", downloadLink);
				}catch(IOException e){
					e.printStackTrace();
				}
				
			}
		}
		RequestDispatcher rd=getServletContext().getRequestDispatcher("/myProject.jsp?project="+fileAttributes[5]);
		if(rd!=null){
			rd.forward(request, response);
		}
		
	}

}
