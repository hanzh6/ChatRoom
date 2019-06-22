package com.chat;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.util.*;
import java.io.IOException;
import java.sql.*;
 
 

/**
 * Servlet implementation class UploadServlet
 */
@WebServlet("/Chat")
public class LoginServlet extends HttpServlet{
	
	protected void doPost(HttpServletRequest request,
	        HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		request.setCharacterEncoding("UTF-8");
        Connection conn=null;
        PreparedStatement preparedStmt=null;
        ResultSet sqlRst=null;
        String promt=new String();
        String Name=new String();
        String filename=new String();
        String identity=new String();
//        String userid=new String();
        String first="1";
        boolean hasLog=false;
        if(request.getParameter("username")!=null){
            Name=request.getParameter("username");
            String pass=request.getParameter("password");
            identity=request.getParameter("identity");
            try{
            	Class.forName("com.mysql.jdbc.Driver");
                conn=GloableSetting.getDBConnect();
                preparedStmt=conn.prepareStatement("select username,password,identity,filename from login where username=? and identity=?");
                preparedStmt.setString(1,Name);
                preparedStmt.setString(2,identity);
                sqlRst=preparedStmt.executeQuery();
                if(sqlRst.next()){
                	filename = sqlRst.getString("filename");
                    if(!pass.equals( new String(sqlRst.getString("password")))){
                        session.setAttribute("login_feedback","瀵嗙爜涓嶆纭紒");
                        response.sendRedirect("login.jsp");
                        return ;
                    }else if(identity.equals("admin")){
                        session.setAttribute("login_feedback","");
                        response.sendRedirect("manage.jsp?verify=ok");
                        return ;
                    }else{
                        session.setAttribute("login_feedback","");
//                        userid=new String(sqlRst.getString("password"));
                    }
                }else{
                    session.setAttribute("login_feedback","褰撳墠璐︽埛涓嶅瓨鍦紒");
                    response.sendRedirect("login.jsp");
                    return ;
                }
            }catch(java.sql.SQLException | ClassNotFoundException e){
                System.out.println(e.toString());
            }finally{
                if(conn!=null)
					try {
						conn.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
            }
            session.setAttribute("last_succ",Name);
            first="1";
        }else{
            Name=(String)session.getAttribute("cur_name");
            if(Name == null){
                response.sendRedirect("login.jsp");
                return ;
            }
            first="0";
        }
        if(session.getAttribute("haslog") == "true")
        	hasLog = true ;
        ArrayList names=(ArrayList)session.getAttribute("lognames");
        if(names==null){
            names=new ArrayList();
            names.add(Name);
            session.setAttribute("lognames",names);
            promt="杩欐槸鎮ㄧ涓�娆＄櫥褰曪紒";
        }else{
            for(int i=0;i<names.size();i++){
                String temp=(String)names.get(i);
                if(Name.equals(temp)){
                    promt="鎮ㄥ凡缁忕櫥褰曡繃浜嗭紒";
                    hasLog=true;
                    break;
                }
            }
            if(!hasLog){
                names.add(Name);
                session.setAttribute("lognames",names);
                promt="杩欐槸鎮ㄧ涓�娆＄櫥褰�";
            }
        }
        request.setAttribute("username",Name);
        request.setAttribute("filename",filename);
//        response.sendRedirect("ChatRoom.jsp");
        
        getServletContext().getRequestDispatcher("/ChatRoom.jsp").forward(
                request, response);
        return ;
	}

}
