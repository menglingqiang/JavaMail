<%@page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<html lang="en-US">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>激活状态界面</title>
<link rel="stylesheet" type="text/css" href="<%=basePath%>resources/css/main.css">
<!--[if lt IE 9]>
  <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
</head>
<body>
<div id="wrapper"><a class="logo" href="/"></a>
   <div id="main">
    <header id="header">
      <h1><span class="icon">√</span>激活成功</h1>
    </header>
    <div id="content" >
      <h2>激活邮件已经发送的您的注册邮箱请及时查收</h2>
    </div>
    
  </div>
</div>
</html>

