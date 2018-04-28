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
	$("#s_btn_add").click(function(){
		$.ajax({
			url:"${pageContext.request.contextPath }/students/doAdd.do",
			type:"post",
			data:$("#formadd_s").serialize(),
			dataType:"json",
			success:function(jsonResult){
				if(jsonResult.tag==1){
					$(".bootbox-close-button").click();
				}else{
					alert(jsonResult.message);
				}
			}
		})
	});
});
</script>
<body>
<form id="formadd_s" name="self" method="post" >
	<input type="hidden" class="form-control" id="uid" name="uid" value="${user.id }">
	<div class="form-group">
    <label for="sid">学号</label>
    <input type="text" class="form-control" id="sid" name="sid" placeholder="Sid" style="width: 200px;color: black;">
  	</div>
  	<div class="form-group">
    <label for="sname">姓名</label>
    <input type="text" class="form-control" id="sname" name="sname" placeholder="Sname" style="width: 200px;color: black;">
  	</div>
  	<div class="form-group">
    <label for="classid">班级</label>
  	<select class="form-control" class="form-control" id="classid" name="classid" style="width:200px">
  		<option value="0">请选择</option>
		<c:forEach items="${classlist }" var="c">
			<option value="${c.classid}">${c.classname }</option>
		</c:forEach>
	</select>
  	</div>
  	<div class="form-group">
    <label for="sex">性别</label>
    <select class="form-control"id="sex" name="sex" style="width:200px">
    	<option value="0">请选择</option>
		<option value="male">男</option>
		<option value="female">女</option>
	</select>
  	</div>
  	<div class="form-group">
    <label for="address">住址</label>
    <input type="text" class="form-control" id="address" name="address" placeholder="Address" style="width: 200px;">
  	</div>
  	<div class="form-group">
    <label for="email">e-mail</label>
    <input type="text" class="form-control" id="email" name="email" placeholder="Email" style="width: 200px;">
  	</div>
  	<div class="form-group">
    <label for="identityCard">身份证</label>
    <input type="text" class="form-control" id="identityCard" name="identityCard" placeholder="IdentityCard" style="width: 200px;color: black;">
  	</div>
  	<div class="form-group">
    <label for="birthday">出生日期</label>
    <input type="text" class="form-control" id="birthday" name="birthday" placeholder="Birthday" style="width: 200px;">
  	</div>
  	<div class="form-group">
    <label for="phone">移动手机</label>
    <input type="text" class="form-control" id="phone" name="phone" placeholder="Phone" style="width: 200px;">
  	</div>
  	<br />
  	<div align="left" style="float:left">
	<button type="button" class="btn btn-success" id="s_btn_add" name="s_btn_add">提交</button>
	</div>
	<div align="right">
	<button type="reset" class="btn btn-primary" id="s_reset" name="s_reset">重置</button>
	</div>
</form>
</body>
</html>