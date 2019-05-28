<%-- 
    Document   : out
    Created on : 2017-12-11, 13:22:19
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
            ArrayList names=(ArrayList)session.getAttribute("lognames");
            names.remove(username);
            response.sendRedirect("login.jsp");
        %>
    </body>
</html>
