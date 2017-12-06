<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>供应商选择</title>
	<meta name="decorator" content="adminLte"/>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
	    <sys:tip content="${message}"/>
		<section class="content">
	    	<form:form id="searchForm" modelAttribute="supplier" action="${ctx}/lgt/si/supplier/select" method="post" class="form-horizontal">
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
									<label for="searchParam" class="col-sm-3 control-label" >供应商名称</label>
									<div class="col-sm-7">
										<form:input path="name" htmlEscape="false" maxlength="100" class="form-control" placeholder="供应商名称查询"/>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-group">
									<label for="searchParam" class="col-sm-3 control-label" >供应商类型</label>
									<div class="col-sm-7">
										<form:select path="type" class="select2">
											<form:option value="" label="所有"/>
											<form:options items="${fns:getDictList('lgt_si_supplier_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
										</form:select>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-group">
									<sys:inputtree url="${ctx}/lgt/ps/category/categoryData" label="供应商分类" tip="请选择供应商分类" id="supplierCategoryId" labelName="supplierCategory.categoryName" name="supplierCategory.id" labelWidth="3" inputWidth="7"></sys:inputtree>
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
				</div>
			</form:form>
			<div class="box box-soild">
				<div class="box-herder with-border"></div>
				<div class="box-body">
					<div class="table-responsive">
						<table id="supplierContentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
							<thead>
								<tr>
									<th class="zf-dataTables-multiline"></th>
									<th>供应商名称</th>
									<th>供应商类型</th>
									<th>信誉等级</th>
									<th>信誉分</th>
									<th>供货合格率</th>
									<th>供应商分类</th>
									<th>备注信息</th>
								</tr>
							</thead>
							<tbody id="tBodyId">
								<c:forEach items="${page.list}" var="supplier" varStatus="status">
									<tr id="${supplier.id }" data-type="item" data-index="${status.index }">
										<td data-type="checkbox"><span><input type="radio" value="${supplier.id}" name="selectName" data-name="${supplier.name}" class="icheckbox_minimal-blue checked"/></span></td>
										<td title="${supplier.name}">
											<input type="hidden" id="supplierId${supplier.id }"  value="${supplier.id}" />
											<input type="hidden" id="supplierName${supplier.id }"  value="${supplier.name}" />
											${fns:abbr(supplier.name,30)}
										</td>
										<td>
											${fns:getDictLabel(supplier.type, 'lgt_si_supplier_type', '')}
										</td>
										<td>
											${fns:getDictLabel(supplier.level, 'lgt_si_supplier_level', '')}
										</td>
										<td>
											${supplier.creditPoint }
										</td>
										<td>
										    ${supplier.qualifiedScale }
										</td>
										<td>
											${supplier.supplierCategory.categoryName}
										</td>
										<td title="${supplier.remarks}">
											${fns:abbr(supplier.remarks, 15)}
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
			var t=ZF.parseTable("#supplierContentTable",{
		 		"paging" : false,
				"lengthChange" : false,
				"searching" : false,//关闭搜索
				"ordering" : false,//开启排序
				"info" : false,
				"autoWidth" : false,
				"multiline":true,//是否开启多行表格
				"isRowSelect":true,//是否开启行选中
				"rowSelect":function(tr){},//行选中回调
				"rowSelectCancel":function(tr){}//行取消选中回调
			});
			
			$(":radio").iCheck({
				checkboxClass : 'icheckbox_minimal-blue',
                disabledCheckboxClass: 'disabled',
                radioClass : 'iradio_minimal-blue'
			});
			
			$(":radio").on("ifClicked",function(){
				$("input[name=selectName]").iCheck('uncheck');
			})
			
			var checkTable=new ZF.CheckTable("${pageKey}");
		})
	</script>
</body>
</html>