<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>品牌管理</title>
	<meta name="decorator" content="adminLte"/>
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
		
		function queryResetForm() {
			$("#brandName").val("");
		}
	</script>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
		<section class="content-header">
			<h1>
		        <small class="menu-active">
		        	<i class="fa fa-repeat"></i><a href="${ctx}/lgt/si/supplierBrand/select">品牌列表</a>
		        </small>
	      	</h1>
		</section>
		<sys:tip content="${message}"/>
		<section class="content">
			<%-- <form:form id="searchForm" modelAttribute="supplierBrand" action="${ctx}/lgt/si/supplierBrand/select" method="post" class="form-horizontal">
				<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
				<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
				<input type="hidden" id="supplier_id" name="supplier.id" value="${supplier.id }"/>
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
									<label for="name" class="col-sm-3 control-label">品牌名称</label>
									<div class="col-sm-7">
										<form:input id="brandName" path="brand.name" htmlEscape="false" maxlength="50" class="form-control"  placeholder="输入品牌名称查询" />
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="box-footer">
						<div class="pull-right box-tools">
			        		<button type="button" class="btn btn-default btn-sm" onclick="queryResetForm()"><i class="fa fa-refresh">重置</i></button>
		               		<button type="submit" class="btn btn-info btn-sm"><i class="fa fa-search">查询</i></button>
			        	</div>
					</div>
				</div>
			</form:form> --%>
			<div class="box box-soild">
				<div class="box-body">
					<div class="table-responsive">
						<table id="contentTable" class="table table-hover table-bordered table-condensed zf-tbody-font-size">
							<thead>
								<tr>
									<th></th>
									<th>品牌名称</th>
									<th>品牌公司名称</th>
									<th>品牌LOGO</th>
									<th>品牌简介</th>
									<th>品牌状态</th>
									<th>备注信息</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${page.list}" var="brand">
									<tr>
										<td nowrap>
											<c:set var="flag" value="0"/>
											<c:forEach items="${supplierBrandList}" var="sb">
												<c:if test="${brand.id eq sb.brand.id}">
													<c:set var="flag" value="1"/>
													<c:set var="sbId" value="${sb.id}"/>
												</c:if>
											</c:forEach>
											<div class="zf-check-wrapper-padding">
												<input type="checkBox" name="checkbox" <c:if test="${flag eq '1' }"> checked="checked"</c:if> sb-id="${sbId}" value="${brand.id}" />
											</div>
											<c:set var="flag" value="0"/>
										</td>
									
										<td title="${brand.name}">
											<input type="hidden" id="brandId${brand.id }"  value="${brand.id}" />
											<input type="hidden" id="brandName${brand.id }"  value="${brand.name}" />
											${fns:abbr(brand.name,20)}
										</td>
										<td title="${brand.companyName}">
											${fns:abbr(brand.companyName,15)}
										</td>
										<td>
											<img onerror="imgOnerror(this);"  src="${imgHost }${brand.logo}" data-big data-src="${imgHost }${brand.logo}" style="width:30px;height:30px;">
										</td>
										<td title="${brand.introduction}">
											${fns:abbr(brand.introduction,15)}
										</td>
										<td>
											<c:choose>
												<c:when test="${brand.brandStatus eq '2'}"><!-- 启用 -->
													<span class="label label-success">${fns:getDictLabel(brand.brandStatus, 'brand_status', '') }</span>
												</c:when>
												<c:when test="${brand.brandStatus eq '1'}"><!-- 停用 -->
													<span class="label label-primary">${fns:getDictLabel(brand.brandStatus, 'brand_status', '') }</span>
												</c:when>
											</c:choose>
										</td>
										<td title="${brand.remarks }">
											${fns:abbr(brand.remarks,15)}
										</td>
									</tr>
								</c:forEach>
							</tbody>
							<tfoot>
								<tr class="hide">
									<td>
										<input type="hidden" id="supplier_id" value="${supplier.id }"/>
									</td>
								</tr>
									
							</tfoot>
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
	$(function(){
		
		ZF.bigImg();
		
		 //表格初始化
		ZF.parseTable("#contentTable", {
			"paging" : false,
			"lengthChange" : false,
			"searching" : false,
			"ordering" : false,
			"info" : false,
			"autoWidth" : false,
			"multiline" : true,//是否开启多行表格
			"isRowSelect" : false//是否开启行选中
		})
		
		$(":checkbox").iCheck({
			checkboxClass : 'icheckbox_minimal-blue'
		});
		
		$(":checkbox").on("ifClicked",function(){
			$("input[name=selectName]").iCheck('uncheck');
		})
		
	});
</script>
	
	
</body>
</html>