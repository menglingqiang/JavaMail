<%@page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
  <title>用户忘记密码输入页面</title>
  <script src="<%= basePath %>resources/script/jquery-1.8.0.min.js"></script>
  <script type="text/javascript">
  	
  	function isRegister()
  	{
  		var email = document.getElementById("email").value;//得到输入的email
  		var form =document.getElementById("form1");
  		var msg = document.getElementById("msg");
  		$.ajax({
            type: "Get",
            url: "isRegister?email="+email,
            contentType: "application/json; charset=utf-8",
            dataType: "text",
            success: function (data) {
            	if(data=="true")
           		{
		          	form.submit();  //注册了发送信息
           		}
            	else{
		  			msg.innerHTML = "您还没有注册，请检查输入的邮箱，或者去注册！"; //没注册提示注册，或者检查email文件 */
            	}
            }
        }); 
  	}
  	</script>
</head>
<!-- 提交之后先调用js，判断是否已经注册，没有注册提示注册并弹出注册信息界面，注册了之后提交表单信息发送信息跳转页面 -->
<body >

	<form id="form1" action="<%=basePath %>user/forgetPassword" method="post">
		请输入注册邮箱<input id="email" name="email" type="email"/></br>
		<input value="提交" type="button" onclick="isRegister()"/></br>
		<a href="<%=basePath %>user/preLogin"/>想起来密码，去登陆?</br>
		<a id="msg" name="msg"/>
	</form>

</body>


</html>