<%@page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
  <title>用户注册成功过度页面</title>
  <script>
	var cnt = 2;
	function lod(){
	if(cnt < 0){
	window.location.href = 'login?user=${user}';//两秒后跳转到登录界面
	}else{
	document.getElementById("showTime").innerHTML = "页面<font color=red>" + cnt + "</font>秒后跳转";
	cnt--;
	}
	setTimeout("lod()",1000);//每过一分钟执行一次lod方法
	}
	</script>

</head>

<body onload="lod()">
	激活账号已经发送的您的邮箱请查收
	<div id="showTime"></div>
</body>

</html>