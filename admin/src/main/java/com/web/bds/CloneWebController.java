package com.web.bds;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.web.bds.model.WebManage;
import com.web.bds.model.UserManage;

public class CloneWebController extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String webname = request.getParameter("domainName");
		WebManage webManage = new WebManage();
		int createWeb = webManage.execute(webname);
		UserManage userManage = new UserManage();
		String username = userManage.getLoginUser(request);
		System.out.println("Web name " + webname);
		boolean updateUser = userManage.updateWebsite(username, webname);
		response.setContentType("text/html");
		PrintWriter writer = response.getWriter();
		if (createWeb != 0 || !updateUser) writer.println("false");
		else writer.println("true");
	}
}
