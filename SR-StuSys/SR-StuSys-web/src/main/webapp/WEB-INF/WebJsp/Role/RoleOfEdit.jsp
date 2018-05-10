<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<script type="text/javascript">
$(document).ready(function(){
	$("#btn_edit_role").click(function(){
		if($("#roleRid_edit").val() == ""){
			alert("角色编号不能为空！");
			return false;
		}
		if($("#roleName_edit").val() == ""){
			alert("角色名称不能为空！");
			return false;
		}
		if($("#roleInfo_edit").val() == ""){
			alert("角色详情不能为空！");
			return false;
		}
		$.ajax({
			url:"${pageContext.request.contextPath }/roles/doedit.do",
			type:"post",
			data:$("#formedit_role").serialize(),
			dataType:"json",
			success:function(jsonResult){
				if(jsonResult.tag==1){
					datatable_role.draw(1);
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
<form id="formedit_role" name="roleedit" method="post">
	<input id="id" name="id" type="hidden" value=${role.id }>
	<div class="form-group">
    <label for="roleRid_edit">角色编号</label>
    <input type="text" class="form-control" id="roleRid_edit" name="rid" placeholder="Rid" value="${role.rid }" readonly="readonly" style="width: 200px;color: black;">
  	</div>
	<div class="form-group">
    <label for="roleName_edit">角色名称</label>
    <input type="text" class="form-control" id="roleName_edit" name="rname" value="${role.rname }" placeholder="Rname" style="width: 200px;">
  	</div>
  	<div class="form-group">
    <label for="roleInfo_edit">角色详情</label>
  	<textarea class="form-control" id="roleInfo_edit" rows="8" cols="200px" name="roleinfo">${role.roleinfo }</textarea>
  	</div>
	<br>
	<div align="left" style="float:left">
	<button type="button" class="btn btn-success" id="btn_edit_role" name="btn_edit_role" data-dismiss="modal">提交</button>
	</div>
	<div align="right">
	<button type="reset" class="btn btn-primary" id="reset" name="reset">重置</button>
	</div>
</form>
</div>
</body>
</html>