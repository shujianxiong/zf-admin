<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>货品货位调整</title>
	<meta name="decorator" content="adminLte"/>
	<style type="text/css">
		tr{ 
		    cursor: pointer;    /*手形*/   
		} 
	</style>
	<script type="text/javascript">
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
				<small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/lgt/ps/productWpChange/list">货品货位调整记录</a></small>
				<shiro:hasPermission name="lgt:ps:productWpChange:edit">
					<small>|</small>
					<small>
						<i class="fa-form-edit"></i><a href="${ctx}/lgt/ps/productWpChange/form">货品货位调整</a>
					</small>
				</shiro:hasPermission> 
			</h1>
		</section>
		
		<sys:tip content="${message}" />
		
		<section class="content">
			<div class="box box-info">
				<div class="box-header with-border zf-query">
					<h5>查询条件</h5>
					<div class="box-tools pull-right">
						<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
						<button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-remove"></i></button>
					</div>
				</div>
	 			<form:form id="searchForm" modelAttribute="productWpChange" action="${ctx}/lgt/ps/productWpChange/list" method="post" class="form-horizontal">
					<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
					<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
					
					<div class="box-body">
						<div class="row">
							<div class="col-md-4">
								<div class="form-group">
									<label for="" class="col-sm-3 control-label">货品编码</label>
									<div class="col-sm-7">
										<form:input path="product.code" htmlEscape="false" maxlength="64" class="form-control" title="支持模糊匹配查询"/>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-group">
									<label for="searchParam" class="col-sm-3 control-label" >调货原因类型</label>
									<div class="col-sm-7">
										<form:select path="reasonType" class="form-control select2">
											<form:option value="" label="所有"/>
											<form:options items="${fns:getDictList('lgt_ps_product_wp_change_reasonType')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
										</form:select>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div  class="form-group">
									<label for="changeUserName" class="col-sm-3 control-label">创建人</label>
									<div class="col-sm-7">
										<div class="input-group">
											<form:hidden id="createById" path="createBy.id" />
											<form:input id="createByName" path="createBy.name"
													htmlEscape="false" maxlength="100" class="form-control zf-input-readonly"
													placeholder="请选择调货人" readonly="true" onclick="selectUser();"/>
											<sys:userselect height="550" url="${ctx}/sys/office/userTreeData"
												width="550" isOffice="false" isMulti="false" title="人员选择"
												id="selectUser" ></sys:userselect>
											
											<span class="input-group-addon" onclick="selectUser();"><i class="fa fa-search"></i></span>
										</div>
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
									<th>货品编码</th>
									<th>调前货位</th>
									<th>调前持有人</th>
									<th>调后货位</th>
									<th>调后持有人</th>
									<th>调货原因类型</th>
									<th>创建人</th>
									<th>创建时间</th>
									<th>备注信息</th>
<%-- 									<th><shiro:hasPermission name="lgt:ps:productWpChange:edit">操作</shiro:hasPermission></th> --%>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${page.list}" var="productWpChange">
									<tr>
										<td>
											${productWpChange.product.code}
										</td>
										<td>
											${productWpChange.preWareplace.warecounter.warearea.warehouse.code}-${productWpChange.preWareplace.warecounter.warearea.code}-${productWpChange.preWareplace.warecounter.code}-${productWpChange.preWareplace.code}
										</td>
										<td>
											${fns:getUserById(productWpChange.preHoldUser.id).name}
										</td>
										<td>
											${productWpChange.postWareplace.warecounter.warearea.warehouse.code}-${productWpChange.postWareplace.warecounter.warearea.code}-${productWpChange.postWareplace.warecounter.code}-${productWpChange.postWareplace.code}
										</td>
										<td>
											${fns:getUserById(productWpChange.postHoldUser.id).name}
										</td>
										<td>
											<c:choose>
												<c:when test="${productWpChange.reasonType eq '1' }">
													<span class="label label-success">${fns:getDictLabel(productWpChange.reasonType, 'lgt_ps_product_wp_change_reasonType','')}</span>
												</c:when>
												<c:when test="${productWpChange.reasonType eq '2' }">
													<span class="label label-primary">${fns:getDictLabel(productWpChange.reasonType, 'lgt_ps_product_wp_change_reasonType','')}</span>
												</c:when>
											</c:choose>
										</td>
										<td>
											${fns:getUserById(productWpChange.createBy.id).name}
										</td>
										<td>
											<fmt:formatDate value="${productWpChange.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
										</td>
										<td title="${productWpChange.remarks}">
											${fns:abbr(productWpChange.remarks,15)}
										</td>
<!-- 										<td> -->
<!-- 											<div class="btn-group zf-tableButton"> -->
<%-- 												<button type="button" class="btn btn-sm btn-info" onclick="window.location.href='${ctx}/lgt/ps/productWpChange/changePath?pid=${productWpChange.product.id}'">流转路径</button> --%>
<!-- 											</div> -->
<!-- 										</td> -->
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
		<script type="application/javascript">
			$(function() {
				/* $("#changeUserName").on("click", function() {
					selectUserinit({
						"selectCallBack" : function(list) {
							$("#changeUserId").val(list[0].id);
							$("#changeUserName").val(list[0].text);
						}
					})
				}); */
				
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
			
			function selectUser() {
				selectUserinit({
					"selectCallBack" : function(list) {
						$("#createById").val(list[0].id);
						$("#createByName").val(list[0].text);
					}
				});
			}
		</script>
	</div>		
</body>
</html>