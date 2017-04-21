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
<title>404 - 对不起，您查找的页面不存在！- JS代码站</title>
<link rel="stylesheet" type="text/css" href="<%=basePath%>resources/css/main.css">
<!--[if lt IE 9]>
  <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
</head>
<body>
<div id="wrapper"><a class="logo" href="/"></a>
  <div id="main">
    <header id="header">
      <h1><span class="icon">!</span>404<span class="sub">page not found</span></h1>
    </header>
    <div id="content">
      <h2>您打开的这个的页面不存在！</h2>
      <p>当您看到这个页面,表示您的访问出错,这个错误是您打开的页面不存在,请确认您输入的地址是正确的,如果是在本站点击后出现这个页面,请联系站长进行处理,或者请通过下边的搜索重新查找资源,JS代码站站长感谢您的支持!</p>
      
    </div>
    
  </div>
</div>
</html>