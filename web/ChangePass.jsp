<%@page contentType="text/html" pageEncoding="UTF-8" errorPage="error.jsp"%>
<%@page import="java.util.*"%>
<%@page import="com.chat.GloableSetting"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            request.setCharacterEncoding("UTF-8");
            Connection conn=null;
            PreparedStatement preparedStmt=null;
            String Name=new String();
            if(request.getParameter("username")!=null){
                Name=request.getParameter("username");
                String old_password=request.getParameter("old_password");
                String new_password=request.getParameter("new_password");
                try{
                    conn=GloableSetting.getDBConnect();
                    preparedStmt=conn.prepareStatement("update login set password=? where username=? and password=?");
                    preparedStmt.setString(1,new_password);
                    preparedStmt.setString(2,Name);
                    preparedStmt.setString(3,old_password);
                    int uu=preparedStmt.executeUpdate();
                    session.setAttribute("cur_name",Name);
                    if(uu==0){
                        session.setAttribute("change_feedback","修改密码失败，原密码错误！");
                        session.setAttribute("haslog", "true") ;
                        response.sendRedirect("ChatRoom.jsp");
                    }else{
                        session.setAttribute("change_feedback","");
                        session.setAttribute("login_feedback","修改成功，请重新登录！");
                        session.setAttribute("haslog", "false") ;
                        response.sendRedirect("out.jsp?username="+Name);
                    }
                }catch(java.sql.SQLException e){
                    out.println(e.toString());
                }finally{
                    if(conn!=null) conn.close();
                }
            }
        %>
    </body>
</html>
