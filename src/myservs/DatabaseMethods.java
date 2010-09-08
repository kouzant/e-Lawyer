package myservs;

import java.sql.*;

/**
 * Class that implements all the methods that query the database.
 * @author Antonis Kouzoupis
 *
 */
public class DatabaseMethods {

	/**
	 * Method to connect to the database server.
	 * @return con Connection object
	 */
	public Connection connect(){
		String url="jdbc:mysql://127.0.0.1/elawyer?useUnicode=true&characterEncoding=UTF8";
		Connection con=null;
		try{
			String driver="com.mysql.jdbc.Driver";
			Class.forName(driver).newInstance();
		}catch (Exception e){
			System.out.println("Failed to load the JDBC driver");
		}
		try{
			con=DriverManager.getConnection(url,"elawyer","elawyer");
		}catch (Exception e){
			e.printStackTrace();
		}
		return con;
	}
	
	/**
	 * Method for registering a new user to the database. All checks are made by the
	 * Register servlet class.
	 *  
	 * @see Register
	 * @param name The name of the user.
	 * @param surname The surname of the user.
	 * @param email The email of the user.
	 * @param password The hashed (sha1) password of the user.
	 * @param id The unique id of the user.
	 * @param telephone The telephone of the user.
	 * @param address The address of the user.
	 * @param postcode The postcode of the user.
	 * @param isadmin A field specifying if the user is administrator or not.
	 * @return result Non zero value at success and zero if it fails.
	 */
	public int registerUser(String name, String surname, String email, String password, String id, int telephone, String address, int postcode, int isadmin){
		Connection con=null;
		try{
			con=connect();
			Statement stmt=con.createStatement();
			String insQuery="INSERT INTO users (name,surname,email,password,id,initId,telephone,address,postcode,isadmin) VALUES ('"+name+"','"+surname+"','"+email+"','"+password+"','"+id+"','"+id+"','"+telephone+"','"+address+"','"+postcode+"','"+isadmin+"')";
			int result=stmt.executeUpdate(insQuery);
			return result;
		}catch(SQLException e){
			System.out.println("SQL statement did not executed");
			int result=0;
			return result;
		}finally{
			closedb(con);
		}
	}
	
	/**
	 * Method for changing the personal data of a user.
	 * 
	 * @see ChangePersonalData
	 * @param name The new name of the user.
	 * @param surname The new surname of the user.
	 * @param email The new email of the user.
	 * @param password The new password of the user.
	 * @param id The new id of the user.
	 * @param telephone The new telephone of the user.
	 * @param address The new address of the user.
	 * @param postcode The new postcode of the user.
	 * @param oldId This is the initial id that the user was given.
	 * @return result Non zero value at success and zero if it fails.
	 */
	public int updateUser(String name, String surname, String email, String password, String id, int telephone, String address, int postcode, String oldId){
		Connection con=null;
		try{
			con=connect();
			Statement stmt=con.createStatement();
			String upQuery="UPDATE users SET name=\'"+name+"\', surname=\'"+surname+"\', email=\'"+email+"\', password=\'"+password+"\', id=\'"+id+"\', telephone=\'"+telephone+"\', address=\'"+address+"\', postcode=\'"+postcode+"\' WHERE id =\'"+oldId+"\'";
			int result=stmt.executeUpdate(upQuery);
			return result;
		}catch(SQLException e){
			e.printStackTrace();
			int result=0;
			return result;
		}finally{
			closedb(con);
		}
	}
	
	/**
	 * Method used by the administrator to change the personal data of the user.
	 * @see AdminChangeData
	 * @param name The new name of the user.
	 * @param surname The new surname of the user.
	 * @param email The new email of the user.
	 * @param id The new id of the user.
	 * @param telephone The new telephone of the user.
	 * @param address The new address of the user.
	 * @param postcode The new postcode of the user.
	 * @param state The new state (administrator or regular user) of the user.
	 * @param oldId This is the initial id that the user was given.
	 * @return Non zero value at success and zero if it fails.
	 */
	public int updateAdmUser(String name, String surname, String email, String id, int telephone, String address, int postcode, int state, String oldId){
		Connection con=null;
		int result=0;
		try{
			con=connect();
			Statement stmt=con.createStatement();
			String upQuery="UPDATE users SET name=\'"+name+"\', surname=\'"+surname+"\', email=\'"+email+"\', id=\'"+id+"\', initId=\'"+oldId+"\', telephone=\'"+telephone+"\', address=\'"+address+"\', postcode=\'"+postcode+"\', enabled=\'"+state+"\' WHERE initId=\'"+oldId+"'";
			result=stmt.executeUpdate(upQuery);
			
			return result;
		}catch(SQLException e){
			e.printStackTrace();
			return result;
		}finally{
			closedb(con);
		}
	}
	
