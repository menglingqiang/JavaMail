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
	${user.name}:您好,你还没有激活，激活之后也什么也没什么用 </br>
	<a href='http://localhost:8080/JavaMail/user/activation?flag=false&code=${user.code}'>点击激活</a>
</body>


</html>