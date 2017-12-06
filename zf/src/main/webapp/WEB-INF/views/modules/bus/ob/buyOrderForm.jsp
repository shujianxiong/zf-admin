<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>购买单管理</title>
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
            <small><i class="fa-list-style"></i><a href="${ctx}/bus/ob/buyOrder/">购买单列表</a></small>
            <shiro:hasPermission name="bus:ob:buyOrder:edit">
	            <small>|</small>
                <small class="menu-active">
                    <i class="fa fa-repeat"></i><a href="${ctx}/bus/ob/buyOrder/form?id=${buyOrder.id}">购买单${not empty buyOrder.id?'修改':'添加'}</a>
                </small>
            </shiro:hasPermission>
        </h1>
    </section>
    <sys:tip content="${message}"/>
    <section class="content">
        <div class="row">
            <div class="col-md-6">
                <form:form id="inputForm" modelAttribute="buyOrder" action="${ctx}/bus/ob/buyOrder/save" method="post" class="form-horizontal" onsubmit="return ZF.formSubmit();">
                    <div class="box box-success">
                        <div class="box-header with-border zf-query">
                            <h5>请完善表单填写</h5>
                            <div class="box-tools">
                               <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                            </div>
                        </div>
                        <div class="box-body">
                            <form:hidden path="id" />
                            
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">订单编号</label>
                                    <div class="col-sm-9">
                                        <input type="text" disabled="disabled" value="${buyOrder.orderNo }" class="form-control"/>
                                        <%-- <sys:inputverify id="orderNo" name="orderNo" tip="请输入订单编号" verifyType="0"  isSpring="true"></sys:inputverify> --%>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">会员</label>
                                    <div class="col-sm-9">
                                        <input type="text" disabled="disabled" value="${buyOrder.member.usercode }" class="form-control"/>
                                        <%-- <sys:inputverify id="member.usercode" name="member.usercode" tip="请输入会员ID" verifyType="0"  isSpring="true"></sys:inputverify> --%>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">订单类型</label>
                                    <div class="col-sm-9">
                                        <input type="text" disabled="disabled" value="${fns:getDictLabel(buyOrder.type, 'bus_ob_buy_order_type', '') }" class="form-control"/>
                                        <%-- <sys:inputverify id="type" name="type" tip="请输入订单类型（购买/预购）" verifyType="0"  isSpring="true"></sys:inputverify> --%>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">购买时机</label>
                                    <div class="col-sm-9">
                                        <input type="text" disabled="disabled" value="${fns:getDictLabel(buyOrder.buyType, 'bus_ob_buy_order_buyType', '') }" class="form-control"/>
                                       <%--  <sys:inputverify id="buyType" name="buyType" tip="请输入购买时机（体验中/后）" verifyType="0"  isSpring="true"></sys:inputverify> --%>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">来源体验单</label>
                                    <div class="col-sm-9">
                                        <input type="text" disabled="disabled" value="${buyOrder.experienceOrder.id }" class="form-control"/>
                                        <%-- <sys:inputverify id="experienceOrder.id" name="experienceOrder.id" tip="请输入来源体验单ID" verifyType="0"  isSpring="true"></sys:inputverify> --%>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">会员订单状态</label>
                                    <div class="col-sm-9">
                                        <input type="text" disabled="disabled" value="${fns:getDictLabel(buyOrder.statusMember, 'bus_ob_buy_order_statusMember', '') }" class="form-control"/>
                                        
                                        <%-- <sys:inputverify id="statusMember" name="statusMember" tip="请输入会员订单状态" verifyType="0"  isSpring="true"></sys:inputverify> --%>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">系统订单状态</label>
                                    <div class="col-sm-9">
                                        <input type="text" disabled="disabled" value="${fns:getDictLabel(buyOrder.statusSystem, 'bus_ob_buy_order_statusSystem', '') }" class="form-control"/>
                                    
                                        <%-- <sys:inputverify id="statusSystem" name="statusSystem" tip="请输入系统订单状态" verifyType="0"  isSpring="true"></sys:inputverify> --%>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">支付状态</label>
                                    <div class="col-sm-9">
                                        <input type="text" disabled="disabled" value="${fns:getDictLabel(buyOrder.statusPay, 'bus_order_statusPay', '') }" class="form-control"/>
                                    
                                        <%-- <sys:inputverify id="statusPay" name="statusPay" tip="请输入支付状态" verifyType="0"  isSpring="true"></sys:inputverify> --%>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">订单关闭类型</label>
                                    <div class="col-sm-9">
                                        <input type="text" disabled="disabled" value="${fns:getDictLabel(buyOrder.closeType, 'operater_type', '') }" class="form-control"/>
                                    
                                        <%-- <sys:inputverify id="closeType" name="closeType" tip="请输入订单关闭类型" verifyType="0"  isSpring="true"></sys:inputverify> --%>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">订单关闭时间</label>
                                    <div class="col-sm-9">
                                        <input type="datetime" disabled="disabled" value='<fmt:formatDate value="${buyOrder.closeTime}" pattern="yyyy-MM-dd HH:mm:ss"/>' class="form-control"/>
                                        <%-- <sys:datetime id="closeTime" inputName="closeTime" tip="请选择订单关闭时间" inputId="closeTimeId" isMandatory="true" value="${buyOrder.closeTime}"></sys:datetime> --%>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">预购到货状态</label>
                                    <div class="col-sm-9">
                                        <input type="text" disabled="disabled" value="${fns:getDictLabel(buyOrder.appointStockStatus, 'bus_order_appointStockStatus', '') }" class="form-control"/>
                                    
                                        <%-- <sys:inputverify id="appointStockStatus" name="appointStockStatus" tip="请输入预购到货状态" verifyType="0"  isSpring="true"></sys:inputverify> --%>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">产品总额</label>
                                    <div class="col-sm-9">
                                        <input type="text" disabled="disabled" value="${buyOrder.moneyProduce }" class="form-control"/>
                                        <%-- <sys:inputverify id="moneyProduce" name="moneyProduce" tip="请输入产品总额" verifyType="0"  isSpring="true"></sys:inputverify> --%>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">物流费</label>
                                    <div class="col-sm-9">
                                        <input type="text" disabled="disabled" value="${buyOrder.moneyLgt }" class="form-control"/>
                                        <%-- <sys:inputverify id="moneyLgt" name="moneyLgt" tip="请输入物流费" verifyType="0"  isSpring="true"></sys:inputverify> --%>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">预购定金</label>
                                    <div class="col-sm-9">
                                        <input type="text" disabled="disabled" value="${buyOrder.moneyAppoint }" class="form-control"/>
                                        <%-- <sys:inputverify id="moneyAppoint" name="moneyAppoint" tip="请输入预购定金" verifyType="0"  isSpring="true"></sys:inputverify> --%>
                                    </div>
                                </div>
                                 <div class="form-group">
                                    <label class="col-sm-2 control-label">预购定金</label>
                                    <div class="col-sm-9">
                                        <input type="text" disabled="disabled" value="${buyOrder.moneyAppointService }" class="form-control"/>
                                        <%-- <sys:inputverify id="moneyAppointService" name="moneyAppointService" tip="请输入预购定金" verifyType="0"  isSpring="true"></sys:inputverify> --%>
                                    </div>
                                </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">魅力豆抵扣数量</label>
                                <div class="col-sm-9">
                                    <input type="text" disabled="disabled" value="${buyOrder.numBeansDeduct }" class="form-control"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">魅力豆抵扣金额</label>
                                <div class="col-sm-9">
                                    <input type="text" disabled="disabled" value="${buyOrder.moneyBeansDeduct }" class="form-control"/>
                                </div>
                            </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">总金额</label>
                                    <div class="col-sm-9">
                                        <input type="text" disabled="disabled" value="${buyOrder.moneyTotal }" class="form-control"/>
                                        <%-- <sys:inputverify id="moneyTotal" name="moneyTotal" tip="请输入总金额" verifyType="0"  isSpring="true"></sys:inputverify> --%>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">已支付金额</label>
                                    <div class="col-sm-9">
                                        <input type="text" disabled="disabled" value="${buyOrder.moneyPaid }" class="form-control"/>
                                        <%-- <sys:inputverify id="moneyPaid" name="moneyPaid" tip="请输入已支付金额" verifyType="0"  isSpring="true"></sys:inputverify> --%>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">支付方式</label>
                                    <div class="col-sm-9">
                                        <input type="text" disabled="disabled" value="${fns:getDictLabel(buyOrder.payType, 'bus_order_payType', '') }" class="form-control"/>
                                    
                                        <%-- <sys:inputverify id="payType" name="payType" tip="请输入支付方式" verifyType="0"  isSpring="true"></sys:inputverify> --%>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">支付渠道</label>
                                    <div class="col-sm-9">
                                        
                                        <input type="text" disabled="disabled" value="${fns:getDictLabel(buyOrder.payChannel, 'bus_order_payChannel', '') }" class="form-control"/>
                                    
                                        <%-- <sys:inputverify id="payChannel" name="payChannel" tip="请输入支付渠道" verifyType="0"  isSpring="true"></sys:inputverify> --%>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">收货人</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="receiveName" name="receiveName" tip="请输入收货人" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">收货电话</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="receiveTel" name="receiveTel" tip="请输入正确的收货电话" verifyType="1"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">收货地址省市区</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="receiveAreaStr" name="receiveAreaStr" tip="请输入收货地址省市区" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">收货地址详情</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="receiveAreaDetail" name="receiveAreaDetail" tip="请输入收货地址详情" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">用户备注</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="memberRemarks" name="memberRemarks" tip="请输入用户备注" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group">
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
                                <c:if test="${empty buyOrder.id}">
                                    <button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
                                </c:if>
                                <shiro:hasPermission name="bus:ob:buyOrder:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
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