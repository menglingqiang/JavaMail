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
<title>用户登录成功</title>
<link rel="stylesheet" type="text/css" href="<%=basePath%>resources/css/main.css">
<!--[if lt IE 9]>
  <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
</head>
<body>
<div id="wrapper"><a class="logo" href="/"></a>
  <div id="main">
    <header id="header">
      <h1><span class="icon">√</span>登录成功</h1>
    </header>
    <div id="content">
      <h2> ${user.name}:您好,你还没有激活，激活之后也什么也没什么用 </h2>
	  <div style="height:50px; line-height:50px;text-align:center;">
		<h2><a href='http://localhost:8080/JavaMail/user/activation?flag=false&code=${user.code}'>点击激活</a></h2>
	  </div>
    </div>
    
  </div>
</div>
</html>
	