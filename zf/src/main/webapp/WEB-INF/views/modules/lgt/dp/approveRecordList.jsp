<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>任务审核管理</title>
	<meta name="decorator" content="adminLte"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
		});
		
	</script>
</head>
<body>
<%-- <div class="nav-tabs-custom tab-success">
		<ul class="nav nav-tabs">
			<li><a href="${ctx}/lgt/dp/dispatchMission/checkList">调货任务列表</a></li>
		<li class="active"><a href="">审核任务审核</a></li>
		</ul><br/>
	</div> --%>
	<div class="content-wrapper sub-content-wrapper">
	    	<section class="content">
	    	<div class="row">
		    	<div class="col-md">
		    		<div class="box box-info">
			    		<div class="box-header with-border">
				          <h5>审核任务</h5>
				        </div>
				        <form:form id="inputForm" modelAttribute="approvalRecord" action="${ctx}/lgt/dp/dispatchMission/approvalRecordSava" method="post" class="form-horizontal">
				        <sys:tip content="${message}"/>
	   					<input type="hidden" name="dispatchMissionId" value="${dispatchMission.id}">
	   					<input type="hidden" name="token" value="${token}">
				        <div class="box-body">
				        	<input name="approveUser.id" type="hidden" value="${fns:getUser().id}"/>
			        		<div class="col-md-4">
			        			<div class="form-group">
				                  <label for="status" class="col-sm-3 control-label">审批结果<font color="red">*</font></label>
				                  <div class="col-sm-7">
				                    <%-- <form:select path="approveResultStatus" class="form-control select2">
										<form:options items="${fns:getDictList('approve_result_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
									</form:select> --%>
				                  </div>
				        		</div>
				        	</div>
				        	<div class="col-md-4">
			        			<div class="form-group">
				                  <label for="remarks" class="col-sm-3 control-label">备注<font color="red">*</font></label>
				                  <div class="col-sm-7">
				                    <textarea name="approveRemarks" rows="3" maxlength="200" style="width:271px"></textarea>
				                  </div>
			                   </div>
			                </div>
				        </div>
				        <div style="border-top: 1px solid;"></div>
		                <div class="box-body">
		                	<div class="col-md-3">
			        			<div class="form-group">
				                  <label for="remarks" class="col-sm-4 control-label">调货单信息</label>
			                   </div>
			                </div>
		                </div>
		                <div class="box-body">
		                	<div class="col-md">
			                   <table id="contentTable" cellspacing="0" class="table table-bordered table-hover table-striped zf-tbody-font-size">
										<thead>
											<tr>
												<th>任务发起人</th>
												<th>调出仓库</th>
												<th>调出仓库责任人</th>
												<th>调入仓库</th>
												<th>调入仓库责任人</th>
												<th>产品名称</th>
												<th>安排调货数量</th>
												<th>实际调货数量</th>
												<th>实调说明</th>
											</tr>
										</thead>
										<tbody>
										<c:forEach items="${dispatchOrders}" var="dispatchOrders">
											<tr>
												<td>
													 ${fns:getUserById(dispatchOrders.dispatchMission.startBy.id).name}
												</td>
												<td>
													${dispatchOrders.outWarehouse.name}
												</td>
												<td>
													${fns:getUserById(dispatchOrders.outUser.id).name}
												</td>
												<td>
													${dispatchOrders.dispatchMission.inWarehouse.name}
												</td>
												<td>
													${fns:getUserById(dispatchOrders.dispatchMission.inUser.id).name}
												</td>
												<td>
													${dispatchOrders.dispatchProduce.produce.goods.name}--${dispatchOrders.dispatchProduce.produce.name}
												</td>
												<td>
													${dispatchOrders.dispatchProduce.planNum}
												</td>
												<td>
													${dispatchOrders.dispatchProduce.actualNum}
												</td>
												<td>
													${dispatchOrders.dispatchProduce.actualRemarks}
												</td>
											</tr>
										</c:forEach>
										</tbody>
									</table>
			                </div>
		                </div>
		                <div style="border-top: 1px solid;"></div>
		                <div class="box-body">
		                	<div class="col-md-3">
			        			<div class="form-group">
				                  <label for="remarks" class="col-sm-4 control-label">审核记录信息</label>
			                   </div>
			                </div>
		                </div>
		                <div class="box-body">
		                	<div class="col-md">
			                   <table id="contentTable" cellspacing="0" class="table table-bordered table-hover table-striped">
										<thead>
											<tr>
												<th>审批人</th>
												<th>审批结果</th>
												<th>备注</th>
											</tr>
										</thead>
										<tbody>
										<c:forEach items="${approvalRecords}" var="approvelRecords">
											<tr>
												<td>
													${fns:getUserById(approvelRecords.approveUser.id).name} 
												</td>
												<td>
													${fns:getDictLabel(approvelRecords.approveResultStatus, 'approve_result_status', '')}
												</td>
												<td>
													${approvelRecords.approveRemarks}
												</td>
											</tr>
										</c:forEach>
										</tbody>
									</table>
			                </div>
		                </div>
				        <div class="box-footer">
				        	<div class="pull-right box-tools">
				        		<button type="button" class="btn btn-default" onclick="history.go(-1)">取消</button>
			               		<button type="submit" class="btn btn-info">确认</button>
				        	</div>
			            </div>
			            </form:form>
			    	</div>
			    </div>
		    </div>
	    	</section>
	</div>



</body>
</html>