<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>购买单管理</title>
    <meta name="decorator" content="adminLte"/>
    <style type="text/css">
        tr{ 
            cursor: pointer;    /*手形*/   
        } 
    </style>
</head>
<body>
<div class="content-wrapper sub-content-wrapper">
   <section class="content-header content-header-menu"></section>
    
    <section class="invoice">
        <div class="box box-primary">
            <div class="box-header with-border zf-query">
                <h5>购买单基本信息</h5>
                <div class="box-tools">
                    <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                </div>
            </div>
            <div class="box-body">
                <div class="table-responsive">
                    <table class="table">
                        <tr>
                            <th width="10%">订单编号</th>
                            <td>${buyOrder.orderNo}</td>
                            <th width="10%">会员账号</th>
                            <td>${fns:getMemberById(buyOrder.member.id).usercode}</td>
                        </tr>
                        <tr>
                            <th width="10%">订单类型</th>
                            <td><span class="label label-primary">${fns:getDictLabel(buyOrder.type,'bus_oe_buy_order_type','')}</span></td>
                            <th width="10%">支付状态</th>
                            <td><span class="label label-primary">${fns:getDictLabel(buyOrder.statusPay,'bus_order_statusPay','')}</span></td>
                        </tr>
                        <tr>
                            <th width="10%">系统订单状态</th>
                            <td><span class="label label-primary">${fns:getDictLabel(buyOrder.statusSystem,'bus_oe_buy_order_statusSystem','')}</span></td>
                            <th width="10%">会员订单状态</th>
                            <td><span class="label label-primary">${fns:getDictLabel(buyOrder.statusMember,'bus_oe_buy_order_statusMember','')}</span></td>
                        </tr>

                        <tr>
                            <th width="10%">预约到货状态</th>
                            <td><span class="label label-primary">${fns:getDictLabel(buyOrder.appointStockStatus,'bus_order_appointStockStatus','')}</span></td>
                            <th width="10%">预约定金</th>
                            <td><span class="text-red">${buyOrder.moneyAppoint}</span></td>
                        </tr>
                        <tr>
                            <th width="10%">预约服务费</th>
                            <td><span class="text-red">${buyOrder.moneyAppointService}</span></td>
                            <th width="10%">物流费</th>
                            <td><span class="text-red">${buyOrder.moneyLgt}</span></td>
                        </tr>
                        <tr>
                            <th width="10%">支付方式</th>
                            <td><span class="label label-primary">${fns:getDictLabel(buyOrder.payType,'bus_order_payType','')}</span></td>
                            <th width="10%">支付渠道</th>
                            <td><span class="label label-primary">${fns:getDictLabel(buyOrder.payChannel, 'bus_order_payChannel', '')}</span></td>
                        </tr>
                        <tr>
                            <th width="10%">魅力豆抵扣数量</th>
                            <td>${buyOrder.numBeansDeduct}</td>
                            <th width="10%">魅力豆抵扣金额</th>
                            <td><span class="text-red">${buyOrder.moneyBeansDeduct}</span></td>
                        </tr>
                        <tr>
                            <th width="10%">总金额</th>
                            <td><span class="text-red">${buyOrder.moneyTotal}</span></td>
                            <th width="10%">已支付金额</th>
                            <td><span class="text-red">${buyOrder.moneyPaid}</span></td>
                        </tr>
                        <tr>
                            <th width="10%">订单关闭类型</th>
                            <td><span class="label label-primary">${fns:getDictLabel(buyOrder.closeType,'operater_type','')}</span></td>
                            <th width="10%">订单关闭时间</th>
                            <td><fmt:formatDate value="${buyOrder.closeTime}" pattern="yyyy-MM-dd HH:mm:ss"/> </td>
                        </tr>
                        <tr>
                            <th width="10%">用户备注</th>
                            <td colspan="3">${buyOrder.memberRemarks}</td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
        <div class="box box-primary">
            <div class="box-header with-border zf-query">
                <h5>收货地址信息</h5>
                <div class="box-tools">
                    <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                </div>
            </div>
            <div class="box-body">
                <div class="table-responsive">
                    <table class="table table-bordered table-hover table-striped zf-tbody-font-size">
                        <thead>
                        <tr>
                            <th>姓名</th>
                            <th>联系电话</th>
                            <th>收货地址</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>
                                ${buyOrder.receiveName}
                            </td>
                            <td>
                                ${buyOrder.receiveTel}
                            </td>
                            <td>
                                ${buyOrder.receiveAreaStr}&nbsp;&nbsp;${buyOrder.receiveAreaDetail }
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="box box-primary">
            <div class="box-header with-border zf-query">
                <h5>商品信息</h5>
                <div class="box-tools">
                    <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                </div>
            </div>
            <div class="box-body">
                <div class="table-responsive">
                    <table class="table table-bordered table-hover table-striped zf-tbody-font-size">
                        <thead>
                        <tr>
                            <th>名称</th>
                            <th>产品编码</th>
                            <th>展示图</th>
                            <th>数量</th>
                            <th>购买原价</th>
                            <th>购买折扣</th>
                            <th>购买价</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${buyOrder.buyProduceList }" var="bp" >
                            <tr>
                                <td>${bp.goodsTitle }&nbsp;&nbsp;${bp.produceName }</td>
                                <td>${bp.produce.code}</td>
                                <td><img src="${imgHost }${bp.produce.goods.icon}" data-big data-src="${imgHost }${bp.produce.goods.icon}" width="20px;" height="20px;"/></td>
                                <td><span class="text-red">${bp.num }</span></td>
                                <td><span class="text-red">${bp.priceSrc }</span></td>
                                <td><span class="text-red">${bp.discountBuy }</span></td>
                                <td><span class="text-red">${bp.priceBuy }</span></td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div class="box-footer">
                    <div class="pull-right box-tools">
                        <p>总价：<span class="text-red">${buyOrder.moneyProduce}</span></p>
                    </div>
                </div>
            </div>
        </div>
        <div class="box box-primary">
            <div class="box-header with-border zf-query">
                <h5>售后信息</h5>
                <div class="box-tools">
                    <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                </div>
            </div>
            <div class="box-body">
                <div class="table-responsive">
                    <table class="table">
                        <tr>
                            <th style=" width: 119px;">是否开具发票</th>
                            <td><span class="label label-primary">${fns:getDictLabel(buyOrder.statusInvoice, 'yes_no', '' )}</span></td>
                        </tr>
                    </table>
                </div>
                <div class="box-footer">
                    <div class="pull-left box-tools">
                        <button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
                    </div>
                </div>
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