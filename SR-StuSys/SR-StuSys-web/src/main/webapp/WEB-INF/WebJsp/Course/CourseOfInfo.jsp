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
var datatable_teach=null;

function createTableTW(){
	if(datatable_teach!=null){
		datatable_teach.destroy();
	}
	datatable_teach=$('#table_id_example_courseInfo').DataTable({
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
				"courseid":$("#courseinfo_courseid").val()
			},
			type:"post"
		},
		columns:[
			{data:'myclass.classname'},
			{data:'teacher.tname'},
			{data:'id',render:function(data,type,row){
				return "<a href='javascript:editTeach("+data+");'>修改</a>    <a href='javascript:delTeach("+data+");'>删除</a>    <a href='javascript:addTeach("+data+");'>增加</a>"
		    }}
		]
	})
}

function createTableGM(){
	if(datatable_teach!=null){
		datatable_teach.destroy();
	}
	datatable_teach=$('#table_id_example_courseInfo').DataTable({
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
				"courseid":$("#courseinfo_courseid").val()
			},
			type:"post"
		},
		columns:[
			{data:'myclass.classname'},
			{data:'teacher.tname'}
		]
	})
}

$(document).ready( function () {
	var userrid = $("#courseinfo_user_rid").val();
	if(userrid=="004"){
		createTableTW();
	} else if (userrid=="001"){
		createTableGM();
	}
});

function delTeach(id){
	bootbox.confirm({
	    message: "是否删除该教学信息？",
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
	    			url:"${pageContext.request.contextPath}/teach/doDel.do",
	    			data:{
	    				"id":id
	    			},
	    			type:"post",
	    			dataType:"json",
	    			success:function(datajson){
	    				if(datajson.tag==1){
	    					datatable_teach.draw(1);
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
function editTeach(id){
	$.ajax({
		url:"${pageContext.request.contextPath}/teach/toEdit.do",
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
					title:"教学信息修改",
				    message:result
				});
			}
		}
	})
}

function addTeach(id){
	$.ajax({
		url:"${pageContext.request.contextPath}/teach/toAdd.do",
		data:{
			"id":id,
			"courseid":$("#courseinfo_courseid").val()
		},
		type:"post",
		dataType:"text",
		success:function(result){
			if(result=="<script>alert('权限不够，不能访问！')"){
				alert("权限不够，不能访问！");
			}else{
				bootbox.dialog({
					title:"教学信息新增",
				    message:result
				});
			}
		}
	})
}
</script>
<body>
<br>
<input type="hidden" id="courseinfo_user_rid" value="${myuser.rid }" >
<input type="hidden" id="courseinfo_courseid" value="${course.courseid }">
<c:if test="${myuser.rid=='004' }">
<table id="table_id_example_courseInfo" class="display">
    <thead>
        <tr>
        	<td>授课班级</td>
        	<td>授课老师</td>
        	<td>操作</td>
        </tr>
    </thead>
    <tbody>
    
    </tbody>
</table>
<a href='javascript:addTeach("+data+");'>增加</a>
</c:if>

<c:if test="${myuser.rid=='001' }">
<table id="table_id_example_courseInfo" class="display">
    <thead>
        <tr>
        	<td>授课班级</td>
        	<td>授课老师</td>
        </tr>
    </thead>
    <tbody>
    
    </tbody>
</table>
</c:if>
</body>
</html>