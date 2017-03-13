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
               	{
               		document.getElementById("checkImage").src="<%=basePath %>resources/img/right.jpg";
               		//恢复按钮点击功能
               		$("#submit").removeAttr("disabled");
               	}
                //退回的时候按键的状态是可以点击的，相当于绕过了前台的验证
                else
                	document.getElementById("checkImage").src="<%=basePath %>resources/img/wrong.jpg";
            }
        }); 
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
  		checkInputCode();
  	}
  	
  </script>
</head>
<body >
	<form action="<%=basePath %>user/login" method="post">
		<table>
		
			<tr>
				<td>   邮  箱      <input type="email" id="email" name="email"/></td>
			</tr>
			
			<tr>
				<td> 用 户 密 码        <input type="password" id="password" name="password"/></td>
			</tr>
							
			<tr>
				<!-- input只可以输入4位 -->
				<td>请输入验证码<input id="inputCode" name="inputCode" type="text"  oninput="javascript:checkInputCode()" placeholder="请输入4位验证码"/></td>
				
				<td><img id="checkImage" src="" style="width:20px;height:20px;" /></td>
				
				<!-- image  alt 没有显示 -->
				<td><img id="imageCode"  src=""/></td>
				<td><a href="javascript:reloadImageCode()">看不清楚</a></td>
			</tr>
			
			<tr>
				<!-- 设置按钮不可点击 -->
				<td><input id="submit" type="submit" value="登录" disabled/></td>
				<td><a href="<%=basePath %>user/preRegister"/>还没有账号？ </td>
				<td><a href="<%=basePath %>user/preForgetPassword"/>忘记密码 </td>
			</tr>
			
		</table>
	</form>

</body>


</html>