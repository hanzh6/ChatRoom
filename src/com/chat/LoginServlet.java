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
//        String userid=new String();
        String first="1";
        boolean hasLog=false;
        if(request.getParameter("username")!=null){
            Name=request.getParameter("username");
            String pass=request.getParameter("password");
            String identity=request.getParameter("identity");
            try{
            	Class.forName("com.mysql.jdbc.Driver");
                conn=java.sql.DriverManager.getConnection("jdbc:mysql://172.18.187.10:3306/16337074_chat","user","123");
                preparedStmt=conn.prepareStatement("select username,password,identity from login where username=? and identity=?");
                preparedStmt.setString(1,Name);
                preparedStmt.setString(2,identity);
                sqlRst=preparedStmt.executeQuery();
                if(sqlRst.next()){
                    if(!pass.equals( new String(sqlRst.getString("password")))){
                        session.setAttribute("login_feedback","密码不正确！");
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
                    session.setAttribute("login_feedback","当前账户不存在！");
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
            promt="这是您第一次登录！";
        }else{
            for(int i=0;i<names.size();i++){
                String temp=(String)names.get(i);
                if(Name.equals(temp)){
                    promt="您已经登录过了！";
                    hasLog=true;
                    break;
                }
            }
            if(!hasLog){
                names.add(Name);
                session.setAttribute("lognames",names);
                promt="这是您第一次登录";
            }
        }
        request.setAttribute("username",Name);
//        response.sendRedirect("ChatRoom.jsp");
        
        getServletContext().getRequestDispatcher("/ChatRoom.jsp").forward(
                request, response);
        return ;
	}

}
