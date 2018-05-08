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
	$("#btn_add_score").click(function(){
		if($("#score_add_sid").val() == ""){
			alert("学生学号不能为空！");
			return false;
		}
		if($("#score_add_courseid").val() == "" || $("#score_add_courseid").val() == "0"){
			alert("考核科目不能为空！");
			return false;
		}
		if($("#score_add_score").val() == ""){
			alert("分数不能为空！");
			return false;
		}
		$.ajax({
			url:"${pageContext.request.contextPath }/score/doadd.do",
			type:"post",
			data:$("#formadd").serialize(),
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
<form id="formadd" name="scoreadd" method="post" >
	<div class="form-group">
    <label for="score_add_sid">学生学号</label>
    <input type="text" class="form-control" id="score_add_sid" name="sid" placeholder="Sid" style="width: 200px;">
  	</div>
  	<div class="form-group">
    <label for="score_add_courseid">考核科目</label>
    <select class="form-control" class="form-control" id="score_add_courseid" name="courseid" style="width:200px">
  		<option value="0">请选择</option>
		<c:forEach items="${courses }" var="c">
			<option value="${c.courseid}">${c.cname }</option>
		</c:forEach>
	</select>
  	</div>
  	<div class="form-group">
    <label for="score_add_score">评定分数</label>
    <input type="text" class="form-control" id="score_add_score" name="score" placeholder="Score" style="width: 200px;">
  	</div>
	<br />
	<div align="left" style="float:left">
	<button type="button" class="btn btn-success" id="btn_add_score" name="btn_add_score" data-dismiss="modal">提交</button>
	</div>
	<div align="right">
	<button type="reset" class="btn btn-primary" id="reset" name="reset">重置</button>
	</div>
</form>
</div>
</body>
</html>