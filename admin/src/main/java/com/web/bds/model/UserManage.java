package com.web.bds.model;

import java.io.*;
import java.util.*;
import java.text.*;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;

public class UserManage {
	
	private String tomcatDir;
	
	public UserManage(){
		this.tomcatDir = System.getProperty("catalina.base");
	}

	public String addUser(String username, String password, String fullname, String gender,
			             String birthday, String email, String phone, String address) {

		// Save personal information
		String location = tomcatDir + "/data";
		System.out.println(location);
		File dataDir = new File(location);
		
		File configurationFile = new File(dataDir, username + ".properties");
		if (configurationFile.exists()) {
            return "Ng\u01b0\u1eddi d\u00f9ng n\u00e0y \u0111\u00e3 t\u1ed3n t\u1ea1i trong h\u1ec7 th\u1ed1ng.";
        } else {
        	try {
    			Properties properties = new Properties();
    			properties.setProperty("fullname", fullname);
    			properties.setProperty("gender", gender);
    			properties.setProperty("birthday", birthday);
    			properties.setProperty("email", email);
    			properties.setProperty("phone", phone);
    			properties.setProperty("address", address);
    			DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
    			Date today = Calendar.getInstance().getTime();
    			String createdDate = df.format(today);
    			properties.setProperty("createdDate", createdDate);

    			FileOutputStream fileOut = new FileOutputStream(configurationFile);
    			properties.store(fileOut, "Add new user");
    			fileOut.close();
    			
    			// Update authentication information
    			updatePassword(username, password);
    			
    			return "true";
    		} catch (FileNotFoundException e) {
    			e.printStackTrace();
    		} catch (IOException e) {
    			e.printStackTrace();
    		}
        }
		return "Kh\u00f4ng th\u1ec3 th\u00eam ng\u01b0\u1eddi d\u00f9ng t\u1ea1i th\u1eddi \u0111i\u1ec3m n\u00e0y, vui l\u00f2ng th\u1eed l\u1ea1i sau.";
	}

	public boolean deleteUser(String username) {
		try {
			String location = tomcatDir + "/data/" + username + ".properties";
    		File file = new File(location);
 
    		if (file.delete()) {
    			// Update authentication information
    			String confFile = tomcatDir + "/conf/users.properties";
    			FileInputStream in = new FileInputStream(confFile);
    			Properties props = new Properties();
    			props.load(in);
    			in.close();

    			FileOutputStream out = new FileOutputStream(confFile);
    			props.remove(username);
    			props.store(out, null);
    			out.close();
    		}
    		return true;
    	} catch(Exception e){
    		e.printStackTrace();
    	}
		return false;
	}

	public boolean updateUser(String username, String fullname, String gender,
            				String birthday, String email, String phone, String address) {
		try {
			String location = tomcatDir + "/data/" + username + ".properties";
			FileInputStream in = new FileInputStream(location);
			Properties properties = new Properties();
			properties.load(in);
			in.close();
	
			FileOutputStream out = new FileOutputStream(location);
			if (!StringUtils.isEmpty(fullname)) properties.setProperty("fullname", fullname);
			if (!StringUtils.isEmpty(gender)) properties.setProperty("gender", gender);
			if (!StringUtils.isEmpty(birthday)) properties.setProperty("birthday", birthday);
			if (!StringUtils.isEmpty(email)) properties.setProperty("email", email);
			if (!StringUtils.isEmpty(phone)) properties.setProperty("phone", phone);
			if (!StringUtils.isEmpty(address)) properties.setProperty("address", address);
			
			properties.store(out, null);
			out.close();
			return true;
		}catch(FileNotFoundException e){
			e.printStackTrace();
		}catch(IOException e){
			e.printStackTrace();
		}
		return false;
	}
	
	public boolean updateWebsite(String username, String website){
		try {
			String location = tomcatDir + "/data/" + username + ".properties";
			FileInputStream in = new FileInputStream(location);
			Properties properties = new Properties();
			properties.load(in);
			in.close();
	
			FileOutputStream out = new FileOutputStream(location);
			System.out.println("Web name " + website);
			if (!StringUtils.isEmpty(website)) properties.setProperty("website", website);
			properties.store(out, null);
			out.close();
			return true;
		}catch(FileNotFoundException e){
			e.printStackTrace();
		}catch(IOException e){
			e.printStackTrace();
		}
		return false;
	}

	public boolean resetPassword(String username, String newPassword) {
		try{
			updatePassword(username, newPassword);
			return true;
		} catch(FileNotFoundException e){
			e.printStackTrace();
		} catch(IOException e){
			e.printStackTrace();
		}
		return false;
	}

	public List<User> getAllUsers() throws FileNotFoundException, IOException{
		List<User> results = new ArrayList<User>();
		String location = tomcatDir + "/data";
		File folder = new File(location);
		for (final File fileEntry : folder.listFiles()) {
			FileInputStream in = new FileInputStream(fileEntry);
			Properties props = new Properties();
			props.load(in);
			in.close();
			String username = fileEntry.getName();
			username = username.substring(0, username.indexOf(".properties"));
			String fullname = props.getProperty("fullname");
			String gender = props.getProperty("gender");
			String birthday = props.getProperty("birthday");
			String email = props.getProperty("email");
			String phone = props.getProperty("phone");
			String address = props.getProperty("phone");
			String createdDate = props.getProperty("createdDate");
			String website = props.getProperty("website");
			
			User user = new User(username, fullname, gender, birthday, email, phone, address, createdDate, website);
			results.add(user);
	    }
		return results;
	}
	
	public String getLoginUser(HttpServletRequest request) {
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
	
	public User getUser(String username) {
		try {
		String location = tomcatDir + "/data/" + username + ".properties";
		File fileEntry = new File(location);
		FileInputStream in = new FileInputStream(fileEntry);
		Properties props = new Properties();
		props.load(in);
		in.close();
		String fullname = props.getProperty("fullname");
		String gender = props.getProperty("gender");
		String birthday = props.getProperty("birthday");
		String email = props.getProperty("email");
		String phone = props.getProperty("phone");
		String address = props.getProperty("phone");
		String createdDate = props.getProperty("createdDate");
		String website = props.getProperty("website");
		
		User user = new User(username, fullname, gender, birthday, email, phone, address, createdDate, website);
		return user;
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
	
	private void updatePassword(String username, String password) throws FileNotFoundException, IOException {
		String encodedPassword = new sun.misc.BASE64Encoder().encode(password.getBytes());
		String confFile = tomcatDir + "/conf/users.properties";
		FileInputStream in = new FileInputStream(confFile);
		Properties props = new Properties();
		props.load(in);
		in.close();

		FileOutputStream out = new FileOutputStream(confFile);
		props.setProperty(username, encodedPassword);
		props.store(out, null);
		out.close();
	}
}