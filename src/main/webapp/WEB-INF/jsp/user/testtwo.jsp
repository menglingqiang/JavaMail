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
	<link rel="stylesheet" type="text/css" href="<%=basePath%>resources/css/normalize.css" />
	<link rel="stylesheet" type="text/css" href="<%=basePath%>resources/css/default.css">
	<link href="<%=basePath%>resources/css/material-design-iconic-font.min.css" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>resources/css/styles.css">
	<script src="<%=basePath%>resources/script/modernizr.js" type="text/javascript"></script>
	<script type="text/javascript">
   		
		<% 
		if(request.getParameter("autoLogin")!=null&& request.getParameter("autoLogin")!="")
		{
			Cookie[] cookies = request.getCookies();
			if(cookies!=null&&cookies.length>0)
			{
				String userName = request.getParameter("userName");
				String password = request.getParameter("password");
				Cookie userNameCookie = new Cookie("userName",userName);
				Cookie passwordCookie = new Cookie("password",password);
				userNameCookie.setMaxAge(60*60*24*10);
				passwordCookie.setMaxAge(60*60*24*10);
				response.addCookie(userNameCookie);
				response.addCookie(passwordCookie);
			}
		}else
		{
			Cookie[] cookies = request.getCookies();
			if(cookies!=null&&cookies.length>0)
			{
				for(Cookie c:cookies)
				{
					if(c.getName().equals("userName")||c.getName().equals("password"))
					{
						c.setMaxAge(0);
						response.addCookie(c);
					}
				}
			}
		}
			
			
		%>
   
	</script>
</head>
<body>
<% %>
	<a href="<%=basePath%>project/test">返回testone页面</a>
    
</body>
</html>


