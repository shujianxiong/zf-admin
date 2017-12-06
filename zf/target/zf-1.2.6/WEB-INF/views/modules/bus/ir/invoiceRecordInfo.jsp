<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>发票开票记录管理</title>
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
    
    <form:form id="inputForm" modelAttribute="invoiceRecord" action="${ctx}/bus/ir/invoiceRecord/info" method="post" class="form-horizontal">
        <section class="content">
            <div class="row">
                <div class="col-md-6">
                    <div class="box box-primary">
                        <div class="box-header with-border">
                            <h5>发票开票记录信息</h5>
                            <div class="box-tools">
                                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                                </button>
                            </div>
                        </div>
                        <!-- /.box-header -->
                        <div class="box-body">
                            
                            <strong>购买订单ID</strong>
                            <p class="text-primary">
                                ${invoiceRecord.buyOrder.id}
                            </p>
                            <hr class="zf-hr">
                            <strong>开票金额</strong>
                            <p class="text-primary">
                                ${invoiceRecord.money}
                            </p>
                            <hr class="zf-hr">
                            <strong>状态</strong>
                            <p class="text-primary">
                                ${invoiceRecord.status}
                            </p>
                            <hr class="zf-hr">
                            <strong>发票类型</strong>
                            <p class="text-primary">
                                ${invoiceRecord.type}
                            </p>
                            <hr class="zf-hr">
                            <strong>发票抬头类型</strong>
                            <p class="text-primary">
                                ${invoiceRecord.titleType}
                            </p>
                            <hr class="zf-hr">
                            <strong>发票抬头</strong>
                            <p class="text-primary">
                                ${invoiceRecord.title}
                            </p>
                            <hr class="zf-hr">
                            <strong>发票税号</strong>
                            <p class="text-primary">
                                ${invoiceRecord.taxNo}
                            </p>
                            <hr class="zf-hr">
                            <strong>发票内容</strong>
                            <p class="text-primary">
                                ${invoiceRecord.contentType}
                            </p>
                            <hr class="zf-hr">
                            <strong>收货人</strong>
                            <p class="text-primary">
                                ${invoiceRecord.receiveName}
                            </p>
                            <hr class="zf-hr">
                            <strong>收货电话</strong>
                            <p class="text-primary">
                                ${invoiceRecord.receiveTel}
                            </p>
                            <hr class="zf-hr">
                            <strong>收货地址省市区</strong>
                            <p class="text-primary">
                                ${invoiceRecord.receiveAreaStr}
                            </p>
                            <hr class="zf-hr">
                            <strong>收货地址详情</strong>
                            <p class="text-primary">
                                ${invoiceRecord.receiveAreaDetail}
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