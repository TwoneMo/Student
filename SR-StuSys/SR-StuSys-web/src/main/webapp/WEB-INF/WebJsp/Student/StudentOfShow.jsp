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
var datatable_student=null;

function createTableT(){
	if(datatable_student!=null){
		datatable_student.destroy();
	}
	datatable_student=$('#table_id_example_student').DataTable({
		searching:false,
		ordering:false,
		language: {
			url: '${pageContext.request.contextPath}/static/china.json'
		},
		"aLengthMenu":[[5,10,15,20],["5条","10条","15条","20条"]],
		serverSide:true,
		ajax:{
			url:"${pageContext.request.contextPath}/students/doShowStudent_json.do",
			dataSrc:"data",
			data:{
				"classid":$("#stu_classid").val()
			},
			type:"post"
		},
		columns:[
			{data:'sid'},
			{data:'sname'},
			{data:'myclass.classname'},
			{data:'id',render:function(data,type,row){
		        return "<a href='javascript:searchStuByid("+data+");'>查看学生详情</a>"
		    }}
		]
	})
}

function createTableTW(){
	if(datatable_student!=null){
		datatable_student.destroy();
	}
	datatable_student=$('#table_id_example_student').DataTable({
		searching:false,
		ordering:false,
		language: {
			url: '${pageContext.request.contextPath}/static/china.json'
		},
		"aLengthMenu":[[5,10,15,20],["5条","10条","15条","20条"]],
		serverSide:true,
		ajax:{
			url:"${pageContext.request.contextPath}/students/doShowStudent_json.do",
			dataSrc:"data",
			data:{
				"classid":$("#stu_classid").val(),
				"sname":$("#StuName").val()
			},
			type:"post"
		},
		columns:[
			{data:'sid'},
			{data:'sname'},
			{data:'myclass.classname'},
			{data:'id',render:function(data,type,row){
		        return "<a href='javascript:editCStu("+data+");'>修改</a>    <a href='javascript:delCStu("+data+");'>删除</a>	   <a href='javascript:searchStuByid("+data+");'>查看学生详情</a>    <a href='javascript:addCStu("+data+");'>增加</a>"
		    }}
		]
	})
}

function createTableGM(){
	if(datatable_student!=null){
		datatable_student.destroy();
	}
	datatable_student=$('#table_id_example_student').DataTable({
		searching:false,
		ordering:false,
		language: {
			url: '${pageContext.request.contextPath}/static/china.json'
		},
		"aLengthMenu":[[5,10,15,20],["5条","10条","15条","20条"]],
		serverSide:true,
		ajax:{
			url:"${pageContext.request.contextPath}/students/doShowStudent_json.do",
			dataSrc:"data",
			data:{
				"classid":$("#stu_classid").val(),
				"sname":$("#StuName").val()
			},
			type:"post"
		},
		columns:[
			{data:'sid'},
			{data:'sname'},
			{data:'myclass.classname'},
			{data:'id',render:function(data,type,row){
		        return "<a href='javascript:searchStuByid("+data+");'>查看学生详情</a>"
		    }}
		]
	})
}

$(document).ready( function () {
	var userrid = $("#userrid").val();
	if(userrid=="003"){
		createTableT();
	} else if (userrid=="004"){
		$('#Stu_Show_btnselect').click(function(){
			createTableTW();
		});
		createTableTW();
	} else if (userrid=="001"){
		$('#Stu_Show_btnselect').click(function(){
			createTableGM();
		});
		createTableGM();
	}
});

function searchStuByid(id){
	$.ajax({
		url:"${pageContext.request.contextPath}/students/toShowStuByid.do",
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

function delCStu(id){
	bootbox.confirm({
	    message: "是否删除该学生的班级信息？",
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
	    		alert(id);
	    		$.ajax({
	    			url:"${pageContext.request.contextPath}/students/doDelC.do",
	    			data:{
	    				"id":id
	    			},
	    			type:"post",
	    			dataType:"json",
	    			success:function(datajson){
	    				if(datajson.tag==1){
	    					datatable_student.draw(1);
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
function editCStu(id){
	$.ajax({
		url:"${pageContext.request.contextPath}/students/toEditC.do",
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
				    message:result
				});
			}
		}
	})
}

function addCStu(id){
	$.ajax({
		url:"${pageContext.request.contextPath}/students/toAddC.do",
		data:{
			"classid":$("#stu_classid").val()
		},
		type:"post",
		dataType:"text",
		success:function(result){
			if(result=="<script>alert('权限不够，不能访问！')"){
				alert("权限不够，不能访问！");
			}else{
				bootbox.dialog({
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
<input type="hidden" id="stu_classid" value="${classid }">

<c:if test="${myuser.rid=='003' }">
<table id="table_id_example_student" class="display">
    <thead>
        <tr>
        	<td>学生学号</td>
        	<td>学生名称</td>
        	<td>所属班级</td>
        	<td>学生详情</td>
        </tr>
    </thead>
    <tbody>
    
    </tbody>
</table>
</c:if>

<c:if test="${myuser.rid=='004' }">
<form id="framsearch">
	学生名称：<input id="StuName" type="text" value="">
	<input id="Stu_Show_btnselect" type="button" value="搜索">
</form>
<table id="table_id_example_student" class="display">
    <thead>
        <tr>
        	<td>学生学号</td>
        	<td>学生名称</td>
        	<td>所属班级</td>
        	<td>操作</td>
        </tr>
    </thead>
    <tbody>
    
    </tbody>
</table>
<a href='javascript:addCStu("+data+");'>增加</a>
</c:if>

<c:if test="${myuser.rid=='001' }">
<form id="framsearch">
	学生名称：<input id="StuName" type="text" value="">
	<input id="Stu_Show_btnselect" type="button" value="搜索">
</form>
<table id="table_id_example_student" class="display">
    <thead>
        <tr>
        	<td>学生学号</td>
        	<td>学生名称</td>
        	<td>所属班级</td>
        	<td>学生详情</td>
        </tr>
    </thead>
    <tbody>
    
    </tbody>
</table>
</c:if>
</body>
</html>