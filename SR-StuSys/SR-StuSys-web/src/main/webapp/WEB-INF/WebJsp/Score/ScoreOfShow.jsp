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
var datatable_score=null;

function createTableS(){
	if(datatable_score!=null){
		datatable_score.destroy();
	}
	datatable_score=$('#table_id_example_score').DataTable({
		searching:false,
		ordering:false,
		language: {
			url: '${pageContext.request.contextPath}/static/china.json'
		},
		"aLengthMenu":[[5,10,15,20],["5条","10条","15条","20条"]],
		serverSide:true,
		ajax:{
			url:"${pageContext.request.contextPath}/score/doShowScore_json.do",
			dataSrc:"data",
			data:{
				"sid":$("#score_sid").val()
			},
			type:"post"
		},
		columns:[
			{data:'course.cname'},
			{data:'course.score'},
			{data:'score'}
		]
	})
}

function createTableT(){
	//console.log("${teach}");
	if(datatable_score!=null){
		datatable_score.destroy();
	}
	datatable_score=$('#table_id_example_score').DataTable({
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
				"tid":$("#score_tid").val(),
				"classid":$("#score_classid").val(),
				"courseid":$("#score_courseid").val()
			},
			type:"post"
		},
		columns:[
			{data:'sid'},
			{data:'student.sname'},
			{data:'student.myclass.classname'},
			{data:'course.cname'},
			{data:'score'},
			{data:'id',render:function(data,type,row){
		        return "<a href='javascript:editScore("+data+");'>修改</a>    <a href='javascript:delScore("+data+");'>删除</a>    <a href='javascript:addScore("+data+");'>增加</a>"
		    }}
		]
	})
}

function createTableGM(){
	if(datatable_score!=null){
		datatable_score.destroy();
	}
	datatable_score=$('#table_id_example_score').DataTable({
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
				"classid":$("#score_classid").val(),
				"courseid":$("#score_courseid").val()
			},
			type:"post"
		},
		columns:[
			{data:'sid'},
			{data:'student.sname'},
			{data:'student.myclass.classname'},
			{data:'course.cname'},
			{data:'score'}
		]
	})
}

$(document).ready( function () {
	var userrid = $("#userrid").val();
	if(userrid=="002"){
		$('#btnselect').click(function(){
			createTableS();
		});
		createTableS();
	} else if (userrid=="003"){
		$('#btnselect').click(function(){
			createTableT();
		});
		createTableT();
	} else if (userrid=="001"||userrid=="004"){
		$('#btnselect').click(function(){
			createTableGM();
		});
		createTableGM();
	}
});

function delScore(id){
	bootbox.confirm({
	    message: "是否删除该成绩？",
	    buttons: {
	        confirm: {
	            label: '删除',
	            className: 'btn-success'
	        },
	        cancel: {
	            label: '取消',
	            className: 'btn-danger'
	        }
	    },
	    callback: function (result) {
	    	if(result){
	    		$.ajax({
	    			url:"${pageContext.request.contextPath}/score/dodel.do",
	    			data:{
	    				"id":id
	    			},
	    			type:"post",
	    			dataType:"json",
	    			success:function(datajson){
	    				if(datajson.tag==1){
	    					datatable_score.draw(1);
	    				}else{
	    					alert(datajson.message)
	    				}
	    			}/* ,
	    			error:function(){
	    				alert("权限不够，不能访问！");
	    			} */
	    		})
	    	}
	    }
	});
	
	
}
function editScore(id){
	$.ajax({
		url:"${pageContext.request.contextPath}/score/toedit.do",
		data:{
			"id":id
		},
		type:"post",
		dataType:"text",
		success:function(result){
			bootbox.dialog({
				   message:result
			});
		}
	})
}

function addScore(id){
	$.ajax({
		url:"${pageContext.request.contextPath}/score/toadd.do",
		data:{
			"id":id
		},
		type:"post",
		dataType:"text",
		success:function(result){
			bootbox.dialog({
			    message:result
			});
		}
	})
}
</script>

<body>
<br>
<input type="hidden" id="userrid" value="${myuser.rid }" >
<c:if test="${myuser.rid=='002' }">
<input type="hidden" id="score_sid" name="sid" value="${student.sid }">
<table id="table_id_example_score" class="display">
    <thead>
        <tr>
        	<td>课程名称</td>
        	<td>课程总分</td>
        	<td>课程得分</td>        	
        </tr>
    </thead>
    <tbody>
    
    </tbody>
</table>
</c:if>

<c:if test="${myuser.rid=='003' }">
<input type="hidden" id="score_tid" name="tid" value="${other.tid }" >
<form id="framsearch">
	班级名称：<select id="score_classid">
		<option value="0">请选择</option>
		<c:forEach items="${teach }" var="t">
			<option value="${t.myclass.classid}">${t.myclass.classname }</option>
		</c:forEach>
	</select>
	课程名称：<select id="score_courseid">
		<option value="0">请选择</option>
		<c:forEach items="${teach }" var="t">
			<option value="${t.course.courseid}">${t.course.cname }</option>
		</c:forEach>
	</select>
	<input id="btnselect" type="button" value="搜索">
</form>
<table id="table_id_example_score" class="display">
    <thead>
        <tr>
        	<td>学生学号</td>
        	<td>学生姓名</td>
        	<td>学生班级</td>
        	<td>考核科目</td>
        	<td>评定分数</td>
        	<td>操作</td>
        </tr>
    </thead>
    <tbody>
    
    </tbody>
</table>
</c:if>

<c:if test="${myuser.rid=='001' || myuser.rid=='004' }">
<form id="framsearch">
	班级名称：<select id="score_classid">
		<option value="0">请选择</option>
		<c:forEach items="${allclass }" var="c">
			<option value="${c.classid}">${c.classname }</option>
		</c:forEach>
	</select>
	课程名称：<select id="score_courseid">
		<option value="0">请选择</option>
		<c:forEach items="${allcourse }" var="co">
			<option value="${co.courseid}">${co.cname }</option>
		</c:forEach>
	</select>
	<input id="btnselect" type="button" value="搜索">
</form>
<table id="table_id_example_score" class="display">
    <thead>
        <tr>
        	<td>学生学号</td>
        	<td>学生姓名</td>
        	<td>学生班级</td>
        	<td>考核科目</td>
        	<td>评定分数</td>
        </tr>
    </thead>
    <tbody>
    
    </tbody>
</table>
</c:if>

</body>
</html>