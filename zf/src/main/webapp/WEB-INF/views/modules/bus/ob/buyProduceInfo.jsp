<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>购买产品管理</title>
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
    
    <form:form id="inputForm" modelAttribute="buyProduce" action="${ctx}/bus/ob/buyProduce/info" method="post" class="form-horizontal">
        <section class="content">
            <div class="row">
                <div class="col-md-6">
                    <div class="box box-primary">
                        <div class="box-header with-border">
                            <h5>购买产品信息</h5>
                            <div class="box-tools">
                                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                                </button>
                            </div>
                        </div>
                        <!-- /.box-header -->
                        <div class="box-body">
                            
                            <strong>购买单ID</strong>
                            <p class="text-primary">
                                ${buyProduce.buyOrder.id}
                            </p>
                            <hr class="zf-hr">
                            <strong>体验产品ID</strong>
                            <p class="text-primary">
                                ${buyProduce.experienceProduce.id}
                            </p>
                            <hr class="zf-hr">
                            <strong>产品ID</strong>
                            <p class="text-primary">
                                ${buyProduce.produce.id}
                            </p>
                            <hr class="zf-hr">
                            <strong>数量</strong>
                            <p class="text-primary">
                                ${buyProduce.num}
                            </p>
                            <hr class="zf-hr">
                            <strong>商品标题</strong>
                            <p class="text-primary">
                                ${buyProduce.goodsDisplayTitle}
                            </p>
                            <hr class="zf-hr">
                            <strong>产品名称</strong>
                            <p class="text-primary">
                                ${buyProduce.produceName}
                            </p>
                            <hr class="zf-hr">
                            <strong>购买价格</strong>
                            <p class="text-primary">
                                ${buyProduce.priceBuy}
                            </p>
                            <hr class="zf-hr">
                            <strong>购买折扣</strong>
                            <p class="text-primary">
                                ${buyProduce.discountBuy}
                            </p>
                            <hr class="zf-hr">
                            <strong>实际购买价</strong>
                            <p class="text-primary">
                                ${buyProduce.priceBuyFact}
                            </p>
                            <hr class="zf-hr">
                            <strong>更新时间</strong>
                            <p class="text-primary">
                                <fmt:formatDate value="${buyProduce.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                            </p>
                            <hr class="zf-hr">
                            <strong>备注信息</strong>
                            <p class="text-primary">
                                ${buyProduce.remarks}
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