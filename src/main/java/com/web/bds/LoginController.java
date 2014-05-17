package com.web.bds;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;

import com.web.bds.model.UserManage;

public class LoginController extends HttpServlet {

	private static String ADMIN_JSP = "/admin.jsp";
	private static String HOME_JSP = "/home.jsp";
	private static String LOGIN_JSP = "/index.jsp";

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String redirect = "";
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		UserManage userManage = new UserManage();
		if (userManage.authenticate(username, password)) {
			HttpSession session = request.getSession();
			session.setAttribute("login", true);
			session.setAttribute("userid", username);
			if (username.equals("admin")) {
				redirect = ADMIN_JSP;
			} else {
				redirect = HOME_JSP;
			}
		} else {
			request.setAttribute("login", false);
			redirect = LOGIN_JSP;
		}
    	response.sendRedirect(redirect);
	}
}