package myservs;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.io.*;
import java.nio.*;
import java.nio.channels.*;

public class Auxiliary {
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

  //Convert from integer to string
    public String stringerize(int integer){
    	try{
    		String strResult=Integer.toString(integer);
    		return strResult;
    	}catch(NumberFormatException e){
    		String strResult=null;
    		return strResult;
    	}
    }
    

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
