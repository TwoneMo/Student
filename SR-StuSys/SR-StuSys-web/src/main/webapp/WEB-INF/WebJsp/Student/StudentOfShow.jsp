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
			{data:'classid'},
			{data:'id',render:function(data,type,row){
		        return "<a href='javascript:searchStuByid("+data+");'>查看学生详情</a>"
		    }}
		]
	})
}

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
			{data:'classid'},
			{data:'id',render:function(data,type,row){
		        return "<a href='javascript:searchStuByid("+data+");'>查看学生详情</a>"
		    }}
		]
	})
}

function createTable(){
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
			url:"${pageContext.request.contextPath}/score/doShowCourse_json.do",
			dataSrc:"data",
			data:{
				"userName":$("#userName_s").val(),
				"userRoleid":$("#selroleids").val()
			},
			type:"post"
		},
		columns:[
			{data:'userName'},
			{data:'userPassword'},
			{data:'role.roleName'},
			{data:'userId',render:function(data,type,row){
		        return "<a href='javascript:editUser("+data+");'>修改</a>    <a href='javascript:delUser("+data+");'>删除</a>    <a href='javascript:addUser("+data+");'>增加</a>"
		    }}
		]
	})
}

$(document).ready( function () {
	var userrid = $("#userrid").val();
	if(userrid=="003"){
		$('#btnselect').click(function(){
			createTableT();
		});
		createTableT();
	} else if (userrid=="004"){
		
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

function delUser(userId){
	bootbox.confirm({
	    message: "是否删除该该用户？",
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
	    			url:"${pageContext.request.contextPath}/admin/users/dodel.do",
	    			data:{
	    				"userId":userId
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
function editUser(userId){
	$.ajax({
		url:"${pageContext.request.contextPath}/admin/users/toedit.do",
		data:{
			"userId":userId
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

function addUser(userId){
	$.ajax({
		url:"${pageContext.request.contextPath}/admin/users/toadd.do",
		data:{
			"userId":userId
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
<input type="text" id="userrid" value="${myuser.rid }" >
<input type="text" id="stu_classid" value="${classid }">
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

<c:if test="${myuser.rid!='002'&&myuser.rid!='003' }">
<form id="framsearch">
	用户名称：<input id="userName_s" type="text" value="">
	用户角色：<select id="selroleids">
		<option value="0">请选择</option>
		<c:forEach items="${roles }" var="r">
			<option value="${r.roleId}">${r.roleName }</option>
		</c:forEach>
	</select>
	<input id="btnselect" type="button" value="搜索">
</form>
<table id="table_id_example_student" class="display">
    <thead>
        <tr>
        	<td>课程名称</td>
        	<td>授课老师</td>
        	<td>课程分数</td>
        	<td>课程学分</td>
        </tr>
    </thead>
    <tbody>
    
    </tbody>
</table>
</c:if>
</body>
</html>