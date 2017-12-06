<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>微信退款执行</title>
    <meta name="decorator" content="adminLte"/>
    <script type="text/javascript">
        $(document).ready(function() {
            
        });
    </script>
</head>
<body>
    <div class="content-wrapper sub-content-wrapper">
    <section class="content-header content-header-menu">
        <h1>
            <small><i class="fa-list-style"></i><a href="${ctx}/bus/wp/wechatRefund/">微信退款列表</a></small>
            <shiro:hasPermission name="bus:wp:wechatRefund:edit">
	            <small>|</small>
                <small class="menu-active">
                    <i class="fa fa-repeat"></i><a href="${ctx}/bus/wp/wechatRefund/refundForm?id=${wechatPayRecord.id}">微信退款执行</a>
                </small>
            </shiro:hasPermission>
        </h1>
    </section>
    <sys:tip content="${message}"/>
    <section class="content">
        <div class="row">
            <div class="col-md-6">
                <form:form id="inputForm" modelAttribute="wechatPayRecord" action="${ctx}/bus/wp/wechatRefund/refundSave" method="post" class="form-horizontal">
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
                                <label class="col-sm-2 control-label">商户号</label>
                                <div class="col-sm-9">
                                    <sys:inputverify id="mchId" name="mchId" tip="请输入商户号" verifyType="0"  isSpring="true" forbidInput="true"></sys:inputverify>
                                </div>
                            </div>
                            <div class="form-group    ">
                                <label class="col-sm-2 control-label">微信支付订单号</label>
                                <div class="col-sm-9">
                                    <sys:inputverify id="transactionId" name="transactionId" tip="请输入微信支付订单号" verifyType="0"  isSpring="true" forbidInput="true"></sys:inputverify>
                                </div>
                            </div>
                            <div class="form-group    ">
                                <label class="col-sm-2 control-label">付款银行</label>
                                <div class="col-sm-9">
                                    <sys:inputverify id="bankType" name="bankType" tip="请输入付款银行" verifyType="0"  isSpring="true" forbidInput="true"></sys:inputverify>
                                </div>
                            </div>
                            <div class="form-group    ">
                                <label class="col-sm-2 control-label">现金支付金额</label>
                                <div class="col-sm-9">
                                    <sys:inputverify id="cashFee" name="cashFee" tip="请输入现金支付金额" verifyType="0"  isSpring="true" forbidInput="true"></sys:inputverify>
                                </div>
                            </div>
                            
                            <div class="form-group    ">
                                <label class="col-sm-2 control-label">退款编号</label>
                                <div class="col-sm-9">
                                    <sys:inputverify id="refundNo" name="refundNo" tip="请输入退款编号" verifyType="0"  isSpring="true" forbidInput="true"></sys:inputverify>
                                </div>
                            </div>
                            <div class="form-group    ">
                                <label class="col-sm-2 control-label">自动退款状态</label>
                                <div class="col-sm-9">
                                    <input id="refundAutoStatus" readonly="readonly" value="${fns:getDictLabel(wechatPayRecord.refundAutoStatus, 'bus_wp_wechat_pay_record_refundAutoStatus', '')}" data-verify="false" placeholder="true" class="form-control zf-input-readonly"/>
                                </div>
                            </div>
                            <div class="form-group    ">
                                <label class="col-sm-2 control-label">自动退款金额</label>
                                <div class="col-sm-9">
                                    <input id="refundAutoMoney" readonly="readonly" value="${wechatPayRecord.refundAutoMoney }" data-verify="false" placeholder="true" class="form-control zf-input-readonly"/>
                                </div>
                            </div>
                            <div class="form-group    ">
                                <label class="col-sm-2 control-label">自动退款时间</label>
                                <div class="col-sm-9">
                                    <input id="refundAutoTime" readonly="readonly" value="<fmt:formatDate value='${wechatPayRecord.refundAutoTime}' pattern='yyyy-MM-dd HH:mm:ss'/>" data-verify="false" placeholder="true" class="form-control zf-input-readonly"/>
                                </div>
                            </div>
                            <div class="form-group    ">
                                <label class="col-sm-2 control-label">人工退款金额</label>
                                <div class="col-sm-9">
                                    <sys:inputverify id="refundArtificialMoney" name="refundArtificialMoney" tip="请输入人工退款金额" verifyType="9"  isSpring="true" forbidInput="false"></sys:inputverify>
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
                                <shiro:hasPermission name="bus:wp:wechatRefund:edit"><button type="button" onclick="formSubmit();" class="btn btn-info btn-sm"><i class="fa fa-save"></i>退款</button></shiro:hasPermission>
                            </div>
                        </div>
                    </div>
                </form:form>
            </div>
        </div>
        
    </section>
    </div>
    
    <script type="text/javascript">
		function formSubmit(){
			var raMoneyStr = $("#refundArtificialMoney").val();
			if(!/^-?\d+\.?\d{0,2}$/.test(raMoneyStr)){
				return false;
			}else {
				confirm("确认已对该退款单退款了"+raMoneyStr+"元？确认后该退款单将不可再进行退款操作","warning",function(){
					$("#inputForm").submit();
				});				
			}
		}
	</script>
    
</body>
</html>