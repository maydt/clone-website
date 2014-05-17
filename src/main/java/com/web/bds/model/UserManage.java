package com.web.bds.model;

import java.io.*;
import java.util.*;
import java.text.*;

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
            return "Người dùng này đã tồn tại trong hệ thống.";
        } else {
        	try {
    			Properties properties = new Properties();
    			properties.setProperty("fullname", fullname);
    			properties.setProperty("gender", gender);
    			properties.setProperty("birthday", birthday);
    			properties.setProperty("email", email);
    			properties.setProperty("phone", phone);
    			properties.setProperty("address", address);
    			DateFormat df = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss");
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
		return "Không thể thêm người dùng tại thời điểm này, vui lòng thử lại sau.";
	}

	public void deleteUser(String username) {
		try {
			String location = tomcatDir + "/data/" + username + ".properties";
    		File file = new File(location);
 
    		if (file.delete()) {
    			System.out.println(file.getName() + " is deleted!");
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
    	} catch(Exception e){
    		e.printStackTrace();
    	}
	}

	public void updateUser(String username, String fullname, String gender,
            				String birthday, String email, String phone, String address) {
		try {
			String location = tomcatDir + "/data/" + username + ".properties";
			FileInputStream in = new FileInputStream(location);
			Properties properties = new Properties();
			properties.load(in);
			in.close();
	
			FileOutputStream out = new FileOutputStream(location);
			properties.setProperty("fullname", fullname);
			properties.setProperty("gender", gender);
			properties.setProperty("birthday", birthday);
			properties.setProperty("email", email);
			properties.setProperty("phone", phone);
			properties.setProperty("address", address);
			properties.store(out, null);
			out.close();
		}catch(FileNotFoundException e){
			e.printStackTrace();
		}catch(IOException ie){
			ie.printStackTrace();
		}
	}

	public void resetPassword(String username, String newPassword) throws IOException {
		updatePassword(username, newPassword);
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