<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>

<SCRIPT type="text/javascript">

		var setting = {
			check:{
				enable:true,
				chkStyle:"checkbox",
				chkboxType:{"Y":"ps","N":"s"}
			},
			data: {
				key:{
					name:"pname"
				},
				simpleData: {
					enable: true,
					idKey:"id",
					pIdKey:"parentid",
					rootPId:0
				}
			}
		};
		
		$(document).ready(function(){
			$.ajax({
				type:"post",
				url:"${pageContext.request.contextPath}/permission/doallot_json.do",
				data:{
					"rid":$("#roleId").val()
				},
				dataType:"json",
				success:function(zNodes){
					$.fn.zTree.init($("#treeDemo2"), setting, zNodes);
					var treeObj = $.fn.zTree.getZTreeObj("treeDemo2");
					treeObj.expandAll(true)
				}
			});
			
			$("#btn_getnodes").click(function(){
				 var treeObj = $.fn.zTree.getZTreeObj("treeDemo2");
				 var nodes = treeObj.getCheckedNodes(true);
				 var pids="";
				 if(nodes!=null){
					 for(var i = 0 ; i<nodes.length;i++){
						 pids=pids+","+nodes[i].id;
					 }
				 }
				 if(pids.length>0){
					 pids= pids.substring(1);
				 }
				/* 分配权限 */
				 $.ajax({
						type:"post",
						url:"${pageContext.request.contextPath}/permission/dispatchpermission.do",
						data:{
							"pids":pids,
							"rid":$("#roleId").val()
						},
						dataType:"json",
						success:function(jsonResult){
							if(jsonResult.tag>0){
								alert(jsonResult.message);
							}else{
								alert(jsonResult.message);
							}

						}
					});
			})
		});
		
	</SCRIPT>

<body>
<div class="content_wrap">
	<div class="zTreeDemoBackground left">
		<ul id="treeDemo2" class="ztree"></ul>
		<input type="hidden" id="roleId" name="rid" value="${rid }">
	</div>
	<div class="right">
	<div align="left" style="float:left">
		<button type="button" class="btn btn-success" id="btn_getnodes" name="btn_getnodes" data-dismiss="modal">分配权限</button>
	</div>
	</div>
</div>
</body>
</html>