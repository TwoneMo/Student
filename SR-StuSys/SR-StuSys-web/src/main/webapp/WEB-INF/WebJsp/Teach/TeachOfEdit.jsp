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
	$("#teach_btn_edit").click(function(){
		if($("#edit_teach_classid").val() == "" || $("#edit_teach_classid").val() == "0" ){
			alert("授课班级不能为空！");
			return false;
		}
		if($("#edit_teach_tid").val() == "" || $("#edit_teach_tid").val() == "0" ){
			alert("授课老师不能为空！");
			return false;
		}
		$.ajax({
			url:"${pageContext.request.contextPath }/teach/doEdit.do",
			type:"post",
			data:$("#form_teach_edit").serialize(),
			dataType:"json",
			success:function(jsonResult){
				if(jsonResult.tag==1){
					datatable_teach.draw(1);
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
<form id="form_teach_edit" name="teachedit" method="post" >
	<input type="hidden" class="form-control" name="id" value="${teach.id }" style="width: 200px;">
    <input type="hidden" class="form-control" id="edit_courseid" name="courseid" value="${teach.courseid }" style="width: 200px;">
  	<div class="form-group">
    <label for="edit_teach_classid">授课班级</label>
    <select class="form-control" id="edit_teach_classid" name="classid" style="width:200px">
  		<option value="0">请选择</option>
		<c:forEach items="${class_list }" var="c">
		<c:if test="${teach.classid==c.classid }">
			<option value="${c.classid}" selected="selected">${c.classname }</option>
		</c:if>
		<c:if test="${teach.classid!=c.classid }">
			<option value="${c.classid}">${c.classname }</option>
		</c:if>
		</c:forEach>
	</select>
  	</div>
  	<div class="form-group">
    <label for="edit_teach_tid">授课老师</label>
    <select class="form-control" id="edit_teach_tid" name="tid" style="width:200px">
  		<option value="0">请选择</option>
    	<c:forEach items="${teacher_list }" var="t">
			<c:if test="${teach.tid==t.tid }">
  				<option value="${t.tid}" selected="selected">${t.tname }</option>
  			</c:if>
  			<c:if test="${teach.tid!=t.tid }">
  				<option value="${t.tid}">${t.tname }</option>
  			</c:if>
		</c:forEach>
	</select>
  	</div>
	<br />
	<div align="left" style="float:left">
	<button type="button" class="btn btn-success" id="teach_btn_edit" name="teach_btn_edit" data-dismiss="modal">提交</button>
	</div>
	<div align="right">
	<button type="reset" class="btn btn-primary" id="reset" name="reset">重置</button>
	</div>
</form>
</div>
</body>
</html>