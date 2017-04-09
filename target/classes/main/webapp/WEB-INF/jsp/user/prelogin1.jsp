<%@page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
	<meta charset="UTF-8">
	<title>登录界面</title>
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
    <div class="zhuce_kong login_kuang">
    	<div class="zc">
        	<div class="bj_bai">
            <h3>登录</h3>
              <form action="<%=basePath %>user/login" method="post">
		<table>
		
			<tr>
				<td><input type="email" id="email" name="email" class="kuang_txt" placeholder="邮 箱"/></td>
			</tr>
			
			<tr>
				<td><input type="password" id="password" name="password" class="kuang_txt" placeholder="密码"/></td>
			</tr>
							
			<tr>
				<!-- input只可以输入4位 -->
				<td><input name="inputCode" id="inputCode" type="text"  oninput="javascript:checkInputCode()" class="kuang_txt yanzm" placeholder="验证码"></td>
			    <td><img id="checkImage" src="" style="width:20px;height:20px;" /></td>
			</tr>
                
			<tr>
				<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img id="imageCode" src="" width="92" height="31"></td>
				<td><img onclick="javascript:reloadImageCode()" src="<%= basePath %>resources/img/zc_25.jpg" width="13" height="14"></td>
			</tr>
			<tr>
				<!-- 设置按钮不可点击 -->
				<td><input id="submit" type="submit" value="登录" class="btn_zhuce" disabled /></td>
				
			</tr>
			<tr>
				<td>
					<a href="<%=basePath %>user/preRegister"/>还没有账号？ 
					<a href="<%=basePath %>user/preForgetPassword"/>忘记密码 
				</td>
			</tr>
		</table>
	</form>
       	  	  <!-- <form action="" method="get">
                <input name="" type="text" class="kuang_txt" placeholder="手机号">
                <input name="" type="text" class="kuang_txt" placeholder="密码">
                <div>
               		<a href="#">忘记密码？</a><input name="" type="checkbox" value="" checked><span>记住我</span> 
                </div>
                <input name="登录" type="button" class="btn_zhuce" value="登录">
                
                </form> -->
            </div>
        	<%-- <div class="bj_right">
            	<p>使用以下账号直接登录</p>
                <a href="#" class="zhuce_qq">QQ注册</a>
                <a href="#" class="zhuce_wb">微博注册</a>
                <a href="#" class="zhuce_wx">微信注册</a>
                <p>已有账号？<a href="<%=basePath %>user/preRegister">立即注册</a></p>
            
            </div> --%>
        </div>
    </div>

</div>
    
</body>
</html>