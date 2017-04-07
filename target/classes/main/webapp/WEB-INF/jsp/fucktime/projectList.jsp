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
  <title>用户总任务列表页面</title>
  <link href="<%=basePath%>resources/css/all.css" rel="stylesheet" type="text/css" />
  <script src="<%=basePath%>resources/script/jquery-1.8.0.min.js"></script>
  <style>
.black_overlay{
	display: none;
	position: absolute;
	top: 0%;
	left: 0%;
	width: 100%;
	height: 100%;
	background-color: black;
	z-index:1001;
	-moz-opacity: 0.8;
	opacity:.80;
	filter: alpha(opacity=80);
}
.white_content {
	display: none;
	position: absolute;
	top: 10%;
	left: 10%;
	width: 80%;
	height: 80%;
	border: 16px solid lightblue;
	background-color: white;
	z-index:1002;
	overflow: auto;
}
.white_content_small {
	display: none;
	position: absolute;
	top: 20%;
	left: 30%;
	width: 40%;
	height: 50%;
	border: 16px solid lightblue;
	background-color: white;
	z-index:1002;
	overflow: auto;
}
</style>
<script type="text/javascript">
//弹出隐藏层
function ShowDiv(show_div,bg_div,para,type,secPara){
 if(type=="modify")
 	{
  document.getElementById("modifyProjectId").value= para;
  document.getElementById("beforeProjectName").value=secPara;
}
 else
 	document.getElementById("addEmail").value= para;
 document.getElementById(show_div).style.display='block';
 document.getElementById(bg_div).style.display='block' ;
 var bgdiv = document.getElementById(bg_div);
 bgdiv.style.width = document.body.scrollWidth;
 // bgdiv.style.height = $(document).height();
 $("#"+bg_div).height($(document).height());
};
//关闭弹出层
function CloseDiv(show_div,bg_div)
{
 document.getElementById(show_div).style.display='none';
 document.getElementById(bg_div).style.display='none';
};
//更正时间
function checkInputCode(id)
{
 var time = document.getElementById(id).value;
 if(time.length==4||time.length==7)
  document.getElementById(id).value=document.getElementById(id).value+"-";
}
//检查时间
function checkDate()
{
 
}
function addProject()
{
 var email = document.getElementById("email").value;
 var projectName = document.getElementById("addProjectName").value;
 var startTime = document.getElementById("addStartTime").value;
 var endTime = document.getElementById("addEndTime").value;
 var form = document.getElementById("mainForm");
 form.action = "<%=basePath%>project/operation?type=add&email="+email+"&projectName="+projectName+"&startTime="+startTime+"&endTime="+endTime;
 form.submit();
}
function modifyProject()
{
 var email = document.getElementById("email").value;
 var projectId = document.getElementById("modifyProjectId").value;
 var projectName = document.getElementById("modifyProjectName").value;
 var startTime = document.getElementById("modifyStartTime").value;
 var endTime = document.getElementById("modifyEndTime").value;
 
 var form = document.getElementById("mainForm");
 form.action = "<%=basePath%>project/operation?type=modify&projectId="+projectId+"&projectName="+projectName+"&startTime="+startTime+"&endTime="+endTime+"&email="+email;
 form.submit();
}
function deleteProject(projectId)
{
 var con=confirm("确定删除?"); //在页面上弹出对话框
 if(con==true)
 {
  var email = document.getElementById("email").value;
  var form = document.getElementById("mainForm");
  form.action = "<%=basePath%>project/operation?type=delete&projectId="+projectId+"&email="+email;
  form.submit();
 }

}
function showDetail(tr,projectName)
{
	var projectId = tr.id;//得到总项目的id
	var form = document.getElementById("mainForm");
	form.action = "<%=basePath%>project/showDetail?projectId="+projectId+"&projectName="+projectName;
	form.submit();
}
</script>
</head>
<body >
	<input type="hidden" id="email" name="email" value="${user.email}">
	<h1>总任务列表界面展示:${user.name}</h1>
	<body style="background: #e1e9eb;">
		<form action="#" id="mainForm" method="post">
			<div class="right">
				<!-- <div class="current">当前位置：<a href="javascript:void(0)" style="color:#6E6E6E;">内容管理</a> &gt; 内容列表</div> -->
				<div class="rightCont">
					<p class="g_title fix">总任务内容列表 <a class="btn03" href="javascript:ShowDiv('MyAddDiv','fade','${user.email}','add','')">增加</a>&nbsp;&nbsp;&nbsp;&nbsp;<a class="btn03" href="javascript:deleteBatch();">删 除</a></p>
					<table class="tab1">
						<tbody>
							<tr>
								<td width="90" align="right">项目名称</td>
								<td>
									<input name="projectNames" type="text" class="allInput" value="${command}"/>
								</td>
								<td width="90" align="right">日期</td>
								<td>
									<input name="date" type="text" class="allInput" value="${description}"/>
								</td>
	                            <td width="85" align="right"><input type="submit" class="tabSub" value="查 询" /></td>
	       					</tr>
						</tbody>
					</table>
					<div class="zixun fix">
						<table class="tab2" width="100%">
							<tbody>
								<tr>
								    <!-- <th><input type="checkbox" id="all" onclick="#"/></th> -->
								    <th>序号</th>
								    <th>项目名称</th>
								    <th>开始日期</th>
								    <th>结束日期</th>
								    <th>修改次数</th>
								    <th>选项</th>
								</tr>
								<c:forEach items="${projectList}" var="project" varStatus="status">
									<tr id="${project.projectId}"  onclick="javascript:showDetail(this,'${project.projectName}')" <c:if test="${status.index % 2 != 0}">style='background-color:#ECF6EE;'</c:if>>
										<%-- <td><input type="checkbox"  name="ids" value="${project.projectId}"/></td> --%>
										<%-- <input type="hidden" name="projectId" id="projectId" value="${project.projectId}"> --%>
										<td>${status.index + 1}</td>
										<td>${project.projectName}</td>
										<td>${project.startTime}</td>
										<td>${project.endTime}</td>
										<td>${project.modify}</td>
										<td>
											<a href="javascript:ShowDiv('MyModifyDiv','fade','${project.projectId}','modify','${project.projectName}')">修改</a>&nbsp;&nbsp;&nbsp;
											<a href="javascript:deleteProject('${project.projectId}')">删除</a>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
	    </form>
		<!--弹出层时背景层DIV-->
		<div id="fade" class="black_overlay">
		</div>
		<!-- 修改弹出层 -->
		<div id="MyModifyDiv" class="white_content">
			<div style="text-align: right; cursor: default; height: 40px;">
			<span style="font-size: 16px;" onclick="CloseDiv('MyModifyDiv','fade')">关闭</span>
			</div>
			<h1>${user.name}:任务修改界面</h1>
			<input type="hidden" id="modifyProjectId" name="modifyProjectId">
			<table class="tab2" width="100%" id="fm2_table">
				<tr style='background-color:#ECF6EE;'>
					<td>原项目名称</td>
					<td><input name="beforeProjectName" id="beforeProjectName"type="text" class="allInput" readonly/></td>
				</tr>
				<tr>
					<td>现项目名称</td>
					<td><input name="modifyProjectName" id="modifyProjectName" type="text" class="allInput" /></td>
				</tr>
				<tr style='background-color:#ECF6EE;'>
					<td>开始时间</td>
					<td><input name="modifyStartTime" id="modifyStartTime" type="text" class="allInput"  oninput="javascript:checkInputCode(this.id)" maxlength="10"/ onkeyup="value=value.replace(/[^\d-]/g,'')" placeholder="请输入数字"></td>
				</tr>
				<tr>
					<td>结束时间</td>
					<td><input name="modifyEndTime" id="modifyEndTime" type="text" class="allInput" oninput="javascript:checkInputCode(this.id)" maxlength="10" onkeyup="value=value.replace(/[^\d-]/g,'')" placeholder="请输入数字"/></td>
				</tr>
			</table>
			</br>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input class="btn03" type="button" onclick="javascript:modifyProject()" value="修改"/>
		</div>
		<!-- 增加弹出层 -->
		<div id="MyAddDiv" class="white_content">
			<div style="text-align: right; cursor: default; height: 40px;">
			<span style="font-size: 16px;" onclick="CloseDiv('MyAddDiv','fade')">关闭</span>
			</div>
			<h1>${user.name}:任务添加界面</h1>
			<input type="hidden" id="addEmail" name="addEmail">
			<table class="tab2" width="100%" id="fm2_table">
				<tr style='background-color:#ECF6EE;'>
					<td>项目名称</td>
					<td><input name="addProjectName" id="addProjectName" type="text" class="allInput"/></td>
				</tr>
				<tr>
					<td>开始时间</td>
					<td><input name="addStartTime" id="addStartTime" type="text" class="allInput" oninput="javascript:checkInputCode(this.id)" maxlength="10"/ onkeyup="value=value.replace(/[^\d-]/g,'')" placeholder="请输入数字"/></td>
				</tr>
				<tr style='background-color:#ECF6EE;'>
					<td>结束时间</td>
					<td><input name="addEndTime"  id="addEndTime" type="text" class="allInput" oninput="javascript:checkInputCode(this.id)" maxlength="10"/ onkeyup="value=value.replace(/[^\d-]/g,'')" placeholder="请输入数字"/></td>
				</tr>
			</table>
			</br>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input class="btn03" type="button" onclick="javascript:addProject()" value="增加"/>
		</div>
	</body>

</html>