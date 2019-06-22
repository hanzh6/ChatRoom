package com.chat;

import java.sql.Connection;
import java.sql.SQLException;

public class GloableSetting {
	private static Connection conn = null;
	public static String IP_ADDRESS = "172.18.187.10";
	public static String DBNAME = "16337074_chat";
	public static Integer DBPORT = 3306;
	public static String DBUSER = "user";
	public static String DBPASS = "123";
	public static Integer PORT = 8080;
	public static String getPath() {
		return "http://172.18.32.20:8080/ChatRoom";
	}
	
	public static String getSocket() {
		return "ws://172.18.32.20:8080/ChatRoom";
	}
	public static Connection getDBConnect() throws SQLException {
		return java.sql.DriverManager.getConnection("jdbc:mysql://"+IP_ADDRESS+":"+DBPORT+"/"+DBNAME,DBUSER,DBPASS);
	}
	
}
