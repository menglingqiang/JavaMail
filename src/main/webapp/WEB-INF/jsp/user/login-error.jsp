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
<title>用户头像上传失败</title>
<link rel="stylesheet" type="text/css" href="<%=basePath%>resources/css/main.css">
<!--[if lt IE 9]>
  <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
</head>
<body>
<div id="wrapper"><a class="logo" href="/"></a>
  <div id="main">
    <header id="header">
      <h1><span class="icon">!</span>抱歉,<span class="sub">用户头像上传失败</span></h1>
    </header>
    <div id="content">
      <h2>用户头像上传失败</h2>
      <p><a href="<%=basePath %>user/preLogin">登录</a></p>
    </div>
    
  </div>
</div>
</html>