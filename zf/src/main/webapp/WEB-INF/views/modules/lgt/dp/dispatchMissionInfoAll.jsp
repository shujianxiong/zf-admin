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
	    <section class="content-header content-header-menu">
            
        </section>
        
        <section class="invoice">
            <p class="lead">基本信息</p>
            <div class="table-responsive">
                <table class="table">
                    <tr>
                        <th width="10%">发起人</th>
                        <td>${dispatchMission.startBy.name}</td>
                        <th width="10%">调货原因</th>
                        <td><span class="label label-primary">${fns:getDictLabel(dispatchMission.reasonType ,'dispatch_mission_reasonType', '')}</span></td>
                    </tr>
                    <tr>
                        <th width="10%">任务发起时间</th>
                        <td><fmt:formatDate value="${dispatchMission.startTime}" type="both" dateStyle="full"/></td>
                        <th width="10%">要求完成时间</th>
                        <td><fmt:formatDate value="${dispatchMission.limitTime}" type="both" dateStyle="full"/></td>
                    </tr>
                    <tr>
                        <th width="10%">调货状态</th>
                        <td><span class="label label-primary">${fns:getDictLabel(dispatchMission.missionStatus, 'dispatch_mission_missionStatus', '')}</span></td>
                        <th width="10%">调入仓库</th>
                        <td><span class="label label-primary">${dispatchMission.inWarehouse.name}</span></td>
                    </tr>
                    <tr>
                        <th width="10%">备注</th>
                        <td><p class="text-muted well well-sm no-shadow">${dispatchMission.remarks}</p></td>
                    </tr>
                </table>
            </div>
        </section>
	    
	    <section class="invoice">
            <p class="lead">任务详情</p>
            <div class="table-responsive">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>调出仓库名称</th>
                            <th>调出仓库负责人</th>
                            <th>责任人电话</th>
                            <th>调货单状态</th>
                        </tr>
                    </thead>
                    <tbody id="contentTable">
                        <c:forEach items="${dispatchMission.dispatchOrderList }" var="order">
                             <tr>
                                 <td>${order.outWarehouse.name }</td>
                                 <td>${order.outWarehouse.responsibleUser.name }</td>
                                 <td>${order.outWarehouse.responsibleMobile }</td>
                                 <td>${fns:getDictLabel(order.orderStatus, 'dispatch_order_status', '')}</td>
                             </tr>
                             <tr>
                                 <th>产品编码</th>
                                 <th>产品名称</th>
                                 <th>实调数量</th>
                                 <th>备注</th>
                             </tr>
                             <c:if test="${not empty order.dispatchProduceList }">
                                 <c:forEach items="${order.dispatchProduceList }" var="disProduce">
                                     <tr>
                                         <td>${disProduce.produce.code }</td>
                                         <td>${disProduce.produce.name }</td>
                                         <td>${disProduce.actualNum }</td>
                                         <td>${disProduce.remarks }</td>
                                     </tr>
                                     <c:if test="${not empty disProduce.dispatchProductList}">
                                         <tr>
                                             <th>货品编码</th>
                                             <th>货品名称</th>
                                             <th>调出货位</th>
                                             <th>调入货位</th>
                                         </tr>
                                         <c:forEach items="${disProduce.dispatchProductList }" var="dispatchProduct">
                                             <tr>
                                                 <td>${dispatchProduct.product.code }</td>
                                                 <td>${dispatchProduct.product.goods.name }</td>
                                                 <td>${dispatchProduct.product.preWarehouseFullName }</td>
                                                 <td>${dispatchProduct.product.postWarehouseFullName }</td>
                                             </tr>
                                         </c:forEach>
                                     </c:if>
                                 </c:forEach>
                             </c:if>
                         </c:forEach>
                    </tbody>
                </table>
            </div>
            <div class="box-footer">
                <div class="pull-left box-tools">
                    <button type="button" class="btn btn-default" onclick="history.go(-1)">返回</button>
                </div>
            </div>
       </section>
	</div>
</body>
</html>