<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>采购订单执行列表</title>
	<meta name="decorator" content="adminLte"/>
	<script type="text/javascript">
		$(document).ready(function() {

			$("#createByName").on("click", function() {
                selectUserinit({
                    "selectCallBack" : function(list) {
                        $("#createById").val(list[0].id);
                        $("#createByName").val(list[0].text);
                    }
                })
            });
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
					<i class="fa fa-repeat"></i><a href="${ctx}/lgt/po/purchaseOrderExe/list">采购订单列表</a>
				</small>
			</h1>
		</section>
		<sys:tip content="${message}" />
		
		<sys:userselect height="550" url="${ctx}/sys/office/userTreeData"
            width="550" isOffice="false" isMulti="false" title="人员选择"
            id="selectUser" ></sys:userselect>
		
		<section class="content">
			<form:form id="searchPurchaseForm" modelAttribute="purchaseOrder"	action="${ctx}/lgt/po/purchaseOrderExe/list" method="post" class="form-horizontal">
				<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
				<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
				<div class="box box-info">
					<div class="box-header with-border zf-query">
						<h5>查询条件</h5>
						<div class="box-tools pull-right">
							<button type="button" class="btn btn-box-tool" data-widget="collapse">
								<i class="fa fa-minus"></i>
							</button>
							<button type="button" class="btn btn-box-tool" data-widget="remove">
								<i class="fa fa-remove"></i>
							</button>
						</div>
					</div>
					<div class="box-body">
						<div class="row">
							<div class="col-md-4">
								<div class="form-group">
									<label for="code" class="col-sm-3 control-label" >采购单编号</label>
									<div class="col-sm-7">
										<form:input id="orderNo" path="orderNo" htmlEscape="false" maxlength="64" class="form-control"  placeholder="请输入采购单编号"/>
									</div>
								</div>
							</div>
						    <div class="col-md-4">
                                <div class="form-group">
                                    <label for="code" class="col-sm-3 control-label" >任务编号</label>
                                    <div class="col-sm-7">
                                        <form:input id="batchNo" path="purchaseMission.batchNo" htmlEscape="false" maxlength="64" class="form-control"  placeholder="请输入任务编号"/>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label for="code" class="col-sm-3 control-label" >采购单状态</label>
                                    <div class="col-sm-7">
                                        <form:select path="orderStatus" htmlEscape="false" maxlength="50" class="form-control select2">
                                            <form:option label="所有" value="" />
                                            <form:options items="${fns:getDictList('lgt_po_purchase_order_orderStatus')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                                        </form:select>
                                    </div>
                                </div>
                            </div>
					   </div>
					   <div class="row">
							<div class="col-md-4">
                                <div class="form-group">
                                    <label for="code" class="col-sm-3 control-label" >下单员工</label>
                                    <div class="col-sm-7">
                                        <form:hidden id="createById" path="createBy.id" />
                                        <form:input id="createByName" path="createBy.name"
                                            htmlEscape="false" maxlength="100" class="form-control zf-input-readonly"
                                            placeholder="选择下单用户" readonly="true"/>
                                    </div>
                                </div>
                            </div>
							<div class="col-md-4">
								<div class="form-group">
									<label for="code" class="col-sm-3 control-label" >供应商</label>
									<div class="col-sm-7">
										<form:select path="supplier.id" htmlEscape="false" maxlength="50" class="form-control select2">
											<form:option label="所有" value="" />
												<form:options items="${supplierList}" itemLabel="name" itemValue="id" htmlEscape="false"/>
										</form:select>
									</div>
								</div>
							</div>
						   <div class="col-md-4">
							   <div class="form-group">
								   <label for="productCode" class="col-sm-3 control-label" >关联货品编码</label>
								   <div class="col-sm-7">
									   <form:input id="productCode" path="productCode" htmlEscape="false" maxlength="64" class="form-control"  placeholder="请输入货品编码"/>
								   </div>
							   </div>
						   </div>
						</div>
						<div class="row">
							<div class="col-md-4">
								<div class="form-group">
									<label for="beginEnterTime" class="col-sm-3 control-label">起始录入时间</label>
									<div class="col-sm-7">
										<sys:datetime id="beginEnterTime" inputId="beginEnterTime" inputName="beginEnterTime" value="${purchaseOrder.beginEnterTime}" tip="请选择起始录入时间" isMandatory="false"></sys:datetime>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-group">
									<label for="endEnterTime" class="col-sm-3 control-label">截止录入时间</label>
									<div class="col-sm-7">
										<sys:datetime id="endEnterTime" inputId="endEnterTime" inputName="endEnterTime" value="${purchaseOrder.endEnterTime}" tip="请选择截止录入时间" isMandatory="false"></sys:datetime>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="box-footer">
						<div class="pull-right box-tools">
						    <button type="button" class="btn btn-sm btn-success" id="exportBtn"><i class="fa fa-file-excel-o">Excel导出</i></button>
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
									<th class="zf-dataTables-multiline"></th>
									<th>采购单编号</th>
									<th>任务编号</th>
									<th>采购单状态</th>
									<th>下单员工</th>
									<th>采购员工</th>
									<th>供应商</th>
									<th title="应付采购金额">应付金额</th>
									<th title="实付采购金额">实付金额</th>
									<th>要求完成时间</th>
									<th>实际完成时间</th>
									<th>结算金价</th>
									<th style="display:none">创建者</th>
									<th style="display:none">创建时间</th>
									<th style="display:none">更新者</th>
									<th style="display:none">更新时间</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${page.list}" var="purchaseOrder" varStatus="pstatus">
									<tr id="${purchaseOrder.purchaseMission.id}" data-index="${pstatus.index}${status.index}">
										<td class="details-control text-center"><i class="fa fa-plus-square-o text-success"></i></td>
										<td>
											${purchaseOrder.orderNo}
										</td>
										<td>
											${purchaseOrder.purchaseMission.batchNo}
										</td>
										<td>
											<c:choose>
											    <c:when test="${purchaseOrder.orderStatus == 1 }">
                                                    <span class="label label-default">${fns:getDictLabel(purchaseOrder.orderStatus,'lgt_po_purchase_order_orderStatus','')}</span>
                                                </c:when>
												<c:when test="${purchaseOrder.orderStatus == 2 }">
													<span class="label label-info">${fns:getDictLabel(purchaseOrder.orderStatus,'lgt_po_purchase_order_orderStatus','')}</span>
												</c:when>
												<c:when test="${purchaseOrder.orderStatus == 3 }">
													<span class="label label-primary">${fns:getDictLabel(purchaseOrder.orderStatus,'lgt_po_purchase_order_orderStatus','')}</span>
												</c:when>
												<c:when test="${purchaseOrder.orderStatus == 4 }">
													<span class="label label-success">${fns:getDictLabel(purchaseOrder.orderStatus,'lgt_po_purchase_order_orderStatus','')}</span>
												</c:when>
												<c:otherwise>
													<span class="label label-danger">已关闭</span>
												</c:otherwise>
											</c:choose>
										</td>
										<td>
											${fns:getUserById(purchaseOrder.createBy.id).name}
										</td>
										<td>
											${fns:getUserById(purchaseOrder.purchaseUser.id).name}
										</td>
										<td>
											${purchaseOrder.supplier.name}
										</td>
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
										<td class="zf-table-money">
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
										<td>
											<div class="btn-group zf-tableButton">
												<button type="button" class="btn btn-sm btn-info" onclick="window.location.href='${ctx}/lgt/po/purchaseOrderExe/info?id=${purchaseOrder.id}'">详情</button>
												<button type="button" class="btn btn-sm btn-info dropdown-toggle" data-toggle="dropdown">
													<span class="caret"></span>
												</button>
											    <shiro:hasPermission name="lgt:po:purchaseOrderExe:edit">
											        <c:choose>
											            <c:when test="${purchaseOrder.orderStatus eq '2'}"> <!-- 审批通过 -->
                                                            <ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
                                                                <li><a href="${ctx}/lgt/po/purchaseOrderExe/receiveOrder?id=${purchaseOrder.id}" style="color:#fff">接单</a></li>
                                                            </ul>
	                                                    </c:when>
	                                                    <c:when test="${purchaseOrder.orderStatus eq '3'}">
                                                            <ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
                                                                <shiro:hasPermission name="lgt:po:purchaseOrderExport:view">
	                                                                <li><a href="#this" onclick="exportFile('${purchaseOrder.id}')">导出</a></li>
                                                                </shiro:hasPermission>
                                                                <li><a href="${ctx}/lgt/po/purchaseOrderExe/form?id=${purchaseOrder.id}" style="color:#fff">录入货品</a></li>
                                                                <li><a href="#this" onclick="finishPurchaseOrder('${ctx}/lgt/po/purchaseOrderExe/finish?id=${purchaseOrder.id}');" style="color:#fff">订单完成</a></li>
                                                            </ul>
	                                                    </c:when>
	                                                    <c:when test="${purchaseOrder.orderStatus eq '4'}">
                                                           <shiro:hasPermission name="lgt:po:purchaseOrderExport:view">
	                                                           <ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
                                                                    <li><a href="#this" onclick="exportFile('${purchaseOrder.id}')">导出</a></li>
                                                                </ul>
                                                           </shiro:hasPermission>
	                                                    </c:when>
											        </c:choose>
											    </shiro:hasPermission>
											    <shiro:lacksPermission name="lgt:po:purchaseOrderExe:edit">
                                                    <shiro:hasPermission name="lgt:po:purchaseOrderExport:view">
                                                         <ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
                                                             <li><a href="#this" onclick="exportFile('${purchaseOrder.id}')">导出</a></li>
                                                         </ul>
                                                    </shiro:hasPermission>											         
											    </shiro:lacksPermission>
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
		$(function () {
			 //表格初始化
			ZF.parseTable("#contentTable",{
				"paging" : false,
				"lengthChange" : false,
				"searching" : false,				// 关闭搜索
				"order": [[ 15, "desc" ]],			// 指定默认初始化按第几列排序，默认排序升序，降序
				"columnDefs":[
					{"orderable":false,targets:0},	//第 0列和第16列不排序
					{"orderable":false,targets:1},
					{"orderable":false,targets:2},
					{"orderable":false,targets:3},
					{"orderable":false,targets:4},
					{"orderable":false,targets:5},
					{"orderable":false,targets:6},
					{"orderable":false,targets:12},
					{"orderable":false,targets:13},
					{"orderable":false,targets:14},
					{"orderable":false,targets:15},
					{"orderable":false,targets:16}
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
		 
		 function exportFile(purchaseOrderId) {
			 window.location.href = "${ctx}/lgt/po/purchaseOrderExport/export?id="+purchaseOrderId;
		 };
		 
		 $("#exportBtn").on("click", function() {
	            $("#searchPurchaseForm").attr("action", "${ctx}/lgt/po/purchaseOrderExport/exportProduct");
	            $("#searchPurchaseForm").submit();
	            $("#searchPurchaseForm").attr("action", "${ctx}/lgt/po/purchaseOrderExe/list");
	        });
	</script>
</body>
</html>