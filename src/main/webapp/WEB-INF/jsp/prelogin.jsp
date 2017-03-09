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
  <script type="text/javascript">
  	function reloadImageCode()
  	{
  		var date = new Date();//不传入一个date的话浏览器认为这个请求是没有必要的，不会刷新页面
  		document.getElementById("imageCode").src="<%=basePath %>user/validate?"+date;
  		//var age = ${picCode};
  		//alert(age);
  	}
  	
  	function checkPicCode()
  	{
  		var inputCode = document.getElementById("inputCode").value.toUpperCase();//变成大写的，不区分大小写，并且后台写入的值是大写的
  		
  		//inputCode 都变成大写的
  		$.ajax({
            type: "Get",
            url: "getPicCode",
            contentType: "application/json; charset=utf-8",
            dataType: "text",
            success: function (data) {
                if(inputCode==data)
                	alert("yes");//画个√号
                else
                	alert("no"); //画个×号
            }
        }); 
  		var picCode = "${picCode}";//可能是浏览器觉得这个数值是一样的所以就不在从后台取值
  	}
  	function checkInputCode()
  	{
  		var inputCode = document.getElementById("inputCode");
  		
  		if(inputCode.value.length>=4)
		{
  			inputCode.value=inputCode.value.substr(inputCode.value.length-4,inputCode.value.length);//输入超过4位，后面的数字自动顶上前面的数字
  			checkPicCode();
		}
  	}
  	window.onload = function(){
  		reloadImageCode();
  		//document.getElementById("picCode").value="{picCode}";
  	}
  	
  </script>
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
				<!-- input只可以输入4位 -->
				<td><input id="inputCode" name="inputCode" type="text"  oninput="javascript:checkInputCode()" placeholder="请输入4位验证码"/></td>
				<!-- image  alt 没有显示 -->
				<td><img id="imageCode" alt="请输入验证码" src=""/></td>
				<td><a href="javascript:reloadImageCode()">看不清楚</a></td>
			</tr>
			
			<tr>
				<td><input type="submit" value="登录"/></td>
			</tr>
			
		</table>
	</form>

</body>


</html>