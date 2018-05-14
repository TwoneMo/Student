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
	
	$("#btn_edit").click(function(){
		//console.log($("#password").val());
		if($("#newpassword").val().trim()==$("#password_edit").val().trim()){
			$.ajax({
				url:"${pageContext.request.contextPath }/users/doEditPassword.do",
				type:"post",
				data:$("#formedit").serialize(),
				dataType:"json",
				success:function(jsonResult){
					if(jsonResult.tag==1){
						/* $(".bootbox-close-button").click(); */
						/* document.getElementById("reset").click(); */
						$("#mmxgreset").click();
						$("#mmxgreset").click();
						alert(jsonResult.message);
					}else{
						alert(jsonResult.message);
					}
				}
			})
		} else {
			alert("修改失败,两次输入的新密码不一致！");
		}
	});
});
</script>
<body>
<div style="margin: auto; width: 200px;">
	<form id="formedit" name="editpassword" method="post" >
	<input type="hidden" class="form-control" name="id" value="${myuser.id }">
	<input type="hidden" class="form-control" name="username" value="${myuser.username }">
	<input type="hidden" class="form-control" name="rid" value="${myuser.rid }">
	<br><br><br>
  	<div class="form-group">
    <label for="oldpassword">用户旧密码</label>
    <input type="password" class="form-control" id="oldpassword" name="oldpassword" placeholder="OldPassword" style="width: 200px;">
  	</div>
  	<div class="form-group">
    <label for="newpassword">用户新密码</label>
    <input type="password" class="form-control" id="newpassword" placeholder="NewPassword" style="width: 200px;">
  	</div>
  	<div class="form-group">
    <label for="password_edit">确认新密码</label>
    <input type="password" class="form-control" id="password_edit" name="password" placeholder="Password" style="width: 200px;">
  	</div>
  	<br />
	<div align="left" style="float:left">
	<button type="button" class="btn btn-success" id="btn_edit" name="btn_edit">提交</button>
	</div>
	<div align="right">
	<button type="reset" class="btn btn-primary" id="mmxgreset" name="reset">重置</button>
	</div>
	</form>
</div>
</body>
</html>