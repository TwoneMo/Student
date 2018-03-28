<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/ind/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/ind/css/common.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/ind/css/slide.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/ind/css/bootstrap.min.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/ind/css/flat-ui.min.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/ind/css/jquery.nouislider.css">
</head>
<script src="${pageContext.request.contextPath}/static/ind/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/static/ind/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/static/ind/js/jquery.nouislider.js"></script>

<link rel="stylesheet" href="${pageContext.request.contextPath}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/bootstrap-3.3.7-dist/css/bootstrap-theme.min.css">
<!-- DataTables CSS -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/DataTables-1.10.15/media/css/jquery.dataTables.css">
<!-- jQuery -->
<script type="text/javascript" charset="utf8" src="${pageContext.request.contextPath}/static/DataTables-1.10.15/media/js/jquery.js"></script>
<!-- DataTables -->
<script type="text/javascript" charset="utf8" src="${pageContext.request.contextPath}/static/DataTables-1.10.15/media/js/jquery.dataTables.js"></script>
<script src="${pageContext.request.contextPath}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/bootbox.min.js"></script>

<style type="text/css">
a:link {
 text-decoration: none;
}
a:visited {
 text-decoration: none;
}
a:hover {
 text-decoration: none;
}
a:active {
 text-decoration: none;
}
</style>
<script>
		$(function() {
			$(".meun-item").click(function() {
				$(".meun-item").removeClass("meun-item-active");
				$(this).addClass("meun-item-active");
				
			});
			$(".toggle-btn").click(function() {
				$("#leftMeun").toggleClass("show");
				$("#rightContent").toggleClass("pd0px");
			})
		})
		
		//时间
		function getCurDate()
		{
		 var d = new Date();
		 var week;
		 switch (d.getDay()){
		 case 1: week="星期一"; break;
		 case 2: week="星期二"; break;
		 case 3: week="星期三"; break;
		 case 4: week="星期四"; break;
		 case 5: week="星期五"; break;
		 case 6: week="星期六"; break;
		 default: week="星期日";
		 }
		 var years = d.getFullYear();
		 var month = add_zero(d.getMonth()+1);
		 var days = add_zero(d.getDate());
		 var hours = add_zero(d.getHours());
		 var minutes = add_zero(d.getMinutes());
		 var seconds=add_zero(d.getSeconds());
		 var stime = "时间："+week+"--"+hours+":"+minutes+":"+seconds;
		 var sweek = "日期："+years+"年"+month+"月"+days+"日 ";
		 $("#stime").html(stime);
		 $("#sweek").html(sweek);
		}
		function add_zero(temp)
		{
		 if(temp<10) return "0"+temp;
		 else return temp;
		}
		
		
		$(document).ready(function(){
				//显示时间
				setInterval(function(){getCurDate() },1000);
				
				$("#jbxx").click(function(){
			        $("#user").load("${pageContext.request.contextPath}/users/toShowSelf.do");
				});
				$("#mmgl").click(function(){
			        $("#password0").load("${pageContext.request.contextPath}/users/toEditPassword.do");
				});
				$("#kcgl").click(function(){
			        $("#course").load("${pageContext.request.contextPath}/course/toShowCourse.do");
				});
				$("#bjgl").click(function(){
					$("#class").load("${pageContext.request.contextPath}/class/toShowClass.do");
				});
				$("#cjgl").click(function(){
			        $("#score").load("${pageContext.request.contextPath}/score/toShowScore.do");
				});
				$("#qxgl").click(function(){
					alert(6);
			        $("#permission").load("https://www.baidu.com");
				});
		})
</script>
<script language="javascript" type="text/javascript">

</script>
<body>
<div id="wrap">
			<!-- 左侧菜单栏目块 -->
			<div class="leftMeun" id="leftMeun">
				<div id="logoDiv">
					<p id="logoP"><!--<img id="logo" alt="图像加载失败" src="images/logo.png">--><span>&nbsp;&nbsp;学生成绩管理系统</span></p>
				</div>
				<div id="personInfor">
				<c:if test="${myuser.rid=='002' }">
					<p id="name">欢迎您：${student.sname }同学</p>
				</c:if>
				<c:if test="${myuser.rid!='002' }">
					<p id="name">欢迎您：${other.tname }老师</p>
				</c:if>
				<p id="sweek" name="sweek"></p>
				<p id="stime" name="stime"></p>
				
				<p>
					<a href="${pageContext.request.contextPath}/users/outlogin.do">退出</a>
				</p>
				</div>
				<div class="meun-title">用户管理</div>
				<div class="meun-item" href="#user" data-toggle="tab" id="jbxx"><img src="${pageContext.request.contextPath}/static/ind/images/icon_card_grey.png">基本信息</div>
				<div class="meun-item" href="#password0" data-toggle="tab" id="mmgl"><img src="${pageContext.request.contextPath}/static/ind/images/icon_rule_grey.png">密码修改</div>
				<div class="meun-title">教学管理</div>
				<div class="meun-item" href="#course" data-toggle="tab" id="kcgl"><img src="${pageContext.request.contextPath}/static/ind/images/icon_user_grey.png">课程管理</div>
				<c:if test="${myuser.rid!='002' }">
				<div class="meun-item" href="#class" data-toggle="tab" id="bjgl"><img src="${pageContext.request.contextPath}/static/ind/images/icon_house_grey.png">班级管理</div>
				</c:if>
				<div class="meun-item" href="#score" data-toggle="tab" id="cjgl"><img src="${pageContext.request.contextPath}/static/ind/images/icon_change_grey.png">成绩管理</div>
				<c:if test="${myuser.rid=='001' }">
				<div class="meun-title">权限管理</div>
				<div class="meun-item" href="#permission" data-toggle="tab" id="qxgl"><img src="${pageContext.request.contextPath}/static/ind/images/icon_chara_grey.png">权限管理</div>
				</c:if>
			
			</div>
			<!-- 右侧具体内容栏目 -->
			<div id="rightContent">
				<a class="toggle-btn" id="nimei">
					<i class="glyphicon glyphicon-align-justify"></i>
				</a>
				<!-- Tab panes -->
				<div class="tab-content">
					<!-- 基本信息模块 -->
					<div role="tabpanel" class="tab-pane active" id="user">
						
					</div>
					<!-- 密码管理模块 -->
					<div role="tabpanel" class="tab-pane" id="password0">
						
					</div>
					<!-- 课程管理模块 -->
					<div role="tabpanel" class="tab-pane" id="course">

					</div>
					<!-- 班级管理模块 -->
					<div role="tabpanel" class="tab-pane" id="class">
						
					</div>
					<!-- 成绩管理模块 -->
					<div role="tabpanel" class="tab-pane" id="score">

					</div>
					<!-- 权限管理模块 -->
					<div role="tabpanel" class="tab-pane" id="permission">
						
					</div>
				</div>
			</div>
		</div>
</body>
</html>