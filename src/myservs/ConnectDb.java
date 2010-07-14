package myservs;

import java.sql.*;

public class ConnectDb {

	//Method for connecting to db server
	public Connection connect(){
		String url="jdbc:mysql://127.0.0.1/elawyer";
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
			String insQuery="INSERT INTO users (name,surname,email,password,id,telephone,address,postcode,isadmin) VALUES ('"+name+"','"+surname+"','"+email+"','"+password+"','"+id+"','"+telephone+"','"+address+"','"+postcode+"','"+isadmin+"')";
			int result=stmt.executeUpdate(insQuery);
			return result;
		}catch(SQLException e){
			System.out.println("SQL statement did not executed");
			int result=0;
			return result;
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
