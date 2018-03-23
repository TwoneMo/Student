<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>

<script type="text/javascript">
$(document).ready(function(){
	$("#btn_add").click(function(){
		if($("#username").val()==""){
			alert("用户名称不能为空！");
			return false;
		}
		if($("#password").val()==""){
			alert("用户密码不能为空！");
			return false;
		}
		$.ajax({
			url:"${pageContext.request.contextPath }/users/doCreateAccount.do",
			type:"post",
			data:$("#formadd").serialize(),
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
<div style="margin: auto; width: 200px;">
<form id="formadd" name="useradd" method="post" >
	<div class="form-group">
    <label for="username">用户名称</label>
    <input type="text" class="form-control" id="username" name="username" placeholder="Username" style="width: 200px;">
  	</div>
  	<div class="form-group">
    <label for="password">用户密码</label>
    <input type="password" class="form-control" id="password" name="password" placeholder="Password" style="width: 200px;">
  	</div>
  	<div class="form-group">
  	<label for="rid">用户角色</label>
	<select class="form-control"id="rid" name="rid" style="width:200px">
  		<option value="0">请选择</option>
		<c:forEach items="${roles }" var="r">
		<c:if test="${r.rid=='002'||r.rid=='003' }">
			<option value="${r.rid}">${r.rname }</option>
		</c:if>
		</c:forEach>
	</select>
	</div>
	<br />
	<div align="left" style="float:left">
	<button type="button" class="btn btn-success" id="btn_add" name="btn_add">提交</button>
	</div>
	<div align="right">
	<button type="reset" class="btn btn-primary" id="reset" name="reset">重置</button>
	</div>
</form>
</div>
</body>
</html>