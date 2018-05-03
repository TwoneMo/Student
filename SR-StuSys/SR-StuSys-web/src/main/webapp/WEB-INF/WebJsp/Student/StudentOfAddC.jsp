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
	$("#s_c_btn_add").click(function(){
		if($("#addc_sid").val()=="" && $("#addc_sid").val()=="0"){
			alert("姓名不能为空！");
			return false;
		}
		$.ajax({
			url:"${pageContext.request.contextPath }/students/doAddC.do",
			type:"post",
			data:$("#formadd_s_c").serialize(),
			dataType:"json",
			success:function(jsonResult){
				if(jsonResult.tag==1){
					datatable_student.draw(1);
				}else{
					alert(jsonResult.message);
				}
			}
		})
	});
});
</script>
<body>
<form id="formadd_s_c" name="self" method="post" >
	<div class="form-group">
    <label for="addc_sid">姓名</label>
    <select class="form-control" class="form-control" id="addc_sid" name="sid" style="width:200px">
  		<option value="0">请选择</option>
		<c:forEach items="${NoClassStu }" var="n">
			<option value="${n.id}">${n.sname }</option>
		</c:forEach>
	</select>
  	</div>
  	<div class="form-group">
    	<label for="addc_classid">班级</label>
    	<input type="text" class="form-control" id="addc_classid" name="classid" value="${classid }" readonly="readonly" style="width: 200px;color: black;">
    </div>
  	<br />
  	<div align="left" style="float:left">
	<button type="button" class="btn btn-success" id="s_c_btn_add" name="s_c_btn_add" data-dismiss="modal">修改</button>
	</div>
	<div align="right">
	<button type="reset" class="btn btn-primary" id="reset" name="reset">重置</button>
	</div>
</form>
</body>
</html>