package com.web.bds;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;

import com.web.bds.model.UserManage;

public class UpdateUserController extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("username");
		String password = request.getParameter("newPassword");
		boolean result = false;
		UserManage userManage = new UserManage();
		if (StringUtils.isEmpty(password)) { // Update normal information
			String fullname = request.getParameter("newFullname");
			String gender = request.getParameter("newGender");
			String birthday = request.getParameter("newBirthday");
			String email = request.getParameter("newEmail");
			String phone = request.getParameter("newPhone");
			String address = request.getParameter("newAddress");
			result = userManage.updateUser(username, fullname, gender, birthday, email, phone, address);
		} else { // Update password information
			System.out.println("new password: " + password);
			result = userManage.resetPassword(username, password);
		}
		response.setContentType("text/html");
		PrintWriter writer = response.getWriter();
		writer.println(result);
	}
}
