<%@page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>注册界面</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1">
    <link href="<%=basePath%>resources/css/login.css" rel="stylesheet" type="text/css" />
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
  		checkInputCode();
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
<body class="login_bj" >

<div class="zhuce_body">
    <div class="zhuce_kong">
    	<div class="zc">
        	<div class="bj_bai">
            <h3>欢迎注册</h3>
       	  	  <form action="<%=basePath %>user/register" method="post">
               
                <table>
		
					<tr>
						<td> <input id="name" name="name" type="text" class="kuang_txt" placeholder="用户名"></td>
					</tr>
					
					<tr>
						<td><input id="email" name="email" type="text" class="kuang_txt email" placeholder="邮箱"></td>
					</tr>
					<tr>
						<td><input id="password" name="password" type="text" class="kuang_txt possword" placeholder="密码"></td>
					</tr>
									
					<tr>
						<!-- input只可以输入4位 -->
						<td><input name="inputCode" id="inputCode" oninput="javascript:checkInputCode()" type="text" class="kuang_txt yanzm" placeholder="验证码"></td>
					    <td><img id="checkImage" src="" style="width:20px;height:20px;" /></td>
					</tr>
		                
					<tr>
						<td><img id="imageCode" src="" width="92" height="31"></td>
						<td><img onclick="javascript:reloadImageCode()" src="<%= basePath %>resources/img/zc_25.jpg" width="13" height="14"></td>
					</tr>
					<tr>
						<!-- 设置按钮不可点击 --> 
						<td><input type="submit" value="注册" class="btn_zhuce" disabled /></td>
					</tr>
				</table>
                </form>
                <%-- <form action="<%=basePath %>user/register" method="post">
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
				</form> --%>
            </div>
        	<%-- <div class="bj_right">
            	<p>使用以下账号直接登录</p>
                <a href="#" class="zhuce_qq">QQ注册</a>
                <a href="#" class="zhuce_wb">微博注册</a>
                <a href="#" class="zhuce_wx">微信注册</a>
                <p>已有账号？<a href="<%=basePath %>user/preLogin">立即登录</a></p>
            
            </div> --%>
        </div>
    </div>

</div>

</body>
</html>