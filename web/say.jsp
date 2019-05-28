<%-- 
    Document   : say
    Created on : 2017-12-10, 14:48:06
    Author     : JasonLin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" errorPage="error.jsp"%>
<%@page import="java.util.*"%>
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
