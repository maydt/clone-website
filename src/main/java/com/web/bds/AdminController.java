package com.web.bds;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.web.bds.model.UserManage;
import com.web.bds.model.User;

import org.apache.commons.lang3.StringUtils;

public class AdminController extends HttpServlet{

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String fullname = request.getParameter("fullname");
		if (StringUtils.isEmpty(fullname)) fullname = "";
		String gender = request.getParameter("gender");
		if (StringUtils.isEmpty(gender)) gender = "";
		String birthday = request.getParameter("birthday");
		if (StringUtils.isEmpty(birthday)) birthday = "";
		String email = request.getParameter("email");
		if (StringUtils.isEmpty(email)) email = "";
		String phone = request.getParameter("phone");
		if (StringUtils.isEmpty(phone)) phone = "";
		String address = request.getParameter("address");
		if (StringUtils.isEmpty(address)) address = "";
		
		UserManage userManage = new UserManage();
		String isUserAdded = userManage.addUser(username, password, fullname, gender, birthday, email, phone, address);
		response.setContentType("text/html");
		PrintWriter writer = response.getWriter();
		writer.println(isUserAdded);
	}
	
	protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("username");
		UserManage userManage = new UserManage();
		boolean result = userManage.deleteUser(username);
		response.setContentType("text/html");
		PrintWriter writer = response.getWriter();
		writer.println(result);
	}
}
