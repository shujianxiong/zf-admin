<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>产品列表管理</title>
	<meta name="decorator" content="adminLte"/>
	<%@include file="/WEB-INF/views/include/treetable.jsp" %>
	<style type="text/css">
		tr{ 
		    cursor: pointer;    /*手形*/   
		} 
	</style>
	<script type="text/javascript">
// 		$(document).ready(function() {
// 			$("#contentTable").treeTable({expandLevel : 3});
			
// 		});
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
	<section class="content-header content-header-menu">
		<h1>
	        <small class="menu-active">
	        	<i class="fa fa-repeat"></i><a href="${ctx}/lgt/ps/whProduce/select?warehouse.id=${whProduce.warehouse.id  }">仓库产品列表</a>
	        </small>
      	</h1>
	</section>
	
	<sys:tip content="${message}"/>
	
	<section class="content">
		<form:form id="searchForm" modelAttribute="whProduce" action="${ctx}/lgt/ps/whProduce/select?warehouse.id=${whProduce.warehouse.id }" method="post" class="form-horizontal">
			<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
			<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
			<input id="pageKey" name="pageKey" type="hidden" value="${pageKey }"/>
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
								<label for="searchParameter" class="col-sm-3 control-label">关键字</label>
								<div class="col-sm-7">
									<form:input id="searchParameter" path="searchParameter.keyWord" htmlEscape="false" maxlength="50" class="form-control" placeholder="输入产品编码或名称查询" />
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
					<table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
						<thead>
							<tr>
								<th></th>
								<th>产品编码</th>
								<th>（商品）产品名称</th>
								<th>标准库存</th>
								<th>安全库存</th>
								<th>警戒库存</th>
							</tr>
						</thead>
						<tbody id="tBodyId">
							<c:forEach items="${page.list}" var="produce">
								<tr id="${produce.id }" data-type="item">
									<td data-type="checkbox">
										<input type="checkBox" name="selectName"  value="${produce.id}" />
									</td>
									<td>
										${produce.code}
									</td>
									<td>
										${produce.goods.name }${fns:abbr(produce.name,28)}
									</td>
									<td>${produce.stockStandard}</td>
									<td>${produce.stockSafe}</td>
									<td>${produce.stockWarning}</td>
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
</div>
<script type="text/javascript">
	$(function(){
		$(":checkbox").iCheck({
			checkboxClass : 'icheckbox_minimal-blue'
		});
		var checkTable=new ZF.CheckTable("${pageKey}");
		
	});
</script>	
</body>
</html>