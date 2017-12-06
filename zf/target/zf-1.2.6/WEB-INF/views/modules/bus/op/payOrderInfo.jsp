<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>付款单管理</title>
    <meta name="decorator" content="adminLte"/>
    <style type="text/css">
        tr{ 
            cursor: pointer;    /*手形*/   
        } 
    </style>
</head>
<body>
<div class="content-wrapper sub-content-wrapper">
    <sys:tip content="${message}"/>
    
    <form:form id="inputForm" modelAttribute="payOrder" action="${ctx}/bus/op/payOrder/info" method="post" class="form-horizontal">
        <section class="content">
            <div class="row">
                <div class="col-md-6">
                    <div class="box box-primary">
                        <div class="box-header with-border">
                            <h5>付款单信息</h5>
                            <div class="box-tools">
                                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                                </button>
                            </div>
                        </div>
                        <!-- /.box-header -->
                        <div class="box-body">
                            
                            <strong>付款单编号</strong>
                            <p class="text-primary">
                                ${payOrder.no}
                            </p>
                            <hr class="zf-hr">
                            <strong>来源订单类型（体验/预约..）</strong>
                            <p class="text-primary">
                                ${payOrder.orderType}
                            </p>
                            <hr class="zf-hr">
                            <strong>来源订单ID</strong>
                            <p class="text-primary">
                                ${payOrder.orderId}
                            </p>
                            <hr class="zf-hr">
                            <strong>来源订单编号</strong>
                            <p class="text-primary">
                                ${payOrder.orderNo}
                            </p>
                            <hr class="zf-hr">
                            <strong>支付金额类型</strong>
                            <p class="text-primary">
                                ${payOrder.moneyType}
                            </p>
                            <hr class="zf-hr">
                            <strong>支付金额</strong>
                            <p class="text-primary">
                                ${payOrder.money}
                            </p>
                            <hr class="zf-hr">
                            <strong>支付状态</strong>
                            <p class="text-primary">
                                ${payOrder.status}
                            </p>
                            <hr class="zf-hr">
                            <strong>支付返回结果</strong>
                            <p class="text-primary">
                                ${payOrder.returnResult}
                            </p>
                            <hr class="zf-hr">
                            <strong>可退款标记</strong>
                            <p class="text-primary">
                                ${payOrder.refundFlag}
                            </p>
                            <hr class="zf-hr">
                            <strong>自动退款状态</strong>
                            <p class="text-primary">
                                ${payOrder.refundAutoStatus}
                            </p>
                            <hr class="zf-hr">
                            <strong>人工退款状态</strong>
                            <p class="text-primary">
                                ${payOrder.refundArtificialStatus}
                            </p>
                            <hr class="zf-hr">
                            <strong>更新时间</strong>
                            <p class="text-primary">
                                <fmt:formatDate value="${payOrder.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                            </p>
                            <hr class="zf-hr">
                            <strong>备注信息</strong>
                            <p class="text-primary">
                                ${payOrder.remarks}
                            </p>
                            <hr class="zf-hr">
                        </div>
                        
                        <div class="box-footer">
                            <button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)">
                                <i class="fa fa-mail-reply"></i>返回
                            </button>
                        </div>
                    </div>
               </div>
            </div>
         </section>
    </form:form>
</div>
</body>
</html>