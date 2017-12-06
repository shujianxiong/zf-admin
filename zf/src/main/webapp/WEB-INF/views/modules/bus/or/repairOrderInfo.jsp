<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>货品维修单管理</title>
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
    
    <form:form id="inputForm" modelAttribute="repairOrder" action="${ctx}/bus/or/repairOrder/info" method="post" class="form-horizontal">
        <section class="content">
            <div class="row">
                <div class="col-md-6">
                    <div class="box box-primary">
                        <div class="box-header with-border">
                            <h5>货品维修单信息</h5>
                            <div class="box-tools">
                                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                                </button>
                            </div>
                        </div>
                        <!-- /.box-header -->
                        <div class="box-body">
                            
                            <strong>货品ID</strong>
                            <p class="text-primary">
                                ${repairOrder.product.id}
                            </p>
                            <hr class="zf-hr">
                            <strong>维修单状态</strong>
                            <p class="text-primary">
                                ${repairOrder.status}
                            </p>
                            <hr class="zf-hr">
                            <strong>申请人</strong>
                            <p class="text-primary">
                                ${repairOrder.applyBy.id}
                            </p>
                            <hr class="zf-hr">
                            <strong>申请时间</strong>
                            <p class="text-primary">
                                <fmt:formatDate value="${repairOrder.applyTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                            </p>
                            <hr class="zf-hr">
                            <strong>问题类型（破损/刮花）</strong>
                            <p class="text-primary">
                                ${repairOrder.breakdownType}
                            </p>
                            <hr class="zf-hr">
                            <strong>损耗估算</strong>
                            <p class="text-primary">
                                ${repairOrder.moneyLoss}
                            </p>
                            <hr class="zf-hr">
                            <strong>申请处理类型（返厂/维修）</strong>
                            <p class="text-primary">
                                ${repairOrder.applyType}
                            </p>
                            <hr class="zf-hr">
                            <strong>处理人</strong>
                            <p class="text-primary">
                                ${repairOrder.dealBy.id}
                            </p>
                            <hr class="zf-hr">
                            <strong>处理类型（返厂/维修）</strong>
                            <p class="text-primary">
                                ${repairOrder.dealType}
                            </p>
                            <hr class="zf-hr">
                            <strong>更新时间</strong>
                            <p class="text-primary">
                                <fmt:formatDate value="${repairOrder.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                            </p>
                            <hr class="zf-hr">
                            <strong>备注信息</strong>
                            <p class="text-primary">
                                ${repairOrder.remarks}
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