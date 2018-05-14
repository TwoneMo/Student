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
	$("#btn_edit_permission").click(function(){
		if($("#perPid_edit").val() == ""){
			alert("权限编号不能为空！");
			return false;
		}
		if($("#perName_edit").val() == ""){
			alert("权限名称不能为空！");
			return false;
		}
		if($("#perUrl_edit").val() == ""){
			alert("权限URL不能为空！");
			return false;
		}
		if($("#perParentid_edit").val() == ""){
			alert("父权限不能为空！");
			return false;
		}
		if($("#perIsparent_edit").val() == ""){
			alert("是否是父权限不能为空！");
			return false;
		}
		if($("#perIsmenu_edit").val() == ""){
			alert("是否是菜单不能为空！");
			return false;
		}
		$.ajax({
			url:"${pageContext.request.contextPath }/permission/doedit.do",
			type:"post",
			data:$("#formedit_permission").serialize(),
			dataType:"json",
			success:function(jsonResult){
				/* if(jsonResult.tag==1){
					datatable.draw(1);
					$(".bootbox-close-button").click();
				} */
				if(jsonResult.tag > 0){
					var zTree = $.fn.zTree.getZTreeObj("treeDemo");
					var selectnode=zTree.getNodeByTId($("#tId").val());
					zTree.reAsyncChildNodes(selectnode.getParentNode(),"refresh");
					//alert("修改成功");
					alert(jsonResult.message);
					$("#right").empty();
				}else{
					//alert("修改失败");
					alert(jsonResult.message);
					$("#right").empty();
				}
			}
		})
	});
});
</script>

<body>
<div style="margin: auto; width: 200px;">
<form id="formedit_permission" name="permissionedit" method="post">
	<input id="tId" type="hidden" value="${requestScope.tId }"><br>
	<input class="form-control" id="id" name="id" type="hidden" value="${requestScope.permission.id }"><br>
	<div class="form-group">
    <label for="perPid_edit">权限编号</label>
    <input type="text" class="form-control" id="perPid_edit" name="pid" placeholder="Pid" value="${requestScope.permission.pid }" readonly="readonly"  style="width: 200px;color: black;">
  	</div>
	<div class="form-group">
    <label for="perName_edit">权限名称</label>
    <input type="text" class="form-control" id="perName_edit" name="pname" placeholder="Pname" value="${requestScope.permission.pname }" style="width: 200px;">
  	</div>
  	<div class="form-group">
    <label for="perUrl_edit">权限URL</label>
    <input type="text" class="form-control" id="perUrl_edit" name="url" placeholder="Url" value="${requestScope.permission.url }" style="width: 200px;">
  	</div>
  	<div class="form-group">
    <label for="perParentid_edit">父权限</label>
    <input type="text" class="form-control" id="perParentid_edit" name="parentid" placeholder="Parentid" value="${requestScope.permission.parentid }" readonly="readonly" style="width: 200px;color: black;">
  	</div>
	<!-- 是否是菜单： --><input id="perIsmenu_edit" name="ismenu" type="hidden" value="${requestScope.permission.ismenu }" ><br>
	<!-- 是否是父权限： --><input id="perIsparent_edit" name="isparent" type="hidden" value="${requestScope.permission.isparent }" ><br>
	<br>
	<div align="left" style="float:left">
	<button type="button" class="btn btn-success" id="btn_edit_permission" name="btn_edit_permission" data-dismiss="modal">提交</button>
	</div>
	<div align="right">
	<button type="reset" class="btn btn-primary" id="reset" name="reset">重置</button>
	</div>
	<br>
</form>
</div>
</body>
</html>