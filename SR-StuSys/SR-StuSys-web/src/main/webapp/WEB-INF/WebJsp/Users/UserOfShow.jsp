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
var datatable_users=null;

function createTableGM(){
	if(datatable_users!=null){
		datatable_users.destroy();
	}
	datatable_users=$('#table_id_example_users').DataTable({
		searching:false,
		ordering:false,
		language: {
			url: '${pageContext.request.contextPath}/static/china.json'
		},
		"aLengthMenu":[[5,10,15,20],["5条","10条","15条","20条"]],
		serverSide:true,
		ajax:{
			url:"${pageContext.request.contextPath}/users/doShowUsers_json.do",
			dataSrc:"data",
			data:{
				"username":$("#users_show_username").val()
			},
			type:"post"
		},
		columns:[
			{data:'username'},
			{data:'role.rname'},
			{data:'id',render:function(data,type,row){
		        return "<a href='javascript:addUser("+data+");'>增加</a>    <a href='javascript:resetPW("+data+");'>初始化密码</a>    <a href='javascript:delUser("+data+");'>删除</a>"
		    }}
		]
	})
}

$(document).ready( function () {
	var userrid = $("#userrid").val();
	if (userrid=="001"){
		$('#btnselect').click(function(){
			createTableGM();
		});
		createTableGM();
	}
});

function delUser(id){
	bootbox.confirm({
	    message: "该用户相关所有数据都将一并删除，是否删除该用户？",
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
	    			url:"${pageContext.request.contextPath}/users/dodel.do",
	    			data:{
	    				"id":id
	    			},
	    			type:"post",
	    			dataType:"json",
	    			success:function(datajson){
	    				if(datajson.tag==1){
	    					datatable_users.draw(1);
	    				}else{
	    					alert(datajson.message)
	    				}
	    			} ,
	    			error:function(){
	    				alert("权限不够，不能访问！");
	    			} 
	    		})
	    	}
	    }
	});
}

function resetPW(id){
	bootbox.confirm({
	    message: "是否初始化该用户的密码？",
	    buttons: {
	        confirm: {
	            label: '重置',
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
	    			url:"${pageContext.request.contextPath}/users/resetPW.do",
	    			data:{
	    				"id":id
	    			},
	    			type:"post",
	    			dataType:"json",
	    			success:function(datajson){
	    				if(datajson.tag==1){
	    					alert(datajson.message);
	    					datatable_users.draw(1);
	    				}else{
	    					alert(datajson.message)
	    				}
	    			} ,
	    			error:function(){
	    				alert("权限不够，不能访问！");
	    			} 
	    		})
	    	}
	    }
	});
}

function addUser(id){
	$.ajax({
		url:"${pageContext.request.contextPath}/users/toCreateAccount.do",
		data:{
			"id":id
		},
		type:"post",
		dataType:"text",
		success:function(result){
			bootbox.dialog({
				title:"用户新增",
			    message:result
			});
		}
	})
}
</script>
<body>
<br>
<input type="hidden" id="userrid" value="${myuser.rid }" >

<c:if test="${myuser.rid=='001' }">
<form id="framsearch">
	用户名称：<input id="users_show_username" type="text" value="">
	<input id="btnselect" type="button" value="搜索">
</form>
<table id="table_id_example_users" class="display">
    <thead>
        <tr>
        	<td>用户姓名</td>
        	<td>用户角色</td>
        	<td>操作</td>
        </tr>
    </thead>
    <tbody>
    
    </tbody>
</table>
</c:if>
</body>
</html>