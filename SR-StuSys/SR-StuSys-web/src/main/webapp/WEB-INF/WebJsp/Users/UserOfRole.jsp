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
	$("#user_role_btn_allot").click(function(){
		if($("#rid_allotRole").val()==""||$("#rid_allotRole").val()=="0"){
			alert("用户角色不能为空！");
			return false;
		}
		$.ajax({
			url:"${pageContext.request.contextPath }/users/doAllotRole.do",
			type:"post",
			data:$("#formallot_user_role").serialize(),
			dataType:"json",
			success:function(jsonResult){
				if(jsonResult.tag==1){
					datatable_users.draw(1);
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
	<form id="formallot_user_role" name="editrole" method="post" >
	<input type="hidden" class="form-control" name="id" value="${user_edit.id }">
	<input type="hidden" class="form-control" name="password" value="${user_edit.password }">
	<br><br><br>
  	<div class="form-group">
    <label for="oldpassword">用户名称</label>
    <input type="text" class="form-control" id="username_allotRole" name="username" value="${user_edit.username }" readonly="readonly" placeholder="Username" style="width: 200px;color: black;">
  	</div>
  	<div class="form-group">
    <label for="rid_allotRole">用户角色</label>
   	<select class="form-control" id="rid_allotRole" name="rid" style="width:200px">
  		<option value="0">请选择</option>
    	<c:forEach items="${allroles }" var="r">
			<c:if test="${user_edit.rid==r.rid }">
  				<option value="${r.rid}" selected="selected">${r.rname }</option>
  			</c:if>
  			<c:if test="${user_edit.rid!=r.rid }">
  				<option value="${r.rid}">${r.rname }</option>
  			</c:if>
		</c:forEach>
	</select>
  	</div>
  	<br />
	<div align="left" style="float:left">
	<button type="button" class="btn btn-success" id="user_role_btn_allot" name="user_role_btn_allot" data-dismiss="modal">提交</button>
	</div>
	<div align="right">
	<button type="reset" class="btn btn-primary" id="reset" name="reset">重置</button>
	</div>
	</form>
</div>
</body>
</html>