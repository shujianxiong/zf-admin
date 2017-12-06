<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>仓库体系结构</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/treeview.jsp" %>
	<style type="text/css">
		.ztree {overflow:auto;margin:0;_margin-top:10px;padding:10px 0 0 10px;}
		keyframes rotate{
		from{-webkit-transform:rotate(0deg)}
		to{-webkit-transform:rotate(360deg)}
		}
		@-webkit-keyframes rotate{
		from{-webkit-transform:rotate(0deg)}
		to{-webkit-transform:rotate(360deg)}
		}
		@-moz-keyframes rotate{
		from{-moz-transform:rotate(0deg)}
		to{-moz-transform:rotate(360deg)}
		}
		@-ms-keyframes rotate{
		from{-ms-transform:rotate(0deg)}
		to{-ms-transform:rotate(360deg)}
		}
		@-o-keyframes rotate{
		from{-o-transform:rotate(0deg)}
		to{-o-transform:rotate(360deg)}
		}
		.oldLoading:before{
			animation: 1s linear 0s normal none infinite rotate;
			-webkit-animation:1s linear 0s normal none infinite rotate;
			-ms-animation: 1s linear 0s normal none infinite rotate;
			-o-animation:1s linear 0s normal none infinite rotate;
			-moz-animation:1s linear 0s normal none infinite rotate;
		}
	</style>
</head>
<body>

	<sys:tip content="${message}"/>
	<div id="content" class="row-fluid">
		<div id="left" class="accordion-group">
			<div class="accordion-heading">
		    	<a class="accordion-toggle">仓库体系结构<i class="icon-refresh pull-right" onclick="refreshTree();"></i></a>
		    </div>
			<div id="ztree" class="ztree"></div>
		</div>
		<div id="openClose" class="close">&nbsp;</div>
		<div id="right">
			<iframe id="officeContent" src="${ctx}/lgt/ps/warecounter/list" width="100%" height="91%" frameborder="0"></iframe>
		</div>
	</div>
	<script type="text/javascript">
		var setting = {data:{simpleData:{enable:true,idKey:"id",pIdKey:"pId",rootPId:'0'}},
			callback:{onClick:function(event, treeId, treeNode){
					var id = treeNode.id;
					if(treeNode.isParent){
						if(treeNode.pId == "0"){
							$('#officeContent').attr("src","${ctx}/lgt/ps/warecounter/list?warearea.warehouse.id="+id+"&warearea.warehouse.name="+treeNode.name);
						}else{
							var parentNode = treeNode.getParentNode();
							$('#officeContent').attr("src","${ctx}/lgt/ps/warecounter/list?warearea.id="+id+"&warearea.name="+treeNode.name
											+"&warearea.warehouse.id="+parentNode.id+"&warearea.warehouse.name="+parentNode.name);
						}
					}else{
						var parentNode = treeNode.getParentNode();
						var grandNode = treeNode.getParentNode().getParentNode();
						$('#officeContent').attr("src","${ctx}/lgt/ps/warecounter/list?warearea.id="+id+"&warearea.code="+treeNode.name
								+"&warearea.warehouse.id="+parentNode.id+"&warearea.warehouse.name="+parentNode.name);
					}
				}
			}
		};
		
		function refreshTree(){
			if($("#loading").length<=0)
				  $("#content").append("<div id='loading' style='position: fixed;height: 100%;width: 100%;top: 0;text-align: center;line-height: 800px;background-color: rgba(0,0,0,0.5);z-index: 1000;'><i class='icon-refresh oldLoading' style='font-size:40px;color:white;'></i></div>");
			$("#loading").show();
			$.getJSON("${ctx}/lgt/ps/warearea/wareareaTreeData",function(data){
				$("#loading").hide();
				$.fn.zTree.init($("#ztree"), setting, data).expandAll(true);
			});
		}
		refreshTree();
		 
		var leftWidth = 180; // 左侧窗口大小
		var htmlObj = $("html"), mainObj = $("#main");
		var frameObj = $("#left, #openClose, #right, #right iframe");
		function wSize(){
			var strs = getWindowSize().toString().split(",");
			htmlObj.css({"overflow-x":"hidden", "overflow-y":"hidden"});
			mainObj.css("width","auto");
			frameObj.height(strs[0] - 5);
			var leftWidth = ($("#left").width() < 0 ? 0 : $("#left").width());
			$("#right").width($("#content").width()- leftWidth - $("#openClose").width() -5);
			$(".ztree").width(leftWidth - 10).height(frameObj.height() - 46);
		}
	</script>
	<script src="${ctxStatic}/common/wsize.min.js" type="text/javascript"></script>
</body>
</html>