package myservs;

import java.sql.*;

public class DatabaseMethods {

	//Method for connecting to db server
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
	
	//Method for registering new users
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
	
	//Method for identifying unique users
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
	
	//Method for identifying unique users
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
	
	//Method for identifying unique users only for the update
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
	
	//Login method
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
	
	public void deleteUser(String userId, String initId){
		Connection con=null;
		try{
			con=connect();
			Statement stmt=con.createStatement();
			String userString="DELETE FROM users WHERE id=\'"+userId+"\'";
			int result=stmt.executeUpdate(userString);
			String fileString="DELETE FROM pfiles WHERE owner=\'"+userId+"\'";
			result=stmt.executeUpdate(fileString);
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			closedb(con);
		}
	}
	
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
	
	public String getOldId(String id){
		String initId=null;
		Connection con=null;
		try{
			con=connect();
			Statement stmt=con.createStatement();
			String qString="SELECT initId FROM users WHERE id=\'"+id+"\'";
			ResultSet result=stmt.executeQuery(qString);
			result.next();
			initId=result.getString(1);
			return initId;
		}catch(SQLException e){
			e.printStackTrace();
			return initId;
		}finally{
			closedb(con);
		}
	}
	
	//Method for closing the connection to db server
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
