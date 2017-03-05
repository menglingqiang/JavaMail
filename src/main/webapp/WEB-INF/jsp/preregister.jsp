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
				<td><input type="text" id="name" name="name"/>用户昵称</td>
			</tr>
			
			<tr>
				<td><input type="password" id="password" name="password"/>用户密码</td>
			</tr>
			
			<tr>
				<td><input type="email" id="email" name="email"/>邮件地址</td>
			</tr>
			<tr>
				<td><input type="submit" value="注册"/></td>
			</tr>
		</table>
	</form>

</body>


</html>