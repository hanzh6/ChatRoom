<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="./css/modal.css" />
		<link rel="stylesheet" href="./css/chatroom.css" />
		<style>
		#hahahaha{
			padding: 50px;
			width:600px;
			margin:0 auto;
		}
		.input-wrap{
			margin:20px 0 20px;
			background-color:rgba(255,255,255,0.8);
		}
		.input-wrap input{
			background-color:rgba(255,255,255,0.8);
			color:black;
		}
		body{
			background: url("./images/599133.jpg") no-repeat;
			background-size: 100% 100%;
		}
		input::-webkit-input-placeholder{
  			 color:#808080; 
		}
		</style>
    </head>
    <body>
          <div id="hahahaha">
                <%
			String Name = (String) request.getParameter("username");
			
		%>
                <h3>修改个人信息</h3>
                <form action="changeinfo.jsp" method="post"  enctype="multipart/form-data">
                    <ul>
                        <li class="input-wrap" style="display: none;">
                            <input type="text" name="username" value="<%=Name%>">
                        </li>
                        <li class="input-wrap">
                            <input required type="text" placeholder="昵称" name="nickname">
                        </li>
                        <li class="input-wrap">
                            <input required type="text" placeholder="电话号码" name="phone_number">
                        </li>
                        <li class="input-wrap">
                            <input required type="text" placeholder="签名" name="sign">
                        </li>
                        <li class="input-wrap">
							选择头像<input  type="file" name="file" id="file">
						</li>
                    </ul>
                    <div class="exp-btn-group">
                        <button type="submit" class="md-sub">确定</button>
                    </div>
                </form>
          </div>
         <!--默认打开login.jsp页面-->
    </body>
</html>
