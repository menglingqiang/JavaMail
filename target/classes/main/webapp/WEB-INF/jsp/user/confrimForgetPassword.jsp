<%@page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
  <title>忘记邮箱提示界面</title>
  <script src="<%= basePath %>resources/script/jquery-1.8.0.min.js"></script>
  
</head>
<body >
		<h1>邮件发送成功，请到注册邮箱修改密码</h1>

</body>


</html>