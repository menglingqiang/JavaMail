<%@page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
  <title>用户注册页面</title>
  
</head>
<body >
	<h2>${user.name}你好</h2>
	<!-- 判断账户是否激活成功   -->
	
</body>


</html>