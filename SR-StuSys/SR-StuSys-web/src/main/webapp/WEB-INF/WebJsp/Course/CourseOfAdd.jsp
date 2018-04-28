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
	$("#course_btn_add").click(function(){
		if($("#add_courseid").val()==""){
			alert("课程编号不能为空！");
			return false;
		}
		if($("#add_cname").val()==""){
			alert("课程名称不能为空！");
			return false;
		}
		if($("#add_score").val()==""){
			alert("课程总分不能为空！");
			return false;
		}
		if($("#add_credit").val()==""){
			alert("课程学分不能为空！");
			return false;
		}
		$.ajax({
			url:"${pageContext.request.contextPath }/course/doAdd.do",
			type:"post",
			data:$("#form_course_add").serialize(),
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
<form id="form_course_add" name="courseadd" method="post" >
	<div class="form-group">
    <label for="add_courseid">课程编号</label>
    <input type="text" class="form-control" id="add_courseid" name="courseid" placeholder="Courseid" style="width: 200px;">
  	</div>
  	<div class="form-group">
    <label for="add_cname">课程名称</label>
    <input type="text" class="form-control" id="add_cname" name="cname" placeholder="Cname" style="width: 200px;">
  	</div>
  	<div class="form-group">
    <label for="add_score">课程总分</label>
    <input type="text" class="form-control" id="add_score" name="score" placeholder="Score" style="width: 200px;">
  	</div>
  	<div class="form-group">
    <label for="add_credit">课程学分</label>
    <input type="text" class="form-control" id="add_credit" name="credit" placeholder="Credit" style="width: 200px;">
  	</div>
	<br />
	<div align="left" style="float:left">
	<button type="button" class="btn btn-success" id="course_btn_add" name="course_btn_add" data-dismiss="modal">提交</button>
	</div>
	<div align="right">
	<button type="reset" class="btn btn-primary" id="reset" name="reset">重置</button>
	</div>
</form>
</div>
</body>
</html>