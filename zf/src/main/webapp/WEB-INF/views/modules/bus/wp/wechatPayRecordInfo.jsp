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
    <sys:tip content="${message}"/>
    
    <form:form id="inputForm" modelAttribute="wechatPayRecord" action="${ctx}/bus/wp/wechatPayRecord/info" method="post" class="form-horizontal">
        <section class="content">
            <div class="row">
                <div class="col-md-6">
                    <div class="box box-primary">
                        <div class="box-header with-border">
                            <h5>微信支付记录信息</h5>
                            <div class="box-tools">
                                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                                </button>
                            </div>
                        </div>
                        <!-- /.box-header -->
                        <div class="box-body">
                            
                            <strong>公众账号ID</strong>
                            <p class="text-primary">
                                ${wechatPayRecord.appid}
                            </p>
                            <hr class="zf-hr">
                            <strong>商户号</strong>
                            <p class="text-primary">
                                ${wechatPayRecord.mchId}
                            </p>
                            <hr class="zf-hr">
                            <strong>设备号</strong>
                            <p class="text-primary">
                                ${wechatPayRecord.deviceInfo}
                            </p>
                            <hr class="zf-hr">
                            <strong>签名类型</strong>
                            <p class="text-primary">
                                ${wechatPayRecord.signType}
                            </p>
                            <hr class="zf-hr">
                            <strong>业务结果</strong>
                            <p class="text-primary">
                                ${wechatPayRecord.resultCode}
                            </p>
                            <hr class="zf-hr">
                            <strong>错误代码</strong>
                            <p class="text-primary">
                                ${wechatPayRecord.errCode}
                            </p>
                            <hr class="zf-hr">
                            <strong>用户标识</strong>
                            <p class="text-primary">
                                ${wechatPayRecord.openid}
                            </p>
                            <hr class="zf-hr">
                            <strong>是否关注公众账号</strong>
                            <p class="text-primary">
                                ${wechatPayRecord.isSubscribe}
                            </p>
                            <hr class="zf-hr">
                            <strong>交易类型</strong>
                            <p class="text-primary">
                                ${wechatPayRecord.tradeType}
                            </p>
                            <hr class="zf-hr">
                            <strong>付款银行</strong>
                            <p class="text-primary">
                                ${wechatPayRecord.bankType}
                            </p>
                            <hr class="zf-hr">
                            <strong>订单金额</strong>
                            <p class="text-primary">
                                ${wechatPayRecord.totalFee}
                            </p>
                            <hr class="zf-hr">
                            <strong>应结订单金额</strong>
                            <p class="text-primary">
                                ${wechatPayRecord.settlementTotalFee}
                            </p>
                            <hr class="zf-hr">
                            <strong>货币种类</strong>
                            <p class="text-primary">
                                ${wechatPayRecord.feeType}
                            </p>
                            <hr class="zf-hr">
                            <strong>更新者</strong>
                            <p class="text-primary">
                                ${wechatPayRecord.updateBy.id}
                            </p>
                            <hr class="zf-hr">
                            <strong>更新时间</strong>
                            <p class="text-primary">
                                <fmt:formatDate value="${wechatPayRecord.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                            </p>
                            <hr class="zf-hr">
                            <strong>备注信息</strong>
                            <p class="text-primary">
                                ${wechatPayRecord.remarks}
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