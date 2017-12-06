<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>采购任务详情</title>
	<meta name="decorator" content="adminLte"/>
</head>
<body >
<div class="conent-wrapper sub-content-wrapper">

    <section class="content-header content-header-menu">
            
    </section>
    
    <section class="invoice">
        <p class="lead">采购信息</p>
        <div class="table-responsive">
            <table class="table">
                <tr>
                    <th width="10%">任务编号</th>
                    <td>${purchaseMission.batchNo }</td>
                </tr>
                <tr>
                    <th width="10%">任务状态</th>
                    <td><span class="label label-primary">${fns:getDictLabel(purchaseMission.missionStatus, 'lgt_po_purchase_mission_missionStatus', '')}</span></td>
                </tr>
                <tr>
                    <th width="10%">备注</th>
                    <td colspan="3"><p class="text-muted well well-sm no-shadow">${purchaseMission.remarks }</p></td>
                </tr>
            </table>
        </div>
    </section>
	
	<section class="invoice">
       <p class="lead">采购产品明细</p>
       <div class="table-responsive">
           <table class="table table-striped">
               <thead>
                   <tr>
                   	   <th width="100px">样图</th>
                       <th width="150px">产品编号</th>
                       <th width="400px">商品名称</th>
                       <th width="280px">产品规格</th>
                       <th width="290px">采购数量</th>
                       <th>采购备注</th>
                   </tr>
               </thead>
               <tbody id="contentTable">
                   <c:forEach items="${purchaseMission.detailList }" var="detail">
	                   <tr>
	                       <td rowspan="1">
	                       	<img onerror="imgOnerror(this);" src="${imgHost }${detail.produce.goods.samplePhoto}" data-big data-src="${imgHost }${detail.produce.goods.samplePhoto}" width="20px" height="20px" />
	                       </td>
	                       <td rowspan="1">${detail.produce.code }</td>
	                       <td title="${detail.produce.goods.name }">${detail.produce.goods.name }</td>
	                       <td>${detail.produce.name }</td>
	                       <td>${detail.num }</td>
	                       <td rowspan="1" title="${detail.remarks}">${fns:abbr(detail.remarks,50)}</td>
	                   </tr>
                   </c:forEach>
               </tbody>
           </table>
       </div>
       
   </section>
   <section class="invoice">
       <p class="lead">采购订单列表</p>
       <div class="table-responsive">
           <table class="table table-striped">
               <thead>
                   <tr>
                       <th>订单编号</th>
                       <th>订单状态</th>
                       <th>供应商</th>
                       <th>采购员工</th>
                       <th>应付采购金额</th>
                       <th>实付采购金额</th>
                       <th>要求完成时间</th>
                       <th>实际完成时间</th>
                       <th>结算金价</th>
                   </tr>
               </thead>
               <tbody id="contentTable">
                   <c:forEach items="${purchaseMission.orderList }" var="order">
                       <tr>
                           <td>${order.orderNo }</td>
                           <td>
                              <c:choose>
                                   <c:when test="${order.orderStatus == 1 }">
                                       <span class="label label-default">${fns:getDictLabel(order.orderStatus,'lgt_po_purchase_order_orderStatus','')}</span>
                                   </c:when>
                                   <c:when test="${order.orderStatus == 2 }">
                                       <span class="label label-info">${fns:getDictLabel(order.orderStatus,'lgt_po_purchase_order_orderStatus','')}</span>
                                   </c:when>
                                   <c:when test="${order.orderStatus == 3 }">
                                       <span class="label label-primary">${fns:getDictLabel(order.orderStatus,'lgt_po_purchase_order_orderStatus','')}</span>
                                   </c:when>
                                   <c:when test="${order.orderStatus == 4 }">
                                       <span class="label label-success">${fns:getDictLabel(order.orderStatus,'lgt_po_purchase_order_orderStatus','')}</span>
                                   </c:when>
                                   <c:otherwise>
                                       <span class="label label-danger">已关闭</span>
                                   </c:otherwise>
                               </c:choose>
                           </td>
                           <td>${order.supplier.name }</td>
                           <td>${fns:getUserById(order.purchaseUser.id).name }</td>
                           <td><span class="text-red">${order.payableAmount }</span></td>
                           <td><span class="text-red">${order.paidAmount }</span></td>
                           <td><fmt:formatDate value="${order.requiredTime }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                           <td><fmt:formatDate value="${order.finishTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                           <td><span class="text-red">${order.clearingGoldprice }</span></td>
                       </tr>
                       <tr>
                           <th style="text-indent: 40px;">产品编号</th>
                           <th>商品名称</th>
                           <th>产品名称</th>
                           <th>要求采购数量</th>
                           <th>实际采购数量</th>
                           <th>实际采购价格</th>
                           <th>&nbsp;</th>
                           <th>&nbsp;</th>
                           <th>&nbsp;</th>
                       </tr>
                       <c:forEach items="${order.purchaseProduceList }" var="purchaseProduce">
                           <tr>
                               <td style="text-indent: 40px;">${purchaseProduce.produce.code }</td>
                               <td>${purchaseProduce.produce.goods.name }</td>
                               <td>${purchaseProduce.produce.name }</td>
                               <td>${purchaseProduce.requiredNum }</td>
                               <td>${purchaseProduce.realityNum }</td>
                               <td><span class="text-red">${purchaseProduce.realityPrice }</span></td>
                               <td>&nbsp;</td>
                               <td>&nbsp;</td>
                               <td>&nbsp;</td>
                           </tr>
                       </c:forEach>
                  </c:forEach>
               </tbody>
           </table>
       </div>    
       
       <div class="box-footer">
           <div class="pull-left box-tools">
               <button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
           </div>
       </div>
   </section>
</div>
	<script type="text/javascript">
	  $(function () {
		ZF.bigImg();
	  });
	</script>
</body>
</html>