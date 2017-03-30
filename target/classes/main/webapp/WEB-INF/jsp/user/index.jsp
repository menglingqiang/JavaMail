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
	<a href="<%=basePath %>user/preLogin">登录</a>
	<%-- "<%=basePath %>resources/js/common/jquery-1.8.0.min.js" --%>
	<a href="<%=basePath %>user/preRegister">注册</a>

</body>


</html>