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
	$("#class_btn_edit").click(function(){
		if($("#edit_classid").val()==""){
			alert("班级编号不能为空！");
			return false;
		}
		if($("#edit_classname").val()==""){
			alert("班级名称不能为空！");
			return false;
		}
		$.ajax({
			url:"${pageContext.request.contextPath }/class/doEdit.do",
			type:"post",
			data:$("#form_class_edit").serialize(),
			dataType:"json",
			success:function(jsonResult){
				if(jsonResult.tag==1){
					datatable_class.draw(1);
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
<form id="form_class_edit" name="classedit" method="post" >
	<input type="hidden" class="form-control" name="id" value="${myclass.id }" placeholder="Id" style="width: 200px;">
	<div class="form-group">
    <label for="edit_classid">班级编号</label>
    <input type="text" class="form-control" id="edit_classid" name="classid" value="${myclass.classid }" placeholder="Classid" style="width: 200px;">
  	</div>
  	<div class="form-group">
    <label for="edit_classname">班级名称</label>
    <input type="text" class="form-control" id="edit_classname" name="classname" value="${myclass.classname }" placeholder="Classname" style="width: 200px;">
  	</div>
  	<div class="form-group">
    <label for="edit_classinfo">班级详情</label>
    <input type="text" class="form-control" id="edit_classinfo" name="classinfo" value="${myclass.classinfo }" placeholder="Classinfo" style="width: 200px;">
  	</div>
	<br />
	<div align="left" style="float:left">
	<button type="button" class="btn btn-success" id="class_btn_edit" name="class_btn_edit" data-dismiss="modal">提交</button>
	</div>
	<div align="right">
	<button type="reset" class="btn btn-primary" id="reset" name="reset">重置</button>
	</div>
</form>
</div>
</body>
</html>