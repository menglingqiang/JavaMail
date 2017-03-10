<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
  <title>用户注册页面</title>
</head>
<body >
	<h2>${user.name}你好</h2>
	<!-- user.status==0 没有激活提示激活，-->
	<c:if test="${user.status==0}">
		<h1>点击激活账户</h1>
		<h3><a href='activation?code=${user.code}'>http://localhost:8080/JavaMail/user/activation?code=${user.code}</a></h3>
	</c:if>
	
	<!-- <!-- user.status==1 已经激活提示进入聊天界面 -->
	<a value="进入聊天界面"/> -->
</body>


</html>