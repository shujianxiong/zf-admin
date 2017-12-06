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
		
	</script>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
		<section class="content-header">
			<h1>
		        <small class="menu-active">
		        	<i class="fa fa-repeat"></i><a href="${ctx}/lgt/bs/brand/select">品牌列表</a>
		        </small>
	      	</h1>
		</section>
		<sys:tip content="${message}"/>
		<section class="content">
			<form:form id="searchForm" modelAttribute="brand" action="${ctx}/lgt/bs/brand/select" method="post" class="form-horizontal">
				<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
				<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
				
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
										<form:input path="name" htmlEscape="false" maxlength="50" class="form-control"  placeholder="输入品牌名称查询" />
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-group">
									<label for="brandStatus" class="col-sm-3 control-label">品牌状态</label>
									<div class="col-sm-7">
										<form:select path="brandStatus" class="form-control select2">
											<form:option value="" label="所有"/>
											<form:options items="${fns:getDictList('brand_status')}" itemLabel="label" itemValue="value" htmlEscape="false" />
										</form:select>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="box-footer">
						<div class="pull-right box-tools">
			        		<button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh">重置</i></button>
		               		<button type="submit" class="btn btn-info btn-sm"><i class="fa fa-search">查询</i></button>
			        	</div>
					</div>
				</div>
			</form:form>
			<div class="box box-soild">
				<div class="box-body">
					<div class="table-responsive">
						<table id="contentTable" class="table table-hover table-bordered table-condensed zf-tbody-font-size">
							<thead>
								<tr>
 									<th></th>
									<th>品牌LOGO</th>
 									<th>品牌名称</th>
									<th>品牌公司名称</th>
									<th>品牌简介</th>
									<th>品牌状态</th>
									<th>备注信息</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${page.list}" var="brand">
									<tr>
										<td>
											<div class="zf-check-wrapper-padding">
												<input type="radio" name="selectName" data-value="${brand.id }=${brand.name}" value="${brand.id}" />
											</div>
										</td>
										<td>
                                            <img onerror="imgOnerror(this);"  src="${imgHost }${fn:replace(brand.logo, '|', '')}" data-big data-src="${imgHost }${brand.logo}" width="20px" height="20px" />
                                        </td>
										<td title="${brand.name}">
											<input type="hidden" id="brandId${brand.id }"  value="${brand.id}" />
											<input type="hidden" id="brandName${brand.id }"  value="${brand.name}" />
											${fns:abbr(brand.name,15)}
										</td>
										<td title="${brand.companyName}">
											${fns:abbr(brand.companyName,15)}
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
		
		$(":radio").iCheck({
            checkboxClass : 'icheckbox_minimal-blue',
            radioClass : 'iradio_minimal-blue'
        });
		
		$(":radio").on("ifClicked",function(){
            $("input[name=selectName]").iCheck('uncheck');
        });
		
		 //表格初始化
		ZF.parseTable("#contentTable", {
			"paging" : false,
			"lengthChange" : false,
			"searching" : false,
			"ordering" : false,
			"info" : false,
			"autoWidth" : false,
			"multiline" : true,//是否开启多行表格
			"isRowSelect" : false,//是否开启行选中
			"orderable" : false
		});
		
	});
</script>
	
	
</body>
</html>