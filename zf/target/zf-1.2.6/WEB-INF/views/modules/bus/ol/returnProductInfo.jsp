<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>退货货品管理</title>
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
        <p class="lead">基本信息</p>
        <div class="table-responsive">
            <table class="table">
                <tr>
                    <th width="10%">货品编码</th>
                    <td>
                        ${returnProduct.product.code}
                    </td>
                </tr>
                <tr>
                    <th width="10%">损坏类型</th>
                    <td>
                        <span class="label label-primary">${fns:getDictLabel(returnProduct.damageType, 'bus_or_repair_order_breakdownType', '')}</span>
                    </td>
                    <th width="10%">扣减金额</th>
                    <td>
                        ${returnProduct.decMoney}
                    </td>
                </tr>
                <tr>
                    <th width="10%">责任人类型</th>
                    <td colspan="3">
                        <span class="label label-primary">${fns:getDictLabel(returnProduct.responsibilityType, 'bus_ol_return_product_responsibilityType', '')}</span>
                    </td>
                </tr>
                <tr>
                    <th width="10%">备注</th>
                    <td colspan="3"><p class="text-muted well well-sm no-shadow">${returnProduct.remarks}</p></td>
                </tr>
            </table>
        </div>
    </section>
    <section class="invoice">
        <p class="lead">图片设置信息</p>
        <div class="table-responsive">
            <table class="table">
                <c:forEach items="${returnProduct.imgs }" var="img" varStatus="status">
                    <tr>
                        <th width="10%"><span data-toggle='tooltip' data-placement='top' data-original-title='用于质检货品'>图片${(status.index)+1}</span></th>
                        <td><img onerror="imgOnerror(this);"  class="img-responsive" src="${imgHost }${img}" alt="icon"></td>
                    </tr>
                </c:forEach>
            </table>
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
</body>
</html>