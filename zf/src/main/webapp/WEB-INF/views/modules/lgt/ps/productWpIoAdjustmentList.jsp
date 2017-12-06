<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>货品出入库记录管理</title>
	<meta name="decorator" content="default"/>
	<style type="text/css">
		tr{ 
		    cursor: pointer;    /*手形*/   
		} 
	</style>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
		
		function adjust(productId, wareplaceId){
			$("#productId").val(productId);
			top.$.jBox.open("iframe:${ctx}/tag/treeselect?url="+encodeURIComponent("/lgt/ps/wareplace/wareplaceTree")+"&module=&checked=&disabled=&isAll=&notAllowSelectParent=true&extId="+wareplaceId+"&wareplaceId="+wareplaceId, "选择需要调整的货位", 300, 420, {
				ajaxData:{selectIds: ""},buttons:{"确定":"ok", ${allowClear?"\"清除\":\"clear\", ":""}"关闭":true}, submit:function(v, h, f){
					console.log(v);
					if (v=="ok"){
						var tree = h.find("iframe")[0].contentWindow.tree;
						var ids = [], names = [], nodes = [];
						
						nodes = tree.getSelectedNodes();
						for(var i=0; i<nodes.length; i++) {
							console.log(nodes[i].id);
							if(nodes[i].id!=""&&nodes[i].name!=""){
								//进入商品添加页面
								$("#wareplaceId").val(nodes[i].id);
								$("#adjustForm").submit();
							}
						}
						
					}
				}, loaded:function(h){
					$(".jbox-content", top.document).css("overflow-y","hidden");
				}
			});
				
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/lgt/ps/productWpIo/">货品货位调整</a></li>
	</ul>
	<form:form id="adjustForm" modelAttribute="product" action="${ctx}/lgt/ps/product/updateWareplace" method="post" class="breadcrumb form-search" >
		<input id="productId" name="id"/>
		<input id="wareplaceId" name="wareplace.id" value=""/>
	</form:form>
	
	<form:form id="searchForm" modelAttribute="productWpIo" action="${ctx}/lgt/ps/productWpIo/adjustment" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>货品编码：</label>
				<form:input path="product.code" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>操作类型：</label>
				<form:select path="ioType" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('lgt_ps_product_wp_io_ioType')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>操作货位：</label>
				<form:input path="ioWareplace.id" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>操作人：</label>
				<form:input path="ioUser.id" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>操作时间：</label>
				<input name="ioTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${productWpIo.ioTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
			</li>
			<li><label>操作原因：</label>
				<form:select path="ioReasonType" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('lgt_ps_product_wp_io_ioReasonType')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>业务单号：</label>
				<form:input path="ioBusinessorderId" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-hover table-bordered table-condensed">
		<thead>
			<tr>
				<th>货品编码</th>
				<th>商品名称</th>
				<th>产品名称</th>
				<th>操作类型</th>
				<th>出入库货位</th>
				<th>操作人</th>
				<th>操作时间</th>
				<th>操作原因</th>
				<th>来源业务单号</th>
				<th>更新时间</th>
				<th>备注信息</th>
				<shiro:hasPermission name="lgt:ps:productWpIo:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="productWpIo">
			<tr>
				<td>
					${productWpIo.product.code}
				</td>
				<td>
					${productWpIo.product.produce.goods.name }
				</td>
				<td>
					${productWpIo.product.produce.name }
				</td>
				<td>
					${fns:getDictLabel(productWpIo.ioType, 'lgt_ps_product_wp_io_ioType', '')}
				</td>
				<td>
					${productWpIo.ioWareplace.wareplaceCode}
				</td>
				<td>
					${fns:getUserById(productWpIo.ioUser.id).name}
				</td>
				<td>
					<fmt:formatDate value="${productWpIo.ioTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${fns:getDictLabel(productWpIo.ioReasonType, 'lgt_ps_product_wp_io_ioReasonType', '')}
				</td>
				<td title="${productWpIo.ioBusinessorderId }">
					${fns:abbr(productWpIo.ioBusinessorderId,22)}
				</td>
				
				<td>
					<fmt:formatDate value="${productWpIo.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td title="${productWpIo.remarks }">
					${fns:abbr(productWpIo.remarks,15)}
				</td>
				<shiro:hasPermission name="lgt:ps:productWpIo:edit">
					<td>
						<a href="javascript:" onclick="adjust('${productWpIo.product.id }','${productWpIo.product.id}')">调整货位</a> 
					</td>
				</shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>