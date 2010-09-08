package myservs;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

/**
 * Administrator servlet class which implements the administration ability to change personal data of the
 * registered users.
 */
public class AdminChangeData extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminChangeData() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * Parse the new data from the form fields of admEdit.jsp, checks whether an obligatory
	 * field is empty, produces the hashes of id and password and then updates the database.
	 * Finally, redirects the request and response to admUsers.jsp
	 * @see DatabaseMethods#updateAdmUser(String, String, String, String, int, String, int, int, String)
	 * @see Auxiliary#shaDigest(String)
	 * @see Auxiliary#integerize(String)
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		String name=request.getParameter("name");
		String surname=request.getParameter("surname");
		String email=request.getParameter("email");
		String telephone=request.getParameter("telephone");
		String address=request.getParameter("address");
		String postcode=request.getParameter("postcode");
		int state=Integer.parseInt(request.getParameter("state").toString());
		
		DatabaseMethods dbPoint = new DatabaseMethods();
		Auxiliary auxPoint = new Auxiliary();
		HttpSession userSession=request.getSession();
		if(Integer.parseInt(userSession.getAttribute("isadmin").toString())==1){
			String initId = userSession.getAttribute("userInitId").toString();
			userSession.removeAttribute("userInitId");
			if (name.isEmpty() || surname.isEmpty() || email.isEmpty()) {
				userSession.setAttribute("error", "1");
			} else {
				String id = name.concat(surname).concat(email);
				String idHash = auxPoint.shaDigest(id);

				int intTelephone = auxPoint.integerize(telephone);
				int intPostcode = auxPoint.integerize(postcode);
				int result = dbPoint.updateAdmUser(name, surname, email,
						idHash, intTelephone, address, intPostcode, state,
						initId);

				if (result != 0) {
					userSession.setAttribute("adminUpdate", "1");
				} else {
					System.out.println("Update Failure");
					userSession.setAttribute("adminUpdate", "0");
				}
			}
		}
		RequestDispatcher rd=getServletContext().getRequestDispatcher("/admUsers.jsp");
		if(rd!=null){
			rd.forward(request, response);
		}
	}

}
