<%@page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<html>
<head>
  <title>测试时间</title>
  <link rel="stylesheet" type="text/css" href="<%=basePath%>resources/css/datedropper.css">
  <link rel="stylesheet" type="text/css" href="<%=basePath%>resources/css/timedropper.min.css">
  
  <script src="<%=basePath%>resources/script/jquery-1.8.0.min.js"></script>
  <script src="<%=basePath%>resources/script/datedropper.min.js"></script>
  <script src="<%=basePath%>resources/script/timedropper.min.js"></script>
<style>
	.demo{margin:80px auto 40px auto;width:320px}
	.input{padding:6px;border:1px solid #d3d3d3}
</style>

</head>
<body >
	<div class="demo">
		<p>请选择日期：<input type="text" class="input" id="pickdate" /></p><br/>
	</div>

<script type="text/javascript">
//js
$("#pickdate").dateDropper({
	animate: false,
	format: 'Y-m-d',
	maxYear: '2020'
});

</script>
</body>

</html>