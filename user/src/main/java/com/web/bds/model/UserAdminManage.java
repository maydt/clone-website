package com.web.bds.model;

import java.io.*;
import java.util.*;
import java.text.*;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;

public class UserAdminManage {
	
	private String tomcatDir;
	
	public UserAdminManage(){
		this.tomcatDir = System.getProperty("catalina.base");
	}
	
	public String getLoginUser(HttpServletRequest request){
		Cookie loginCookie = null;
        Cookie[] cookies = request.getCookies();
        if(cookies != null){
	        for(Cookie cookie : cookies){
	            if(cookie.getName().equals("user")){
	                loginCookie = cookie;
	                break;
	            }
	        }
        }
        return loginCookie.getValue();
	}
	
	public String getWebsite(String username) {
		try {
		String location = tomcatDir + "/data/" + username + ".properties";
		File fileEntry = new File(location);
		FileInputStream in = new FileInputStream(fileEntry);
		Properties props = new Properties();
		props.load(in);
		in.close();

		String website = props.getProperty("website");
		return website;
		} catch (FileNotFoundException e){
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}

	public boolean authenticate(String username, String password) {
		if (StringUtils.isEmpty(username) || StringUtils.isEmpty(password)) return false;
		Properties props = new Properties();
		try {
			String confFile = tomcatDir + "/conf/users.properties";
			FileInputStream in = new FileInputStream(confFile);
			props.load(in);
			in.close();
			String savedPassword = props.getProperty(username);
			if (StringUtils.isEmpty(savedPassword)) return false;
			else {
				if (savedPassword.equals(new sun.misc.BASE64Encoder().encode(password.getBytes()))) return true;
				else return false;
			}
		} catch (IOException e) {
			e.printStackTrace();
			return false;
		}
	}
}