	/**
	 * Method for switching the state of a user (administrator - regular user)
	 * @see MakeAdmin
	 * @param userId The unique id of the user.
	 * @return result Non zero value at success and zero if it fails.
	 */
	public int makeAdmin(String userId){
		Connection con=null;
		int result=0;
		String adminQuery="0";
		try{
			con=connect();
			Statement stmt=con.createStatement();
			String qString="SELECT isadmin FROM users WHERE id=\'"+userId+"\'";
			ResultSet admin=stmt.executeQuery(qString);
			admin.next();
			if(admin.getInt(1)==0){
				adminQuery="UPDATE users SET isadmin='1' WHERE id=\'"+userId+"\'";
			}else if(admin.getInt(1)==1){
				adminQuery="UPDATE users SET isadmin='0' WHERE id=\'"+userId+"\'";
			}
			result=stmt.executeUpdate(adminQuery);
			return result;
		}catch(SQLException e){
			e.printStackTrace();
			return result;
		}finally{
			closedb(con);
		}
	}
	
	/**
	 * Method for populating the uploads table at database. This methods writes 
	 * the cases that the users upload to the database server.
	 * @see Publish
	 * @param title The title of the case.
	 * @param description The description of the case.
	 * @param location The directory of the uploaded file at the server.
	 * @param userid The id of the owner
	 * @return result Non zero value at success and zero if it fails.
	 */
	public int uploadTable(String title, String description, String location, String userid){
		Connection con=null;
		try{
			con=connect();
			Statement stmt=con.createStatement();
			String upQuery="INSERT INTO uploads (title,description,location,userid) VALUES ('"+title+"','"+description+"','"+location+"','"+userid+"')";
			int result=stmt.executeUpdate(upQuery);
			return result;
		}catch(SQLException e){
			e.printStackTrace();
			int result=0;
			return result;
		}finally{
			closedb(con);
		}
	}
	
	/**
	 * Method for populating the pfiles table of the database. pfiles table holds
	 * the personal files of a registered user under a versioning system.
	 * @see AddProject
	 * @param title The title of the project.
	 * @param comment The comment of every revision.
	 * @param revision The current revision.
	 * @param path The path of the file at the server.
	 * @param owner The owner id.
	 * @param commonFileName The name of the initial file (when first uploaded) without the revision prefix.
	 * @param realName Just the name of the file.
	 * @return result Non zero value at success and zero if it fails.
	 */
	public int populatePfileTable(String title, String comment, int revision, String path, String owner, String commonFileName, String realName){
		Connection con=null;
		int result=0;
		try{
			con=connect();
			Statement stmt=con.createStatement();
			String insQuery="INSERT INTO pfiles (title,comment,version,path,owner,fileName,realName) VALUES ('"+title+"', '"+comment+"', '"+revision+"', '"+path+"', '"+owner+"', '"+commonFileName+"', '"+realName+"')";
			result=stmt.executeUpdate(insQuery);
			return result;
		}catch(SQLException e){
			e.printStackTrace();
			return result;
		}finally{
			closedb(con);
		}
	}
	
