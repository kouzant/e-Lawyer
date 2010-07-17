package myservs;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.File;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 * Servlet implementation class Publish
 */
public class Publish extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String TMP_DIR_PATH = "/tmp";
	private File tmpDir;
	private static final String DESTINATION_DIR_PATH = "/uploads";
	private File destinationDir;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Publish() {
        super();
        // TODO Auto-generated constructor stub
       
        tmpDir = new File(TMP_DIR_PATH);
        if (!tmpDir.isDirectory()){
        	System.out.println(TMP_DIR_PATH + "is not a directory");
        }
        /*String realPath=getServletContext().getRealPath(DESTINATION_DIR_PATH);
        System.out.println(realPath);
        destinationDir = new File(realPath);
        if (!destinationDir.isDirectory()){
        	System.out.println(DESTINATION_DIR_PATH + "is not a directory");
        }*/
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		
		PrintWriter out = response.getWriter();
		
		response.setContentType("text/plain");
		out.println("<h1>Servlet Upload File Prototype</h1>");
		
		DiskFileItemFactory fileItemFactory = new DiskFileItemFactory();
		//Set the size threshold.
		fileItemFactory.setSizeThreshold(1*1024*1024); //1mb
		
		//Set the temporary upload directory
		fileItemFactory.setRepository(tmpDir);
		
		ServletFileUpload uploadHandler = new ServletFileUpload(fileItemFactory);
		try{
			//Parse the request
			List items = uploadHandler.parseRequest(request);
			Iterator itr = items.iterator();
			while(itr.hasNext()){
				FileItem item = (FileItem) itr.next();
				//Handle form fields
				if (item.isFormField()){
					out.println("File Name = "+ item.getFieldName()+", Value = "+item);
				}else{
					//Handle uploaded file
					out.println("Uploaded file Field Name: "+item.getFieldName()+
							", File Name: "+item.getName()+
							", Content Type: "+item.getContentType()+
							", File Size: "+item.getSize());
					//Write file to ultimate destination
					File file = new File("/opt/uploads",item.getName());
					item.write(file);
				}
				out.close();
			}
		}catch(FileUploadException e){
			e.printStackTrace();
		}catch(Exception e){
			e.printStackTrace();
		}
	}

}
