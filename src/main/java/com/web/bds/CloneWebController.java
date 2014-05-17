package com.web.bds;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.web.bds.model.WebManage;

public class CloneWebController extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String webname = request.getParameter("domainName");
		WebManage webManage = new WebManage();
		int result = webManage.execute(webname);
		response.setContentType("text/html");
		PrintWriter writer = response.getWriter();
		if (result != 0) writer.println("false");
		else writer.println("true");
	}
}
