package com.web.bds.model;

public class User {
	
	private String username;
	private String fullname;
	private String gender;
	private String birthday;
	private String email;
	private String phone;
	private String address;
	private String createdDate;
	private String website;
	
	public User(String username, String fullname, String gender, String birthday, String email,
				String phone, String address, String createdDate, String website){
		this.username = username;
		this.fullname = fullname;
		this.gender = gender;
		this.birthday = birthday;
		this.email = email;
		this.phone = phone;
		this.address = address;
		this.createdDate = createdDate;
		this.website = website;
	}
	
	public void setUsername(String username) {
		this.username = username;
	}
	
	public String getUsername(){
		return username;
	}
	
	public void setFullname(String fullname) {
		this.fullname = fullname;
	}
	
	public String getFullname(){
		return fullname;
	}
	
	public void setGender(String gender) {
		this.gender = gender;
	}
	
	public String getGender(){
		return gender;
	}
	
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	
	public String getBirthday(){
		return birthday;
	}
	
	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getEmail(){
		return email;
	}
	
	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	public String getPhone(){
		return phone;
	}
	
	public void setAddress(String address) {
		this.address = address;
	}
	
	public String getAddress(){
		return address;
	}
	
	public void setCreatedDate(String createdDate) {
		this.createdDate = createdDate;
	}
	
	public String getCreatedDate(){
		return createdDate;
	}
	
	public void setWebsite(String website) {
		this.website = website;
	}
	
	public String getWebsite(){
		return website;
	}	
}
