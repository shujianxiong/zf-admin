<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>微信支付记录管理</title>
    <meta name="decorator" content="adminLte"/>
    <script type="text/javascript">
        $(document).ready(function() {
            
            $('input').iCheck({
                checkboxClass : 'icheckbox_minimal-blue',
                radioClass : 'iradio_minimal-blue'
            });
            
            
        });
    </script>
</head>
<body>
    <div class="content-wrapper sub-content-wrapper">
    <section class="content-header content-header-menu">
        <h1>
            <small><i class="fa-list-style"></i><a href="${ctx}/bus/wp/wechatPayRecord/">微信支付记录列表</a></small>
            <shiro:hasPermission name="bus:wp:wechatPayRecord:edit">
	            <small>|</small>
                <small class="menu-active">
                    <i class="fa fa-repeat"></i><a href="${ctx}/bus/wp/wechatPayRecord/form?id=${wechatPayRecord.id}">微信支付记录${not empty wechatPayRecord.id?'修改':'添加'}</a>
                </small>
            </shiro:hasPermission>
        </h1>
    </section>
    <sys:tip content="${message}"/>
    <section class="content">
        <div class="row">
            <div class="col-md-6">
                <form:form id="inputForm" modelAttribute="wechatPayRecord" action="${ctx}/bus/wp/wechatPayRecord/save" method="post" class="form-horizontal" onsubmit="return ZF.formSubmit();">
                    <div class="box box-success">
                        <div class="box-header with-border zf-query">
                            <h5>请完善表单填写</h5>
                            <div class="box-tools">
                               <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                            </div>
                        </div>
                        <div class="box-body">
                            <form:hidden path="id" />
                            
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">公众账号ID</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="appid" name="appid" tip="请输入公众账号ID" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">商户号</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="mchId" name="mchId" tip="请输入商户号" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">设备号</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="deviceInfo" name="deviceInfo" tip="请输入设备号" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">随机字符串</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="nonceStr" name="nonceStr" tip="请输入随机字符串" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">签名类型</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="signType" name="signType" tip="请输入签名类型" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">业务结果</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="resultCode" name="resultCode" tip="请输入业务结果" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">错误代码</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="errCode" name="errCode" tip="请输入错误代码" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">错误代码描述</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="errCodeDes" name="errCodeDes" tip="请输入错误代码描述" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">用户标识</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="openid" name="openid" tip="请输入用户标识" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">是否关注公众账号</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="isSubscribe" name="isSubscribe" tip="请输入是否关注公众账号" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">交易类型</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="tradeType" name="tradeType" tip="请输入交易类型" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">付款银行</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="bankType" name="bankType" tip="请输入付款银行" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">订单金额</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="totalFee" name="totalFee" tip="请输入订单金额" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">应结订单金额</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="settlementTotalFee" name="settlementTotalFee" tip="请输入应结订单金额" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">货币种类</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="feeType" name="feeType" tip="请输入货币种类" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">现金支付金额</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="cashFee" name="cashFee" tip="请输入现金支付金额" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">现金支付货币类型</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="cashFeeType" name="cashFeeType" tip="请输入现金支付货币类型" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">总代金券金额</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="couponFee" name="couponFee" tip="请输入总代金券金额" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">代金券使用数量</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="couponCount" name="couponCount" tip="请输入代金券使用数量" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">代金券类型</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="couponType$n" name="couponType$n" tip="请输入代金券类型" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">微信支付订单号</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="transactionId" name="transactionId" tip="请输入微信支付订单号" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">单个代金券支付金额</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="couponFee$n" name="couponFee$n" tip="请输入单个代金券支付金额" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">商户订单号</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="outTradeNo" name="outTradeNo" tip="请输入商户订单号" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">商家数据包</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="attach" name="attach" tip="请输入商家数据包" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">支付完成时间</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="timeEnd" name="timeEnd" tip="请输入支付完成时间" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">签名</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="sign" name="sign" tip="请输入签名" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">代金券ID</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="couponId$n" name="couponId$n" tip="请输入代金券ID" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">备注信息</label>
                                    <div class="col-sm-9">
                                        <form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="200" class="form-control"/>
                                    </div>
                                </div>
                            
                        </div>
                        <div class="box-footer">
                            <div class="pull-left box-tools">
                                <button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
                            </div>
                            <div class="pull-right box-tools">
                                <c:if test="${empty wechatPayRecord.id}">
                                    <button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
                                </c:if>
                                <shiro:hasPermission name="bus:wp:wechatPayRecord:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
                            </div>
                        </div>
                    </div>
                </form:form>
            </div>
        </div>
        
    </section>
    </div>
    
</body>
</html>