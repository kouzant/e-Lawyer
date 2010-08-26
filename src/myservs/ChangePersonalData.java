package myservs;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

/**
 * Servlet implementation class ChangePersonalData
 */
public class ChangePersonalData extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ChangePersonalData() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		String name=request.getParameter("name");
		String surname=request.getParameter("surname");
		String email=request.getParameter("email");
		String password=request.getParameter("password");
		String repassword=request.getParameter("repass");
		String telephone=request.getParameter("telephone");
		String address=request.getParameter("address");
		String postcode=request.getParameter("postcode");
		
		DatabaseMethods dbPoint = new DatabaseMethods();
		Auxiliary auxPoint = new Auxiliary();
		HttpSession userSession = request.getSession();
		String oldId=userSession.getAttribute("id").toString();
		if(name.isEmpty() || surname.isEmpty() || email.isEmpty() || password.isEmpty()){
			userSession.setAttribute("error", "1");
		}else if(!password.equals(repassword)){
			userSession.setAttribute("error", "2");
		}else{
			//Do the things
			//Concatenate name, surname and email
			String id=name.concat(surname).concat(email);
			String idHash=auxPoint.shaDigest(id);
			if(dbPoint.updateUniqueUser(idHash, email)!=1){
				String passHash=auxPoint.shaDigest(password);
				int intTelephone=auxPoint.integerize(telephone);
				int intPostcode=auxPoint.integerize(postcode);
				int result=dbPoint.updateUser(name, surname, email, passHash, idHash, intTelephone, address, intPostcode, oldId);
				
				if (result!=0){
					userSession.setAttribute("error", "0");
					userSession.setAttribute("name", name);
					userSession.setAttribute("surname", surname);
					userSession.setAttribute("email", email);
					userSession.setAttribute("telephone", telephone);
					userSession.setAttribute("address", address);
					userSession.setAttribute("postcode", postcode);
					userSession.setAttribute("id", idHash);
				}else{
					userSession.setAttribute("error", "3");
				}
			}else{
				userSession.setAttribute("error", "4");
			}
		}
		RequestDispatcher rd=getServletContext().getRequestDispatcher("/cpanel.jsp");
		if(rd!=null){
			rd.forward(request, response);
		}
	}
}
