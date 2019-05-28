<%-- 
    Document   : login
    Created on : 2017-12-10, 14:47:44
    Author     : JasonLin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" errorPage="error.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <meta http-equiv="Pragma" content="no-cache">
	<meta name="renderer" content="webkit">
        <title>聊天室</title>
        <link rel="stylesheet" href="css/modal.css">
        <link rel="stylesheet" href="css/login.css">
    </head>
    <body>
        <div class="content">
            <p class="subtitle pulse animated">聊天室</p>
            <form method="post" action="ChatRoom.jsp" class="login_form">
                <div class="index-tab-nav clearfix fadeInDown animated">
                    <div class="nav-slider clearfix">
                        <input type="radio" name="identity" id="staff" value="staff" checked="checked">
                        <label for="staff" class="active">用户</label>
                        <input type="radio" name="identity" id="admin" value="admin">
                        <label for="admin">管理员</label>
                        <span class="nav-slider-bar"></span>
                    </div>
                </div>
                <%
                    request.setCharacterEncoding("UTF-8");
                    String login_feedback=(String)session.getAttribute("login_feedback");
                    String cur_Name=(String)session.getAttribute("last_succ");
                    if(cur_Name==null){
                        cur_Name="";
                    }
                %>
                <div class="input-group fadeInDown animated">
                    <div class="input-wrap">
                        <input required type="text" placeholder="用户名" value="<%=cur_Name%>" name="username" class="name_input">
                    </div>
                    <div class="input-wrap">
                        <input required type="password" placeholder="密码" name="password">
                    </div>
                    <div class="input-wrap">
                        <input required type="text" placeholder="验证码" maxlength="5" name="verify" class="code_input">
                        <div class="code"></div>
                    </div>
                </div>
                <div class="button-wrap fadeInDown animated">
                    <button class="sign-button" type="submit">登录</button>
                </div>
            </form>
            <div class="signin-misc-wrapper clearfix">
                <a href="#" class="md-trigger" data-modal="modal-1">注册新用户</a>
                <!--<a href="#" class="unable-login">忘记密码？</a>-->
            </div>
            <p class="copy fadeIn animated">Copyright © 2017.JasonLin</p>
            <p style="display: none;" id="login_feedback"><%=login_feedback%></p>
	</div>
        <div class="md-modal md-effect-1" id="modal-1">
            <div class="md-content">
                <h3>注册新用户</h3>
                <form action="NewUser.jsp" method="post">
                    <ul>
                        <li class="input-wrap">
                            <input required type="text" placeholder="用户名" name="username">
                        </li>
<!--                    <li class="input-wrap">
                            <input required type="text" placeholder="手机号（用于找回密码）" name="phone">
                        </li>-->
                        <li class="input-wrap">
                            <input required type="password" placeholder="密码" name="password">
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
	<script src="./js/login.js"></script>
    </body>
</html>
