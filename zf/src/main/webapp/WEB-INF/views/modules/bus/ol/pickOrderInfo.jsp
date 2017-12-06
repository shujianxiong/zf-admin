<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>打包任务详情</title>
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
                
        </section>
        
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
            <p class="lead">关联的发货单信息</p>
            <div class="table-responsive">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>发货单编号</th>
                            <th>关联订单类型</th>
                            <th>关联订单编号</th>
                            <th>生成时间</th>
                            <th>收货人姓名</th>
                            <th>收货人电话</th>
                            <th>收货人地址</th>
                            <th>状态</th>
                            <th>激活状态</th>
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
                           </tr>
                       </c:forEach>
                    </tbody>
                </table>
            </div>
            <div class="box-footer">
                <button type="button" class="btn btn-default btn-sm"
                    onclick="javascript:history.go(-1)">
                    <i class="fa fa-mail-reply"></i>返回
                </button>
            </div>
        </section>  
     </div>
     <script type="text/javascript"></script>
</body>
</html>