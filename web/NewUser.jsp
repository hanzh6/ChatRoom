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
            String requrl=request.getHeader("Referer");//判断请求来源
            if(request.getParameter("username")!=null){
                Name=request.getParameter("username");
                String password=request.getParameter("password");
                try{
                	Class.forName("com.mysql.jdbc.Driver");
                    conn=GloableSetting.getDBConnect();
                    preparedStmt=conn.prepareStatement("insert into login(identity,username,password)value(?,?,?)");
                    preparedStmt.setString(1,"staff");
                    preparedStmt.setString(2,Name);
                    preparedStmt.setString(3,password);
                    int uu=preparedStmt.executeUpdate();
                    session.setAttribute("cur_name",Name);
                    if(uu==0){
                        if((requrl.indexOf("login.jsp"))!=-1){
                            session.setAttribute("login_feedback","注册失败，当前用户名已存在");
                            response.sendRedirect("login.jsp");
                        }else{
                            session.setAttribute("manage_op_feedback","操作失败，请重试！");
                            response.sendRedirect("manage.jsp?verify=ok");
                        }
                    }else{
                        if((requrl.indexOf("login.jsp"))!=-1){
                            session.setAttribute("login_feedback","注册成功，可以登录啦！");
                            response.sendRedirect("login.jsp");
                        }else{
                            session.setAttribute("manage_op_feedback","操作成功！");
                            response.sendRedirect("manage.jsp?verify=ok");
                        }
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
