<%-- 
    Document   : query
    Created on : 2017-12-20, 12:57:28
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
        <link rel="stylesheet" href="./css/modal.css"/>
        <link rel="stylesheet" href="./css/manage.css"/>
    </head>
    <body>
        <h1>用户信息表</h1>
        <div class="content">
            <div class="top_option">
                <a class="md-trigger"  data-modal="modal-1" option="new" style="margin-right: 3px;">录入</a>
                <a class="md-trigger"  data-modal="modal-1" option="query">查询</a>
            </div>
            <table>
                <tr>
                    <th width="150px;">ID</th>
                    <th width="350px;">用户名</th>
                    <th width="350px;">密码</th>
                    <th width="110px;">操作</th>
                </tr>
        <%
            request.setCharacterEncoding("UTF-8");
            Connection conn=null;
            Statement stat =null;
            ResultSet sqlRst =null;
            String userid=request.getParameter("userid");
            String username=request.getParameter("username");
            String userpass=request.getParameter("password");
            try{
                conn=java.sql.DriverManager.getConnection("jdbc:mysql://localhost/javaee","root","971230");
                StringBuilder sql=new StringBuilder("select * from login where 1=1");
                if(!userid.isEmpty()){
			sql.append(" and id like '%"+userid+"%' ");
		}
		if(!username.isEmpty()){
			sql.append(" and username like '%"+username+"%' ");
		}
		if(!userpass.isEmpty()){
			sql.append(" and password like '%"+userpass+"%' ");
		}
                sql.append(";");
                stat=conn.createStatement();
                sqlRst=stat.executeQuery(sql.toString());
                while(sqlRst.next()){
        %>
                <tr>
                    <td><%=sqlRst.getString("id")%></td>
                    <td><%=sqlRst.getString("username")%></td>
                    <td><%=sqlRst.getString("password")%></td>
                    <td>
                        <a href="#" class="md-trigger" option="modify" data-modal="modal-1" user-id="<%=sqlRst.getString("id")%>" user-name="<%=sqlRst.getString("username")%>" user-pass="<%=sqlRst.getString("password")%>">修改</a>
                        <form action="del.jsp" method="post" style="display: inline-block;">
                            <input type="text" name="username" style="display: none;" value="<%=sqlRst.getString("username")%>">
                            <button type="submit" class="op_btn" onclick="return confirm('您确认要执行删除吗?')">删除</button>
                        </form>
                    </td>
                </tr>
            <%}%>
            </table>
        </div>
        <%  
            }catch(java.sql.SQLException e){
                out.println(e.toString());
            }finally{
                if(conn!=null) conn.close();
            }
         %>
    <div class="md-modal md-effect-1" id="modal-1"><!--弹出框模板-->
        <div class="md-content">
            <h3>注册新用户</h3>
            <form action="NewUser.jsp" method="post">
                <ul>
                    <li class="input-wrap" style="display: none;" id="userid_wrap">
                        <input type="text"  placeholder="ID" name="userid" id="userid">
                    </li>
                    <li class="input-wrap">
                        <input type="text" placeholder="用户名" name="username" id="username">
                    </li>
<!--                <li class="input-wrap">
                        <input required type="text" placeholder="手机号（用于找回密码）" name="phone">
                    </li>-->
                    <li class="input-wrap">
                        <input type="text" placeholder="密码" name="password" id="userpass">
                    </li>
                </ul>
                <div class="exp-btn-group">
                    <button type="submit" class="md-sub">确定</button>
                </div>
            </form>
        </div>
    </div>
    <div class="md-overlay"></div>
    <canvas id="Mycanvas" style="z-index: -1;position:absolute;top: 0;width: 100%;height: 100%;"></canvas>
    <script src="./js/jquery.min.js"></script>
    <script src="./js/canvas.js"></script>
    <script src="./js/layer.js"></script>
    <script src="./js/manage.js"></script>
    </body>
</html>