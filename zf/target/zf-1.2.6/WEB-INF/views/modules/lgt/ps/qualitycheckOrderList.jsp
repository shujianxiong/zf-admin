<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>货品质检单管理</title>
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
			<small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/lgt/ps/qualitycheckOrder/">待质检调货单列表</a></small>
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
			
			<form:form id="searchForm" modelAttribute="qualitycheckOrder" action="${ctx}/lgt/ps/qualitycheckOrder/" method="post" class="form-horizontal">
				<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
				<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
				
				<div class="box-body">
					<div class="row">
						<div class="col-md-4">
							<div  class="form-group">
								<label for="type" class="col-sm-3 control-label">质检类型</label>
								<div class="col-sm-7">	
									<form:select path="qcBusinessType" class="form-control select2">
										<form:option value="" label="所有"/>
										<form:options items="${fns:getDictList('lgt_ps_qualitycheck_order_qcType')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
									</form:select>
								</div>
							</div>
						</div>
						<div class="col-md-4">
							<div  class="form-group">
								<label for="type" class="col-sm-3 control-label">质检状态</label>
								<div class="col-sm-7">
									<form:select path="qcStatus" class="form-control select2">
										<form:option value="" label="所有"/>
										<form:options items="${fns:getDictList('lgt_ps_qualitycheck_order_qcStatus')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
									</form:select>
								</div>
							</div>
						</div>
						
						<div class="col-md-4">
							<div  class="form-group">
								<label for="level" class="col-sm-3 control-label">员工编号</label>
								<div class="col-sm-7">
									<form:hidden id="qcUserId" path="qcUser.id" />
									<form:input id="qcUserName" path="qcUser.name"
										htmlEscape="false" maxlength="100" class="form-control zf-input-readonly"
										placeholder="请选择员工" readonly="true"/>
								</div>
							</div>
						</div>
						
					</div>
					<div class="row">
						<div class="col-md-4">
							<div  class="form-group">
								<label for="activeFlag" class="col-sm-3 control-label">质检结果</label>
								<div class="col-sm-7">
									<form:select path="qcResult" class="form-control select2">
										<form:option value="" label="所有"/>
										<form:options items="${fns:getDictList('lgt_ps_qualitycheck_order_qcResult')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
									</form:select>
								</div>
							</div>
						</div>
						
						<div class="col-md-4">
							<div  class="form-group">
								<label for="activeFlag" class="col-sm-3 control-label">质检开始时间</label>
								<div class="col-sm-7" style="display: inline;">
									<sys:datetime inputId="beginQcTime" inputName="beginQcTime" tip="请选择开始时间" value="${qualitycheckOrder.beginQcTime}" id="beginQCTime" isMandatory="false"></sys:datetime>
								</div>
							</div>
						</div>
						<div class="col-md-4">
							<div  class="form-group">
								<label for="activeFlag" class="col-sm-3 control-label">质检结束时间</label>
								<div class="col-sm-7" style="display: inline;">
									<sys:datetime inputId="endQcTime" inputName="endQcTime" tip="请选择结束时间" value="${qualitycheckOrder.endQcTime}" id="endQCTime" isMandatory="false" ></sys:datetime>
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
								<th>调货单编号</th>	
								<th>质检类型</th>
								<th>质检状态</th>
								<th>质检员工</th>
								<th>质检时间</th>
								<th>是否称重</th>
								<th>是否检验外观</th>
								<th>是否核对裸石编码</th>
								<th>完成时间</th>
								<th>质检结果</th>
								<th>备注信息</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody>
						<c:forEach items="${page.list}" var="qualitycheckOrder">
						<tr>
							<td>
								${qualitycheckOrder.batchNo }
							</td>
							<td>
								<c:choose>
									<c:when test="${qualitycheckOrder.qcBusinessType eq '1' }">
										<span class="label label-success">${fns:getDictLabel(qualitycheckOrder.qcBusinessType, 'lgt_ps_qualitycheck_order_qcType', '')}</span>
									</c:when>
									<c:when test="${qualitycheckOrder.qcBusinessType eq '2' }">
										<span class="label label-primary">${fns:getDictLabel(qualitycheckOrder.qcBusinessType, 'lgt_ps_qualitycheck_order_qcType', '')}</span>
									</c:when>
								</c:choose>
							</td>
							<td>
								<c:choose>
									<c:when test="${qualitycheckOrder.qcStatus eq '0' }">
										<span class="label label-info">${fns:getDictLabel(qualitycheckOrder.qcStatus, 'lgt_ps_qualitycheck_order_qcStatus', '')}</span>
									</c:when>
									<c:when test="${qualitycheckOrder.qcStatus eq '1' }">
										<span class="label label-default">${fns:getDictLabel(qualitycheckOrder.qcStatus, 'lgt_ps_qualitycheck_order_qcStatus', '')}</span>
									</c:when>
									<c:when test="${qualitycheckOrder.qcStatus eq '2' }">
										<span class="label label-success">${fns:getDictLabel(qualitycheckOrder.qcStatus, 'lgt_ps_qualitycheck_order_qcStatus', '')}</span>
									</c:when>
								</c:choose>
							</td>
							<td>
								${fns:getUserById(qualitycheckOrder.qcUser.id).name}
							</td>
							<td>
								<fmt:formatDate value="${qualitycheckOrder.qcTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
							</td>
							<td>
								<c:choose>
									<c:when test="${qualitycheckOrder.weighFlag eq '1'}">
										<span class="label label-success">${fns:getDictLabel(qualitycheckOrder.weighFlag, 'yes_no', '')}</span>
									</c:when>
									<c:when test="${qualitycheckOrder.weighFlag eq '0'}">
										<span class="label label-primary">${fns:getDictLabel(qualitycheckOrder.weighFlag, 'yes_no', '')}</span>
									</c:when>
								</c:choose>
							</td>
							<td>
								<c:choose>
									<c:when test="${qualitycheckOrder.surfacecheckFlag eq '1'}">
										<span class="label label-success">${fns:getDictLabel(qualitycheckOrder.surfacecheckFlag, 'yes_no', '')}</span>
									</c:when>
									<c:when test="${qualitycheckOrder.surfacecheckFlag eq '0'}">
										<span class="label label-primary">${fns:getDictLabel(qualitycheckOrder.surfacecheckFlag, 'yes_no', '')}</span>
									</c:when>
								</c:choose>
							</td>
							<td>
								<c:choose>
									<c:when test="${qualitycheckOrder.codecheckFlag eq '1'}">
										<span class="label label-success">${fns:getDictLabel(qualitycheckOrder.codecheckFlag, 'yes_no', '')}</span>
									</c:when>
									<c:when test="${qualitycheckOrder.codecheckFlag eq '0'}">
										<span class="label label-primary">${fns:getDictLabel(qualitycheckOrder.codecheckFlag, 'yes_no', '')}</span>
									</c:when>
								</c:choose>
							</td>
							<td>
								<fmt:formatDate value="${qualitycheckOrder.finishTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
							</td>
							<td>
								<c:choose>
									<c:when test="${qualitycheckOrder.qcResult eq '1'}">
										<span class="label label-success">${fns:getDictLabel(qualitycheckOrder.qcResult, 'lgt_ps_qualitycheck_order_qcResult', '')}</span>
									</c:when>
									<c:when test="${qualitycheckOrder.qcResult eq '0'}">
										<span class="label label-primary">${fns:getDictLabel(qualitycheckOrder.qcResult, 'lgt_ps_qualitycheck_order_qcResult', '')}</span>
									</c:when>
								</c:choose>
								
							</td>
							<td title="${qualitycheckOrder.remarks}">
								${fns:abbr(qualitycheckOrder.remarks,15)}
							</td>
							<td>
								<shiro:hasPermission name="lgt:ps:lgtPsQualitycheckOrder:edit">
									<div class="btn-group zf-tableButton">
										<c:choose>
											<c:when test="${qualitycheckOrder.qcStatus eq '0'}"><!-- 待质检 -->
												<button type="button" class="btn btn-sm btn-info"
													onclick="window.location.href='${ctx}/lgt/ps/qualitycheckOrder/qualityStart?id=${qualitycheckOrder.id}'">质检</button>
												<button type="button"
													class="btn btn-sm btn-info dropdown-toggle"
													data-toggle="dropdown">
													<span class="caret"></span>
												</button>
												<ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
													<li><a href="${ctx}/lgt/ps/qualitycheckOrder/info?id=${qualitycheckOrder.id}">详情</a></li>
												</ul>
											</c:when>
											<c:when test="${qualitycheckOrder.qcStatus eq '1'}"><!-- 质检中 -->
												<button type="button" class="btn btn-sm btn-info"
													onclick="window.location.href='${ctx}/lgt/ps/qualitycheckOrder/form?id=${qualitycheckOrder.id}'">录入结果</button>
												<button type="button"
													class="btn btn-sm btn-info dropdown-toggle"
													data-toggle="dropdown">
													<span class="caret"></span>
												</button>
												<ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
													<li><a href="${ctx}/lgt/ps/qualitycheckOrder/info?id=${qualitycheckOrder.id}">详情</a></li>
												</ul>
											</c:when>
											<c:otherwise>
												<button type="button" class="btn btn-sm btn-info" onclick="window.location.href='${ctx}/lgt/ps/qualitycheckOrder/info?id=${qualitycheckOrder.id}'">详情</button>
												<button type="button" class="btn btn-sm btn-info dropdown-toggle" data-toggle="dropdown">
													<span class="caret"></span>
												</button>
											</c:otherwise>
										</c:choose>
									</div>
								</shiro:hasPermission>
								<shiro:lacksPermission name="lgt:ps:lgtPsQualitycheckOrder:edit">
									<div class="btn-group zf-tableButton">
										<button type="button" class="btn btn-sm btn-info" onclick="window.location.href='${ctx}/lgt/ps/qualitycheckOrder/info?id=${qualitycheckOrder.id}'">详情</button>
										<button type="button" class="btn btn-sm btn-info dropdown-toggle" data-toggle="dropdown">
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
    	
    	<sys:userselect height="550" url="${ctx}/sys/office/userTreeData"
			width="550" isOffice="false" isMulti="false" title="人员选择"
			id="selectUser" ></sys:userselect>
	 </section>
	</div>
	<script type="text/javascript">
		$(function() {
			$("#qcUserName").on("click", function() {
				selectUserinit({
					"selectCallBack" : function(list) {
						$("#qcUserId").val(list[0].id);
						$("#qcUserName").val(list[0].text);
					}
				})
			});
			
			//表格初始化
			ZF.parseTable("#contentTable", {
				"paging" : false,
				"lengthChange" : false,
				"searching" : false,
				"ordering" : true,
				"order": [[ 4, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
				"columnDefs":[
					{"orderable":false,targets:0},
					{"orderable":false,targets:1},
					{"orderable":false,targets:2},
					{"orderable":false,targets:3},
					{"orderable":false,targets:5},
					{"orderable":false,targets:6},
					{"orderable":false,targets:7},
					{"orderable":false,targets:9},
					{"orderable":false,targets:10},
					{"orderable":false,targets:11}
	          	],
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
	</script>
</body>
</html>