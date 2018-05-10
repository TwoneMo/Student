<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<script type="text/javascript">
var datatable_role=null;
function createTable(){
	if(datatable_role!=null){
		datatable_role.destroy();
	}
	datatable_role=$('#table_id_example_role').DataTable({
		searching:false,
		ordering:false,
		language: {
			url: '${pageContext.request.contextPath}/static/china.json'
		},
		"aLengthMenu":[[5,10,15,20],["5条","10条","15条","20条"]],
		serverSide:true,
		ajax:{
			url:"${pageContext.request.contextPath}/roles/doshow_json.do",
			dataSrc:"data",
			data:{
				"rname":$("#roleName_s").val()
			},
			type:"post"
		},
		columns:[
			{data:'rname'},
			{data:'roleinfo'},
			{data:'id',render:function(data,type,row){
		        return "<a href='javascript:editRole("+data+");'>修改</a>    <a href='javascript:delRole("+data+");'>删除</a>    <a href='javascript:addRole("+data+");'>增加</a>    <a href='javascript:addPer("+data+");'>分配权限</a>"
		    }}
		]
	})
}

$(document).ready( function () {
	$('#btnselect_role_show').click(function(){
		createTable();
	});
	createTable();
});

function delRole(id){
	bootbox.confirm({
	    message: "是否删除该角色？",
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
	    			url:"${pageContext.request.contextPath}/roles/dodel.do",
	    			data:{
	    				"id":id
	    			},
	    			type:"post",
	    			dataType:"json",
	    			success:function(datajson){
	    				if(datajson.tag == 1){
	    					datatable_role.draw(1);
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
function editRole(id){
	$.ajax({
		url:"${pageContext.request.contextPath}/roles/toedit.do",
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

function addRole(id){
	$.ajax({
		url:"${pageContext.request.contextPath}/roles/toadd.do",
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

function addPer(id){
	$.ajax({
		url:"${pageContext.request.contextPath}/permission/doallot.do",
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
<form id="framsearch">
	角色名称：<input id="roleName_s" type="text" value="">
	<input id="btnselect_role_show" type="button" value="搜索">
</form>
<table id="table_id_example_role" class="display">
    <thead>
        <tr>
        	<td>角色名称</td>
        	<td>角色详情</td>
        	<td>操作</td>
        </tr>
    </thead>
    <tbody>
    
    </tbody>
</table>
</body>
</html>