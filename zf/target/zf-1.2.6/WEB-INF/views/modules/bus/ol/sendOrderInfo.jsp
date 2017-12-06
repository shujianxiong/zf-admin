<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>发货单详情</title>
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
            <p class="lead">基本信息</p>
            <div class="table-responsive">
                <table class="table">
                    <tr>
                        <th width="10%">发货单编号</th>
                        <td >${sendOrder.sendOrderNo}</td>
                        <th width="10%">发货单类型</th>
                        <td><span class="label label-primary">${fns:getDictLabel(sendOrder.type, 'send_order_type', '')}</span></td>
                    </tr>
                    <tr>
                        <th width="10%">发货状态</th>
                        <td width="40%"><span class="label label-primary">${fns:getDictLabel(sendOrder.status, 'bus_ol_send_order_status', '')}</span></td>
                        <th width="10%">发货时间</th>
                        <td><fmt:formatDate value="${sendOrder.expressTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                    </tr>
                    <tr>
                        <th width="10%">来源订单类型</th>
                        <td><span class="label label-primary">${fns:getDictLabel(sendOrder.orderType, 'bus_order_type', '')}</span></td>
                        <th width="10%">来源订单编号</th>
                        <td>${sendOrder.orderNo}</td>
                    </tr>
                    <tr>
                        <th width="10%">收货人</th>
                        <td>${sendOrder.receiveName}</td>
                        <th width="10%">收货电话</th>
                        <td width="40%">${sendOrder.receiveTel}</td>
                    </tr>
                    <tr>
                        <th width="10%">收货地址省市区</th>
                        <td>${sendOrder.receiveAreaStr}</td>
                        <th width="10%">收货地址详情</th>
                        <td width="40%">${sendOrder.receiveAreaDetail}</td>
                    </tr>
                    <tr>
                        <th width="10%">用户备注</th>
                        <td colspan="3"><p class="text-muted well well-sm no-shadow">${sendOrder.memberRemarks}</p></td>
                    </tr>
                    <tr>
                        <th width="10%">快递公司</th>
                        <td><span class="label label-primary">${fns:getDictLabel(sendOrder.expressCompany, 'express_company', '')}</span></td>
                        <th width="10%">快递单号</th>
                        <td>${sendOrder.expressNo}</td>
                    </tr>
                    <tr>
                        <th width="10%">备注</th>
                        <td colspan="3"><p class="text-muted well well-sm no-shadow">${sendOrder.remarks}</p></td>
                    </tr>
                </table>
            </div>
        </section>
        <section class="invoice">
            <p class="lead">关联发货产品</p>
            <div class="table-responsive">
                <table class="table table-striped">
                     <tr>
                         <th>照片</th>
                         <th>商品名称</th>
                         <th>产品编码</th>
                         <th>规格</th>
                         <th>货品编码</th>
                         <th>数量</th>
                     </tr>
                     <c:forEach items="${sendOrder.sendProduceList}" var="sp" varStatus="status">
                         <tr data-index="${status.index }">
                             <td>
                                 <img  onerror="imgOnerror(this);" data-big data-src="${imgHost }${sp.produce.goods.icon}"  src="${imgHost }${sp.produce.goods.icon}" width="100px;" height="100px;"/>
                             </td>
                             <td>
                                 ${sp.produce.goods.name}
                             </td>
                             <td>
                                 ${sp.produce.code }
                             </td>
                             <td>
                                 ${sp.produce.name }
                             </td>
                             <td>
                                <c:forEach items="${sp.productList }" var="t">
                                     ${t.code }<br/>
                                </c:forEach>
                             </td>
                             <td>
                                 ${sp.num }
                             </td>
                         </tr>
                     </c:forEach>
                </table>
            </div>
        </section>
    
        <section class="invoice">
            <div class="row no-print">
                <div class="col-xs-12">
                    <button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
                </div>
            </div>
        </section>
        
     </div>
    <script type="text/javascript">
    $(function() {
    	ZF.bigImg();
    });
    </script>
</body>
</html>