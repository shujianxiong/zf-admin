<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>调货任务入库管理</title>
	<meta name="decorator" content="adminLte"/>
	<style type="text/css">
		tr{ 
		    cursor: pointer;    /*手形*/   
		} 
	</style>
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
	<!-- Content Wrapper. Contains page content -->
	<div class="content-wrapper sub-content-wrapper">
		<section class="content-header content-header-menu">
			<h1>
				<small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/lgt/dp/dispatchOrder/pendingStockList">执行调货任务入库列表</a></small>
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
			    <form:form id="searchForm" modelAttribute="dispatchOrder" action="${ctx}/lgt/dp/dispatchOrder/pendingStockList" method="post" class="form-horizontal">
			    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
				<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		        <div class="box-body">
		        	<div class="row">
		        		<div class="col-md-4">
		        			<div class="form-group">
			                  <label for="reasonType" class="col-sm-3 control-label">调货原因</label>
			                  <div class="col-sm-7">
			                    <form:select path="dispatchMission.reasonType" class="form-control select2" style="width: 100%;">
									<form:option value="" label="所有"/>
									<form:options items="${fns:getDictList('dispatch_mission_reasonType')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
								</form:select>
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
				<div class="box-header">
					
				</div>
				<div class="box-body">
				<div class="table-responsive">
	    			<table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
						<thead>
							<tr>
							<th class="zf-dataTables-multiline"></th>
							<th>任务编号</th>
							<th>发起人</th>
							<th>调货原因</th>
							<th style="display:none">发起时间</th>
							<th style="display:none">要求完成时间</th>
							<th style="display:none">实际完成时间</th>
							<th>任务类型</th>
							<th>任务状态</th>
							<th>调货单状态</th>
							<th>调出仓库</th>
							<th>调出责任人</th>
							<th>调入仓库</th>
							<th>接收责任人</th>
							<shiro:hasPermission name="lgt:dp:dispatchOrder:edit"><th>操作</th></shiro:hasPermission>
						</tr>
						</thead>
						<tbody>
						<c:forEach items="${page.list}" var="dispatchOrder" varStatus="status">
							<tr data-index="${status.index }">
								<td class="details-control text-center">
									<i class="fa fa-plus-square-o text-success"></i>
								</td>
								<td>${dispatchOrder.dispatchMission.missionCode}</td>
								<td>
									${fns:getUserById(dispatchOrder.dispatchMission.startBy.id).name} 
								</td>
								<td>
									${fns:getDictLabel(dispatchOrder.dispatchMission.reasonType, 'dispatch_mission_reasonType', '')}
								</td>
								<td data-hide="true">
									<fmt:formatDate value="${dispatchOrder.dispatchMission.startTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
								</td>
								<td data-hide="true">
									<fmt:formatDate value="${dispatchOrder.dispatchMission.limitTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
								</td>
								<td data-hide="true">
									<fmt:formatDate value="${dispatchOrder.dispatchMission.endTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
								</td>
								<td>
									<c:if test="${dispatchOrder.dispatchMission.businessType eq '1'}">
										<span class="label label-info">${fns:getDictLabel(dispatchOrder.dispatchMission.businessType, 'bas_mission_businessType', '')}</span>
									</c:if>
									<c:if test="${dispatchOrder.dispatchMission.businessType eq '2'}">
										<span class="label label-danger">${fns:getDictLabel(dispatchOrder.dispatchMission.businessType, 'bas_mission_businessType', '')}</span>
									</c:if>
								</td>
								<td>
									<c:if test="${dispatchOrder.dispatchMission.missionStatus eq '1'}">
										<span class="label label-info">${fns:getDictLabel(dispatchOrder.dispatchMission.missionStatus, 'dispatch_mission_missionStatus', '')}</span>
									</c:if>
									<c:if test="${dispatchOrder.dispatchMission.missionStatus eq '2'}">
										<span class="label label-warning">${fns:getDictLabel(dispatchOrder.dispatchMission.missionStatus, 'dispatch_mission_missionStatus', '')}</span>
									</c:if>
									<c:if test="${dispatchOrder.dispatchMission.missionStatus eq '3'}">
										<span class="label label-primary">${fns:getDictLabel(dispatchOrder.dispatchMission.missionStatus, 'dispatch_mission_missionStatus', '')}</span>
									</c:if>
									<c:if test="${dispatchOrder.dispatchMission.missionStatus eq '4'}">
										<span class="label label-success">${fns:getDictLabel(dispatchOrder.dispatchMission.missionStatus, 'dispatch_mission_missionStatus', '')}</span>
									</c:if>
								</td>
								<td>
									<c:if test="${dispatchOrder.orderStatus eq '1'}">
										<span class="label label-info">${fns:getDictLabel(dispatchOrder.orderStatus, 'dispatch_order_status', '')}</span>
									</c:if>
									<c:if test="${dispatchOrder.orderStatus eq '2'}">
										<span class="label label-primary">${fns:getDictLabel(dispatchOrder.orderStatus, 'dispatch_order_status', '')}</span>
									</c:if>
									<c:if test="${dispatchOrder.orderStatus eq '3'}">
										<span class="label label-primary">${fns:getDictLabel(dispatchOrder.orderStatus, 'dispatch_order_status', '')}</span>
									</c:if>
									<c:if test="${dispatchOrder.orderStatus eq '4'}">
										<span class="label label-primary">${fns:getDictLabel(dispatchOrder.orderStatus, 'dispatch_order_status', '')}</span>
									</c:if>
									<c:if test="${dispatchOrder.orderStatus eq '5'}">
										<span class="label label-primary">${fns:getDictLabel(dispatchOrder.orderStatus, 'dispatch_order_status', '')}</span>
									</c:if>
									<c:if test="${dispatchOrder.orderStatus eq '6'}">
										<span class="label label-primary">${fns:getDictLabel(dispatchOrder.orderStatus, 'dispatch_order_status', '')}</span>
									</c:if>
									<c:if test="${dispatchOrder.orderStatus eq '7'}">
										<span class="label label-success">${fns:getDictLabel(dispatchOrder.orderStatus, 'dispatch_order_status', '')}</span>
									</c:if>
								</td>
								<td>
									${dispatchOrder.outWarehouse.name}
								</td>
								<td>
									${fns:getUserById(dispatchOrder.outUser.id).name}
								</td>
								<td>
									${dispatchOrder.dispatchMission.inWarehouse.name}
								</td>
								<td>
									${fns:getUserById(dispatchOrder.dispatchMission.inUser.id).name} 
								</td>
								<shiro:hasPermission name="lgt:dp:dispatchOrder:edit">
    								<td>
										<div class="btn-group">
						                  <input type="hidden" id="dispatchOrderId" value="${dispatchOrder.id }"/>
						                  <input type="hidden" id="dispatchMissionId" value="${dispatchOrder.dispatchMission.id }"/>
						                  <button type="button" class="btn btn-sm btn-info" onclick="window.location.href='${ctx}/lgt/dp/dispatchProduct/stockInfo?dispatchOrderId=${dispatchOrder.id}'">去入库</button>
						                   <button type="button" class="btn btn-sm btn-info dropdown-toggle" data-toggle="dropdown">
						                    <span class="caret"></span>
						                  </button>
						                  <ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
												<li><a href="${ctx}/lgt/dp/dispatchMission/detailed?id=${dispatchMission.dispatchMission.id}&dispatchOrder.id=${dispatchOrder.id}" style="color:#fff">详情</a></li>
							                  </ul>
						                </div>
    								</td>
								</shiro:hasPermission>
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
		//表格初始化
		 	var t=ZF.parseTable("#contentTable",{
				"paging" : false,
				"lengthChange" : false,
				"searching" : false,//关闭搜索
				"ordering" : false,//开启排序
				"info" : false,
				"autoWidth" : false,
				"multiline":true,//是否开启多行表格
				"isRowSelect":true,//是否开启行选中
				"rowSelect":function(tr){},//行选中回调
				"rowSelectCancel":function(tr){},//行取消选中回调
				"addRow":{
					"eventId":"#addRow",
					"getData":function(){
						return ["<td class=\"details-control text-center\"><i class=\"fa fa-plus-square-o text-success\"></i></td>",
						        "<td>2</td>",
						        "<td>3</td>",
						        "<td>4</td>",
						        "<td>5</td>",
						        "<td>6</td>",
						        "<td>7</td>",
						        "<td data-hide=\"true\">8</td>",
						        "<td data-hide=\"true\">9</td>",
						        "<td data-hide=\"true\">10</td>",
						        "<td data-hide=\"true\">11</td>",
						        "<td title=\"测试\">12</td>",
						        "<td>13</td>"
						       ];
					},
					"callBack":function(){
						console.log("行添加结束")
					}
					
				}
			});
	    
	  	//表格单选功能
	    $('#contentTable tbody').on( 'click', 'tr', function (){
	        if ($(this).hasClass('selected')) {
	            $(this).removeClass('selected');
	        }else{
	        	$('#contentTable tr.selected').removeClass('selected');
	            $(this).addClass('selected');
	        }
	    });
	  	
	  });
</script>
</body>
</html>