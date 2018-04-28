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
	$("#course_btn_edit").click(function(){
		if($("#edit_courseid").val()==""){
			alert("课程编号不能为空！");
			return false;
		}
		if($("#edit_cname").val()==""){
			alert("课程名称不能为空！");
			return false;
		}
		if($("#edit_score").val()==""){
			alert("课程总分不能为空！");
			return false;
		}
		if($("#edit_credit").val()==""){
			alert("课程学分不能为空！");
			return false;
		}
		$.ajax({
			url:"${pageContext.request.contextPath }/course/doEdit.do",
			type:"post",
			data:$("#form_course_edit").serialize(),
			dataType:"json",
			success:function(jsonResult){
				if(jsonResult.tag==1){
					datatable_course.draw(1);
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
<form id="form_course_edit" name="courseedit" method="post" >
	<input type="text" class="form-control" name="id" value="${course.id }" placeholder="Id" style="width: 200px;">
	<div class="form-group">
    <label for="edit_courseid">课程编号</label>
    <input type="text" class="form-control" id="edit_courseid" name="courseid" value="${course.courseid }" placeholder="Courseid" style="width: 200px;">
  	</div>
  	<div class="form-group">
    <label for="edit_cname">课程名称</label>
    <input type="text" class="form-control" id="edit_cname" name="cname" value="${course.cname }" placeholder="Cname" style="width: 200px;">
  	</div>
  	<div class="form-group">
    <label for="edit_score">课程总分</label>
    <input type="text" class="form-control" id="edit_score" name="score" value="${course.score }" placeholder="Score" style="width: 200px;">
  	</div>
  	<div class="form-group">
    <label for="edit_credit">课程学分</label>
    <input type="text" class="form-control" id="edit_credit" name="credit" value="${course.credit }" placeholder="Credit" style="width: 200px;">
  	</div>
	<br />
	<div align="left" style="float:left">
	<button type="button" class="btn btn-success" id="course_btn_edit" name="course_btn_edit" data-dismiss="modal">提交</button>
	</div>
	<div align="right">
	<button type="reset" class="btn btn-primary" id="reset" name="reset">重置</button>
	</div>
</form>
</div>

</body>
</html>