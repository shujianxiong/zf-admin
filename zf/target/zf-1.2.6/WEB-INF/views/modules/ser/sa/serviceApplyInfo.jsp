<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>服务申请管理</title>
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
        <p class="lead">服务申请信息</p>
        <div class="table-responsive">
            <table class="table">
                <tr>
                    <th width="10%">服务单编号</th>
                    <td colspan="3">  ${serviceApply.no}</td>
                </tr>
                <tr>
                    <th width="10%">来源订单类型</th>
                    <td>
                        <span class="label label-primary">${fns:getDictLabel(serviceApply.orderType, 'bus_order_type', '')}</span>
                    </td>
                    <th width="10%">来源订单编号</th>
                    <td>
                        ${serviceApply.orderNo}
                    </td>
                </tr>
                <tr>
                    <th width="10%">来源订单产品ID</th>
                    <td>${serviceApply.orderProduceId}</td>
                    <th width="10%">数量</th>
                    <td>
                        ${serviceApply.orderProduceNum}
                    </td>
                </tr>
                <tr>
                    <th width="10%">状态</th>
                    <td colspan="3">
                        <span class="label label-primary">${fns:getDictLabel(serviceApply.status, 'ser_sa_service_apply_status', '')}</span>
                    </td>
                </tr>
                <tr>
                    <th width="10%">申请时机类型</th>
                    <td><span class="label label-primary">${fns:getDictLabel(serviceApply.applyTimeType, 'ser_sa_service_apply_applyTimeType', '')}</span></td>
                    <th width="10%">申请处理类型</th>
                    <td>
                        <span class="label label-primary">${fns:getDictLabel(serviceApply.applyDealType, 'ser_sa_service_apply_applyDealType', '')}</span>
                    </td>
                </tr>
                <tr>
                    <th width="10%">申请原因类型</th>
                    <td><span class="label label-primary">${fns:getDictLabel(serviceApply.applyReasonType, 'ser_sa_service_apply_applyReasonType', '')}</span></td>
                    <th width="10%">处理人</th>
                    <td>
                        ${fns:getUserById(serviceApply.dealBy.id).name}
                    </td>
                </tr>
                <tr>
                    <th width="10%">处理时间</th>
                    <td><fmt:formatDate value="${serviceApply.dealTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                    <th width="10%">处理备注</th>
                    <td>
                        ${serviceApply.dealRemarks}
                    </td>
                </tr>
                <tr>
                    <th width="10%">更新时间</th>
                    <td colspan="3">
                        <fmt:formatDate value="${serviceApply.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                    </td>
                </tr>
                <tr>
                    <th width="10%">备注</th>
                    <td colspan="3"><p class="text-muted well well-sm no-shadow">${serviceApply.remarks}</p></td>
                </tr>
            </table>
        </div>
    </section>

    <section class="content">
        <div class="box box-soild">
            <div class="box-body">
                <div class="table-responsive">
                    <table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
                        <thead>
                        <tr>
                            <th>产品编号</th>
                            <th>产品名称</th>
                            <th>产品图片</th>
                        </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>
                                        ${produce.code}
                                </td>
                                <td>
                                        ${produce.name}
                                </td>
                                <td>
                                    <img onerror="imgOnerror(this);" src="${imgHost }${produce.goods.samplePhoto}" data-big data-src="${imgHost }${produce.goods.samplePhoto}" width="20px" height="20px" />
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
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
<script>
    $(function () {
        ZF.bigImg();
    });

</script>
</body>

</html>