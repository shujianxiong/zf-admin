<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>货品管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
		
		function copyToClipboard(copyName, copyText){
			if (window.clipboardData){
				window.clipboardData.setData("Text", copyText)
			}else {
				var flashcopier = 'flashcopier';
				if(!document.getElementById(flashcopier)){
					var divholder = document.createElement('div');
					divholder.id = flashcopier;
					document.body.appendChild(divholder);
				}
				document.getElementById(flashcopier).innerHTML = '';
				var divinfo = '<embed src="../js/_clipboard.swf" FlashVars="clipboard='+encodeURIComponent(copyText)+'" width="0" height="0" type="application/x-shockwave-flash"></embed>';
		        document.getElementById(flashcopier).innerHTML = divinfo;
		    }
			top.$.jBox.tip(copyName+"已复制到剪贴板！", 'message');
	    }
		
		function adjust(productId){
			$("#productId").val(productId);
			top.$.jBox.open("iframe:${ctx}/tag/treeselect?url="+encodeURIComponent("/lgt/ps/wareplace/wareplaceTree")+"&module=&checked=&disabled=&isAll=&notAllowSelectParent=true&extId="+productId+"&wareplaceId="+productId, "选择需要调整的货位", 300, 420, {
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
		
		//清空查询条件
		function clearQueryParam(){
			$("#wareplaceidId").val("");
			$("#wareplaceidName").val("");
			$("#code").val("");
			$("#beginCreateDate").val("");
			$("#endCreateDate").val("");
			$("#s2id_status").select2("val","");
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="#">货品货位调整</a></li>
	</ul>
	
	<form:form id="adjustForm" modelAttribute="product" action="${ctx}/lgt/ps/productWpChange/updateWareplace" method="post" class="breadcrumb form-search" style="display:none">
		<input id="productId" name="id"/>
		<input id="wareplaceId" name="wareplaceId" value=""/>
	</form:form>
	<form:form id="searchForm" modelAttribute="product" action="${ctx}/lgt/ps/productWpChange/adjustment" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>货品编码：</label>
				<form:input path="code" htmlEscape="false"  maxlength="255" class="input-medium"/>
			</li>
			<li><label>当前状态：</label>
				<form:select path="status" class="input-medium">
					<form:option value="" label="所有"/>
					<form:options items="${fns:getDictList('lgt_ps_product_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>货位编号：</label>
				<sys:treeselect id="wareplaceid" name="wareplace.id" value="${product.wareplace.id}" labelName="wareplace.code" labelValue="${product.wareplace.code}"
					title="货位" url="/lgt/ps/wareplace/wareplaceTreeData" cssClass="input-small required" allowClear="true" notAllowSelectParent="true" extId=""/>
			</li>
			<li><label>创建时间：</label>
				<input id="beginCreateDate" name="beginCreateDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${product.beginCreateDate}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/> - 
				<input id="endCreateDate" name="endCreateDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${product.endCreateDate}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"><input id="clearSubmit" class="btn btn-primary" type="button" value="清除" onclick="clearQueryParam()"/></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>货品编码</th>
				<th>商品名称（编号）</th>
				<th>产品名称（编号）</th>
				<th>当前状态</th>
				<th>货位编号</th>
				<th>持有员工编号</th>
				<th>货品克重</th>
				<th>货品原厂编码</th>
				<th>货品证书编号</th>
				<th>创建者</th>
				<th>创建时间</th>
				<th>更新者</th>
				<th>更新时间</th>
				<th>备注</th>
				<shiro:hasPermission name="lgt:ps:productWpChange:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="product">
			<tr>
				<td><a href="${ctx}/lgt/ps/product/form?id=${product.id}">
					${product.code}
				</a></td>
				<c:set var="name" value="${product.goods.name}（${product.goods.code}）"/>
				<td title="${name }">
					${fns:abbr(name,'20') }
				</td>
				<td>
					${product.produce.name}（${product.produce.code}）
				</td>
				<td>
					${fns:getDictLabel(product.status, 'lgt_ps_product_status', '')}
				</td>
				<td>
					${product.wareplace.code}
				</td>
				<td>
					${fns:getUserById(product.holdUser.id).name}
				</td>
				<td>
					${product.weight}
				</td>
				<td>
					${product.factoryCode}
				</td>
				<td>
					${product.certificateNo}
				</td>
				<td>
					${fns:getUserById(product.createBy.id).name}
				</td>
				<td>
					<fmt:formatDate value="${product.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${fns:getUserById(product.updateBy.id).name}
				</td>
				<td>
					<fmt:formatDate value="${product.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td title="${product.remarks}">
					${fns:abbr(product.remarks,15)}
				</td>
				<shiro:hasPermission name="lgt:ps:productWpChange:edit"><td>
					<a href="javascript:" onclick="adjust('${product.id}')">调整货位</a> 
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>