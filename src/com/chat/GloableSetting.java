package com.chat;

import java.sql.Connection;
import java.sql.SQLException;

public class GloableSetting {
	private static Connection conn = null;
	public static String IP_ADDRESS = "172.18.187.10";
	public static String DB_ADDRESS = "172.18.187.10";
	public static String DBNAME = "chat16337035";
	public static String PROJECT_NAME = "16337035";
//	public static String IP_ADDRESS = "172.18.32.20";
//	public static String DB_ADDRESS = "172.18.187.10";
//	public static String DBNAME = "chat16337035";
//	public static String PROJECT_NAME = "ChatRoom";
	public static Integer DBPORT = 3306;
	public static String DBUSER = "user";
	public static String DBPASS = "123";
	public static Integer PORT = 8080;
	public static String getPath() {
		return "http://"+IP_ADDRESS+":8080/"+PROJECT_NAME;
	}
	
	public static String getSocket() {
		return "ws://"+IP_ADDRESS+":8080/"+PROJECT_NAME;
	}
	public static Connection getDBConnect() throws SQLException {
		return java.sql.DriverManager.getConnection("jdbc:mysql://"+DB_ADDRESS+":"+DBPORT+"/"+DBNAME,DBUSER,DBPASS);
	}
	
}
