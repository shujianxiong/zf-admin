<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>属性详情</title>
	<meta name="decorator" content="adminLte"/>
	<%@include file="/WEB-INF/views/include/treeview.jsp" %>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			// 分类
			var zNodes=[
					{id:"0", pId:"-1", name:"分类列表"},
					<c:forEach items="${categoryAll}" var="category">{id:"${category.id}", pId:"${not empty category.parent.id?category.parent.id:0}", name:"${category.categoryName}"},
		            </c:forEach>
				];
			
			var setting = {check:{enable:true,nocheckInherit:true},view:{selectedMulti:false},
				data:{simpleData:{enable:true}},callback:{beforeClick:function(id, node){
					tree.checkNode(node, !node.checked, true, true);
					return false;
				}}};
			
			var tree = $.fn.zTree.init($("#tree"), setting, zNodes);
			
			// 不选择父节点
			tree.setting.check.chkboxType = { "Y" : "ps", "N" : "s" };
			// 默认选择节点
			var ids = "${property.selectCategoryIds}".split(",");
			
			for(var i=0; i<ids.length; i++) {
				var node = tree.getNodeByParam("id", ids[i]);
				try{tree.checkNode(node, true, false);}catch(e){}
			}
			// 默认展开全部节点
			tree.expandAll(true);
			
		});
		
		function addRow(list, idx, tpl, row){
			$(list).append(Mustache.render(tpl, {
				idx: idx, delBtn: false, row: row
			}));
		}
	</script>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
		<section class="content-header content-header-menu">
			
	    </section>
	    
	    <section class="invoice">
	    	<p class="lead">基本信息</p>
	    	<div class="table-responsive">
	     		<table class="table">
	     			<tr>
		                <th width="10%">属性名称</th>
		                <td>${property.propName }</td>
		                <th width="10%">属性类型</th>
		                <td><span class="label label-primary">${fns:getDictLabel(property.propType, 'lgt_ps_property_propType', '')}</span></td>
	              	</tr>
	              	<tr>
		                <th width="10%">适用范围</th>
		                <td><span class="label label-primary">${fns:getDictLabel(property.suitType, 'lgt_ps_property_sultType', '')}</span></td>
		                <th width="10%">取值类型</th>
		                <td><span class="label label-primary">${fns:getDictLabel(property.valueType, 'lgt_ps_property_valueType', '')}</span></td>
	              	</tr>
	              	<tr>
		                <th width="10%">是否影响价格</th>
		                <td><span class="label label-primary">${fns:getDictLabel(property.produceFlag,'yes_no','') }</span></td>
		                <th width="10%">是否筛选可用</th>
                        <td><span class="label label-primary">${fns:getDictLabel(property.filterFlag,'yes_no','') }</span></td>
	              	</tr>
	              	<tr>
		                <th width="10%">商品必备属性</th>
		                <td><span class="label label-primary">${fns:getDictLabel(property.necessaryFlag,'yes_no','') }</span></td>
		                <th width="10%">排序序号</th>
		                <td>${property.orderNo }</td>
	              	</tr>
					<tr>
						<th width="10%">是否前台展示</th>
						<td><span class="label label-primary">${fns:getDictLabel(property.showFlag,'yes_no','') }</span></td>
						<th width="10%">是否属于展示标题</th>
						<td><span class="label label-primary">${fns:getDictLabel(property.titleFlag,'yes_no','') }</span></td>
					</tr>
	              	<tr>
	              	    <th width="10%">备注</th>
                        <td colspan="3"><p class="text-muted well well-sm no-shadow">${property.remarks }</p></td>
	              	</tr>
	     		</table>
	     	</div>
	    </section>
	    
	    <section class="invoice">
	    	<p class="lead">属性值信息</p>
	    	<div class="table-responsive">
	    		<table class="table table-striped">
					<thead>
						<tr>
							<th>属性值</th>
							<th>属性值别名</th>
							<th>排列序号</th>
						</tr>
					</thead>
					<tbody id="contentTable">
					
					</tbody>
				</table>
				<script type="text/template" id="templateScript">//<!--
					<tr id="templateScript{{idx}}">
						<td>{{row.pvalueName}}</td>
						<td>{{row.pvalueNickname}}</td>
						<td>{{row.orderNo}}</td>
					</tr>//-->
				</script>
				<script type="text/javascript">
					var rowIdx = 0, tpl = $("#templateScript").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
					$(document).ready(function() {
						var data = ${fns:toJson(property.propvalueList)};
						for (var i=0; i<data.length; i++){
							addRow('#contentTable', rowIdx, tpl, data[i]);
							rowIdx = rowIdx + 1;
						}
					});
				</script>
	     	</div>
	    </section>
	    
	    <section class="invoice">
	    	<p class="lead">关联分类信息</p>
	     	<div class="table-responsive">
	     		<table class="table">
	     			<tr>
		                <th width="10%">分类列表</th>
		                <td>
		                	<div id="tree" class="ztree" >
		                	
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