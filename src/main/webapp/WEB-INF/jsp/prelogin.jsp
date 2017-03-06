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
	<form action="<%=basePath %>user/login" method="post">
		<table>
		
			<tr>
				<td><input type="email" id="email" name="email"/>邮箱</td>
			</tr>
			
			<tr>
				<td><input type="password" id="password" name="password"/>用户密码</td>
			</tr>
			
			<tr>
				<td><input type="submit" value="登录"/></td>
			</tr>
		</table>
	</form>

</body>


</html>