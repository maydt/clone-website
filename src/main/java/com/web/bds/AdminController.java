package com.web.bds;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.web.bds.model.UserManage;
import com.web.bds.model.User;

public class AdminController extends HttpServlet{

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String fullname = request.getParameter("fullname");
		String gender = request.getParameter("gender");
		String birthday = request.getParameter("birthday");
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		String address = request.getParameter("address");
		
		UserManage userManage = new UserManage();
		String isUserAdded = userManage.addUser(username, password, fullname, gender, birthday, email, phone, address);
		response.setContentType("text/html");
		PrintWriter writer = response.getWriter();
		writer.println(isUserAdded);
	}
}
