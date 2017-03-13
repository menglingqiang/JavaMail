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
  <script src="<%= basePath %>resources/script/jquery-1.8.0.min.js"></script>
  <script >
  	function activa(code)
  	{
  		//alert(code);
  		$.ajax({
            type: "get",
            url: "activation?flag=false&code="+code,
            contentType: "application/json; charset=utf-8",
            dataType: "text",
            success: function (data) {
            }
        });  
  		document.getElementById("activaButton").type="hidden";
  		document.getElementById("showWord").innerHTML = "请到您的邮箱激活账户";
  	}
  	function alerttest()
  	{
  		alert("testboom");
  	}
  </script>
</head>
<body>
	<h2>${user.name}你好</h2>
	<!-- user.status==0 没有激活提示激活，-->
	<c:if test="${user.status!=1}">
		<h1>您还没有激活点击发送邮件激活</h1>
		<%-- <h3><a id = "alertWord" href='activation?flag=false&code=${user.code}' >我要激活</a></h3> --%>
		<input id="activaButton" name="activaButton" type="button"   onclick="javascript:activa('${user.code}');" value="激活账户"><!-- user.code 要用''包住不然那有错误 -->
		<div id="showWord"></div>
	</c:if>
	<c:if test="${user.status==1}">
		<h1>我还没想好激活之后干什么。。。。</h1>
	</c:if>
	<!-- <!-- user.status==1 已经激活提示进入聊天界面 -->
</body>


</html>