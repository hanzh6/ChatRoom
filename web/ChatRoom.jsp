<%-- 
    Document   : ChatRoom
    Created on : 2017-12-10, 14:47:59
    Author     : JasonLin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" errorPage="error.jsp"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="pragma" content="no-cache">
        <title>聊天室</title>
        <link rel="stylesheet" href="./css/modal.css"/>
        <link rel="stylesheet" href="./css/chatroom.css"/>
    </head>
    <body>
        <div class="content">
            <p class="subtitle pulse animated">聊天室</p>
            <%
//          由于用户量较小，字段相同，且为了方便管理，登录只建一个数据表
            request.setCharacterEncoding("UTF-8");
            Connection conn=null;
            PreparedStatement preparedStmt=null;
            ResultSet sqlRst=null;
            String promt=new String();
            String Name=new String();
//            String userid=new String();
            String first="1";
            if(request.getParameter("username")!=null){
                Name=request.getParameter("username");
                String pass=request.getParameter("password");
                String identity=request.getParameter("identity");
                try{
                	Class.forName("com.mysql.jdbc.Driver");
                    conn=java.sql.DriverManager.getConnection("jdbc:mysql://172.18.187.10:53306/16337074_chat","user","123");
                    preparedStmt=conn.prepareStatement("select username,password,identity from login where username=? and identity=?");
                    preparedStmt.setString(1,Name);
                    preparedStmt.setString(2,identity);
                    sqlRst=preparedStmt.executeQuery();
                    if(sqlRst.next()){
                        if(!pass.equals( new String(sqlRst.getString("password")))){
                            session.setAttribute("login_feedback","密码不正确！");
                            response.sendRedirect("login.jsp");
                        }else if(identity.equals("admin")){
                            session.setAttribute("login_feedback","");
                            response.sendRedirect("manage.jsp");
                        }else{
                            session.setAttribute("login_feedback","");
//                            userid=new String(sqlRst.getString("password"));
                        }
                    }else{
                        session.setAttribute("login_feedback","当前账户不存在！");
                        response.sendRedirect("login.jsp");
                    }
                }catch(java.sql.SQLException e){
                    out.println(e.toString());
                }finally{
                    if(conn!=null) conn.close();
                }
                session.setAttribute("last_succ",Name);
                first="1";
            }else{
                Name=(String)session.getAttribute("cur_name");
                first="0";
            }
            boolean hasLog=false;
            ArrayList names=(ArrayList)session.getAttribute("lognames");
            if(names==null){
                names=new ArrayList();
                names.add(Name);
                session.setAttribute("lognames",names);
                promt="这是您第一次登录！";
            }else{
                for(int i=0;i<names.size();i++){
                    String temp=(String)names.get(i);
                    if(temp.equals(Name)){
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
            String change_feedback=(String)session.getAttribute("change_feedback");
            %>
            <div id="none" class="none"><%=promt%></div>
            <div id="none2" class="none"><%=first%></div>
            <div id="none3" class="none"><%=change_feedback%></div>
            <div class="main">
                <div class="room">
                    <p class="cur_user">欢迎您，<%=Name%></p>
                    <div class="record">
                        <% ArrayList chat_records=new ArrayList(); 
                        chat_records=(ArrayList)application.getAttribute("say");
                        if(chat_records!=null){
                            for (int i=0;i<chat_records.size();i++)
                            {
                                String temp_record=(String)chat_records.get(i);
                                out.println(temp_record);
                                out.println("<br/>");
                            }
                        }
                        %>
                    </div>
                    <form action="say.jsp" method="post">
                        <input type="text" style="display: none;" value="<%=Name%>" name="username">
                        <textarea rows="3" autofocus="autofocus" name="my_meg" required="required"></textarea>
                        <div style="overflow: hidden;">
                            <button type="submit" id="send_meg">发送</button>
                            <button type="reset">重置</button>
                        </div>
                    </form>
                </div>
                <div class="member">
                    <h4 style="font-size:15px;font-weight:400;">当前在线人数：<%=names.size()%></h4>
                    <ul>
                    <%for(int i=0;i<names.size();i++){
                        String temp=(String)names.get(i);
                        out.println("<li class='member_li'>"+temp+"</li>");
                    }
                    %>
                    </ul>
                </div>
                <div class="change_btn">
                    <a type="submit" class="md-trigger" data-modal="modal-1">修改密码</a>
                </div>
                <form action="out.jsp" method="post" id="out_form" class="top_form">
                    <input type="text" style="display: none;" value="<%=Name%>" name="username">
                    <button type="submit" id="change">退出</button>
                </form>
                <form action="dispose.jsp" method="post" id="dispose_form" class="top_form">
                    <input type="text" style="display: none;" value="<%=Name%>" name="username">
                    <button type="submit" id="out">退出并销毁</button>
                </form>
            </div>
            <p class="copy fadeIn animated">Copyright © 2017.JasonLin</p>
        </div>
        <div class="md-modal md-effect-1" id="modal-1">
            <div class="md-content">
                <h3>修改密码</h3>
                <form action="ChangePass.jsp" method="post">
                    <ul>
                        <li class="input-wrap" style="display: none;">
                            <input type="text" name="username" value="<%=Name%>">
                        </li>
                        <li class="input-wrap">
                            <input required type="text" placeholder="原始密码" name="old_password">
                        </li>
                        <li class="input-wrap">
                            <input required type="password" placeholder="新密码" name="new_password">
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
    <script src="./js/chatroom.js"></script>
    </body>
</html>
