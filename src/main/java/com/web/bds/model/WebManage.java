package com.web.bds.model;

import java.io.IOException;

public class WebManage {
	
	  public int execute(String domainName) {
		  String tomcatDir = System.getProperty("catalina.base");
		  String cmd = "sh " + tomcatDir + "/conf/prepare.sh " + tomcatDir + " " + domainName;
		    try {
		      Process process = Runtime.getRuntime().exec(cmd);
		      int result = process.waitFor();
		      return result;
		    } catch (IOException e) {
		    	e.printStackTrace();
		    	return -1;
		    } catch (InterruptedException e) {
		    	e.printStackTrace();
		    	return -1;
		    }
	  }
}
