<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>微信充值单管理</title>
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
    
    <form:form id="inputForm" modelAttribute="rechargeOrder" action="${ctx}/crm/bb/rechargeOrder/info" method="post" class="form-horizontal">
        <section class="content">
            <div class="row">
                <div class="col-md-6">
                    <div class="box box-primary">
                        <div class="box-header with-border">
                            <h5>微信充值单信息</h5>
                            <div class="box-tools">
                                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                                </button>
                            </div>
                        </div>
                        <!-- /.box-header -->
                        <div class="box-body">
                            
                            <strong>充值单编号</strong>
                            <p class="text-primary">
                                ${rechargeOrder.no}
                            </p>
                            <hr class="zf-hr">
                            <strong>充值会员ID</strong>
                            <p class="text-primary">
                                ${rechargeOrder.member.id}
                            </p>
                            <hr class="zf-hr">
                            <strong>状态（待充值/已充值）</strong>
                            <p class="text-primary">
                                ${rechargeOrder.status}
                            </p>
                            <hr class="zf-hr">
                            <strong>充值时间</strong>
                            <p class="text-primary">
                                <fmt:formatDate value="${rechargeOrder.rechargeTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                            </p>
                            <hr class="zf-hr">
                            <strong>充值流水号</strong>
                            <p class="text-primary">
                                ${rechargeOrder.serialNo}
                            </p>
                            <hr class="zf-hr">
                            <strong>到账时间</strong>
                            <p class="text-primary">
                                <fmt:formatDate value="${rechargeOrder.receiveTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                            </p>
                            <hr class="zf-hr">
                            <strong>更新者</strong>
                            <p class="text-primary">
                                ${rechargeOrder.updateBy.id}
                            </p>
                            <hr class="zf-hr">
                            <strong>更新时间</strong>
                            <p class="text-primary">
                                <fmt:formatDate value="${rechargeOrder.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                            </p>
                            <hr class="zf-hr">
                            <strong>备注信息</strong>
                            <p class="text-primary">
                                ${rechargeOrder.remarks}
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