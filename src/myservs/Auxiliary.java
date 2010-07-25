package myservs;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;
import java.util.HashMap;
import com.oreilly.servlet.multipart.*;

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
    
    //Return a map with multipart values
    public Map<String,String> multiValues(HttpServletRequest request){
		Map<String,String> paramMap = new HashMap<String,String>();
    	try{
    		MultipartParser mp = new MultipartParser(request,1*1024*1024);
    		Part part;
    		while((part=mp.readNextPart())!=null){
    			String name=part.getName();
    			if (part.isParam()){
    				ParamPart paramPart = (ParamPart) part;
    				String value=paramPart.getStringValue();
    				paramMap.put(name, value);
    			}
    		}
    		return paramMap;
    	}catch(IOException e){
    		e.printStackTrace();
    		return paramMap;
    	}    
    }
}
