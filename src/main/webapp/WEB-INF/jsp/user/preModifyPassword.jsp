<%@page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
  <title>用户修改信息页面</title>
  <script src="<%= basePath %>resources/script/jquery-1.8.0.min.js"></script>
  
</head>
<body >
	<form action="<%=basePath %>user/modifyPassword" method="get">
		请输入新密码<input id="password" name="password" type="text"/></br>
		<input id="email" name="email"  value="${email}" type="hidden"/>
		<input value="提交" type="submit"/>
	</form>

</body>


</html>