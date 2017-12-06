<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>体验产品管理</title>
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
    
    <form:form id="inputForm" modelAttribute="experienceProduce" action="${ctx}/bus/oe/experienceProduce/info" method="post" class="form-horizontal">
        <section class="content">
            <div class="row">
                <div class="col-md-6">
                    <div class="box box-primary">
                        <div class="box-header with-border">
                            <h5>体验产品信息</h5>
                            <div class="box-tools">
                                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                                </button>
                            </div>
                        </div>
                        <!-- /.box-header -->
                        <div class="box-body">
                            
                            <strong>体验单ID</strong>
                            <p class="text-primary">
                                ${experienceProduce.experienceProduce.id}
                            </p>
                            <hr class="zf-hr">
                            <strong>产品ID</strong>
                            <p class="text-primary">
                                ${experienceProduce.produce.id}
                            </p>
                            <hr class="zf-hr">
                            <strong>数量</strong>
                            <p class="text-primary">
                                ${experienceProduce.num}
                            </p>
                            <hr class="zf-hr">
                            <strong>商品标题</strong>
                            <p class="text-primary">
                                ${experienceProduce.goodsTitle}
                            </p>
                            <hr class="zf-hr">
                            <strong>产品名称</strong>
                            <p class="text-primary">
                                ${experienceProduce.produceName}
                            </p>
                            <hr class="zf-hr">
                            <strong>购买价格</strong>
                            <p class="text-primary">
                                ${experienceProduce.priceBuy}
                            </p>
                            <hr class="zf-hr">
                            <strong>体验状态</strong>
                            <p class="text-primary">
                                ${experienceProduce.status}
                            </p>
                            <hr class="zf-hr">
                            <strong>消费决策（退/买/换购/预购）</strong>
                            <p class="text-primary">
                                ${experienceProduce.decisionType}
                            </p>
                            <hr class="zf-hr">
                            <strong>消费购买单ID</strong>
                            <p class="text-primary">
                                ${experienceProduce.decisionBuyOrder.id}
                            </p>
                            <hr class="zf-hr">
                            <strong>结算扣减金额</strong>
                            <p class="text-primary">
                                ${experienceProduce.moneySettlementDec}
                            </p>
                            <hr class="zf-hr">
                            <strong>结算优惠金额</strong>
                            <p class="text-primary">
                                ${experienceProduce.moneySettlementPre}
                            </p>
                            <hr class="zf-hr">
                            <strong>更新时间</strong>
                            <p class="text-primary">
                                <fmt:formatDate value="${experienceProduce.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                            </p>
                            <hr class="zf-hr">
                            <strong>备注信息</strong>
                            <p class="text-primary">
                                ${experienceProduce.remarks}
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