<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>供应商账号管理</title>
	<meta name="decorator" content="adminLte"/>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
		<section class="content-header content-header-menu">
			<h1>
				<small class="menu-active"><i class="fa fa-repeat"></i><a
					href="${ctx}/lgt/si/supplierContacts/">供应商通讯录列表</a></small> 
				<shiro:hasPermission name="lgt:si:supplierContacts:edit">
					<small>|</small>
					<small><i class="fa-form-edit"></i><a
						href="${ctx}/lgt/si/supplierContacts/form?id=${supplierContacts.id}">供应商联系人${not empty supplierContacts.id?'修改':'添加'}</a></small>
				</shiro:hasPermission>
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
				
				<form:form id="searchForm" modelAttribute="supplierContacts"
					action="${ctx}/lgt/si/supplierContacts/" method="post"
					class="form-horizontal">
					<input id="pageNo" name="pageNo" type="hidden"
						value="${page.pageNo}" />
					<input id="pageSize" name="pageSize" type="hidden"
						value="${page.pageSize}" />
					<div class="box-body">
						<div class="row">
							<div class="col-md-4">
									<sys:inputtree name="supplier.id" url="${ctx}/lgt/si/supplier/treeData"
										id="supplier" label="供应商" labelValue="" labelWidth="3"
										inputWidth="7" labelName="supplier.name" value="" tip="请选择供应商"></sys:inputtree>
							</div>
							<div class="col-md-4">
								<div class="form-group">
									<label for="officeName" class="col-sm-3 control-label">岗位</label>
									<div class="col-sm-7">
										<form:select path="job" class="form-control select2">
											<form:option value="" label="所有" />
											<form:options
												items="${fns:getDictList('lgt_si_supplier_contacts_job')}"
												itemLabel="label" itemValue="value" htmlEscape="false" />
										</form:select>
									</div>
								</div>
							</div>
							
							<div class="col-md-4">
								<div class="form-group">
									<label for="role" class="col-sm-3 control-label">角色</label>
									<div class="col-sm-7">
										<form:select path="role" class="form-control select2">
											<form:option value="" label="所有" />
											<form:options
												items="${fns:getDictList('lgt_si_supplier_contacts_role')}"
												itemLabel="label" itemValue="value" htmlEscape="false" />
										</form:select>
									</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-4">
								<div class="form-group">
									<label for="name" class="col-sm-3 control-label">联系人姓名</label>
									<div class="col-sm-7">
										<form:input id="name" path="name" htmlEscape="false" maxlength="255" class="form-control"   placeholder="请输入联系人姓名"/>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="box-footer">
						<div class="pull-right box-tools">
							<button type="button" class="btn btn-default btn-sm"
								onclick="ZF.resetForm()">
								<i class="fa fa-refresh"></i>重置
							</button>
							<button type="submit" class="btn btn-info btn-sm">
								<i class="fa fa-search"></i>查询
							</button>
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
									<th>联系人姓名</th>
									<th>所属供应商名称</th>
									<th>角色</th>
									<th>岗位</th>
									<th>联系电话</th>
									<th style="display:none;">创建者</th>
									<th style="display:none;">创建时间</th>
									<th style="display:none;">更新者</th>
									<th style="display:none;">更新时间</th>
									<th style="display:none;">备注信息</th>
									<shiro:hasPermission name="lgt:si:supplierContacts:edit">
										<th>操作</th>
									</shiro:hasPermission>
								</tr>
							</thead>
						    <tbody>
								<c:forEach items="${page.list}" var="supplierContacts" varStatus="status">
									<tr data-index="${status.index }">
										<td class="details-control text-center">
											<i class="fa fa-plus-square-o text-success"></i>
										</td>
										<td title="${supplierContacts.name }">
											${fns:abbr(supplierContacts.name, 20)} 
										</td>
										<td title="${supplierContacts.supplier.name }">${fns:abbr(supplierContacts.supplier.name, 20)}</td>
										<td>${fns:getDictLabel(supplierContacts.role, 'lgt_si_supplier_contacts_role', '')}
										</td>
										<td>${fns:getDictLabel(supplierContacts.job, 'lgt_si_supplier_contacts_job', '')}
										</td>
										<td>
											${fns:abbr(supplierContacts.telephone,20)}</td>
										<td data-hide="true">${supplierContacts.createBy.name}</td>
										<td data-hide="true"><fmt:formatDate value="${supplierContacts.createDate}"
												pattern="yyyy-MM-dd HH:mm:ss" /></td>
										<td data-hide="true">${supplierContacts.updateBy.name}</td>
										<td data-hide="true"><fmt:formatDate value="${supplierContacts.updateDate}"
												pattern="yyyy-MM-dd HH:mm:ss" /></td>
										<td  data-hide="true">
											${fns:abbr(supplierContacts.remarks,15)}</td>
										<td>
											<shiro:hasPermission name="lgt:si:supplierContacts:edit">
												<div class="btn-group zf-tableButton">
													<button type="button" class="btn btn-sm btn-info"
															onclick="window.location.href='${ctx}/lgt/si/supplierContacts/form?id=${supplierContacts.id}'">修改</button>
													<button type="button"
														class="btn btn-sm btn-info dropdown-toggle"
														data-toggle="dropdown">
														<span class="caret"></span>
													</button>
													<ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
														<li><a
															href="${ctx}/lgt/si/supplierContacts/delete?id=${supplierContacts.id}"
															style="color: #fff"
															onclick="return ZF.delRow('确认要删除该联系人吗？',this.href)">删除</a>
														</li>
														<li><a href="${ctx}/lgt/si/supplierContacts/info?id=${supplierContacts.id}">详情</a></li>
													</ul>
												</div>
											</shiro:hasPermission>
											<shiro:lacksPermission name="lgt:si:supplierContacts:edit">
												<div class="btn-group zf-tableButton">
													<button type="button" class="btn btn-sm btn-info"
															onclick="window.location.href='${ctx}/lgt/si/supplierContacts/info?id=${supplierContacts.id}'">详情</button>
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
					<div class="box-footer">
	        			<div class="dataTables_paginate paging_simple_numbers">${page}</div>
	        		</div>
			</div>
		</section>
	</div>
	<script type="text/javascript">
		$(function() {
			
			//表格初始化
			ZF.parseTable("#contentTable", {
				"paging" : false,
				"lengthChange" : false,
				"searching" : false,
				"ordering" : false,
				"info" : false,
				"autoWidth" : false,
				"multiline" : true,//是否开启多行表格
				"isRowSelect" : true,//是否开启行选中
				"rowSelect" : function(tr) {
					
				},
				"rowSelectCancel" : function(tr) {
					
				}
			});
			
		});
		
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
   </script>
</body>
</html>