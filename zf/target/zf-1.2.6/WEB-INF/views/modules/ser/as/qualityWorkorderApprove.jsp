<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>质检工单列表管理</title>
    <meta name="decorator" content="adminLte"/>
    <style type="text/css">
        tr{ 
            cursor: pointer;    /*手形*/   
        } 
    </style>
</head>
<body>
<div class="content-wrapper sub-content-wrapper">
    <section class="content-header">
        <h1>
            <small><i class="fa-list-style"></i><a href="${ctx}/ser/as/qualityWorkorder/list">质检工单列表</a></small>
            <small>|</small>
            <shiro:hasPermission name="ser:as:qualityWorkorder:approve"><small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/ser/as/qualityWorkorder/toApprove?id=${qualityWorkorder.id}">质检工单审核</a></small></shiro:hasPermission>
        </h1>
    </section>
    <sys:tip content="${message}"/>
    <section class="invoice">
        <p class="lead">质检工单信息</p>
        <div class="table-responsive">
            <table class="table">
                <tr>
                    <th width="10%">工单编号</th>
                    <td colspan="3">   ${qualityWorkorder.workorderNo}</td>
                </tr>
                <tr>
                    <th width="10%">工单类型</th>
                    <td>
                        <span class="label label-primary">${fns:getDictLabel(qualityWorkorder.workorderType, 'ser_as_workorder_workorderType', '')}</span>
                    </td>
                    <th width="10%">工单状态</th>
                    <td>
                        <span class="label label-primary">${fns:getDictLabel(qualityWorkorder.status, 'ser_as_qualityWorkorder_status', '')}</span>
                    </td>
                </tr>
                <tr>
                    <th width="10%">会员账号</th>
                    <td>${qualityWorkorder.usercode}</td>
                </tr>
                <tr>
                    <th width="10%">订单类型</th>
                    <td><span class="label label-primary">${fns:getDictLabel(qualityWorkorder.orderType, 'bus_order_type', '')}</span></td>
                    <th width="10%">订单编号</th>
                    <td>
                        ${qualityWorkorder.orderNo}
                    </td>
                </tr>
                <tr>
                    <th width="10%">被指派人</th>
                    <td><span class="label label-primary">${fns:getUserById("qualityWorkorder.appointedUser")}</span></td>
                </tr>
                <tr>
                    <th width="10%">处理时间</th>
                    <td><fmt:formatDate value="${qualityWorkorder.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                    <th width="10%">描述</th>
                    <td>
                        ${serviceApply.description}
                    </td>
                </tr>
            </table>
        </div>
    </section>
    <section class="invoice">
        <div class="box box-success">
            <div class="box-header with-border zf-query">
                <h5>工单关联货品设置列表</h5>
            </div>
            <div class="box-body">
                <div class="table-responsive">
                    <table class="table table-bordered table-hover table-striped zf-tbody-font-size">
                        <thead>
                        <tr>
                            <th>货品编码</th>
                            <th>货品图片</th>
                            <th>货品名称</th>
                            <th>损坏类型</th>
                            <th>损坏金额</th>
                            <th>责任人类型</th>
                        </tr>
                        </thead>
                        <tbody id="tBody">
                        <c:forEach items="${qualityWorkorder.qualityWorkordProductList}" var="workProduct" varStatus="status">
                            <tr>
                                <td>
                                        ${workProduct.product.code }
                                </td>
                                <td>
                                    <img onerror="imgOnerror(this);"  src="${imgHost }${workProduct.product.goods.samplePhoto}" data-big data-src="${imgHost }${workProduct.product.goods.samplePhoto}" width="21" height="21" />
                                </td>
                                <td>
                                        ${workProduct.product.goods.name}
                                </td>
                                <td>
                                    <span class="label label-primary">${fns:getDictLabel(workProduct.damageType, 'bus_or_repair_order_breakdownType', '')}</span>
                                </td>
                                <td>
                                        ${workProduct.decMoney}
                                </td>
                                <td>
                                    <span class="label label-primary">${fns:getDictLabel(workProduct.responsibilityType, 'bus_ol_return_product_responsibilityType', '')}</span>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </section>
    <section class="invoice">
        <div class="box-footer">
            <div class="pull-left box-tools">
                <button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
            </div>
            <div class="pull-right box-tools">
                <shiro:hasPermission name="ser:as:qualityWorkorder:approve"><button type="button" class="btn btn-info btn-sm" onclick="window.location.href='${ctx}/ser/as/qualityWorkorder/refuse?id=${qualityWorkorder.id}'"><i class="fa fa-save"></i>拒绝</button></shiro:hasPermission>
            </div>
            <div class="pull-right box-tools">
                <shiro:hasPermission name="ser:as:qualityWorkorder:approve"><button type="button" class="btn btn-info btn-sm" onclick="window.location.href='${ctx}/ser/as/qualityWorkorder/approve?id=${qualityWorkorder.id}'"><i class="fa fa-save"></i>通过</button>&nbsp;&nbsp;&nbsp;&nbsp;</shiro:hasPermission>
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