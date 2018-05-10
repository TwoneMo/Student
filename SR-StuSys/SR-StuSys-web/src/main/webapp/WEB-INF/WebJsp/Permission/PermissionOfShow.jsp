<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>

<style type="text/css">
.ztree li span.button.add {margin-left:2px; margin-right: -1px; background-position:-144px 0; vertical-align:top; *vertical-align:middle}
</style>

	<SCRIPT type="text/javascript">
		var setting = {
			async: {
				enable: true,
				url:"${pageContext.request.contextPath}/permission/getpermissionbyparentid.do",
				autoParam:["id", "pname", "level"],
				otherParam:{"otherParam":"zTreeAsyncTest"}
			},
			view: {expandSpeed:"fast",
				addHoverDom: addHoverDom,
				removeHoverDom: removeHoverDom,
				selectedMulti: false,
				showLine:true
			},
			edit: {
				enable: true
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
			},
			callback:{
				beforeEditName:zTreeBeforeEditName,
				beforeRemove:zTreeBeforeRemove,
				beforeDrop:zTreeBeforeDrop
			}
		};
		
		function zTreeBeforeEditName(treeId,treeNode){
			$.ajax({
				url:"${pageContext.request.contextPath}/permission/toedit.do",
				type:"post",
				data:{
					"id":treeNode.id,
					"tId":treeNode.tId
				},
				dataType:"text",
				success:function(content){
					$("#right").html(content);
				}
			});
			return false;
		}
		
		function zTreeBeforeDrop(treeId,treeNodes,targetNode,moveType){
			var id = treeNodes[0].id;
			var oldparentid = treeNodes[0].getParentNode()==null?0:treeNodes[0].getParentNode().id;
			var newparentid = targetNode==null?0:targetNode.id;
			$.ajax({
				url:"${pageContext.request.contextPath}/permission/domove.do",
				type:"post",
				data:{
					"id":id,
					"oldParentid":oldparentid,
					"newParentid":newparentid
				},
				dataType:"json",
				success:function(jsonResult){
					if(jsonResult.tag > 0){
						var zTree = $.fn.zTree.getZTreeObj("treeDemo");
						zTree.reAsyncChildNodes(null,"refresh");
					}else{
						alert("移动失败");
					}
				}
			});
			return false;
		}
		
		function zTreeBeforeRemove(treeId,treeNode){
			if(treeNode.isParent){
				alert("无法删除父权限！")
			}else{
				$.ajax({
					url:"${pageContext.request.contextPath}/permission/dodel.do",
					type:"post",
					data:{
						"id":treeNode.id,
						"parentid":treeNode.getParentNode()==null?0:treeNode.getParentNode().id
					},
					dataType:"json",
					success:function(jsonResult){
						if(jsonResult.tag>0){
							var zTree = $.fn.zTree.getZTreeObj("treeDemo");
							if(jsonResult.message==""){
								zTree.reAsyncChildNodes(null,"refresh");
							}else if(jsonResult.message=="1"){
								zTree.reAsyncChildNodes(treeNode.getParentNode(),"refresh");
							}else{
								zTree.reAsyncChildNodes(treeNode.getParentNode().getParentNode(),"refresh");
							}
							alert("删除成功");
						}else if(jsonResult.tag == 0){
							alert("删除失败");
						}else{
							alert("有角色拥有该权限,删除失败");
						}
					}
				});
			}
			return false;
		}
		
		$(document).ready(function(){
			$.fn.zTree.init($("#treeDemo"), setting);
		});
		
		function beforeRemove(treeId, treeNode) {
			var zTree = $.fn.zTree.getZTreeObj("treeDemo");
			zTree.selectNode(treeNode);
			return confirm("确认删除 节点 -- " + treeNode.name + " 吗？");
		}		
		function beforeRename(treeId, treeNode, newName) {
			if (newName.length == 0) {
				setTimeout(function() {
					var zTree = $.fn.zTree.getZTreeObj("treeDemo");
					zTree.cancelEditName();
					alert("节点名称不能为空.");
				}, 0);
				return false;
			}
			return true;
		}

		var newCount = 1;
		function addHoverDom(treeId, treeNode) {
			var sObj = $("#" + treeNode.tId + "_span");
			if (treeNode.editNameFlag || $("#addBtn_"+treeNode.tId).length>0) return;
			var addStr = "<span class='button add' id='addBtn_" + treeNode.tId
				+ "' title='add node' onfocus='this.blur();'></span>";
			sObj.after(addStr);
			var btn = $("#addBtn_"+treeNode.tId);
			if (btn) btn.bind("click", function(){
				var parentid=treeNode.id;
				var tId =treeNode.tId;
				$.ajax({
					url:"${pageContext.request.contextPath}/permission/toadd.do",
					type:"post",
					data:{
						"parentid":parentid,
						"tId":tId
					},
					dataType:"text",
					success:function(content){
						$("#right").html(content);
						/* bootbox.dialog({
						    message:content
						}); */
					}
				});
				return false;
			});
		};
		
		function removeHoverDom(treeId, treeNode) {
			$("#addBtn_"+treeNode.tId).unbind().remove();
		};
		
		function addroot(){
			var parentid = 0;
			var tId ="treeDemo_00";
			$.ajax({
				url:"${pageContext.request.contextPath}/permission/toadd.do",
				type:"post",
				data:{
					"parentid":parentid,
					"tId":tId
				},
				dataType:"text",
				success:function(content){
					$("#right").html(content);
				}
			});
		}
	</SCRIPT>

<body>
<div class="content_wrap">
	<div id="right" class="right">
		
	</div>
	<div class="zTreeDemoBackground left">
		<ul id="treeDemo" class="ztree"></ul>
		<a href="javascript:addroot();">添加父权限</a>
	</div>
</div>
</body>
</html>