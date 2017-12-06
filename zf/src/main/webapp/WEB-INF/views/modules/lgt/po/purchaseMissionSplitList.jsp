<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>采购任务分单</title>
<meta name="decorator" content="adminLte" />
<script type="text/javascript">
	function page(n, s) {
		$("#pageNo").val(n);
		$("#pageSize").val(s);
		$("#searchPurchaseForm").submit();
		return false;
	};

	function removePurchase(url, id) {
		confirm("确认要删除该采购单吗？", "warning", function() {
			window.location.href = url + "?id=" + id;
		});
	};
</script>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
		<section class="content-header content-header-menu">
			<h1>
				<small class="menu-active">
					<i class="fa fa-repeat"></i><a href="${ctx}/lgt/po/purchaseMissionSplit/list">采购任务分单列表</a>
				</small>
			</h1>
		</section>
		<sys:tip content="${message}" />
		<section class="content">
			<form:form id="searchPurchaseForm" modelAttribute="purchaseMission"	action="${ctx}/lgt/po/purchaseMissionSplit/list" method="post" class="form-horizontal">
				<input id="pageNo" name="pageNo" type="hidden"
					value="${page.pageNo}" />
				<input id="pageSize" name="pageSize" type="hidden"
					value="${page.pageSize}" />
				<div class="box box-info">
					<div class="box-header with-border zf-query">
						<h5>查询条件</h5>
						<div class="box-tools pull-right">
							<button type="button" class="btn btn-box-tool"
								data-widget="collapse">
								<i class="fa fa-minus"></i>
							</button>
							<button type="button" class="btn btn-box-tool"
								data-widget="remove">
								<i class="fa fa-remove"></i>
							</button>
						</div>
					</div>
					<div class="box-body">
						<div class="row">
						  <div class="col-md-4">
                                <div class="form-group">
                                    <label for="code" class="col-sm-3 control-label" >任务编号</label>
                                    <div class="col-sm-7">
                                        <sys:inputverify name="batchNo" id="batchNo" verifyType="0" tip="请输入任务编号" isSpring="true" isMandatory="false"></sys:inputverify>
                                    </div>
                                </div>
                            </div>
							<div class="col-md-4">
								<div class="form-group">
									<label for="code" class="col-sm-3 control-label" >任务状态</label>
									<div class="col-sm-7">
										<form:select path="missionStatus" htmlEscape="false" maxlength="50" class="form-control select2">
											<form:option label="所有" value="" />
											<form:options items="${fns:getDictList('lgt_po_purchase_mission_missionStatus')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
										</form:select>
									</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-4">
								<div class="form-group">
									<label for="beginCreateDate" class="col-sm-3 control-label">起始创建时间</label>
									<div class="col-sm-7">
										<sys:datetime id="beginCreateDate" inputId="beginCreateDate" inputName="beginCreateDate" value="${purchaseMission.beginCreateDate}" tip="请选择起始创建时间" isMandatory="false"></sys:datetime>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-group">
									<label for="endCreateDate" class="col-sm-3 control-label">截止创建时间</label>
									<div class="col-sm-7">
										<sys:datetime id="endCreateDate" inputId="endCreateDate" inputName="endCreateDate" value="${purchaseMission.endCreateDate}" tip="请选择截止创建时间" isMandatory="false"></sys:datetime>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="box-footer">
						<div class="pull-right box-tools">
							<button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()">
								<i class="fa fa-refresh"></i>重置
							</button>
							<button type="submit" class="btn btn-info btn-sm">
								<i class="fa fa-search"></i>查询
							</button>
						</div>
					</div>
				</div>
			</form:form>

			<div class="box box-soild">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-12 pull-right"></div>
					</div>
					<div class="table-responsive">
						<table id="contentTable" class="table table-hover table-bordered table-striped zf-tbody-font-size">
							<thead>
								<tr>
									<th>任务编号</th>
									<th>任务状态</th>
									<th>创建者</th>
									<th>创建时间</th>
									<th>更新者</th>
									<th>更新时间</th>
									<th>备注信息</th>
									<th><shiro:hasPermission name="lgt:po:purchaseMissionSplit:edit">操作</shiro:hasPermission></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${page.list}" var="purchaseMission" varStatus="pstatus">
									<tr id="${purchaseMission.id}" data-index="${pstatus.index}${status.index}">
										<td nowrap>${purchaseMission.batchNo}</td>
										<td>
											<c:choose>
												<c:when test="${purchaseMission.missionStatus == 3 }">
													<span class="label label-info">${fns:getDictLabel(purchaseMission.missionStatus,'lgt_po_purchase_mission_missionStatus','')}</span>
												</c:when>
												<c:when test="${purchaseMission.missionStatus == 4 }">
													<span class="label label-primary">${fns:getDictLabel(purchaseMission.missionStatus,'lgt_po_purchase_mission_missionStatus','')}</span>
												</c:when>
												<c:when test="${purchaseMission.missionStatus == 5 }">
													<span class="label label-success">${fns:getDictLabel(purchaseMission.missionStatus,'lgt_po_purchase_mission_missionStatus','')}</span>
												</c:when>
												<c:otherwise>
													<span class="label label-danger"></span>
												</c:otherwise>
											</c:choose>
										</td>
										<td>${fns:getUserById(purchaseMission.createBy.id).name}</td>
										<td><fmt:formatDate value="${purchaseMission.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
										<td>${fns:getUserById(purchaseMission.updateBy.id).name}</td>
										<td><fmt:formatDate value="${purchaseMission.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
										<td>${fns:abbr(purchaseOrder.remarks,15)}</td>
										<td>
											<div class="btn-group zf-tableButton">
												<button type="button" class="btn btn-sm btn-info" onclick="window.location.href='${ctx}/lgt/po/purchaseMissionSplit/info?id=${purchaseMission.id}'">详情</button>
												   <button type="button" class="btn btn-sm btn-info dropdown-toggle" data-toggle="dropdown">
	                                               <span class="caret"></span>
                                                </button>
												<c:choose>
													<c:when test="${purchaseMission.missionStatus eq '3'}">
														<shiro:hasPermission name="lgt:po:purchaseMissionSplit:edit">
															<ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
																<li><a href="${ctx}/lgt/po/purchaseMissionSplit/splitForm?id=${purchaseMission.id}" style="color:#fff">分单</a></li>
															</ul>
														</shiro:hasPermission>
													</c:when>
												</c:choose>
											</div>
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
		var purchaseId = null;
		$(function() {
			//表格初始化
			ZF.parseTable("#contentTable", {
				"paging" : false,
				"lengthChange" : false,
				"searching" : false,//关闭搜索
				"ordering" : true,
				"order": [[ 5, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
                "columnDefs":[
                    {"orderable":false,targets:0},
                    {"orderable":false,targets:1},
                    {"orderable":false,targets:2},
                    {"orderable":false,targets:4},
                    {"orderable":false,targets:6},
                    {"orderable":false,targets:7}
                ],
				"info" : false,
				"multiline":true,//是否开启多行表格
				"isRowSelect":true,//是否开启行选中
				"isRowSelect" : true,//是否开启行选中
				"rowSelect" : function(tr) {
					purchaseId = tr.attr("data-value");
				},
				"rowSelectCancel" : function(tr) {
					purchaseId = null;
				}
			});

			$("#purchaseUserName").on("click", function() {
				selectUserinit({
					"selectCallBack" : function(list) {
						$("#purchaseUserId").val(list[0].id);
						$("#purchaseUserName").val(list[0].text);
					}
				})
			});
			$("#orderUserName").on("click", function() {
				selectUserinit({
					"selectCallBack" : function(list) {
						$("#orderUserId").val(list[0].id);
						$("#orderUserName").val(list[0].text);
					}
				})
			});
		});
	</script>
</body>

<%@include file="/WEB-INF/views/include/treetable.jsp" %>
</html>