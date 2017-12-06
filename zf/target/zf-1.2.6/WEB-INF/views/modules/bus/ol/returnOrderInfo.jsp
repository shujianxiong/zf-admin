<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>退货单管理</title>
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
                    <th width="10%">退货单编号</th>
                    <td>${returnOrder.returnOrderNo }</td>
                    <th width="10%">退货原因类型</th>
                    <td width="40%"><span class="label label-primary">${fns:getDictLabel(returnOrder.reasonType, 'bus_ol_return_order_reasonType', '')}</span></td>
                </tr>
                <tr>
                    <th width="10%">退货原因详情</th>
                    <td colspan="3"><p class="text-muted well well-sm no-shadow">${returnOrder.reasonDetail}</p></td>
                </tr>
                <tr>
                    <th width="10%">下单日期</th>
                    <td><fmt:formatDate value="${returnOrder.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                    <th width="10%">退货状态</th>
                    <td width="40%"><span class="label label-primary">${fns:getDictLabel(returnOrder.status, 'bus_ol_return_order_status', '')}</span></td>
                </tr>
                <tr>
                    <th width="10%">物流快递公司</th>
                    <td><span class="label label-primary">${fns:getDictLabel(returnOrder.expressCompany, 'express_company', '')}</span></td>
                    <th width="10%">物流单号</th>
                    <td width="40%">${returnOrder.expressNo}</td>
                </tr>
            </table>
        </div>
    </section>
    <section class="invoice">
        <p class="lead">关联退货货品</p>
        <div class="table-responsive">
            <table class="table table-striped">
                <tr>
                    <th>货品编码</th>
                    <th>货品名称</th>
                    <th>损坏类型</th>
                    <th>扣减金额</th>
                    <th>损坏图片</th>
                    <th>责任人类型</th>
                    <th>入库状态</th>
                    <th>入库货位</th>
                </tr>
                <c:forEach items="${returnOrder.returnProductList}" var="returnProduct" varStatus="status">
                    <tr>
                        <td>${returnProduct.product.code }</td>
                        <td>${returnProduct.product.goods.name }</td>
                        <td><span class="label label-primary">${fns:getDictLabel(returnProduct.damageType, 'bus_or_repair_order_breakdownType', '')}</span></td>
                        <td>${returnProduct.decMoney}</td>
                        <td>
                            <c:forEach items="${returnProduct.imgs}" var="img" varStatus="status">
                                <img onerror="imgOnerror(this);" src="${imgHost }${img}" data-big data-src="${imgHost }${img}" width="20px" height="20px" />
                            </c:forEach>
                        </td>
                        <td><span class="label label-primary">${fns:getDictLabel(returnProduct.responsibilityType, 'bus_ol_return_product_responsibilityType', '')}</span></td>
                        <td><span class="label label-primary">${fns:getDictLabel(returnProduct.inStatus, 'bus_ol_return_product_inStatus', '')}</span></td>
                        <td>${returnProduct.inWareplace }</td>
                    </tr>
                </c:forEach>
            </table>
        </div>
        <div class="row no-print">
            <div class="col-xs-12">
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