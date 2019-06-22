<%@page import="com.chat.GloableSetting"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8" errorPage="error.jsp"%>
<%@page import="java.util.*"%>
<%@page import="com.chat.GloableSetting"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<title>聊天室</title>
<link rel="stylesheet" href="./css/modal.css" />
<link rel="stylesheet" href="./css/chatroom.css" />
</head>
<body>
	<div class="content">
		<p class="subtitle pulse animated">聊天室</p>
		<%
			String Name = (String) request.getParameter("username");
			String fname=(String) request.getAttribute("filename");
			String fileName = new String();
			if(fname == null){
				fileName=GloableSetting.getPath()+("/js/theme/default/head_1.png");
			}
			else{
				fileName=GloableSetting.getPath() + "/file/"+(String) request.getAttribute("filename");
			}
			
			
			if(Name == null){
				response.sendRedirect("login.jsp") ;
				return ;
			}
			ArrayList names = (ArrayList) session.getAttribute("lognames");
			String change_feedback = (String) session.getAttribute("change_feedback");
		%>
		
		<div id="none" class="none">欢迎你</div>
		<div id="none2" class="none">欢迎你</div>
		<div id="none3" class="none"><%=change_feedback%></div>
		<div class="main">
			<div class="room">
				<p class="cur_user">
					欢迎您，<img src="<%=fileName%>" width="42" height="42"><%=Name%></p>
				<input id="username" hidden="hidden" value=${username } type="text" />
				<div class="record" id="record"></div>
				<input type="text" style="display: none;" value="<%=Name%>"
					name="username">
				<textarea rows="3" autofocus="autofocus" id="my_meg" class="msg_input"
					required="required"></textarea>
				<div style="overflow: hidden;background-color:black;">
					<button class="button1" type="submit" id="send_meg">发送</button>
					<button class="button1" type="reset" id="send_reset">重置</button>
				</div>
			</div>
			<div class="member">
				<h4 id="userNum" style="font-size: 15px; font-weight: 400;">
					当前在线人数：<%=names.size()%></h4>
				<ul id = "userlist">
					
				</ul>
			</div>
			<div class="change_btn">
				<a type="submit" class="md-trigger" data-modal="modal-1">修改密码</a>
			</div>
			<form action="change.jsp" method="post" id="change_info" class="change_form" target="_blank">
				<input type="text" style="display: none;" value="<%=Name%>" name="username">
				<button type="submit" id="out">修改个人信息</button>
			</form>
			<form action="out.jsp" method="post" id="out_form" class="top_form">
				<input type="text" style="display: none;" value="<%=Name%>"
					name="username">
				<button type="submit" id="change" class="md-trigger1">退出</button>
			</form>
			<form action="dispose.jsp" method="post" id="dispose_form"
				class="top_form">
				<input type="text" style="display: none;" value="<%=Name%>"
					name="username">
				<button type="submit" id="out" class="md-trigger1">退出并销毁</button>
			</form>
		</div>
	</div>
	<div class="md-modal md-effect-1" id="modal-1">
		<div class="md-content">
			<h3>修改密码</h3>
			<form action="ChangePass.jsp" method="post">
				<ul>
					<li class="input-wrap" style="display: none;"><input
						type="text" name="username" value="<%=Name%>"></li>
					<li class="input-wrap"><input required type="text"
						placeholder="原始密码" name="old_password"></li>
					<li class="input-wrap"><input required type="password"
						placeholder="新密码" name="new_password"></li>
				</ul>
				<div class="exp-btn-group">
					<button type="submit" class="md-sub">确定</button>
				</div>
			</form>
		</div>
	</div>
	<div class="md-overlay"></div>
	<canvas id="Mycanvas"
		style="z-index: -1; position: absolute; top: 0; width: 100%; height: 100%;"></canvas>
	<script src="./js/jquery.min.js"></script>
	<script src="./js/canvas.js"></script>
	<script src="./js/layer.js"></script>
	<script src="./js/chatroom.js"></script>
	<script type="text/javascript">
		// setInterval("getuser()", 1000)
		// function getuser() {
		// 	$.ajax({
		// 		type:'get',
		// 		url:'RoomUser',
		// 		async:false,
		// 		error:function(data){
		// 			alert('发生错误');
		// 		},
		// 		success:function(data){
		// 			console.log(data);
		// 			$('#userlist').html(data);
		// 		}
				
		// 	});
		// }
		 var websocket = null;
		    var userName =document.getElementById('username').value;
		    //判断当前浏览器是否支持WebSocket
		    if ('WebSocket' in window) {
		        websocket = new WebSocket("<%=GloableSetting.getSocket()%>"+ "/websocket?username="+userName);
		    }
		    else {
		        alert('当前浏览器 Not support websocket')
		    }

		    //连接发生错误的回调方法
		    websocket.onerror = function () {
		        setMessageInnerHTML("WebSocket连接发生错误");
		    };

		    //连接成功建立的回调方法
		    websocket.onopen = function () {
		        setMessageInnerHTML("连接成功，可以开始聊天了");
		    }
		    //接收到消息的回调方法
		    websocket.onmessage = function (event) {
					var data = event.data;
					if (data[0] === '1'){
						document.getElementById('record').innerHTML+= "<p class='msgbox lbox'>"+data.slice(2)+"</p></br>";
						document.getElementById('record').scrollTop = document.getElementById('record').scrollHeight ;
					} else {
						var data = data.slice(2);
						$('#userlist').html(data);
						var size = document.getElementById('userlist').children.length;
						document.getElementById('userNum').innerText = "当前在线人数:"+size;
					}
		    }

		    //连接关闭的回调方法
		    websocket.onclose = function () {
		        setMessageInnerHTML("WebSocket连接关闭");
		    }

		    //监听窗口关闭事件，当窗口关闭时，主动去关闭websocket连接，防止连接还没断开就关闭窗口，server端会抛异常。
		    window.onbeforeunload = function () {
		        closeWebSocket();
		    }

		    //将消息显示在网页上
		    function setMessageInnerHTML(innerHTML) {
		        document.getElementById('record').innerHTML= innerHTML + '<br/>';
		    }

		    //关闭WebSocket连接
		    function closeWebSocket() {
		        websocket.close();
		    }
		    document.getElementById("send_meg").onclick=sendMessage;
		    function sendMessage () {
		    	  var message = document.getElementById('my_meg').value;
		    	  document.getElementById('my_meg').value="";
		          if(message==="" || message==='\n' ){
			            layer.msg('消息不能为空哦', {icon: 5});
			            return ;
			      }
		          websocket.send(message);
		          // document.getElementById('record').innerHTML+= "<p class='msgbox rbox'>我说:"+message+"</p></br>";
		          document.getElementById('record').innerHTML+= "<p class='msgbox rbox'>我说:"+message+"</p>";
		          document.getElementById("my_meg").focus();
		          document.getElementById('record').scrollTop = document.getElementById('record').scrollHeight ;
		    };
		    document.onkeydown = function (e) { // 回车提交表单
		    	// 兼容FF和IE和Opera
		    	    var theEvent = window.event || e;
		    	    var code = theEvent.keyCode || theEvent.which || theEvent.charCode;
		    	    if (code == 13) {
		    	    	sendMessage();
		    	    }
		    	}
		    document.getElementById("send_reset").onclick=function(){
		    	document.getElementById('my_meg').value = "" ;
		        document.getElementById("my_meg").focus();
		    };
	</script>
</body>
</html>
