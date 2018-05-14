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
	$("#btn_add_permission").click(function(){
		if($("#perPid_add").val() == ""){
			alert("权限编号不能为空！");
			return false;
		}
		if($("#perName_add").val() == ""){
			alert("权限名称不能为空！");
			return false;
		}
		if($("#perUrl_add").val() == ""){
			alert("权限URL不能为空！");
			return false;
		}
		if($("#perParentid_add").val() == ""){
			alert("父权限不能为空！");
			return false;
		}
		if($("#perIsparent_add").val() == ""){
			alert("是否是父权限不能为空！");
			return false;
		}
		if($("#perIsmenu_add").val() == ""){
			alert("是否是菜单不能为空！");
			return false;
		}
		$.ajax({
			url:"${pageContext.request.contextPath }/permission/doadd.do",
			type:"post",
			data:$("#formadd_permission").serialize(),
			dataType:"json",
			success:function(jsonResult){
				/* if(jsonResult.tag==1){
					datatable.draw(1);
					$(".bootbox-close-button").click();
				} */
				if(jsonResult.tag>0){
					var zTree = $.fn.zTree.getZTreeObj("treeDemo");
					//var selectnodes = zTree.getSelectedNodes();
					var selectnode = zTree.getNodeByTId($("#tId").val());
					if(selectnode){
						if(selectnode.isParent == true){
							zTree.reAsyncChildNodes(selectnode,"refresh");
							alert(jsonResult.message);
							$("#right").empty();
						}else{
							zTree.reAsyncChildNodes(selectnode.getParentNode(),"refresh");
							alert(jsonResult.message);
							$("#right").empty();
						}
					}else{
						zTree.reAsyncChildNodes(null,"refresh");
						alert(jsonResult.message);
						$("#right").empty();
					}
				}else{
					//alert("添加失败");
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
<form id="formadd_permission" name="permissionadd" method="post">
	<input id="tId" type="hidden" value="${requestScope.tId }"><br>
	<div class="form-group">
    <label for="perPid_add">权限编号</label>
    <input type="text" class="form-control" id="perPid_add" name="pid" placeholder="Pid" style="width: 200px;">
  	</div>
	<div class="form-group">
    <label for="perName_add">权限名称</label>
    <input type="text" class="form-control" id="perName_add" name="pname" placeholder="Pname" style="width: 200px;">
  	</div>
  	<div class="form-group">
    <label for="perUrl_add">权限URL</label>
    <input type="text" class="form-control" id="perUrl_add" name="url" placeholder="Url" style="width: 200px;">
  	</div>
  	<div class="form-group">
    <label for="perParentid_add">父权限</label>
    <input type="text" class="form-control" id="perParentid_add" name="parentid" placeholder="Parentid" value="${requestScope.parentid }" readonly="readonly" style="width: 200px;color: black;">
  	</div>
  	<!-- 是否是菜单： --><input id="perIsmenu_add" name="ismenu" type="hidden" value="1"><br>
	<!-- 是否是父权限： --><input id="perIsparent_add" name="isparent" type="hidden" value="0">
	<br>
	<div align="left" style="float:left">
	<button type="button" class="btn btn-success" id="btn_add_permission" name="btn_add_permission" data-dismiss="modal">提交</button>
	</div>
	<div align="right">
	<button type="reset" class="btn btn-primary" id="reset" name="reset">重置</button>
	</div>
	<br>
</form>
</div>
</body>
</html>