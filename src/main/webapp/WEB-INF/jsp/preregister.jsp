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
	<form action="<%=basePath %>user/register" method="post">
		<table>
			<tr>
				<td>用户昵称 <input type="text" id="name" name="name"/></td>
			</tr>
			
			<tr>
				<td>用户密码 <input type="password" id="password" name="password"/></td>
			</tr>
			
			<tr>
				<td>邮件地址 <input type="email" id="email" name="email"/></td>
			</tr>
			<tr>
				<td><input type="submit" value="注册"/></td>
				<td><a href="<%=basePath %>user/preLogin"/>有账号，去登陆？ </td>
			</tr>
		</table>
	</form>

</body>


</html>