<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>产品货品列表管理</title>
	<meta name="decorator" content="adminLte"/>
	<%@include file="/WEB-INF/views/include/treetable.jsp" %>
	<style type="text/css">
		tr{ 
		    cursor: pointer;    /*手形*/   
		} 
	</style>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#contentTable").treeTable({expandLevel : 3});
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
		
		function rowCheck(obj){
			var goodsName=$(obj).attr("type-name");
			if($(obj).attr("checked")=="checked"){
				//$("input[name='selectName']").removeAttr("checked");
				$(obj).attr("checked","checked")
				//临时测试
				window.parent.builderTable("<tr data-val='1' id="+$(obj).val()+" class='proudceId' type-code="+$(obj).val()+"><td>"+goodsName+"</td>");
			}else{
				//临时测试 
// 				window.parent.removeTable($(obj).val());
				//window.parent.builderTable("<tr id="+$(obj).val()+"><td>Trident</td><td>InternetExplorer 4.0</td><td>Win 95+</td><td> 4</td><td>X</td></tr>");
				//window.parent.iframeSelected($(obj).val());
			}
		}
		
		function clearQueryParam(){
			$("#categoryName").val("");
			$("#s2id_goodsStatus").select2("val","");
			$("#searchParameterKeyWord").val("");
		}
		
		
		
	</script>
</head>
<body>

<div class="content-wrapper sub-content-wrapper">
	<section class="content-header">
		<h1>
	        <small class="menu-active">
	        	<i class="fa fa-repeat"></i><a href="${ctx}/lgt/ps/product/select?produce.id=${product.produce.id }&wareplace.warecounter.warearea.warehouse.id=${product.wareplace.warecounter.warearea.warehouse.id}">仓库货品列表</a>
	        </small>
      	</h1>
	</section>
	
	<sys:tip content="${message}"/>
	
	<section class="content">
		<form:form id="searchForm" modelAttribute="product" action="${ctx}/lgt/ps/product/select" method="post" class="form-horizontal">
		<input id="pageNo"  data-unclear="true"  name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize"  data-unclear="true"  name="pageSize" type="hidden" value="${page.pageSize}"/>
		<input type="hidden"  data-unclear="true"  name="produce.id" value="${product.produce.id }"/>
		<input type="hidden"   data-unclear="true" name="wareplace.warecounter.warearea.warehouse.id" value="${product.wareplace.warecounter.warearea.warehouse.id }"/>
		<div class="box box-info">
			<div class="box-header with-border zf-query">
				<h5>查询条件</h5>
				<div class="box-tools pull-right">
					<button type="button" class="btn btn-box-tool"data-widget="collapse"><i class="fa fa-minus"></i></button>
					<button type="button" class="btn btn-box-tool"data-widget="remove"><i class="fa fa-remove"></i></button>
				</div>
			</div>
			<div class="box-body">
				<div class="row">
					<div class="col-md-4">
						<div class="form-group">
							<label for="searchParameter.keyWord" class="col-sm-3 control-label" >关键字</label>
							<div class="col-sm-7">
								<form:input path="searchParameter.keyWord" htmlEscape="false" maxlength="255" class="form-control"   placeholder="请输入货品编码或产品编码或名称查询"/>
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="form-group">
							<label for="searchParam" class="col-sm-3 control-label" >当前状态</label>
							<div class="col-sm-7">
								<form:select path="status" class="form-control select2">
									<form:option value="" label="所有"/>
									<form:options items="${fns:getDictList('lgt_ps_product_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
								</form:select>
							</div>
						</div>
					</div>
<!-- 					<div class="col-md-4"> -->
<%-- 						<sys:inputtree name="wareplace.warecounter.warearea.warehouse.id" url="${ctx}/lgt/ps/warehouse/warehouseListData" id="warehouse" label="所属仓库" labelValue="" labelWidth="3" inputWidth="7" --%>
<%-- 							 labelName="wareplace.warecounter.warearea.warehouse.name" value="" tip="请选择仓库" onchange="changeWarehouse"></sys:inputtree> --%>
<!-- 					</div> -->
				</div>
			</div>
			<div class="box-footer">
				<div class="pull-right box-tools">
	        		<button type="button" class="btn btn-default btn-sm" onclick="resetForm()"><i class="fa fa-refresh">重置</i></button>
               		<button type="submit" class="btn btn-info btn-sm"><i class="fa fa-search">查询</i></button>
	        	</div>
			</div>
		</div>
		</form:form>
		<div class="box box-soild">
			<div class="box-body">
				<div class="table-responsive">
					<table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
						<thead>
							<tr>
								<th></th>
								<th>货品编码</th>
								<th>商品名称（编码）</th>
								<th>产品名称（编码）</th>
								<th>当前状态</th>
								<th>存放货位</th>
								<th>持有人</th>
								<th>货品克重</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${page.list}" var="product">
								<tr>
									<td>
										<input type="checkBox" name="selectName"  value="${product.id}" data-value="${product.goods.name } ${product.produce.name}" type-code="${product.code}"/>
									</td>
									<td>
										${product.code}
									</td>
									<td>
										${product.goods.name}（${product.goods.code}）
									</td>
									<td>
										${product.produce.name}（${product.produce.code}）
									</td>
									<td>
										<c:choose>
											<c:when test="${ product.status eq '1'}">
												<span class="label label-primary">${fns:getDictLabel(product.status, 'lgt_ps_product_status', '')}</span>
											</c:when>
											<c:when test="${ product.status eq '2'}">
												<span class="label label-default">${fns:getDictLabel(product.status, 'lgt_ps_product_status', '')}</span>
											</c:when>
											<c:when test="${ product.status eq '3'}">
												<span class="label label-warning">${fns:getDictLabel(product.status, 'lgt_ps_product_status', '')}</span>
											</c:when>
											<c:when test="${ product.status eq '4'}">
												<span class="label label-warning">${fns:getDictLabel(product.status, 'lgt_ps_product_status', '')}</span>
											</c:when>
											<c:when test="${ product.status eq '5'}">
												<span class="label label-default">${fns:getDictLabel(product.status, 'lgt_ps_product_status', '')}</span>
											</c:when>
											<c:otherwise>
												<span class="label label-default">${fns:getDictLabel(product.status, 'lgt_ps_product_status', '')}</span>
											</c:otherwise>
										</c:choose>
									</td>
									<td>
										<c:if test="${product.wareplace!=null && product.wareplace.code!=null}">
											${product.wareplace.warecounter.warearea.warehouse.name} - ${product.wareplace.warecounter.warearea.name} - ${product.wareplace.warecounter.code} - ${product.wareplace.code}
										</c:if>
									</td>
									<td>
										${fns:getUserById(product.holdUser.id).name}
									</td>
									<td>
										${product.weight}
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<div class="box-footer">
		        	<div class="dataTables_paginate paging_simple_numbers">${page}</div>
	            </div>
			</div>
		</div>
	</section>
	
	<script>
	  $(function () {
	
	   ZF.bigImg();
		  
	   $('input').iCheck({
		   checkboxClass : 'icheckbox_minimal-blue'
	   });
		 
	  });
	  
	  function resetForm() {
			var form = $("#searchForm");
			$("input[type=text]", form).val("");
			$("input[type=hidden]", form).each(function() {
				var c = $(this).attr("data-unclear");
				if(c == null || c == undefined || c.length <= 0 || c != "true") {
					$(this).val("");
				}
			});
			$("select", form).val("");
			$("select", form).each(function(){
				$(this).select2("val","");
			});
	}
</script>
</div>	
</body>
</html>