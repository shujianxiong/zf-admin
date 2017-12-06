<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>我的打包任务 - 发货单管理</title>
    <meta name="decorator" content="adminLte"/>
    <style type="text/css">
        tr{ 
            cursor: pointer;    /*手形*/   
        } 
    </style>
</head>
<body>
    <div class="content-wrapper sub-content-wrapper">
	    <section class="content-header content-header-menu">
	        <h1>
	            <small><i class="fa-list-style"></i><a href="${ctx}/bus/ol/pickOrder/myPackageList">打包任务列表</a></small>
	            <small>|</small>
	            <small class="menu-active">
	                <i class="fa fa-repeat"></i>
	                <a href="${ctx}/bus/ol/pickOrder/myPackageSendOrderList?id=${pickOrder.id}">发货单管理</a>
	            </small>
	        </h1>
	    </section>
	    <sys:tip content="${message}"/>
        
        <section class="invoice">
            <p class="lead">拣货单信息</p>
            <div class="table-responsive">
                <table class="table">
                    <tr>
                        <th width="10%">拣货单编号</th>
                        <td>${pickOrder.pickOrderNo}</td>
                        <th width="10%">托盘编码</th>
                        <td>${pickOrder.plateNo}</td>
                    </tr>
                    <tr>
                        <th width="10%">拣货人</th>
                        <td>${fns:getUserById(pickOrder.pickBy.id).name}</td>
                        <th width="10%">打包人</th>
                        <td>${fns:getUserById(pickOrder.packageBy.id).name }</td>
                    </tr>
                    <tr>
                        <th width="10%">拣货开始时间</th>
                        <td><fmt:formatDate value="${pickOrder.pickStartTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                        <th width="10%">拣货结束时间</th>
                        <td><fmt:formatDate value="${pickOrder.pickEndTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                    </tr>
                    <tr>
                        <th width="10%">打包开始时间</th>
                        <td><fmt:formatDate value="${pickOrder.packageStartTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                        <th width="10%">打包结束时间</th>
                        <td><fmt:formatDate value="${pickOrder.packageEndTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                    </tr>
                    <tr>   
                        <th width="10%">备注</th>
                        <td colspan="3"><p class="text-muted well well-sm no-shadow">${pickOrder.remarks }</p></td>
                    </tr>
                </table>
            </div>
        </section>
        
        <section class="invoice">
            <p class="lead">关联的出库单信息</p>
            <div class="table-responsive">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>出库单编号</th>
                            <th>关联订单类型</th>
                            <th>关联订单编号</th>
                            <th>生成时间</th>
                            <th>收货人姓名</th>
                            <th>收货人电话</th>
                            <th>收货人地址</th>
                            <th>状态</th>
                            <th>激活状态</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody id="contentTable">
                       <c:forEach items="${pickOrder.sendOrderList }" var="so">
                           <tr>
                               <td>
                                   ${so.sendOrderNo }
                               </td>
                               <td>
                                   <span class="label label-primary">${fns:getDictLabel(so.orderType, 'bus_order_type', '')}</span>
                               </td>
                               <td>
                                   ${so.orderNo }
                               </td>
                               <td>
                                   <fmt:formatDate value="${so.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                               </td>
                               <td>
                                   ${so.receiveName}
                               </td>
                               <td>
                                   ${so.receiveTel}
                               </td>
                               <td>
                                   ${so.receiveAreaStr}
                               </td>
                               <td>
                                   <span class="label label-primary">${fns:getDictLabel(so.status, 'bus_ol_send_order_status', '')}</span>
                               </td>
                               <td> 
                                   <span class="label label-primary">${fns:getDictLabel(so.activeFlag, 'yes_no', '')}</span>
                               </td>
                               <td id="td_${so.id }">
                                   <c:if test="${so.activeFlag eq '0' and  so.status ne '99' }">
	                                   <button type="button" class="btn btn-default btn-sm" onclick="updateActiveFlag('${so.id}')">激活</button>
                                   </c:if>
                                   <c:if test="${so.activeFlag eq '1'}">
                                       <c:if test="${so.status eq '1' or so.status eq '2' or so.status eq '3'}">
	                                   <button type="button" class="btn btn-default btn-sm" onclick="updateActiveFlag('${so.id}')">挂起</button>
                                       </c:if>
                                   </c:if>
                                   <c:if test="${so.activeFlag eq '0' }">
                                       <c:if test="${so.status eq '1' or so.status eq '2' or so.status eq '3' or so.status eq '4' or so.status eq '5'}">
                                           <button type="button" class="btn btn-default btn-sm" onclick="applyCancelBusinessOrder('${so.id}')">取消订单</button>
                                       </c:if>
	                               </c:if>
                               </td>
                           </tr>
                       </c:forEach>
                    </tbody>
                </table>
            </div>
            <div class="box-footer">
                <button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)">
                    <i class="fa fa-mail-reply"></i>返回
                </button>
            </div>
        </section>  
     </div>
     <script type="text/javascript">
     // 挂起或激活发货单
     function updateActiveFlag(sendOrderId) {
    	 confirm("您确认要变更该发货单的激活标记吗?", "info", function() {
             var url="${ctx}/bus/ol/pickOrder/updateActiveFlagById";
             ZF.ajaxQuery(false,url,$.parseJSON('{"id":"'+sendOrderId+'"}'),function(data){
                 if(data.status==1){
                     ZF.showTip(data.message, "info");
                     window.location.reload();
                     return false;
                 }else{
                	 ZF.showTip(data.message, "info");
                     return false;
                 }
             },function(){
            	 ZF.showTip("更新激活标记失败!", "info");
                 return false;
             });
         }, function() {
             
         });
     }
     
     // 申请取消体验单或购买单（待客服处理）
     function applyCancelBusinessOrder(sendOrderId){
    	 confirm("请确认是否取消该发货单对应的订单?客服审核通过后对应订单将变为关闭状态！", "info", function() {
             var url="${ctx}/bus/ol/pickOrder/applyCancelBusinessOrder";
             ZF.ajaxQuery(false,url,$.parseJSON('{"id":"'+sendOrderId+'"}'),function(data){
                 if(data.status==1){
                     ZF.showTip(data.message, "info");
                     window.location.reload();
                     return false;
                 }else{
                	 ZF.showTip(data.message, "info");
                     return false;
                 }
             },function(){
            	 ZF.showTip("更新激活标记失败!", "info");
                 return false;
             });
         }, function() {
             
         });
     }
     
     </script>
</body>
</html>