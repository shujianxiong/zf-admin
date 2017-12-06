<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>采购订单详情</title>
	<meta name="decorator" content="adminLte"/>
</head>
<body >
<div class="conent-wrapper sub-content-wrapper">
   
   <section class="content-header content-header-menu">
            
   </section>
   
   <section class="invoice">
       <p class="lead">基本信息</p>
       <div class="table-responsive">
           <table class="table">
               <tr>
                   <th width="10%">任务编号</th>
                   <td>${purchaseOrder.purchaseMission.batchNo}</td>
                   <th width="10%">采购单编号</th>
                   <td>${purchaseOrder.orderNo}</td>
               </tr>
               <tr>
                   <th width="10%">供应商</th>
                   <td colspan="3">${purchaseOrder.supplier.name}</td>
               </tr>
               <tr>
                   <th width="10%">采购单状态</th>
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
                   <th width="10%">采购员工</th>
                   <td>${fns:getUserById(purchaseOrder.purchaseUser.id).name}</td>
               </tr>
               <tr>
                   <th width="10%">应付采购金额</th>
                   <td><span class="text-red">${purchaseOrder.payableAmount}</span></td>
                   <th width="10%">实付采购金额</th>
                   <td><span class="text-red">${purchaseOrder.paidAmount}</span></td>
               </tr>
               <tr>
                   <th width="10%">要求完成时间</th>
                   <td>
                       <fmt:formatDate var="requiredTimeVar" value="${purchaseOrder.requiredTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                       ${requiredTimeVar}
                   </td>
                   <th width="10%">实际完成时间</th>
                   <td>
                       <fmt:formatDate var="finishTimeVar" value="${purchaseOrder.finishTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                       ${finishTimeVar}
                   </td>
               </tr>
               <tr>
                   <th width="10%">结算金价</th>
                   <td><span class="text-red">${purchaseOrder.clearingGoldprice}</span></td>
                   <th width="10%">任务审批人</th>
                   <td>${fns:getUserById(purchaseOrder.purchaseMission.checkBy.id).name}</td>
               </tr>
               <tr>
                   <th width="10%">任务审批结果</th>
                   <td colspan="3"><p class="text-muted well well-sm no-shadow">${purchaseOrder.purchaseMission.checkRemarks}</p></td>
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
                       <th colspan="3">产品样图</th>
                       <th>产品编号</th>
                       <th>产品名称</th>
                       <th>产品规格</th>
                       <th>需采量</th>
                       <th>合格数</th>
                       <th>备注</th>
                   </tr>
               </thead>
               <tbody id="contentTable">
	               <c:forEach items="${purchaseOrder.purchaseProduceList }" var="ppe" varStatus="ppeStatus">
                      <tr id="${ppe.id }" data-index="${ppeStatus.index }" data-pcode="${ppe.produce.code }">
                          <td colspan="3"><img src="${imgHost }${ppe.produce.goods.samplePhoto}" data-big data-src="${imgHost }${ppe.produce.goods.samplePhoto}" width="20px;" height="20px;"/></td>
                          <td>
                              <input type="hidden" name="purchaseProduceList[${ppeStatus.index }].id" value="${ppe.id }"/>
                              ${ppe.produce.code }
                          </td>
                          <td>${ppe.produce.goods.name }</td>
                          <td>${ppe.produce.name }</td>
                          <td>${ppe.requiredNum }</td>
                          <td>${ppe.inNum }</td>
                          <td>${ppe.remarks }</td>
                      </tr>
                      <tr>
                         <th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
                         <th>货品保存批次号</th>
                         <th>货品克重</th>
                          <th>货品编码</th>
                         <th>货品采购价</th>
                         <th>货品证书编号</th>
                         <th>货品电子码</th>
                         <th>货品存放货位</th>
                         <th>货品是否合格</th>
                         <th>货品备注</th>
                      </tr>
                      <c:forEach items="${ppe.purchaseProductList }" var="ppt" varStatus="pptStatus">
                      <tr>
                          <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                          <td>${ppt.inBatchNo }</td>
                          <td>
                               ${ppt.weight }
                          </td>
                          <td>
                                  ${ppt.product.code }
                          </td>
                          <td>
                               ${ppt.pricePurchase }
                          </td>
                          <td>
                               ${ppt.certificateNo }
                          </td>
                          <td>
                               ${ppt.scanCode }                                    
                          </td>
                          <td>
                              ${ppt.wareplace.warecounter.warearea.warehouse.code }-${ppt.wareplace.warecounter.warearea.code }-${ppt.wareplace.warecounter.code }-${ppt.wareplace.code }
                          </td>
                          <td> 
                               <span class="label label-primary">${fns:getDictLabel(ppt.regularFlag, 'yes_no', '')  }</span>
                          </td>
                          <td> 
                               ${ppt.remarks }
                          </td>
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
   <script type="text/javascript">
    $(function() {
    	ZF.bigImg();
    });
   </script>
</div>
</body>
</html>