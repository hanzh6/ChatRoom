<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="com.chat.GloableSetting"%>
<%@page import="java.sql.*"%>
<%@ page import="java.io.*, java.util.*,org.apache.commons.io.*"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.apache.commons.fileupload.disk.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.*"%>
<%@page import="com.chat.GloableSetting"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%request.setCharacterEncoding("UTF-8");%><%
	        boolean isMultipart = ServletFileUpload.isMultipartContent(request);
        	String nickname=null;
        	String phone_number=null;
        	String sign=null;
        	String username = null;
        	String filename = null;
    		Connection conn=null;
            PreparedStatement preparedStmt=null;
	    	if (isMultipart){
	    		FileItemFactory factory = new DiskFileItemFactory();
	    		//factory.setSizeThreshold(yourMaxMemorySize); //设置使用的内存最大值
	    		//factory.setRepository(yourTempDirectory); //设置文件临时目录
	    		ServletFileUpload upload = new ServletFileUpload(factory);
	    		//upload.setSizeMax(yourMaxRequestSize); //允许的最大文件尺寸
	    		List items = upload.parseRequest(request);
	    		for (int i = 0; i < items.size(); i++) {
	    			FileItem fi = (FileItem) items.get(i);
	    			if (fi.isFormField()) {//如果是表单字段
	    				if(fi.getFieldName().equals("username")){
	    					username = fi.getString("utf-8");
	    				}
	    				else if(fi.getFieldName().equals("nickname")){
	    					nickname = fi.getString("utf-8");
	    				}
	    				else if(fi.getFieldName().equals("phone_number")){
	    					phone_number = fi.getString("utf-8");
	    				}
	    				else if(fi.getFieldName().equals("sign")){
	    					sign = fi.getString("utf-8");
	    				}
	    			}
	    			else {
	    				//如果是文件
	    				DiskFileItem dfi = (DiskFileItem) fi;
	    				if (!dfi.getName().trim().equals("")) {//getName()返回文件名称或空串
	    					String fileName=request.getServletContext().getRealPath("/file/");
	    					if (!(new java.io.File(fileName).isDirectory())){
	    						new java.io.File(fileName).mkdir();
	    					}
	    					String type = FilenameUtils.getExtension(dfi.getName());
	    					if (type.equals("jpeg") || type.equals("png") ||
	    						type.equals("jpg") || type.equals("gif") || 
	    						type.equals("ico") ||type.equals("bmp")){
	    						fileName=request.getServletContext().getRealPath("/file/") + username+"."+FilenameUtils.getExtension(dfi.getName());
		    					filename = username+"."+FilenameUtils.getExtension(dfi.getName());
		    					
		    					dfi.write(new File(fileName));
	    					}
	    					else{
	    						out.println("修改失败，头像类型只能是.jpeg, .png, .jpg, .gif, .ico, .bmp");
	    						return;
	    					}
	    				} //if
	    			} //if
	    		} //for
	    	}  
            try{
                conn=GloableSetting.getDBConnect();
                preparedStmt=conn.prepareStatement("update login set nickname=?,phone_number=?,sign=?,filename=? where username=?");
                preparedStmt.setString(1,nickname);
                preparedStmt.setString(2,phone_number);
                preparedStmt.setString(3,sign);
                preparedStmt.setString(4,filename);
                preparedStmt.setString(5,username);
                int uu=preparedStmt.executeUpdate();
                if(uu==0){
                    session.setAttribute("manage_op_feedback","操作失败，请重试！");
                    response.sendRedirect("manage.jsp?verify=ok");
                }else{
                    session.setAttribute("manage_op_feedback","操作成功！");
                    out.println("操作成功！");
                }
            }catch(java.sql.SQLException e){
                out.println(e.toString());
            }finally{
                if(conn!=null) conn.close();
            }
        %>
    </body>
</html>
