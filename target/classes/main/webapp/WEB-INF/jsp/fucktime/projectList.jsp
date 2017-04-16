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
<!-- 表格的样式-->
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
<!-- 进度条的样式-->
body
        {
            font-family: Thoma, Microsoft YaHei, 'Lato', Calibri, Arial, sans-serif;
        }

        #content
        {
            margin: 120px auto;
            width: 80%;
        }

        .loadBar
        {
            width: 200px;
            height: 10px;
            border: 3px solid #212121;
            border-radius: 20px;
            position: relative;
        }

        .loadBar div
        {
            width: 100%;
            height: 100%;
            position: absolute;
            top: 0;
            left: 0;
        }

        .loadBar div span, .loadBar div i
        {
            box-shadow: inset 0 -2px 6px rgba(0, 0, 0, .4);
            width: 0%;
            display: block;
            height: 100%;
            position: absolute;
            top: 0;
            left: 0;
            border-radius: 20px;
        }

        .loadBar div i
        {
            width: 100%;
            -webkit-animation: move .8s linear infinite;
            background: -webkit-linear-gradient(left top, #7ed047 0%, #7ed047 25%, #4ea018 25%, #4ea018 50%, #7ed047 50%, #7ed047 75%, #4ea018 75%, #4ea018 100%);
            background-size: 40px 40px;
        }

        .loadBar .percentNum
        {
            position: absolute;
            top: 100%;
            right: 10%;
            padding: 1px 15px;
            border-bottom-left-radius: 16px;
            border-bottom-right-radius: 16px;
            border: 1px solid #222;
            background-color: #222;
            color: #fff;

        }

        @-webkit-keyframes move
        {
            0%
            {
                background-position: 0 0;
            }
            100%
            {
                background-position: 40px 0;
            }
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
function checkDate(type)
{
 if(type=="modify")
 {
 	var startTime = document.getElementById("modifyStratTime").value;
 	var endTime = document.getElementById("modifyEndTime").value;
 	return checkTime(startTime,endTime);
 }
 else if(type=="add")
 {
 	var startTime = document.getElementById("addStartTime").value;
 	var endTime = document.getElementById("addEndTime").value;
 	return checkTime(startTime,endTime);
 }
 else {
	 alert("error");
	 return false;
 }
}
function checkTime(startTime,endTime)//2014-09-09
{
    //获取当前时间
	var now = getNowFormatDate();
	for(var i=0;i<startTime.length;i++)
	{
		if(i!=4&&i!=7)
		{
			//开始时间不可以超过结束时间
			if(parseInt(startTime.charAt(i))>parseInt(endTime.charAt(i)))
			{
				alert("时光不可以倒流，开始时间不可以大于结束时间");
				return false;
			}
			//结束时间不可以小于当前时间
			if(parseInt(now.charAt(i))>parseInt(endTime.charAt(i)))
			{
				alert("这是一个网站，不是时光机，结束时间不可以小于当前的时间");
				return false;
			}
			//开始时间和结束时间都应该在一年以内
			if(i<4)
			{
				if( ( parseInt(endTime.charAt(i))-parseInt(now.charAt(i)) )>1 )
				{
					alert("先定一个一年以内的小目标，限定时间不可以超过当前时间一年");
					return false;
				}
			}
		}
	}
	return true;
}
//获取当前的日期时间 格式“yyyy-MM-dd HH:MM:SS”
function getNowFormatDate() {
    var date = new Date();
    var seperator1 = "-";
    var seperator2 = ":";
    var month = date.getMonth() + 1;
    var strDate = date.getDate();
    if (month >= 1 && month <= 9) {
        month = "0" + month;
    }
    if (strDate >= 0 && strDate <= 9) {
        strDate = "0" + strDate;
    }
    var currentdate = date.getFullYear() + seperator1 + month + seperator1 + strDate
            + " " + date.getHours() + seperator2 + date.getMinutes()
            + seperator2 + date.getSeconds();
    return currentdate;
} 
function addProject()
{
 if(!checkDate("add"))
	 return ;
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
 if(!checkDate("modify"))
	 return ;
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
function showDetail(projectId,projectName)
{
	var form = document.getElementById("mainForm");
	form.action = "<%=basePath%>project/showDetail?projectId="+projectId+"&projectName="+projectName;
	form.submit();
}


//进度条的js
 function LoadingBar(id)
{
    this.loadbar = $("#" + id);
    this.percentEle = $(".percent", this.loadbar);
    this.percentNumEle = $(".percentNum", this.loadbar);
    this.max = 100;
    this.currentProgress = 0;
}
LoadingBar.prototype = {
    constructor: LoadingBar,
    setMax: function (maxVal)
    {
        this.max = maxVal;
    },
    setProgress: function (val)
    {
        if (val >= this.max)
        {
            val = this.max;
        }
        this.currentProgress = parseInt((val / this.max) * 100) + "%";
        this.percentEle.width(this.currentProgress);
        this.percentNumEle.text(this.currentProgress);
    }
};
function loadBars()
{
	var email = document.getElementById("email").value;
	//先计算比例值
	$.ajax({
        type: "GET",
        url: "<%=basePath%>project/getHaveDone?email="+email,
        contentType: "application/json; charset=utf-8",
        dataType: "text",
        success: function (data) {
        	//alert(data);
        }
	});
	for(var i=0;i<'${projectList.size()}';i++)
	{
		var projectId = '${projectList.get(i).getProjectId()}';
		//alert(projectId);
		var loadBarName = "loadBar"+projectId;
		//alert(i+":"+loadBarName);
		loadBar(loadBarName);
	}
   
}
function loadBar(loadBarName)
{
	var loadbar = new LoadingBar(loadBarName);
	var projectId = loadBarName.substr(7); 
	var test = 'percentMap'+projectId;
	alert(test);
	var percent =  '${test}';
	//alert("projectId:"+projectId+"percent:"+percent);
    var max = 1000;
    loadbar.setMax(max);
    var i = 0;
    var currentPercent = 1000*percent;//获得当前比例
    var time = setInterval(function ()
    {
        loadbar.setProgress(i);
        if (i == currentPercent)
        {
            clearInterval(time);
            return;
        }
        i += 10;
    }, 40);
   
}
window.onload=loadBars;
</script>
</head>
<body >
	<input type="hidden" id="email" name="email" value="${user.email}">
	<input type="hidden" id="percentMap" name="percentMap" >
	<input onclick="javascript:loadBars()" value="bar2" type="button">
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
								    <th>项目进度</th>
								    <th>选项</th>
								</tr>
								<c:forEach items="${projectList}" var="project" varStatus="status">
									<tr <c:if test="${status.index % 2 != 0}">style='background-color:#ECF6EE;'</c:if>>
										<%-- <td><input type="checkbox"  name="ids" value="${project.projectId}"/></td> --%>
										<%-- <input type="hidden" name="projectId" id="projectId" value="${project.projectId}"> --%>
										<td  onclick="javascript:showDetail('${project.projectId}','${project.projectName}')">${status.index + 1}</td>
										<td  onclick="javascript:showDetail('${project.projectId}','${project.projectName}')">${project.projectName}</td>
										<td  onclick="javascript:showDetail('${project.projectId}','${project.projectName}')">${project.startTime}</td>
										<td  onclick="javascript:showDetail('${project.projectId}','${project.projectName}')">${project.endTime}</td>
										<td  style="text-align:center;" onclick="javascript:showDetail('${project.projectId}','${project.projectName}')">
											<div id='loadBar${project.projectId}' class="loadBar">
										        <div>
										             <span class="percent">
										                <i></i>
										             </span>
										        </div>
										        <span class="percentNum">0%</span>
										    </div>
										</td><!-- 进来展现进度，然后放在进度条上显示比例 -->
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