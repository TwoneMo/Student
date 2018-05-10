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
var datatable_course=null;

function createTableS(){
	if(datatable_course!=null){
		datatable_course.destroy();
	}
	datatable_course=$('#table_id_example_course').DataTable({
		searching:false,
		ordering:false,
		language: {
			url: '${pageContext.request.contextPath}/static/china.json'
		},
		"aLengthMenu":[[5,10,15,20],["5条","10条","15条","20条"]],
		serverSide:true,
		ajax:{
			url:"${pageContext.request.contextPath}/teach/doShowTeach_json.do",
			dataSrc:"data",
			data:{
				"classid":$("#cclassid").val()
			},
			type:"post"
		},
		columns:[
			{data:'course.cname'},
			{data:'teacher.tname'},
			{data:'course.score'},
			{data:'course.credit'}
		]
	})
}

function createTableT(){
	if(datatable_course!=null){
		datatable_course.destroy();
	}
	datatable_course=$('#table_id_example_course').DataTable({
		searching:false,
		ordering:false,
		language: {
			url: '${pageContext.request.contextPath}/static/china.json'
		},
		"aLengthMenu":[[5,10,15,20],["5条","10条","15条","20条"]],
		serverSide:true,
		ajax:{
			url:"${pageContext.request.contextPath}/teach/doShowTeach_json.do",
			dataSrc:"data",
			data:{
				"tid":$("#tid").val()
			},
			type:"post"
		},
		columns:[
			{data:'course.cname'},
			{data:'myclass.classname'},
			{data:'course.score'},
			{data:'course.credit'}
		]
	})
}

function createTableTW(){
	if(datatable_course!=null){
		datatable_course.destroy();
	}
	datatable_course=$('#table_id_example_course').DataTable({
		searching:false,
		ordering:false,
		language: {
			url: '${pageContext.request.contextPath}/static/china.json'
		},
		"aLengthMenu":[[5,10,15,20],["5条","10条","15条","20条"]],
		serverSide:true,
		ajax:{
			url:"${pageContext.request.contextPath}/course/doShowCourse_json.do",
			dataSrc:"data",
			data:{
				"cname":$("#course_show_search_name").val()
			},
			type:"post"
		},
		columns:[
			{data:'cname'},
			{data:'score'},
			{data:'credit'},
			{data:'id',render:function(data,type,row){
		        return "<a href='javascript:editCourse("+data+");'>修改</a>    <a href='javascript:delCourse("+data+");'>删除</a>    <a href='javascript:CourseInfo("+data+");'>详情</a>    <a href='javascript:addCourse("+data+");'>增加</a>"
		    }}
		]
	})
}

function createTableGM(){
	if(datatable_course!=null){
		datatable_course.destroy();
	}
	datatable_course=$('#table_id_example_course').DataTable({
		searching:false,
		ordering:false,
		language: {
			url: '${pageContext.request.contextPath}/static/china.json'
		},
		"aLengthMenu":[[5,10,15,20],["5条","10条","15条","20条"]],
		serverSide:true,
		ajax:{
			url:"${pageContext.request.contextPath}/course/doShowCourse_json.do",
			dataSrc:"data",
			data:{
				"cname":$("#course_show_search_name").val()
			},
			type:"post"
		},
		columns:[
			{data:'cname'},
			{data:'score'},
			{data:'credit'},
			{data:'id',render:function(data,type,row){
		        return "<a href='javascript:CourseInfo("+data+");'>详情</a>"
		    }}
		]
	})
}

$(document).ready( function () {
	var userrid = $("#userrid").val();
	if(userrid=="002"){
		createTableS();
	} else if (userrid=="003"){
		createTableT();
	} else if (userrid=="004"){
		$('#course_btnselect').click(function(){
			createTableTW();
		});
		createTableTW();
	} else if (userrid=="001"){
		$('#course_btnselect').click(function(){
			createTableGM();
		});
		createTableGM();
	}
});

function delCourse(id){
	bootbox.confirm({
	    message: "删除该课程将连带删除该课程下的所有教学关系，是否删除该课程？",
	    buttons: {
	        confirm: {
	            label: '是',
	            className: 'btn-success'
	        },
	        cancel: {
	            label: '否',
	            className: 'btn-danger'
	        }
	    },
	    callback: function (result) {
	    	if(result){
	    		$.ajax({
	    			url:"${pageContext.request.contextPath}/course/doDel.do",
	    			data:{
	    				"id":id
	    			},
	    			type:"post",
	    			dataType:"json",
	    			success:function(datajson){
	    				if(datajson.tag==1){
	    					datatable_course.draw(1);
	    				}else{
	    					alert(datajson.message)
	    				}
	    			},
	    			error:function(){
	    				alert("权限不够，不能访问！");
	    			}
	    		})
	    	}
	    }
	});
	
	
}
function editCourse(id){
	$.ajax({
		url:"${pageContext.request.contextPath}/course/toEdit.do",
		data:{
			"id":id
		},
		type:"post",
		dataType:"text",
		success:function(result){
			if(result=="<script>alert('权限不够，不能访问！')"){
				alert("权限不够，不能访问！");
			}else{
				bootbox.dialog({
					title:"课程修改",
				    message:result
				});
			}
		}
	})
}

function addCourse(id){
	$.ajax({
		url:"${pageContext.request.contextPath}/course/toAdd.do",
		data:{
			"id":id
		},
		type:"post",
		dataType:"text",
		success:function(result){
			if(result=="<script>alert('权限不够，不能访问！')"){
				alert("权限不够，不能访问！");
			}else{
				bootbox.dialog({
					title:"课程新增",
				    message:result
				});
			}
		}
	})
}

function CourseInfo(id){
	$.ajax({
		url:"${pageContext.request.contextPath}/course/toInfo.do",
		data:{
			"id":id
		},
		type:"post",
		dataType:"text",
		success:function(result){
			if(result=="<script>alert('权限不够，不能访问！')"){
				alert("权限不够，不能访问！");
			}else{
				bootbox.dialog({
					title:"教学详情",
				    message:result
				});
			}
		}
	})
}
</script>

<body>
<br>
<input type="hidden" id="userrid" value="${myuser.rid }" >
<c:if test="${myuser.rid=='002' }">
<input type="hidden" id="cclassid" name="classid" value="${student.classid }">
<table id="table_id_example_course" class="display">
    <thead>
        <tr>
        	<td>课程名称</td>
        	<td>授课老师</td>
        	<td>课程总分</td>
        	<td>课程学分</td>
        </tr>
    </thead>
    <tbody>
    
    </tbody>
</table>
</c:if>

<c:if test="${myuser.rid=='003' }">
<input type="hidden" id="tid" name="tid" value="${other.tid }">
<table id="table_id_example_course" class="display">
    <thead>
        <tr>
        	<td>课程名称</td>
        	<td>授课班级</td>
        	<td>课程总分</td>
        	<td>课程学分</td>
        </tr>
    </thead>
    <tbody>
    
    </tbody>
</table>
</c:if>

<c:if test="${myuser.rid!='002'&&myuser.rid!='003' }">
<form id="framsearch_course">
	课程名称：<input id="course_show_search_name" type="text" value="">
	<input id="course_btnselect" type="button" value="搜索">
</form>
<table id="table_id_example_course" class="display">
    <thead>
        <tr>
        	<td>课程名称</td>
        	<td>课程总分</td>
        	<td>课程学分</td>
        	<td>操作</td>
        </tr>
    </thead>
    <tbody>
    
    </tbody>
</table>
</c:if>

</body>
</html>