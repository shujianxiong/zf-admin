<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>供应商采购订单列表</title>
	<meta name="decorator" content="adminLte"/>
	<script type="text/javascript">
		$(document).ready(function() {

		});
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
				<small class="menu-active">
					<i class="fa fa-repeat"></i><a href="#" onclick="javascript:history.go(0);">采购订单列表</a>
				</small>
			</h1>
		</section>
		<sys:tip content="${message}" />
		<section class="content">
			<div class="box box-soild">
				<div class="box-body">
					<div class="table-responsive">
						<table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
							<thead>
								<tr>
									<th>&nbsp;</th>
									<th>采购单编号</th>
									<!-- <th>任务批次编号</th> -->
									<th>采购单状态</th>
									<!-- <th>下单员工</th> -->
									<th>采购员工</th>
									<!-- <th>供应商</th> -->
									<th title="应付采购金额">应付金额</th>
									<th title="实付采购金额">实付金额</th>
									<th>要求完成时间</th>
									<th>实际完成时间</th>
									<th title="结算金价">结算金价</th>
									<th style="display:none">创建者</th>
									<th style="display:none">创建时间</th>
									<th style="display:none">更新者</th>
									<th style="display:none">更新时间</th>
									<th>备注信息</th>
									<%-- <shiro:hasPermission name="lgt:po:purchase:edit"><th>操作</th></shiro:hasPermission> --%>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${page.list}" var="purchaseOrder" varStatus="pstatus">
									<tr id="${purchaseOrder.purchaseMission.id}" data-index="${pstatus.index}${status.index}">
										<td>
											<input type="radio" name="selectName"  value="${purchaseOrder.id}=${purchaseOrder.orderNo}" />
										</td>
										<td>
											${purchaseOrder.orderNo}
										</td>
										<%-- <td>
											${purchaseOrder.purchaseMission.batchNo}
										</td> --%>
										<td>
											<c:choose>
												<c:when test="${purchaseOrder.orderStatus == 2 }">
													<span class="label label-default">${fns:getDictLabel(purchaseOrder.orderStatus,'lgt_po_purchase_order_orderStatus','')}</span>
												</c:when>
												<c:when test="${purchaseOrder.orderStatus == 3 }">
													<span class="label label-primary">${fns:getDictLabel(purchaseOrder.orderStatus,'lgt_po_purchase_order_orderStatus','')}</span>
												</c:when>
												<c:when test="${purchaseOrder.orderStatus == 4 }">
													<span class="label label-success">${fns:getDictLabel(purchaseOrder.orderStatus,'lgt_po_purchase_order_orderStatus','')}</span>
												</c:when>
												<c:otherwise>
													<span class="label label-danger"></span>
												</c:otherwise>
											</c:choose>
										</td>
										<%-- <td>
											${fns:getUserById(purchaseOrder.createBy.id).name}
										</td> --%>
										<td>
											${fns:getUserById(purchaseOrder.purchaseUser.id).name}
										</td>
										<%-- <td>
											${purchaseOrder.supplier.name}
										</td> --%>
										<td class="zf-table-money">
											<span class="text-red">${purchaseOrder.payableAmount}</span>
										</td>
										<td class="zf-table-money">
											<span class="text-red">${purchaseOrder.paidAmount}</span>
										</td>
										<td>
											<fmt:formatDate value="${purchaseOrder.requiredTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
										</td>
										<td>
											<fmt:formatDate value="${purchaseOrder.finishTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
										</td>
										<td  class="zf-table-money">
											<span class="text-red">${purchaseOrder.clearingGoldprice}</span>
										</td>
										<td data-hide="true">
											${fns:getUserById(purchaseOrder.createBy.id).name}
										</td>
										<td data-hide="true">
											<fmt:formatDate value="${purchaseOrder.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
										</td>
										<td data-hide="true">
											${fns:getUserById(purchaseOrder.updateBy.id).name}
										</td>
										<td data-hide="true">
											<fmt:formatDate value="${purchaseOrder.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
										</td>
										<td title="${purchaseOrder.remarks }">
											${fns:abbr(purchaseOrder.remarks,15)}
										</td>
										<%-- <td>
											<div class="btn-group zf-tableButton">
												<button type="button" class="btn btn-sm btn-info" onclick="window.location.href='${ctx}/lgt/po/purchaseOrderExe/info?id=${purchaseOrder.id}'">预览</button>
												<c:choose>
													<c:when test="${purchaseOrder.orderStatus eq '2'}">
														<shiro:hasPermission name="lgt:po:purchaseMissionSplit:edit">
														<button type="button" class="btn btn-sm btn-info dropdown-toggle" data-toggle="dropdown">
															<span class="caret"></span>
														</button>
														<ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
															<li><a href="${ctx}/lgt/po/purchaseOrderExe/receiveOrder?id=${purchaseOrder.id}" style="color:#fff">接单</a></li>
														</ul>
														</shiro:hasPermission>
													</c:when>
													<c:when test="${purchaseOrder.orderStatus eq '3'}">
														<shiro:hasPermission name="lgt:po:purchaseMissionSplit:edit">
														<button type="button" class="btn btn-sm btn-info dropdown-toggle" data-toggle="dropdown">
															<span class="caret"></span>
														</button>
														<ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
															<li><a href="${ctx}/lgt/po/purchaseOrderExe/form?id=${purchaseOrder.id}" style="color:#fff">录入货品</a></li>
															<li><a href="#this" onclick="finishPurchaseOrder('${ctx}/lgt/po/purchaseOrderExe/finish?id=${purchaseOrder.id}');" style="color:#fff">订单完成</a></li>
														</ul>
														</shiro:hasPermission>
													</c:when>
													<c:otherwise>
														<button type="button" class="btn btn-sm btn-info dropdown-toggle disable" data-toggle="dropdown">
										                   <span class="caret"></span>
										                </button>
													</c:otherwise>
												</c:choose>
											</div>
										</td> --%>
										
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
		$(function () {
			
			$('input').iCheck({
				checkboxClass : 'icheckbox_minimal-blue',
				radioClass : 'iradio_minimal-blue'
			});
			
			 //表格初始化
			ZF.parseTable("#contentTable",{
				"paging" : false,
				"lengthChange" : false,
				"searching" : false,				// 关闭搜索
				"order": [[ 4, "desc" ]],			// 指定默认初始化按第几列排序，默认排序升序，降序
				"columnDefs":[
					{"orderable":false,targets:0},	//第 0列和第16列不排序
					{"orderable":false,targets:1},
					{"orderable":false,targets:2},
					{"orderable":false,targets:3},
					{"orderable":false,targets:9},
					{"orderable":false,targets:10},
					{"orderable":false,targets:11},
					{"orderable":false,targets:12},
					{"orderable":false,targets:13}
		       ],
				"ordering" : true,					// 开启排序
				"info" : false,
				"autoWidth" : false,
				"multiline":true,					// 是否开启多行表格
				"isRowSelect":true,					// 是否开启行选中
				"rowSelect":function(tr){},			// 行选中回调
				"rowSelectCancel":function(tr){}	// 行取消选中回调
			});
		});
		
		 function finishPurchaseOrder(url){
			 confirm("确认该采购订单已完成？<br/>确认后该采购订单将进入已完成状态，采购订单、采购产品、采购货品将不可修改，对应货品将入库，对应仓库库存将变更！", "warning", function(){
				 window.location.href = url;
			 });
		 }
	</script>
</body>
</html>