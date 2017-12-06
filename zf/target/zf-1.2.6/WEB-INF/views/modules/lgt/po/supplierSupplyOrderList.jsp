<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>供应商供货管理</title>
	<meta name="decorator" content="adminLte"/>
	<script type="text/javascript">
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchPurchaseForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
		<section class="content-header content-header-menu">
			<h1>
				<small class="menu-active"><i class="fa fa-repeat"></i><a
					href="${ctx}/lgt/po/purchaseOrderExe/supplierSupplyOrderList">供货单列表</a></small>
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
		
				<form:form id="searchPurchaseForm" modelAttribute="purchaseOrder"
				action="${ctx}/lgt/po/purchaseOrderExe/supplierSupplyOrderList" method="post"
				class="form-horizontal">
					<input id="pageNo" name="pageNo" type="hidden"
						value="${page.pageNo}" />
					<input id="pageSize" name="pageSize" type="hidden"
						value="${page.pageSize}" />
					<div class="box-body">
						<div class="row">
							<div class="col-md-4">
								<div class="form-group">
									<label for="beginRequiredTime" class="col-sm-3 control-label">需完成开始时间</label>
									<div class="col-sm-7">
										<sys:datetime id="beginRequiredTimeId" inputName="beginRequiredTime" value="${purchaseOrder.beginRequiredTime }" tip="请选择开始时间" inputId="beginRequiredTime"></sys:datetime>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-group">
									<label for="endRequiredTime" class="col-sm-3 control-label">需完成截止时间</label>
									<div class="col-sm-7">
										<sys:datetime id="endRequiredTimeId" inputName="endRequiredTime" value="${purchaseOrder.endRequiredTime }"  tip="请选择截止时间" inputId="endRequiredTime"></sys:datetime>
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
					</div>
				</form:form>
			</div>

			<div class="box box-soild">
				<div class="box-body">
					<div class="table-responsive">
						<table id="contentTable"
							class="table table-bordered table-hover table-striped zf-tbody-font-size">
							<thead>
								<tr>
									<th>采购单编号</th>
									<th>采购订单状态</th>
									<th>采购员工</th>
									<th>要求完成时间</th>
									<th>应付采购金额</th>
									<th>实付采购金额</th>
									<th>实际完成时间</th>
									<th>结算金价</th>
									<!-- <th>创建者</th>
									<th>创建时间</th>
									<th>更新者</th> -->
									<!-- <th>更新时间</th>
									<th>备注信息</th> -->
									<%-- <shiro:hasPermission name="lgt:si:supplier:edit">
										<th>操作</th>
									</shiro:hasPermission> --%>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${page.list}" var="purchaseOrder">
									<tr>
										<td>
											<%-- <a href="${ctx}/lgt/po/purchase/purchaseOrderDetail?id=${purchaseOrder.id}"> --%>
												${purchaseOrder.orderNo}
											<!-- </a> -->
										</td>
										<td>
											<c:if test="${purchaseOrder.orderStatus  eq '1'}"><!-- 新建 -->
												<span class="label label-default">${fns:getDictLabel(purchaseOrder.orderStatus, 'lgt_po_purchase_order_orderStatus', '')}</span>
											</c:if> 
											<c:if test="${purchaseOrder.orderStatus  eq '2'}"><!-- 已提交 -->
												<span class="label label-primary">${fns:getDictLabel(purchaseOrder.orderStatus, 'lgt_po_purchase_order_orderStatus', '')}</span>
											</c:if>
											<c:if test="${purchaseOrder.orderStatus  eq '3'}"><!-- 采购中 -->
												<span class="label label-info">${fns:getDictLabel(purchaseOrder.orderStatus, 'lgt_po_purchase_order_orderStatus', '')}</span>
											</c:if> 
											<c:if test="${purchaseOrder.orderStatus eq '4'}"><!-- 采购完成 -->
												<span class="label label-success">${fns:getDictLabel(purchaseOrder.orderStatus, 'lgt_po_purchase_order_orderStatus', '')}</span>
											</c:if>
										</td>
										<td>${fns:getUserById(purchaseOrder.purchaseUser.id).name}</td>
										<td><fmt:formatDate value="${purchaseOrder.requiredTime}"
												pattern="yyyy-MM-dd HH:mm:ss" /></td>
										<td   class="zf-table-money">
											<span class="text-red">${purchaseOrder.payableAmount}</span>
										</td>
										<td   class="zf-table-money">
											<span class="text-red">${purchaseOrder.paidAmount}</span>
										</td>
										<td><fmt:formatDate value="${purchaseOrder.finishTime}"
												pattern="yyyy-MM-dd HH:mm:ss" /></td>
										<td   class="zf-table-money">
											<span class="text-red">${purchaseOrder.clearingGoldprice}</span>
										</td>
										<%-- <td>
										${fns:getUserById(purchase.createBy.id).name}
									</td>
									<td>
										<fmt:formatDate value="${purchase.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>
									<td>
										${fns:getUserById(purchase.updateBy.id).name}
									</td> --%>
										<%-- <td>
										<fmt:formatDate value="${purchase.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>
									<td title="${purchase.remarks }">
										${fns:abbr(purchase.remarks,15)}
									</td> --%>
										<%-- <td><shiro:hasPermission name="lgt:po:purchase:edit">
												<div class="btn-group">
													<c:if test="${purchase.status=='1'}">
													<button type="button" class="btn btn-sm btn-info"
														onclick="window.location.href='${ctx}/lgt/po/purchase/form?id=${purchaseOrder.id}'">修改</button>
													 </c:if>
						    					<c:if test="${purchase.status=='1' or purchase.status=='2'}">
													<button type="button"
														class="btn btn-sm btn-info dropdown-toggle"
														data-toggle="dropdown">
														<span class="caret"></span>
													</button>
													<ul class="dropdown-menu btn-info" role="menu">
														<li><a href="#this"
															onclick="removePurchase('${ctx}/lgt/po/purchase/delete','${purchaseOrder.id}')"
															style="color: #fff">删除</a></li>
													</ul>
												</div>
											</shiro:hasPermission></td> --%>
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
				"searching" : false,
				"ordering" : true,
				"order": [[ 3, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
				"columnDefs":[
                    {"orderable":false,targets:0},
                    {"orderable":false,targets:1},
					{"orderable":false,targets:2}
	          	],
				"info" : false,
				"autoWidth" : false,
				"multiline" : true,//是否开启多行表格
				"isRowSelect" : true,//是否开启行选中
				"rowSelect" : function(tr) {
					purchaseId = tr.attr("data-value");
				},
				"rowSelectCancel" : function(tr) {
					purchaseId = null;
				}
			})
			
			$('.date-picker').datepicker({
                language: 'zh-CN',
                autoclose: true,
                todayHighlight: true
            });
			
		});
	</script>
</body>
</html>