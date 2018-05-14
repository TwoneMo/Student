<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<script type="text/javascript">
$(document).ready(function(){
	$("#sbtn_add").click(function(){
		$.ajax({
			url:"${pageContext.request.contextPath }/students/doEditSelf.do",
			type:"post",
			data:$("#formadd").serialize(),
			dataType:"json",
			success:function(jsonResult){
				if(jsonResult.tag==1){
					/* $(".bootbox-close-button").click(); */
					alert(jsonResult.message);
					$("#user").load("${pageContext.request.contextPath}/users/toShowSelf.do");
				}else{
					alert(jsonResult.message);
				}
			}
		})
	});
	$("#tbtn_add").click(function(){
		$.ajax({
			url:"${pageContext.request.contextPath }/teachers/doEditSelf.do",
			type:"post",
			data:$("#formadd").serialize(),
			dataType:"json",
			success:function(jsonResult){
				if(jsonResult.tag==1){
					/* $(".bootbox-close-button").click(); */
					alert(jsonResult.message);
					$("#user").load("${pageContext.request.contextPath}/users/toShowSelf.do");
				}else{
					alert(jsonResult.message);
				}
			}
		})
	});
});
</script>
<body>
<div style="margin: auto; width: 200px;">
	<c:if test="${myuser.rid=='002' }">
	<form id="formadd" name="self" method="post" >
	<input type="hidden" class="form-control" name="id" value="${student.id }">
	<input type="hidden" class="form-control" name="uid" value="${student.uid }">
	<div class="form-group">
    <label for="sid">学号</label>
    <input type="text" class="form-control" id="sid" name="sid" value="${student.sid }" placeholder="Sid" readonly="readonly" style="width: 200px;color: black;">
  	</div>
  	<div class="form-group">
    <label for="sname">姓名</label>
    <input type="text" class="form-control" id="sname" name="sname" value="${student.sname }" placeholder="Sname" readonly="readonly" style="width: 200px;color: black;">
  	</div>
  	<div class="form-group">
    <label for="rid">身份</label>
    <input type="hidden" class="form-control" name="rid" value="${myuser.role.rid }" placeholder="Rid" readonly="readonly" style="width: 200px;color: black;">
    <input type="text" class="form-control" id="rid" value="${myuser.role.rname }" placeholder="Rid" readonly="readonly" style="width: 200px;color: black;">
  	</div>
  	<div class="form-group">
    <label for="classid">班级</label>
    <input type="hidden" class="form-control" name="classid" value="${student.myclass.classid }" placeholder="Classid" readonly="readonly" style="width: 200px;color: black;">
    <input type="text" class="form-control" id="classid"  value="${student.myclass.classname }" placeholder="Classid" readonly="readonly" style="width: 200px;color: black;">
  	</div>
  	<div class="form-group">
    <label for="sex">性别</label>
    <select class="form-control"id="sex" name="sex" style="width:200px">
		<c:if test="${student.sex=='male' }">
			<option value="male" selected="selected">男</option>
			<option value="female">女</option>
		</c:if>
		<c:if test="${student.sex=='female' }">
			<option value="male">男</option>
			<option value="female" selected="selected">女</option>
		</c:if>
	</select>
  	</div>
  	<div class="form-group">
    <label for="address">住址</label>
    <input type="text" class="form-control" id="address" name="address" value="${student.address }" placeholder="Address" style="width: 200px;">
  	</div>
  	<div class="form-group">
    <label for="email">e-mail</label>
    <input type="text" class="form-control" id="email" name="email" value="${student.email }" placeholder="Email" style="width: 200px;">
  	</div>
  	<div class="form-group">
    <label for="identityCard">身份证</label>
    <input type="text" class="form-control" id="identityCard" name="identityCard" value="${student.identityCard }" placeholder="IdentityCard" readonly="readonly" style="width: 200px;color: black;">
  	</div>
  	<div class="form-group">
    <label for="birthday">出生日期</label>
    <input type="text" class="form-control" id="birthday" name="birthday" value="${student.birthday }" placeholder="Birthday" style="width: 200px;">
  	</div>
  	<div class="form-group">
    <label for="phone">移动手机</label>
    <input type="text" class="form-control" id="phone" name="phone" value="${student.phone }" placeholder="Phone" style="width: 200px;">
  	</div>
  	<br />
	<div align="left" style="float:left">
	<button type="button" class="btn btn-success" id="sbtn_add" name="sbtn_add">提交</button>
	</div>
	<div align="right">
	<button type="reset" class="btn btn-primary" id="jbxxreset" name="reset">重置</button>
	</div>
	</form>
	</c:if>
	
	<c:if test="${myuser.rid!='002' }">
	<form id="formadd" name="roleadd" method="post" >
	<input type="hidden" class="form-control" name="id" value="${other.id }">
	<input type="hidden" class="form-control" name="uid" value="${other.uid }">
	<div class="form-group">
    <label for="tid">工号</label>
    <input type="text" class="form-control" id="tid" name="tid" value="${other.tid }" placeholder="Tid" readonly="readonly" style="width: 200px;color: black;">
  	</div>
  	<div class="form-group">
    <label for="tname">姓名</label>
    <input type="text" class="form-control" id="tname" name="tname" value="${other.tname }" placeholder="Tname" readonly="readonly" style="width: 200px;color: black;">
  	</div>
  	<div class="form-group">
    <label for="rid">身份</label>
    <input type="hidden" class="form-control" name="rid" value="${myuser.role.rid }" placeholder="Rid" readonly="readonly" style="width: 200px;color: black;">
    <input type="text" class="form-control" id="rid" value="${myuser.role.rname }" placeholder="Rid" readonly="readonly" style="width: 200px;color: black;">
  	</div>
  	<div class="form-group">
    <label for="sex">性别</label>
    <select class="form-control"id="sex" name="sex" style="width:200px">
		<c:if test="${other.sex=='male' }">
			<option value="male" selected="selected">男</option>
			<option value="female">女</option>
		</c:if>
		<c:if test="${other.sex=='female' }">
			<option value="male">男</option>
			<option value="female" selected="selected">女</option>
		</c:if>
	</select>
  	</div>
  	<div class="form-group">
    <label for="address">住址</label>
    <input type="text" class="form-control" id="address" name="address" value="${other.address }" placeholder="Address" style="width: 200px;">
  	</div>
  	<div class="form-group">
    <label for="email">e-mail</label>
    <input type="text" class="form-control" id="email" name="email" value="${other.email }" placeholder="Email" style="width: 200px;">
  	</div>
  	<div class="form-group">
    <label for="identityCard">身份证</label>
    <input type="text" class="form-control" id="identityCard" name="identityCard" value="${other.identityCard }" placeholder="IdentityCard" readonly="readonly" style="width: 200px;color: black;">
  	</div>
  	<div class="form-group">
    <label for="birthday">出生日期</label>
    <input type="text" class="form-control" id="birthday" name="birthday" value="${other.birthday }" placeholder="Birthday" style="width: 200px;">
  	</div>
  	<div class="form-group">
    <label for="phone">移动手机</label>
    <input type="text" class="form-control" id="phone" name="phone" value="${other.phone }" placeholder="Phone" style="width: 200px;">
  	</div>
  	<br />
	<div align="left" style="float:left">
	<button type="button" class="btn btn-success" id="tbtn_add" name="tbtn_add">提交</button>
	</div>
	<div align="right">
	<button type="reset" class="btn btn-primary" id="jbxxreset" name="reset">重置</button>
	</div>
	</form>
	</c:if>
</div>
<br><br><br>
</body>
</html>