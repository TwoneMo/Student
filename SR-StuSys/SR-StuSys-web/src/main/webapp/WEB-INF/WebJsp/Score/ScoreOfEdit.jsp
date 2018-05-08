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
	$("#btn_edit_score").click(function(){
		if($("#score_edit_score").val() == ""){
			alert("分数不能为空！");
			return false;
		}
		$.ajax({
			url:"${pageContext.request.contextPath }/score/doedit.do",
			type:"post",
			data:$("#formedit").serialize(),
			dataType:"json",
			success:function(jsonResult){
				if(jsonResult.tag==1){
					datatable_score.draw(1);
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
<form id="formedit" name="scoreedit" method="post" >
<input type="hidden" class="form-control" id="score_edit_id" name="id" placeholder="Id" value="${score.id }" style="width: 200px;color: black;">
	<div class="form-group">
    <label for="score_edit_sid">学生学号</label>
    <input type="text" class="form-control" id="score_edit_sid" name="sid" placeholder="Sid" value="${score.sid }" readonly="readonly" style="width: 200px;color: black;">
  	</div>
  	<div class="form-group">
    <label for="score_edit_courseid">考核科目</label>
    <input type="hidden" class="form-control" id="score_edit_courseid" name="courseid" placeholder="Courseid" value="${score.courseid }" style="width: 200px;">
  	<input type="text" class="form-control" id="score_edit_cname" placeholder="Courseid" value="${score.course.cname }" readonly="readonly" style="width: 200px;color: black;">
  	</div>
  	<div class="form-group">
    <label for="score_edit_score">评定分数</label>
    <input type="text" class="form-control" id="score_edit_score" name="score" placeholder="Score" value="${score.score }" style="width: 200px;">
  	</div>
	<br />
	<div align="left" style="float:left">
	<button type="button" class="btn btn-success" id="btn_edit_score" name="btn_edit_score" data-dismiss="modal">提交</button>
	</div>
	<div align="right">
	<button type="reset" class="btn btn-primary" id="reset" name="reset">重置</button>
	</div>
</form>
</div>
</body>
</html>