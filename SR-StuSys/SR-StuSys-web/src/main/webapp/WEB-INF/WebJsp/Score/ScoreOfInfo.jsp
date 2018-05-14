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
var datatable_score_info=null;

function createTableT(){
	//console.log("${teach}");
	if(datatable_score_info!=null){
		datatable_score_info.destroy();
	}
	datatable_score_info=$('#table_id_example_sinfo').DataTable({
		searching:false,
		ordering:false,
		language: {
			url: '${pageContext.request.contextPath}/static/china.json'
		},
		"aLengthMenu":[[5,10,15,20],["5条","10条","15条","20条"]],
		serverSide:true,
		ajax:{
			url:"${pageContext.request.contextPath}/score/doShowScore_jsonOfTea.do",
			dataSrc:"data",
			data:{
				"tid":$("#score_info_tid").val(),
				"classid":$("#score_info_classid").val(),
				"courseid":$("#score_info_courseid").val()
			},
			type:"post"
		},
		columns:[
			{data:'sid'},
			{data:'student.sname'},
			{data:'score'},
		]
	})
}

$(document).ready( function () {
	var userrid = $("#userrid_socre_info").val();
	if (userrid=="003"){
		$('#btnselect_score_max').click(function(){
			maxScore();
		});
		$('#btnselect_score_min').click(function(){
			minScore();
		});
		$('#btnselect_score_avg').click(function(){
			avgScore();
		});
		$('#btnselect_score_pass').click(function(){
			passRate();
		});
		createTableT();
	}
	
});

function maxScore(){
	$.ajax({
		url:"${pageContext.request.contextPath }/score/maxScore.do",
		type:"post",
		data:$("#framsearchs").serialize(),
		dataType:"json",
		success:function(jsonResult){
			alert(jsonResult.message);
		}
	})
}

function minScore(){
	$.ajax({
		url:"${pageContext.request.contextPath }/score/minScore.do",
		type:"post",
		data:$("#framsearchs").serialize(),
		dataType:"json",
		success:function(jsonResult){
			alert(jsonResult.message);
		}
	})
}

function avgScore(){
	$.ajax({
		url:"${pageContext.request.contextPath }/score/avgScore.do",
		type:"post",
		data:$("#framsearchs").serialize(),
		dataType:"json",
		success:function(jsonResult){
			alert(jsonResult.message);
		}
	})
}

function passRate(){
	$.ajax({
		url:"${pageContext.request.contextPath }/score/passRate.do",
		type:"post",
		data:$("#framsearchs").serialize(),
		dataType:"json",
		success:function(jsonResult){
			alert(jsonResult.message);
		}
	})
}
</script>
<body>
<br>
<input type="hidden" id="userrid_socre_info" value="${myuser.rid }" >
<c:if test="${myuser.rid=='003' }">
<form id="framsearchs">
<input type="hidden" id="score_info_tid" name="tid" value="${other.tid }" >
<input type="hidden" id="score_info_classid" name="classid" value="${teach_score.classid }" >
<input type="hidden" id="score_info_courseid" name="courseid" value="${teach_score.courseid }" >
<input id="btnselect_score_max" type="button" value="最高分">
<input id="btnselect_score_min" type="button" value="最低分">
<input id="btnselect_score_avg" type="button" value="平均分">
<input id="btnselect_score_pass" type="button" value="及格率">
</form>
<table id="table_id_example_sinfo" class="display">
    <thead>
        <tr>
        	<td>学生学号</td>
        	<td>学生姓名</td>
        	<td>评定分数</td>
        </tr>
    </thead>
    <tbody>
    
    </tbody>
</table>
</c:if>
</body>
</html>