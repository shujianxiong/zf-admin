<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>微信预支付记录管理</title>
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
    
    <form:form id="inputForm" modelAttribute="wechatPrepayRecord" action="${ctx}/bus/wp/wechatPrepayRecord/info" method="post" class="form-horizontal">
        <section class="content">
            <div class="row">
                <div class="col-md-6">
                    <div class="box box-primary">
                        <div class="box-header with-border">
                            <h5>微信预支付记录信息</h5>
                            <div class="box-tools">
                                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                                </button>
                            </div>
                        </div>
                        <!-- /.box-header -->
                        <div class="box-body">
                            
                            <strong>支付订单类型（体验/预约..）</strong>
                            <p class="text-primary">
                                ${wechatPrepayRecord.orderType}
                            </p>
                            <hr class="zf-hr">
                            <strong>支付订单ID</strong>
                            <p class="text-primary">
                                ${wechatPrepayRecord.orderId}
                            </p>
                            <hr class="zf-hr">
                            <strong>支付订单编号</strong>
                            <p class="text-primary">
                                ${wechatPrepayRecord.orderNo}
                            </p>
                            <hr class="zf-hr">
                            <strong>预支付编号</strong>
                            <p class="text-primary">
                                ${wechatPrepayRecord.prepayNo}
                            </p>
                            <hr class="zf-hr">
                            <strong>更新时间</strong>
                            <p class="text-primary">
                                <fmt:formatDate value="${wechatPrepayRecord.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                            </p>
                            <hr class="zf-hr">
                            <strong>备注信息</strong>
                            <p class="text-primary">
                                ${wechatPrepayRecord.remarks}
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