	/**
	 * Method for identifying if a user is unique.
	 * @see Register
	 * @param id The unique id of the user.
	 * @param email The email of the user.
	 * @return exists Returns 1 if a user with the same credentials already exists of 0 if not.
	 */
	public int uniqueUser(String id, String email){
		Connection con=null;
		try{
			con=connect();
			Statement stmt=con.createStatement();
			String uniqueQuery="SELECT id,email FROM users";
			ResultSet result=stmt.executeQuery(uniqueQuery);
			int exists=0;
			
			while (result.next()){
				String usersId=result.getString(1);
				String usersEmail=result.getString(2);
				if ((id.equals(usersId)) || (email.equals(usersEmail))){
					//User with same login details already exists
					exists=1;
				}
			}
			return exists;
		}catch (SQLException e){
			System.out.println("SQL statement did not executed");
			int sqlError=1;
			return sqlError;
		}finally{
			closedb(con);
		}		
	}
	
	/**
	 * Method for identifying unique users only from their email account.
	 * @param email The email account of the user.
	 * @return exists Returns 1 if a user with the same credentials already exists of 0 if not.
	 */
	public int uniqueEmailUser(String email){
		Connection con=null;
		try{
			con=connect();
			Statement stmt=con.createStatement();
			String uniqueQuery="SELECT email FROM users";
			ResultSet result=stmt.executeQuery(uniqueQuery);
			int exists=0;
			
			while (result.next()){
				String usersEmail=result.getString(2);
				if (email.equals(usersEmail)){
					//User with same login details already exists
					exists=1;
				}
			}
			return exists;
		}catch (SQLException e){
			System.out.println("SQL statement did not executed");
			int sqlError=1;
			return sqlError;
		}finally{
			closedb(con);
		}		
	}
	
	/**
	 * Method for identifying unique users but only for the update function.
	 * @see ChangePersonalData
	 * @param id The id of the user.
	 * @param email The email of the user.
	 * @return exists Returns 1 if a user with the same credentials already exists of 0 if not.
	 */
	public int updateUniqueUser(String id, String email){
		Connection con=null;
		try{
			con=connect();
			Statement stmt=con.createStatement();
			String uniqueQuery="SELECT id,email FROM users";
			ResultSet result=stmt.executeQuery(uniqueQuery);
			int exists=0;
			
			while (result.next()){
				String usersId=result.getString(1);
				String usersEmail=result.getString(2);
				if ((id.equals(usersId)) && (email.equals(usersEmail))){
					//User with same login details already exists
					exists=1;
				}
			}
			return exists;
		}catch (SQLException e){
			System.out.println("SQL statement did not executed");
			int sqlError=1;
			return sqlError;
		}finally{
			closedb(con);
		}		
	}
	
	/**
	 * Method for updating the  case's data.
	 * @see EditCase
	 * @param caseId The case id.
	 * @param title The new case title.
	 * @param description The new case description.
	 * @return success Non zero value at success and zero if it fails.
	 */
	public int updateCases(int caseId, String title, String description){
		Connection con=null;
		int success=0;
		try{
			con=connect();
			Statement stmt=con.createStatement();
			String qString="UPDATE uploads SET title=\'"+title+"\', description=\'"+description+"\' WHERE uploads.key=\'"+caseId+"\'";
			success=stmt.executeUpdate(qString);
			return success;
		}catch(SQLException e){
			e.printStackTrace();
			return success;
		}finally{
			closedb(con);
		}
	}

	/**
	 * Method to identify if a user is registered to the system or not.
	 * @see CheckLogin
	 * @param email Given email.
	 * @param password Given password.
	 * @return userCredentials[] If user is registered, returns all the data of the user, else returns an empty array. 
	 */
	public String[] identifyUser(String email, String password){
		Connection con=null;
		String userCredentials[]=new String[12];
		
		try{
			con=connect();
			Statement stmt=con.createStatement();
			String identifyQuery="SELECT * FROM users";
			ResultSet result=stmt.executeQuery(identifyQuery);
			
			while (result.next()){
				String storedEmail=result.getString(4);
				String storedPass=result.getString(5);
				if (email.equals(storedEmail) && password.equals(storedPass)){
					for (int i=1;i<13;i++){
						userCredentials[i-1]=result.getString(i);
					}
					break;
				}
			}
			return userCredentials;
		}catch(Exception e){
			e.printStackTrace();
			return userCredentials;
		}finally{
			closedb(con);
		}
	}
	
