<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8" errorPage="error.jsp"%>
<%@ page import="java.io.*, java.util.*,org.apache.commons.io.*"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.apache.commons.fileupload.disk.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            request.setCharacterEncoding("UTF-8");
	      	String username=new String (request.getParameter("username"));
	        String my_meg=new String (request.getParameter("my_meg"));
	        my_meg=username+" ： "+my_meg;
	        ArrayList chat_records=(ArrayList)application.getAttribute("say");
	        if(chat_records==null){
	            chat_records=new ArrayList();
	        }
	        chat_records.add(my_meg);
	        application.setAttribute("say",chat_records);
	        session.setAttribute("cur_name",username);
	        response.sendRedirect("ChatRoom.jsp");
        %>
    </body>
</html>
