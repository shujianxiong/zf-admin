<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>微信支付记录管理</title>
    <meta name="decorator" content="adminLte"/>
    <style type="text/css">
        tr{ 
            cursor: pointer;    /*手形*/   
        } 
    </style>
</head>
<body>
<div class="content-wrapper sub-content-wrapper">
	<section class="content-header content-header-menu"></section>
    
    <section class="invoice">
        <p class="lead">微信退款基本信息</p>
        <div class="table-responsive">
            <table class="table">
                <tr>
                    <th width="10%">商户号</th>
                    <td>${wechatPayRecord.mchId}</td>
                    <th width="10%">微信支付订单号</th>
                    <td>${wechatPayRecord.transactionId}</td>
                </tr>
                <tr>
                    <th width="10%">付款银行</th>
                    <td>${wechatPayRecord.bankType}</td>
                    <th width="10%">现金支付金额</th>
                    <td><span class="text-red">${wechatPayRecord.cashFee}</span></td>
                </tr>
                <tr>
                    <th width="10%">退款编号</th>
                    <td colspan="3">${wechatPayRecord.refundNo}</td>
                </tr>
                <tr>
                    <th width="10%">自动退款状态</th>
                    <td colspan="3">${fns:getDictLabel(wechatPayRecord.refundAutoStatus, 'bus_wp_wechat_pay_record_refundAutoStatus', '')}</td>
                </tr>
                <tr>
                    <th width="10%">自动退款金额</th>
                    <td colspan="3"><span class="text-red">${wechatPayRecord.refundAutoMoney}</span></td>
                </tr>
                <tr>
                    <th width="10%">自动退款时间</th>
                    <td colspan="3"><fmt:formatDate value="${wechatPayRecord.refundAutoTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                </tr>
                <tr>
                    <th width="10%">人工退款状态</th>
                    <td colspan="3">${fns:getDictLabel(wechatPayRecord.refundArtificialStatus, 'bus_wp_wechat_pay_record_refundArtificialStatus', '')}</td>
                </tr>
                <tr>
                    <th width="10%">人工退款金额</th>
                    <td colspan="3"><span class="text-red">${wechatPayRecord.refundArtificialMoney}</span></td>
                </tr>
                <tr>
                    <th width="10%">人工退款时间</th>
                    <td colspan="3"><fmt:formatDate value="${wechatPayRecord.refundArtificialTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                </tr>
                <tr>
                    <th width="10%">备注</th>
                    <td colspan="3">${wechatPayRecord.remarks}</td>
                </tr>
            </table>
        </div>
    </section>
</div>
</body>
</html>