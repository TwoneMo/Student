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
	$("#s_c_btn_edit").click(function(){
		if($("#editc_classid").val()=="" || $("#editc_classid").val()=="0"){
			alert("班级不能为空！");
			return false;
		}
		$.ajax({
			url:"${pageContext.request.contextPath }/students/doEditC.do",
			type:"post",
			data:$("#formedit_s_c").serialize(),
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
<form id="formedit_s_c" name="self" method="post" >
	<input type="text" class="form-control" id="editc_id" name="id" value="${cstu.id }" style="width: 200px;color: black;">
	<div class="form-group">
    <label for="editc_sname">姓名</label>
    <input type="text" class="form-control" id="editc_sname" name="sname" value="${cstu.sname }" readonly="readonly" style="width: 200px;color: black;">
  	</div>
  	<div class="form-group">
    <label for="editc_classid">班级</label>
    <select class="form-control" class="form-control" id="editc_classid" name="classid" style="width:200px">
  		<option value="0">请选择</option>
		<c:forEach items="${classlist }" var="c">
			<option value="${c.classid}">${c.classname }</option>
		</c:forEach>
	</select>
  	</div>
  	<br />
  	<div align="left" style="float:left">
	<button type="button" class="btn btn-success" id="s_c_btn_edit" name="s_c_btn_edit" data-dismiss="modal">修改</button>
	</div>
	<div align="right">
	<button type="reset" class="btn btn-primary" id="reset" name="reset">重置</button>
	</div>
</form>
</body>
</html>