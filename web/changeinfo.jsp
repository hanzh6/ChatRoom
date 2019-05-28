<%-- 
    Document   : changeinfo
    Created on : 2017-12-19, 20:55:52
    Author     : JasonLin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" errorPage="error.jsp"%>
<%@page import="java.util.*"%>
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
            String userid=new String();
            if(request.getParameter("userid")!=null){
                userid=request.getParameter("userid");
                String username=request.getParameter("username");
                String password=request.getParameter("password");
                try{
                    conn=java.sql.DriverManager.getConnection("jdbc:mysql://localhost/javaee","root","971230");
                    preparedStmt=conn.prepareStatement("update login set username=?,password=? where id=?");
                    preparedStmt.setString(1,username);
                    preparedStmt.setString(2,password);
                    preparedStmt.setString(3,userid);
                    int uu=preparedStmt.executeUpdate();
                    if(uu==0){
                        session.setAttribute("manage_op_feedback","操作失败，请重试！");
                        response.sendRedirect("manage.jsp");
                    }else{
                        session.setAttribute("manage_op_feedback","操作成功！");
                        response.sendRedirect("manage.jsp");
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
