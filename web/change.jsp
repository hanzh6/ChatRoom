<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
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
							头像<input type="file" name="file" id="file">
						</li>
                    </ul>
                    <div class="exp-btn-group">
                        <button type="submit" class="md-sub">确定</button>
                    </div>
                </form>
         <!--默认打开login.jsp页面-->
    </body>
</html>