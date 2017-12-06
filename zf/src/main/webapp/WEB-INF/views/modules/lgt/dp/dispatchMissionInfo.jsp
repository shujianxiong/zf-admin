<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>调货任务详细信息</title>
	<meta name="decorator" content="adminLte"/>
	
</head>
<script type="text/javascript">
$(document).ready(function() {
	
})
</script>
<body>
	<div class="content-wrapper sub-content-wrapper">
			<%-- <section class="content-header content-header-menu">
				<h1>
					<small><i class="fa fa-repeat"></i><a href="${ctx}/lgt/dp/dispatchMissionExe">执行调货出库任务列表</a></small>
					<small>|</small>
					<small class="menu-active"><i class="fa fa-repeat"></i><a>调货任务详细信息</a></small>
				</h1>
			</section> --%>
	    	<section class="content">
	    	<div class="row">
		    	<div class="col-md-12">
		    		<div class="box box-primary">
			    		<div class="box-header with-border zf-query">
				          <h5>调货任务详细信息</h5>
				        </div>
				        <form:form id="inputForm" modelAttribute="dispatchMission" action="${ctx}/lgt/dp/dispatchMission/save" method="post" class="form-horizontal">
				        <sys:tip content="${message}"/>
	   					<form:hidden path="id"/>
				        <div class="box-body">
			              	<strong>发起人</strong>
							<p class="text-primary">${dispatchMission.startBy.name}</p>
							<hr class="zf-hr">
			                <strong>调货原因</strong>
							<p><span class="label label-primary">${fns:getDictLabel(dispatchMission.reasonType ,'dispatch_mission_reasonType', '')}</span></p>
							<hr class="zf-hr">
			              	<strong>任务发起时间</strong>
							<p class="text-primary"><fmt:formatDate value="${dispatchMission.startTime}" type="both" dateStyle="full"/></p>
							<hr class="zf-hr">
			                <strong>要求完成时间</strong>
							<p class="text-primary"><fmt:formatDate value="${dispatchMission.limitTime}" type="both" dateStyle="full"/></p>
							<hr class="zf-hr">
			                <strong>调货状态</strong>
							<p><span class="label label-primary">${fns:getDictLabel(dispatchMission.missionStatus, 'dispatch_mission_missionStatus', '')}</span></p>
							<hr class="zf-hr">
			                <strong>调入仓库</strong>
							<p class="text-primary">${dispatchMission.inWarehouse.name}</p>
							<hr class="zf-hr">
							<strong>调入仓库责任人</strong>
							<p class="text-primary">${fns:getUserById(dispatchMission.inUser.id).name}</p>
							<hr class="zf-hr">
			                <strong>备注</strong>
							<p class="text-primary">${dispatchMission.remarks}</p>
							<hr class="zf-hr">
		                </div>
		                <div class="box-body">
		                	<div class="col-md">
			                   <table id="contentTable" cellspacing="0" class="table table-bordered table-hover table-striped zf-tbody-font-size">
										<thead>
										<tr>
											<th>产品编号</th>
											<th>产品名称</th>
											<th>需调拨数量</th>
											<th>实调拨数量</th>
										</tr>
									</thead>
									<tbody id="tableList">
										<c:forEach items="${dispatchMission.dispatchOrder.dispatchProduceList}" var="prce" varStatus="sta">
											<tr  id="table_${prce.produce.id}">
												<td>
													${prce.produce.code}
												</td>
												<td>${prce.produce.name }</td>
												<td>
													${prce.planNum}
												</td>
												<td>
													${prce.actualNum}
												</td>
											</tr>
											<tr>
												<th>货品编码</th>
												<th>货品名称</th>
												<th>调出货位</th>
												<th>调入货位</th>
											</tr>
											<c:forEach items="${prce.dispatchProductList }" var="disProduct"> 
												<tr>
													<td>${disProduct.product.code }</td>
													<td>${disProduct.product.goods.name }</td>
													<td>${disProduct.product.preWarehouseFullName }</td>
													<td>${disProduct.product.postWarehouseFullName }</td>
												</tr>
											</c:forEach>
										</c:forEach>
									</tbody>
								</table>
			                </div>
		                </div>
				        <div class="box-footer">
				        	<div class="pull-left box-tools">
				        		<button type="button" class="btn btn-default" onclick="history.go(-1)">返回</button>
				        	</div>
			            </div>
			            </form:form>
			    	</div>
			    </div>
		    </div>
		    <sys:selectmutil id="viewGoodsByProduceId" title="调出货品详情" url="" isDisableCommitBtn="false" width="1200" height="700" ></sys:selectmutil>
	    	</section>
	</div>
<script type="text/javascript">
function viewGoods(dispatchProduceId) {
	// 选择产品
	$("#viewGoodsByProduceIdModalUrl").val("${ctx}/lgt/dp/dispatchProduct/?dispatchProduceId="+dispatchProduceId);//带参数请求URL设置方式
   	$("#viewGoodsByProduceIdModal").modal('toggle');//显示模态框
}
</script>

</body>

</html>