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
            String Name=new String();
            if(request.getParameter("username")!=null){
                Name=request.getParameter("username");
                try{
                    conn=java.sql.DriverManager.getConnection("jdbc:mysql://172.18.187.10:3306/16337074_chat","user","123");
                    preparedStmt=conn.prepareStatement("delete from login where username=?");
                    preparedStmt.setString(1,Name);
                    int uu=preparedStmt.executeUpdate();
                    if(uu==0){
                        session.setAttribute("manage_op_feedback","操作失败，请重试！");
                        response.sendRedirect("manage.jsp");
                    }else{
                        session.setAttribute("manage_op_feedback","操作成功！");
                        response.sendRedirect("manage.jsp");
                    }
                    response.sendRedirect("manage.jsp");
                }catch(java.sql.SQLException e){
                    out.println(e.toString());
                }finally{
                    if(conn!=null) conn.close();
                }
            }
        %>
    </body>
</html>
