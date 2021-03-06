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
	$("#t_btn_add").click(function(){
		$.ajax({
			url:"${pageContext.request.contextPath }/teachers/doAdd.do",
			type:"post",
			data:$("#formadd_t").serialize(),
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
<form id="formadd_t" name="self" method="post" >
	<input type="hidden" class="form-control" id="uid" name="uid" value="${user.id }">
	<div class="form-group">
    <label for="tid">工号</label>
    <input type="text" class="form-control" id="tid" name="tid" placeholder="Tid" style="width: 200px;color: black;">
  	</div>
  	<div class="form-group">
    <label for="tname">姓名</label>
    <input type="text" class="form-control" id="tname" name="tname" placeholder="Tname" style="width: 200px;color: black;">
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
	<button type="button" class="btn btn-success" id="t_btn_add" name="t_btn_add">提交</button>
	</div>
	<div align="right">
	<button type="reset" class="btn btn-primary" id="t_reset" name="t_reset">重置</button>
	</div>
	</form>
</body>
</html>