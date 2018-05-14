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
var datatable_class=null;

function createTableT(){
	if(datatable_class!=null){
		datatable_class.destroy();
	}
	datatable_class=$('#table_id_example_class').DataTable({
		searching:false,
		ordering:false,
		language: {
			url: '${pageContext.request.contextPath}/static/china.json'
		},
		"aLengthMenu":[[5,10,15,20],["5条","10条","15条","20条"]],
		serverSide:true,
		ajax:{
			url:"${pageContext.request.contextPath}/teach/doShowClass_json.do",
			dataSrc:"data",
			data:{
				"tid":$("#class_show_tid").val()
			},
			type:"post"
		},
		columns:[
			{data:'myclass.classname'},
			{data:'myclass.classinfo'},
			{data:'myclass.classid',render:function(data,type,row){
		        return "<a href='javascript:searchStuByclassid("+data+");'>查看班级详情</a>"
		    }}
		]
	})
}

function createTableTW(){
	if(datatable_class!=null){
		datatable_class.destroy();
	}
	datatable_class=$('#table_id_example_class').DataTable({
		searching:false,
		ordering:false,
		language: {
			url: '${pageContext.request.contextPath}/static/china.json'
		},
		"aLengthMenu":[[5,10,15,20],["5条","10条","15条","20条"]],
		serverSide:true,
		ajax:{
			url:"${pageContext.request.contextPath}/class/doShowClass_json.do",
			dataSrc:"data",
			data:{
				"classname":$("#class_show_name").val()
			},
			type:"post"
		},
		columns:[
			{data:'classname'},
			{data:'classinfo'},
			{data:'id',render:function(data,type,row){
				return "<a href='javascript:editClass("+data+");'>修改</a>    <a href='javascript:delClass("+data+");'>删除</a>    <a href='javascript:ClassInfo("+data+");'>详情</a>    <a href='javascript:addClass("+data+");'>增加</a>"
		    }}
		]
	})
}

function createTableGM(){
	if(datatable_class!=null){
		datatable_class.destroy();
	}
	datatable_class=$('#table_id_example_class').DataTable({
		searching:false,
		ordering:false,
		language: {
			url: '${pageContext.request.contextPath}/static/china.json'
		},
		"aLengthMenu":[[5,10,15,20],["5条","10条","15条","20条"]],
		serverSide:true,
		ajax:{
			url:"${pageContext.request.contextPath}/class/doShowClass_json.do",
			dataSrc:"data",
			data:{
				"classname":$("#class_show_name").val()
			},
			type:"post"
		},
		columns:[
			{data:'classname'},
			{data:'classinfo'},
			{data:'id',render:function(data,type,row){
				return "<a href='javascript:ClassInfo("+data+");'>详情</a>"
		    }}
		]
	})
}

$(document).ready( function () {
	var userrid = $("#userrid").val();
	if(userrid=="003"){
		createTableT();
	} else if (userrid=="004"){
		$('#class_btnselect').click(function(){
			createTableTW();
		});
		createTableTW();
	} else if (userrid=="001"){
		$('#class_btnselect').click(function(){
			createTableGM();
		});
		createTableGM();
	}
});

function searchStuByclassid(classid){
	$.ajax({
		url:"${pageContext.request.contextPath}/students/toShowStudent.do",
		data:{
			"classid":classid
		},
		type:"post",
		dataType:"text",
		success:function(result){
				bootbox.dialog({
					title:"班级详情",
				    message:result
				});
		}
	})
}

function delClass(id){
	bootbox.confirm({
	    message: "删除该班级将连携删除该班级下的所有学生归属信息，是否删除该该用户？",
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
	    			url:"${pageContext.request.contextPath}/class/doDel.do",
	    			data:{
	    				"id":id
	    			},
	    			type:"post",
	    			dataType:"json",
	    			success:function(datajson){
	    				if(datajson.tag==1){
	    					datatable_class.draw(1);
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
function editClass(id){
	$.ajax({
		url:"${pageContext.request.contextPath}/class/toEdit.do",
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
					title:"班级修改",
				    message:result
				});
			}
		}
	})
}

function addClass(id){
	$.ajax({
		url:"${pageContext.request.contextPath}/class/toAdd.do",
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
					title:"班级新增",
				    message:result
				});
			}
		}
	})
}

function ClassInfo(id){
	$.ajax({
		url:"${pageContext.request.contextPath}/class/toInfo.do",
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
</script>

<body>
<br>
<input type="hidden" id="userrid" value="${myuser.rid }" >

<c:if test="${myuser.rid=='003' }">
<input type="text" id="class_show_tid" name="tid" value="${other.tid }" hidden>
<table id="table_id_example_class" class="display">
    <thead>
        <tr>
        	<td>班级名称</td>
        	<td>班级备注</td>
        	<td>班级详情</td>
        </tr>
    </thead>
    <tbody>
    
    </tbody>
</table>
</c:if>

<c:if test="${myuser.rid=='004' }">
<form id="framsearch">
	班级名称：<input id="class_show_name" type="text" value="">
	<input id="class_btnselect" type="button" value="搜索">
</form>
<table id="table_id_example_class" class="display">
    <thead>
        <tr>
        	<td>班级名称</td>
        	<td>班级备注</td>
        	<td>操作</td>
        </tr>
    </thead>
    <tbody>
    
    </tbody>
</table>
</c:if>

<c:if test="${myuser.rid=='001' }">
<form id="framsearch">
	班级名称：<input id="class_show_name" type="text" value="">
	<input id="class_btnselect" type="button" value="搜索">
</form>
<table id="table_id_example_class" class="display">
    <thead>
        <tr>
        	<td>班级名称</td>
        	<td>班级备注</td>
        	<td>操作</td>
        </tr>
    </thead>
    <tbody>
    
    </tbody>
</table>
</c:if>
</body>
</html>