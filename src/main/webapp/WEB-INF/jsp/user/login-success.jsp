<%@page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
  <title>用户登录页面</title>
  
</head>
<body >
	${user.name}:您好 
	<a href='http://localhost:8080/JavaMail/user/activation?flag=false&code=${user.code}'>激活</a>
</body>


</html>