# ChatRoom
多人聊天系统
嗯

——————————————v2————————————————  
1.去掉文件开头注释、copyright；更改数据库连接。
2.NewUser.jsp插入字段（23行）新增identity，默认插入staff组用户。
3.数据库表新增id字段作为主键，相关文件进行简单调整。
4.ChatRoom.jsp新增上传文件模块，新增文件fileupload.jsp，但是未实现。

			——czf

——————————————v3————————————————  
1.输错密码以后，弹窗显示“密码不正确”，刷新页面仍然显示“密码不正确”。
解决方法：客户端显示反馈信息以后就将其置为空。login.jsp中第54行<%=login_feedback %>后面新增代码
<%session.setAttribute("login_feedback",""); %>

2.直接用http://localhost:8080/ChatRoom/ChatRoom.jsp登录会以一个用户名为"null"的用户进入聊天室。
解决方法：增加判断若用户名为null重定向到login.jsp。ChatRoom.jsp中第61行增加
                if(Name == null)｛
                    response.sendRedirect("login.jsp");
	    return;
	｝

3.直接用http://localhost:8080/ChatRoom/manage.jsp登录能够直接看到用户列表。
解决方法：ChatRoom.jsp第43行更改代码response.sendRedirect("manage.jsp?verify=ok");（加上verify=ok)，manage.jsp第29行增加代码
String verify = request.getParameter("verify") ;    
            	if(verify==null)
                    response.sendRedirect("login.jsp");

4.登陆的时候有时候用户名、密码、验证码都正确但是进入错误界面
解决方法：去掉ChatRoom.jsp开头的errorPage="error.jsp"发现75行报错，将temp.equals(Name)改为Name.equals(temp) 。

5.修改密码以后再次登陆，在线列表有两个相同ID的人。
解决方法：ChangePass.jsp中第34行改为 response.sendRedirect("out.jsp?username="+Name);

6.修改密码失败以后，在线列表多出一个相同ID的人。
解决方法：ChangePass.jsp第30行增加代码session.setAttribute("haslog", "true") ;ChatRoom.jsp第66行增加代码if(session.getAttribute("haslog") == "true")
            	hasLog = true ;
				
			——czf
			
——————————————v4————————————————  
1.chatroom.jsp增加
	if(cur_Name==null){
                        cur_Name="";
                    }以免直接通过chatroom.jsp进入聊天室

2.reset按钮失效
新增js代码（164-166）：document.getElementById("send_reset").onclick=function(){
		    	document.getElementById('my_meg').value = "" ;
		    };

3.reset、send之后光标置于文本框中新增代码document.getElementById("my_meg").focus();
4.聊天内容太多不会自动换行
128、160行增加代码max-width:500px;height:auto;word-break:break-all;

5.聊天信息框内页面优化：新增chatroom.css新增.msgbox\.lbox\.rbox

6.聊天信息框自动下拉：129、163行新增代码document.getElementById('record').scrollTop = document.getElementById('record').scrollHeight ;

			——czf
——————————————v5———————————————— 

更新了changeinfo.jsp以及ChatRoom.jsp的内容，现在可以更新用户信息

——————————————v6———————————————— 

更新了changeinfo.jsp, ChatRoom.jsp, LoginServlet.java的内容，现在可以显示用户头像，ChatRoom.jsp的17行的String Name = (String) request.getAttribute("username");改为String Name = (String) request.getParameter("username");

——————————————v7————————————————

更新了ChatRoom.jsp和ChatRoom.css,UI设计更新
