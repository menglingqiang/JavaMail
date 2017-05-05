<%@page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!doctype html>
<html lang="zh">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>用户信息</title>
	<script src="<%=basePath%>resources/script/jquery-1.8.0.min.js"></script>
	<script type="text/javascript">
	
	</script>
</head>
<body>
	<form id="form1" action="" enctype="multipart/form-data" method="post">
		${user.name}:您好 ${messageList}
	</form>
</body>
</html>