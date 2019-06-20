<%@ page pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<%@ page import="java.io.*, java.util.*,org.apache.commons.io.*"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.apache.commons.fileupload.disk.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.*"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>JSP Page</title>
	</head>
	<body><%request.setCharacterEncoding("utf-8");%><%
			boolean isMultipart = ServletFileUpload.isMultipartContent(request);
        	if (isMultipart){
        		FileItemFactory factory = new DiskFileItemFactory();
        		//factory.setSizeThreshold(yourMaxMemorySize); //设置使用的内存最大值
        		//factory.setRepository(yourTempDirectory); //设置文件临时目录
        		ServletFileUpload upload = new ServletFileUpload(factory);
        		//upload.setSizeMax(yourMaxRequestSize); //允许的最大文件尺寸
        		List items = upload.parseRequest(request);
        		String username = null ;
        		String my_meg = null ;
        		for (int i = 0; i < items.size(); i++) {
        			FileItem fi = (FileItem) items.get(i);
        			if (fi.isFormField()) {//如果是表单字段
        				if(fi.getFieldName().equals("username")){
        					username = fi.getString("utf-8");
        				}
        			}
        			else {
        				//如果是文件
        				DiskFileItem dfi = (DiskFileItem) fi;
        				if (!dfi.getName().trim().equals("")) {//getName()返回文件名称或空串
        					String fileName=application.getRealPath("/file")
        					+ System.getProperty("file.separator")
        					+ username + '_' + FilenameUtils.getName(dfi.getName());
        					my_meg=username+ " : " ;
        					dfi.write(new File(fileName));
        					my_meg = my_meg + "<br><a href='"+fileName+"'>"+username+'_'+FilenameUtils.getName(dfi.getName())+"</a>" ;
        					ArrayList chat_records=(ArrayList)application.getAttribute("say");
        			        if(chat_records==null){
        			            chat_records=new ArrayList();
        			        }
        			        chat_records.add(my_meg);
        			        application.setAttribute("say",chat_records);
        			        session.setAttribute("cur_name",username);
        			        response.sendRedirect("ChatRoom.jsp");
        				} //if
        			} //if
        		} //for
        	}
        %>
	</body>
</html>