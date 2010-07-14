package myservs;

import java.io.*;

import javax.servlet.*;
import javax.servlet.http.*;

import java.security.*;
/**
 * Servlet implementation class Register
 */
public class Register extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Register() {
        super();
        // TODO Auto-generated constructor stub
    }
    public String shaDigest(String id){
    	//SHA1 digest from id for unity
		byte[] idBytes=id.getBytes();
		try{
			MessageDigest algorithm = MessageDigest.getInstance("SHA1");
			algorithm.reset();
			algorithm.update(idBytes);
			byte messageDigest[] = algorithm.digest();
			
			StringBuffer hexString = new StringBuffer();
			for (int i=0;i<messageDigest.length;i++){
				hexString.append(Integer.toHexString(0xFF & messageDigest[i]));
			}
			//String foo=messageDigest.toString();
			id=hexString+"";
			String idHashed=hexString.toString();
			return idHashed;
			}catch (NoSuchAlgorithmException nsae){
				nsae.printStackTrace();
			}
			String error="Fatal Error: Could not produce hash digest";
			return error;
    }
    
    //Convert from string to integer
    public int integerize(String string){
    	try{
    		int intResult=Integer.parseInt(string);
    		return intResult;
    	}catch(NumberFormatException e){
    		int intResult=0;
    		return intResult;
    	}
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String name=request.getParameter("name");
		String surname=request.getParameter("surname");
		String email=request.getParameter("email");
		String password=request.getParameter("password");
		String repassword=request.getParameter("repass");
		String telephone=request.getParameter("telephone");
		String address=request.getParameter("address");
		String postcode=request.getParameter("postcode");
		HttpSession userSession=request.getSession(true);
		userSession.setMaxInactiveInterval(5);
		
		//Unfilled required fields
		if (name.isEmpty() || surname.isEmpty() || email.isEmpty() || password.isEmpty()){
			userSession.setAttribute("error", "1");
			
		}else if (!password.equals(repassword)){
			userSession.setAttribute("error", "2");
		}else{
			//Concatenate name, surname, email
			String id=name.concat(surname).concat(email);
			String idHash=shaDigest(id);
			String passHash=shaDigest(password);
			int isadmin=0;
			System.out.println(idHash);
			int intTelephone=integerize(telephone);
			int intPostCode=integerize(postcode);
			ConnectDb point = new ConnectDb();
			int val=point.registerUser(name,surname,email,passHash,idHash,intTelephone,address,intPostCode,isadmin);
			
			if (val!=0){
				//Everything went fabulous
				userSession.setAttribute("error", "0");
			}else{
				//Write to database error
				userSession.setAttribute("error", "3");
			}
		}
		
		userSession.setAttribute("name", name);
		userSession.setAttribute("surname", surname);
		userSession.setAttribute("email", email);
		userSession.setAttribute("telephone", telephone);
		userSession.setAttribute("address", address);
		userSession.setAttribute("postcode", postcode);
		
		RequestDispatcher rd=getServletContext().getRequestDispatcher("/register.jsp");
		if(rd!=null){
			rd.forward(request, response);
		}
	}

}
