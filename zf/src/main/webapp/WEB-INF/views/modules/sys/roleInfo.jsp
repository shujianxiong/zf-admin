<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>角色信息</title>
	<meta name="decorator" content="adminLte"/>
	<%@include file="/WEB-INF/views/include/treeview.jsp" %>
	<script type="text/javascript">
		$(function() {
			var a=${fns:toJson(role)}

			var setting = {check:{enable:true,nocheckInherit:false},view:{selectedMulti:false},
					data:{simpleData:{enable:true}},callback:{beforeClick:function(id, node){
						tree.checkNode(node, !node.checked, true, true);
						return false;
					}}};
			
			// 用户-菜单
			var zNodes=[
					<c:forEach items="${menuList}" var="menu">{id:"${menu.id}", pId:"${not empty menu.parent.id?menu.parent.id:0}", name:"${not empty menu.parent.id?menu.name:'权限列表'}"},
		            </c:forEach>];
			// 初始化树结构
			var tree = $.fn.zTree.init($("#menuTree"), setting, zNodes);
			// 不选择父节点
			tree.setting.check.chkboxType = { "Y" : "ps", "N" : "s" };
			// 默认选择节点
			var ids = "${role.menuIds}".split(",");
			for(var i=0; i<ids.length; i++) {
				var node = tree.getNodeByParam("id", ids[i]);
				try{tree.checkNode(node, true, false); }catch(e){}
			}
			tree.expandAll(true);
		});
	</script>
</head>
<body>
 	<div class="content-wrapper sub-content-wrapper">
	    
	    <section class="content-header content-header-menu">
			
	    </section>
	    
	     <section class="invoice">
	     	<div class="table-responsive">
	     		<table class="table">
	     			<tr>
		                <th width="10%">角色名称</th>
		                <td>${role.name}</td>
	              	</tr>
	              	<tr>
		                <th width="10%">英文名称</th>
		                <td>${role.enname}</td>
	              	</tr>
	              	<tr>
		                <th width="10%">归属机构</th>
		                <td>${role.office.name }</td>
	              	</tr>
	              	<tr>
		                <th width="10%">备注</th>
		                <td><p class="text-muted well well-sm no-shadow">${role.remarks }</p></td>
	              	</tr>
	     		</table>
	     	</div>
	     </section>
	     
	     <section class="invoice">
	     	<div class="table-responsive">
	     		<table class="table">
	     			<tr>
		                <th width="10%">权限</th>
		                <td>
		                	<div id="menuTree" class="ztree" >
		                	
		                	</div>
		                </td>
	              	</tr>
	     		</table>
	     	</div>
	     	
	     	<div class="row no-print">
	       		<div class="col-xs-12">
	       			<button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
	       		</div>
			</div>
	     </section>
	 </div>
</body>
</html>