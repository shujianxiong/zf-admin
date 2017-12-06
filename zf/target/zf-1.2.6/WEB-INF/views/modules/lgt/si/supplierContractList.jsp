<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>供应商合同管理</title>
	<meta name="decorator" content="adminLte"/>
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
	<section class="content-header content-header-menu">
		<h1>
			<small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/lgt/si/supplierContract/">供应商合同列表</a></small>
			
			<shiro:hasPermission name="lgt:si:supplierContract:edit"><small>|</small><small><i class="fa-form-edit"></i><a href="${ctx}/lgt/si/supplierContract/form">供应商合同${not empty supplierContract.id?'修改':'添加'}</a></small></shiro:hasPermission>
		</h1>
	</section>
	<sys:tip content="${message}"/>
	<section class="content">
		<div class="box box-info">
			<div class="box-header with-border zf-query">
				<h5>查询条件</h5>
				<div class="box-tools pull-right">
					<button type="button" class="btn btn-box-tool"data-widget="collapse"><i class="fa fa-minus"></i></button>
					<button type="button" class="btn btn-box-tool"data-widget="remove"><i class="fa fa-remove"></i></button>
				</div>
			</div>
			
			<form:form id="searchForm" modelAttribute="supplierContract" action="${ctx}/lgt/si/supplierContract/list" method="post" class="form-horizontal">
				<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
				<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
				<div class="box-body">
					<div class="row">
						<%-- <div class="col-md-4">
							<div  class="form-group">
								<label for="type" class="col-sm-3 control-label">供应商名称</label>
								<div class="col-sm-7">	
									<select name="supplier.id" id="supplierId" class="form-control select2">
							                 <option value="" selected="selected">请选择供应商</option>
							                 <c:forEach items="${supplierList }" var="su">
							                 	<option value="${su.id }" <c:if test="${su.id == supplier.id}">selected</c:if>>${su.name }</option>
							                 </c:forEach>
						            </select>
								</div>
							</div>
						</div> --%>
						
						<div class="col-md-4">
							<div  class="form-group">
								<label for="name" class="col-sm-3 control-label">合同名称</label>
								<div class="col-sm-7">	
									<sys:inputverify name="name" id="name" verifyType="0" tip="请输入合同名称" isMandatory="false" isSpring="true"></sys:inputverify>
								</div>
							</div>
						</div>
						<div class="col-md-4">
							<div  class="form-group">
								<label for="beginRequiredTime" class="col-sm-3 control-label">失效时间</label>
								<div class="col-sm-7">
									<sys:datetime id="beginRequiredTime" inputName="beginRequiredTime" value="${supplierContract.beginRequiredTime }" tip="请选择失效开始时间" inputId="beginRequiredTimeID"></sys:datetime>
								</div>
							</div>
						</div>
						<div class="col-md-4">
							<div  class="form-group">
								<label for="endRequiredTime" class="col-sm-3 control-label">失效结束时间</label>
								<div class="col-sm-7">	
									<sys:datetime id="endRequiredTime" inputName="endRequiredTime" value="${supplierContract.endRequiredTime }" tip="请选择失效结束时间" inputId="endRequiredTimeID"></sys:datetime>
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
								<th class="zf-dataTables-multiline"></th>
								<th>供应商名称</th>
								<th>采购单单号</th>
								<th>合同编号</th>
								<th>合同名称</th>
								<th>生效时间</th>
								<th>失效时间</th>
								<th style="display:none;">创建者</th>
								<th style="display:none;">创建时间</th>
								<th style="display:none;">更新者</th>
								<th style="display:none;">更新时间</th>
								<th>备注信息</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${page.list}" var="supplierContract" varStatus="status">
								<tr  data-index="${status.index }">
								<!--  -->
									<td class="details-control text-center">
											<i class="fa fa-plus-square-o text-success"></i>
									</td>
									<td>
										<%-- <a href="${ctx}/lgt/si/supplierContract/info?id=${supplierContract.id}" target=""> --%>
										${supplierContract.supplier.name}
										<!-- </a> -->
									</td>
									<td>
										${supplierContract.purchaseOrder.orderNo}
									</td>
									<td>${supplierContract.contractNo }</td>
									<td>
										<shiro:hasPermission name="lgt:si:supplier:contractView">
											<a href="#" download="${supplierContract.fileLibrary.name}" href="${imgHost }${supplierContract.fileLibrary.fileUrl}">
										</shiro:hasPermission>
											${supplierContract.name }
										<shiro:hasPermission name="lgt:si:supplier:contractView">
											</a>
										</shiro:hasPermission>
									</td>
									<td>
										<fmt:formatDate value="${supplierContract.effectStartTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>
									<td>
										<fmt:formatDate value="${supplierContract.effectEndTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>
									<td data-hide="true">
										${fns:getUserById(supplierContract.createBy.id).name}
									</td>
									<td data-hide="true">
										<fmt:formatDate value="${supplierContract.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>
									<td data-hide="true">
										${fns:getUserById(supplierContract.updateBy.id).name}
									</td>
									<td data-hide="true">
										<fmt:formatDate value="${supplierContract.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>
									<td title="${supplierContract.remarks }">
										${fns:abbr(supplierContract.remarks, 15)}
									</td>
									<td>
										<shiro:hasPermission name="lgt:si:supplierContract:edit">
											<div class="btn-group zf-tableButton">
													<button type="button" class="btn btn-sm btn-info"
														onclick="window.location.href='${ctx}/lgt/si/supplierContract/form?id=${supplierContract.id}'">修改</button>
													<button type="button"
														class="btn btn-sm btn-info dropdown-toggle"
														data-toggle="dropdown">
														<span class="caret"></span>
													</button>
													<ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
														<li><a href="${ctx}/lgt/si/supplierContract/delete?id=${supplierContract.id}" style="color: #fff" onclick="return ZF.delRow('确定要删除该合同吗？',this.href)">删除</a>
														</li>
														<li><a href="${ctx}/lgt/si/supplierContract/info?id=${supplierContract.id}" target="">详情</a></li>
													</ul>
											</div>
										</shiro:hasPermission>
										<shiro:lacksPermission name="lgt:si:supplierContract:edit">
											<div class="btn-group zf-tableButton">
													<button type="button" class="btn btn-sm btn-info"
														onclick="window.location.href='${ctx}/lgt/si/supplierContract/info?id=${supplierContract.id}'">详情</button>
													<button type="button"
														class="btn btn-sm btn-info dropdown-toggle"
														data-toggle="dropdown">
														<span class="caret"></span>
													</button>
											</div>
										</shiro:lacksPermission>
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
	
	<script>
	  $(function () {
		
		ZF.bigImg();
		 
		$('input').iCheck({
			checkboxClass : 'icheckbox_minimal-blue',
			radioClass : 'iradio_minimal-blue'
		});
		  
	    //表格初始化
		ZF.parseTable("#contentTable", {
			"paging" : false,
			"lengthChange" : false,
			"searching" : false,
			"ordering" : true,
			"order": [[ 5, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
			"columnDefs":[
				{"orderable":false,targets:0},
				{"orderable":false,targets:1},
				{"orderable":false,targets:2},
				{"orderable":false,targets:3},
				{"orderable":false,targets:4},
				{"orderable":false,targets:7},
				{"orderable":false,targets:8},
				{"orderable":false,targets:9},
				{"orderable":false,targets:10},
				{"orderable":false,targets:11},
				{"orderable":false,targets:12}
          	],
			"info" : false,
			"autoWidth" : false,
			"multiline" : true,//是否开启多行表格
			"isRowSelect" : true,//是否开启行选中
			"rowSelect" : function(tr) {
				
			},
			"rowSelectCancel" : function(tr) {
				
			}
		})
	  });
	  
	  function xz(url) {
		  return window.open(url);
	  }
   </script>
</body>
</html>