	/**
	 * Method to delete the user entry at users table, as well as the user's personal files from pfiles table.
	 * @see UserDel
	 * @param userId The current user id.
	 * @param initId The initial user id.
	 */
	public void deleteUser(String userId, String initId){
		Connection con=null;
		try{
			con=connect();
			Statement stmt=con.createStatement();
			String userString="DELETE FROM users WHERE id=\'"+userId+"\'";
			stmt.executeUpdate(userString);
			String fileString="DELETE FROM pfiles WHERE owner=\'"+userId+"\'";
			stmt.executeUpdate(fileString);
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			closedb(con);
		}
	}
	
	/**
	 * Method for deleting a case from the database.
	 * @see CaseDel
	 * @param caseId The case unique id.
	 * @return result Non zero value at success and zero if it fails.
	 */
	public int caseDelete(int caseId){
		Connection con=null;
		int result=0;
		try{
			con=connect();
			Statement stmt=con.createStatement();
			String delString="DELETE FROM uploads WHERE uploads.key=\'"+caseId+"\'";
			result=stmt.executeUpdate(delString);
			return result;
		}catch(SQLException e){
			e.printStackTrace();
			return result;
		}finally{
			closedb(con);
		}
	}
	
	/**
	 * Method to get the personal file's revision.
	 * @see AddProject
	 * @param commonFileName The path of the initial uploaded file of the same project.
	 * @return revision Returns the revision number of that project.
	 */
	public int findFileRevision(String commonFileName){
		Connection con=null;
		int revision=0;
		try{
			con=connect();
			Statement stmt=con.createStatement();
			String queryString="SELECT version FROM pfiles WHERE fileName=\'"+commonFileName+"\' ORDER BY version ASC";
			ResultSet result=stmt.executeQuery(queryString);
			while(result.next()){
				revision=result.getInt(1);
			}
			return revision;
		}catch(Exception e){
			e.printStackTrace();
			return revision;
		}finally{
			closedb(con);
		}
	}
	
	/**
	 * Method to get from a specific personal file, all its data.
	 * @see Download
	 * @param path The initial path of the uploaded file.
	 * @param revision The version from which we want to take the data.
	 * @return fileAttributes[] If succeed returns an array with the file's data else an empty array.
	 */
	public String[] getFileAttributes(String path, int revision){
		Connection con=null;
		String fileAttributes[]=new String[7];
		try{
			con=connect();
			Statement stmt=con.createStatement();
			String query="SELECT * FROM pfiles WHERE fileName=\'"+path+"\' AND version=\'"+revision+"\'";
			ResultSet result=stmt.executeQuery(query);
			while(result.next()){
				fileAttributes[0]=result.getString(1);
				fileAttributes[1]=result.getString(2);
				fileAttributes[2]=Integer.toString(result.getInt(3));
				fileAttributes[3]=result.getString(4);
				fileAttributes[4]=result.getString(5);
				fileAttributes[5]=result.getString(6);
				fileAttributes[6]=result.getString(7);
			}
			return fileAttributes;
		}catch(Exception e){
			e.printStackTrace();
			return fileAttributes;
		}finally{
			closedb(con);
		}
	}
	
	/**
	 * Method to get all the data from the specified project.
	 * @param fileName The initial path of the first uploaded file of the project (project's distinguished name)
	 * @return projectAtt[] Returns an array with all the characteristics of the project on success, else an empty array.
	 */
	public String[] getProjectAttributes(String fileName){
		String[] projectAtt=new String[2];
		Connection con=null;
		try{
			con=connect();
			Statement stmt=con.createStatement();
			String qString="SELECT comment,version FROM pfiles WHERE fileName=\'"+fileName+"\' ORDER BY version ASC";
			ResultSet result=stmt.executeQuery(qString);
			result.last();
			projectAtt[0]=result.getString(1);
			projectAtt[1]=Integer.toString(result.getInt(2));
			return projectAtt;
		}catch(Exception e){
			e.printStackTrace();
			return projectAtt;
		}finally{
			closedb(con);
		}
		
	}
	
	/**
	 * Method for closing a connection to the database server.
	 * @param con The connection object to the JDBC
	 */
	public void closedb(Connection con){
		if (con != null){
			try{
				con.close();
			}catch (Exception e){
				e.printStackTrace();
			}
			
		}
	}	
}
