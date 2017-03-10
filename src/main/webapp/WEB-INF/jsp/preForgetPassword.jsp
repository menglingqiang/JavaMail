<%@page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
  <title>用户登录页面</title>
  <script src="<%= basePath %>resources/script/jquery-1.8.0.min.js"></script>
  
</head>
<body >
	<form action="<%=basePath %>user/forgetPassword" method="get">
		请输入注册邮箱<input id="email" name="email" type="email"/></br>
		<input value="提交" type="submit"/>
	</form>

</body>


</html>