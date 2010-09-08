package myservs;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.io.*;
import java.nio.*;
import java.nio.channels.*;

/**
 * Class that implements all the auxiliary methods needed.
 * @author Antonis Kouzoupis
 *
 */
public class Auxiliary {
	/**
	 * Method which takes a string and produces its sha1 hash.
	 * @see AdminChangeData
	 * @see ChangePersonalData
	 * @see CheckLogin
	 * @see Register
	 * @param id A string. Used only for id and password.
	 * @return idHashed The hash of the given string.
	 */
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
			id=hexString+"";
			String idHashed=hexString.toString();
			return idHashed;
			}catch (NoSuchAlgorithmException nsae){
				nsae.printStackTrace();
			}
			String error="Fatal Error: Could not produce hash digest";
			return error;
    }
	
	/**
	 * Method to transform a string to integer.
	 * @see AdminChangeData
	 * @see ChangePersonalData
	 * @see Register
	 * @param string Any given string.
	 * @return intResult The integer representation of the given string.
	 */
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
	 * Method to transform an integer to a string.
	 * @param integer Any given integer
	 * @return strResult The string representation of the given integer.
	 */
	public String stringerize(int integer){
    	try{
    		String strResult=Integer.toString(integer);
    		return strResult;
    	}catch(NumberFormatException e){
    		String strResult=null;
    		return strResult;
    	}
    }
    

	/**
	 * Method which copies a file to another location at the filesystem.
	 * @param sourceFile The path of the source file.
	 * @param destFile The path of the destination file.
	 * @throws IOException
	 */
    public void copyFile(File sourceFile, File destFile) throws IOException {
    	 if(!destFile.exists()) {
    	  destFile.createNewFile();
    	 }

    	 FileChannel source = null;
    	 FileChannel destination = null;
    	 try {
    	  source = new FileInputStream(sourceFile).getChannel();
    	  destination = new FileOutputStream(destFile).getChannel();
    	  destination.transferFrom(source, 0, source.size());
    	 }
    	 finally {
    	  if(source != null) {
    	   source.close();
    	  }
    	  if(destination != null) {
    	   destination.close();
    	  }
    	}
    }
    
}
