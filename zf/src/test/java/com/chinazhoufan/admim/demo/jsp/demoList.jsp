<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>采购订单编辑</title>
	<meta name="decorator" content="adminLte"/>
</head>
<body >
	<div class="content-wrapper sub-content-wrapper">
		<section  class="content-header content-header-menu">
			<h1>
				<small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/lgt/bs/brand/list">品牌列表</a></small>
				<small>|</small>
				<shiro:hasPermission name="lgt:bs:brand:edit"><small><i class="fa-form-edit"></i><a href="${ctx}/lgt/bs/brand/form">品牌${not empty brand.id?'修改':'添加'}</a></small></shiro:hasPermission>
			</h1>
		</section>
		
		<sys:tip content="${message}"/>
		
		<section  class="content">
			<div class="box box-info">
				<div class="box-header with-border zf-query">
					<h5>查询条件</h5>
					<div class="box-tools pull-right">
						<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
						<button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-remove"></i></button>
					</div>
				</div>
				<form:form id="searchForm" modelAttribute="brand" action="${ctx}/lgt/bs/brand/list" method="post" class="form-horizontal">
					<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
					<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
					<div class="box-body">
						<div class="row">
							<!-- 输入框查询 -->
							<div class="col-md-4">
								<div  class="form-group">
									<label for="name" class="col-sm-3 control-label">品牌名称</label>
									<div class="col-sm-7">
										<sys:inputverify name="name" id="name" verifyType="0" tip="请输入查询的品牌名称" isMandatory="false" isSpring="true"></sys:inputverify>
									</div>
								</div>
							</div>
							<!-- 数据字典下拉列表查询 -->
							<div class="col-md-4">
								<div  class="form-group">
									<label for="brandStatusId" class="col-sm-3 control-label">品牌状态</label>
									<div class="col-sm-7">
										<form:select path="brandStatus" class="input-medium" id="brandStatusId">
											<form:option value="" label="所有"/>
											<form:options items="${fns:getDictList('brand_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
										</form:select>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="box-footer">
						<div class="pull-right box-tools">
			        		<button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
		               		<button type="submit" class="btn btn-info btn-sm"><i class="fa fa-search"></i>查询</button>
			        	</div>
					</div>
	            </form:form>
				</div>
				<div class="box box-soild">
				<div class="box-body">
					<div class="table-responsive">
						<table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
							<thead>
								<tr>
									<th>品牌类型</th>
									<th>品牌状态</th>
									<th>创建者</th>
									<th>更新时间</th>
									<th>备注信息</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${page.list}" var="brand">
									<tr>
										<!-- 数据字典匹配显示 -->
										<td>
											${fns:getDictLabel(brand.type, 'lgt_bs_brand_type', '')}
										</td>
										<!-- 不同状态分颜色显示 -->
										<td>
											<c:choose>
												<c:when test="${brand.brandStatus eq '2'}">
													<span class="label label-success">${fns:getDictLabel(brand.brandStatus, 'brand_status', '')}</span>
												</c:when>
												<c:when test="${brand.brandStatus eq '1'}">
													<span class="label label-primary">${fns:getDictLabel(brand.brandStatus, 'brand_status', '')}</span>
												</c:when>
											</c:choose>
										</td>
										<!-- 系统用户姓名标签显示 -->
										<td>
											${fns:getUserById(brand.createBy.id).name}
										</td>
										<!-- 时间显示 -->
										<td>
											<fmt:formatDate value="${brand.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
										</td>
										<!-- 字符串截取 -->
										<td title="${brand.remarks}">
											${fns:abbr(brand.remarks,15)}
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
				<div class="box-footer">
	    			<div class="dataTables_paginate paging_simple_numbers">${page}</div>
	    		</div>
			</div>
		</section>
	</div>
	
	<script type="text/javascript">
		// 初始化数据
		function initData(){
			// 实体转Json
			purchaseOrder = ${fns:toJson(purchaseOrder)};
		// 	purchaseOrder = $.parseJSON(purchaseOrder);
			var productList = purchaseOrder.purchaseProduceList;
			
			for(var i=0; i<productList.length; i++){
				var purchaseProduce = new PurchaseProduce(productList[i]);
				if(productList[i].purchaseProductList!=null){
					for(var j=0; j<productList[i].purchaseProductList.length; j++){
						purchaseProduce.add(productList[i].purchaseProductList[j]);
					}
				}
				dataSource.push(purchaseProduce);
			}
		}
	</script>

</body>
</html>