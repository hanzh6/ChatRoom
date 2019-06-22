package com.chat;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.Set;
import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;
import java.util.*;
import java.io.IOException;
import java.sql.*;

/**
 * @ServerEndpoint 注解标识该类是websocket类
 */
@ServerEndpoint("/websocket")
public class ChatSocket {

	// 将用户的名字和每个websocket连接存在map集合中，static修饰，其他类可以直接调用
	private static HashMap<String, ChatSocket> webSocketMap = new HashMap<String, ChatSocket>();
	private static HashMap<String, String> nickNameMap = new HashMap<String, String>();
	// session保存用户请求过来的信息
	private Session session;
	private String userName;

	/**
	 *
	 * 
	 * @param session 当有客户端与服务器建立连接时调用
	 */
	@OnOpen
	public void onOpen(Session session) throws ClassNotFoundException {
		this.session = session;
		try {
			this.userName = URLDecoder
					.decode(session.getQueryString().substring(session.getQueryString().indexOf("=") + 1), "UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		webSocketMap.put(this.userName, this);
		Set<String> keys = webSocketMap.keySet();
		Connection conn = null;
		PreparedStatement preparedStmt = null;
		ResultSet sqlRst = null;
		Class.forName("com.mysql.jdbc.Driver");
		try {
			conn = GloableSetting.getDBConnect();
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		StringBuffer str = new StringBuffer();
		try {
			for (String key : keys) {
				preparedStmt = conn.prepareStatement("select filename,nickname from login where username=?");
				preparedStmt.setString(1, key);
				sqlRst = preparedStmt.executeQuery();
				if (sqlRst.next()) {
					String filename;
					String nickname;
					try {
						filename = new String(sqlRst.getString("filename"));
					} catch (Exception e) {
						filename = null;
					}
					try {
						nickname = new String(sqlRst.getString("nickname"));
					} catch (Exception e) {
						nickname = null;
					}
					String name = nickname == null ? key : nickname;
					nickNameMap.put(key, name);
					if (filename == null) {
						str.append("<li>"
								+ "<img src=" + GloableSetting.getPath()+ "/js/theme/default/head_1.png" + " alt=\"无\"  style=\"width: 20px; height:20px; border-radius:100%; border:solid 1px black; font-size:2px;\">"
								+ name + " </li>");
					} else {
						str.append("<li>" + "<img src=" + GloableSetting.getPath() + "/file/" + filename
								+ " alt=\"无\" +  style=\"width: 20px; height:2 0px; border-radius:100%; border:solid 1px black; font-size:2px;\">"
								+ name + " </li>");
					}
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		for (String key : keys) {
			try {
				webSocketMap.get(key).sendMessage("0_" + str);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				continue;
			}
		}

	}

	/**
	 * 与服务器连接关闭时调用
	 * 
	 * @throws ClassNotFoundException
	 */
	@OnClose
	public void onClose() throws ClassNotFoundException {
		webSocketMap.remove(this.userName);
		Set<String> keys = webSocketMap.keySet();
		Connection conn = null;
		PreparedStatement preparedStmt = null;
		ResultSet sqlRst = null;
		Class.forName("com.mysql.jdbc.Driver");
		try {
			conn = GloableSetting.getDBConnect();
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		StringBuffer str = new StringBuffer();
		try {
			for (String key : keys) {
				preparedStmt = conn.prepareStatement("select filename,nickname from login where username=?");
				preparedStmt.setString(1, key);
				sqlRst = preparedStmt.executeQuery();
				if (sqlRst.next()) {
					String filename;
					String nickname;
					try {
						filename = new String(sqlRst.getString("filename"));
					} catch (Exception e) {
						filename = null;
					}
					try {
						nickname = new String(sqlRst.getString("nickname"));
					} catch (Exception e) {
						nickname = null;
					}
					String name = nickname == null ? key : nickname;
					nickNameMap.put(key, name);
					if (filename == null) {
						str.append("<li>"
								+ "<img src=" + GloableSetting.getPath()+ "/js/theme/default/head_1.png" + " alt=\"无\"  style=\"width: 20px; height:20px; border-radius:100%; border:solid 1px black; font-size:2px;\">"
								+ name + " </li>");
					} else {
						str.append("<li>" + "<img src=" + GloableSetting.getPath() + "/file/" + filename
								+ " alt=\"无\" +  style=\"width: 20px; height:2 0px; border-radius:100%; border:solid 1px black; font-size:2px;\">"
								+ name + " </li>");
					}
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		for (String key : keys) {
			try {
				webSocketMap.get(key).sendMessage("0_" + str);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				continue;
			}
		}
	}

	/**
	 *
	 * 
	 * @param message
	 * @param session 收到来自客户端的消息时调用，session保存发送消息的客户端信息
	 */
	@OnMessage
	public void onMessage(String message, Session session) {
		String messageUser = null;
		try {
			messageUser = URLDecoder
					.decode(session.getQueryString().substring(session.getQueryString().indexOf("=") + 1), "UTF-8");
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		Set<String> keys = webSocketMap.keySet();
		for (String key : keys) {
			if (!key.equals(messageUser)) {
				try {
					webSocketMap.get(key).sendMessage("1_" + nickNameMap.get(messageUser) + "说：" + message);
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
					continue;
				}
			}
		}

	}

	/**
	 * 发生错误时调用
	 * 
	 * @param session
	 * @param error
	 */
	@OnError
	public void onError(Session session, Throwable error) {

		error.printStackTrace();
	}

	public void sendMessage(String message) throws IOException {
		this.session.getBasicRemote().sendText(message);
		// this.session.getAsyncRemote().sendText(message);
	}

	public static synchronized Set<String> getUser() {

		return webSocketMap.keySet();

	}

}