<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>体验单管理</title>
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
            <small><i class="fa-list-style"></i><a href="${ctx}/bus/oe/experienceOrder/">体验单列表</a></small>
            <shiro:hasPermission name="bus:oe:experienceOrder:edit">
	            <small>|</small>
                <small class="menu-active">
                    <i class="fa fa-repeat"></i><a href="${ctx}/bus/oe/experienceOrder/form?id=${experienceOrder.id}">体验单${not empty experienceOrder.id?'修改':'添加'}</a>
                </small>
            </shiro:hasPermission>
        </h1>
    </section>
    <sys:tip content="${message}"/>
    <section class="content">
        <div class="row">
            <div class="col-md-6">
                <form:form id="inputForm" modelAttribute="experienceOrder" action="${ctx}/bus/oe/experienceOrder/save" method="post" class="form-horizontal" onsubmit="return ZF.formSubmit();">
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
                                        <input type="text" disabled="disabled" value="${experienceOrder.orderNo }" class="form-control"/>
                                        <%-- <sys:inputverify id="orderNo" name="orderNo" tip="请输入订单编号" verifyType="0"  isSpring="true" forbidInput="true"></sys:inputverify> --%>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">会员</label>
                                    <div class="col-sm-9">
                                        <input type="text" disabled="disabled" value="${experienceOrder.member.usercode }" class="form-control"/>
                                        <%-- <sys:inputverify id="member.usercode" name="member.usercode" tip="请输入会员ID" verifyType="0"  isSpring="true" forbidInput="true"></sys:inputverify> --%>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">订单类型</label>
                                    <div class="col-sm-9">
                                        <input type="text" disabled="disabled" value="${fns:getDictLabel(experienceOrder.type, 'bus_oe_experience_order_type', '') }" class="form-control"/>
                                        
                                        <%-- <sys:selectverify name="type" tip="请选择订单类型" disabled="true" verifyType="0" dictName="bus_oe_experience_order_type" id="type"></sys:selectverify> --%>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">会员订单状态</label>
                                    <div class="col-sm-9">
                                        <input type="text" disabled="disabled" value="${fns:getDictLabel(experienceOrder.statusMember, 'bus_oe_experience_order_statusMember', '') }" class="form-control"/>
                                        <%-- <sys:selectverify name="statusMember"  disabled="true" tip="请选择会员订单状态" verifyType="0" dictName="bus_oe_experience_order_statusMember" id="statusMember"></sys:selectverify> --%>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">系统订单状态</label>
                                    <div class="col-sm-9">
                                        <input type="text" disabled="disabled" value="${fns:getDictLabel(experienceOrder.statusSystem, 'bus_oe_experience_order_statusSystem', '') }" class="form-control"/>
                                        
                                    
                                        <%-- <sys:selectverify name="statusSystem"  disabled="true" tip="请选择系统订单状态" verifyType="0" dictName="bus_oe_experience_order_statusSystem" id="statusSystem"></sys:selectverify> --%>
                                    </div>
                                </div>
                                 <div class="form-group">
                                    <label class="col-sm-2 control-label">支付状态</label>
                                    <div class="col-sm-9">
                                        <input type="text" disabled="disabled" value="${fns:getDictLabel(experienceOrder.statusPay, 'bus_order_statusPay', '') }" class="form-control"/>
                                         
                                    
                                        <%-- <sys:selectverify name="statusPay"   disabled="true" tip="请选择支付状态" verifyType="0" dictName="bus_order_statusPay" id="statusPay"></sys:selectverify> --%>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">订单关闭类型</label>
                                    <div class="col-sm-9">
                                        <input type="text" disabled="disabled" value="${fns:getDictLabel(experienceOrder.closeType, 'operater_type', '') }" class="form-control"/>
                                        
                                    
                                        <%-- <sys:selectverify name="closeType"  disabled="true" tip="请选择订单关闭类型" verifyType="0" dictName="operater_type" id="closeType"></sys:selectverify> --%>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">订单关闭时间</label>
                                    <div class="col-sm-9">
                                        <input type="datetime" disabled="disabled" value='<fmt:formatDate value="${experienceOrder.closeTime}" pattern="yyyy-MM-dd HH:mm:ss"/>' class="form-control"/>
                                        <%-- <sys:datetime id="closeTime" inputName="closeTime" tip="请选择订单关闭时间" inputId="closeTimeId" isMandatory="true" value="${experienceOrder.closeTime}"></sys:datetime> --%>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">预约时间类型</label>
                                    <div class="col-sm-9">
                                        <input type="text" disabled="disabled" value="${fns:getDictLabel(experienceOrder.appointDateType, 'bus_oe_experience_order_appointDateType', '') }" class="form-control"/>
                                         
                                        <%-- <sys:selectverify name="appointDateType"  disabled="true" tip="请选择预约时间类型" verifyType="0" dictName="bus_oe_experience_order_appointDateType" id="appointDateType"></sys:selectverify> --%>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">预约体验日期</label>
                                    <div class="col-sm-9">
                                        <input type="text" disabled="disabled" value='<fmt:formatDate value="${experienceOrder.appointDate}" pattern="yyyy-MM-dd HH:mm:ss"/>' class="form-control"/>
                                        <%-- <fmt:formatDate value="${experienceOrder.appointDate}" pattern="yyyy-MM-dd HH:mm:ss"/> --%>
                                        <%-- <sys:datetime id="appointDate"  inputName="appointDate" tip="请选择预约体验日期" inputId="appointDateId" isMandatory="true" value="${experienceOrder.appointDate}"></sys:datetime> --%>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">预约到货状态</label>
                                    <div class="col-sm-9">
                                        <input type="text" disabled="disabled" value="${fns:getDictLabel(experienceOrder.appointStockStatus, 'bus_order_appointStockStatus', '') }" class="form-control"/>
                                        
                                       <%--  <sys:selectverify name="appointStockStatus"  disabled="true" tip="请选择预约到货状态" verifyType="0" dictName="bus_order_appointStockStatus" id="appointStockStatus"></sys:selectverify> --%>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">产品总额</label>
                                    <div class="col-sm-9">
                                        <input type="text" disabled="disabled" value="${experienceOrder.moneyProduce }" class="form-control"/>
                                        
                                        <%-- <sys:inputverify id="moneyProduce"  forbidInput="true" name="moneyProduce" tip="请输入产品总额" verifyType="4"  isSpring="true"></sys:inputverify> --%>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">物流费</label>
                                    <div class="col-sm-9">
                                        <input type="text" disabled="disabled" value="${experienceOrder.moneyLgt }" class="form-control"/>
                                       
                                        <%-- <sys:inputverify id="moneyLgt"  forbidInput="true" name="moneyLgt" tip="请输入物流费" verifyType="9"  isSpring="true"></sys:inputverify> --%>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">体验费</label>
                                    <div class="col-sm-9">
                                        <input type="text" disabled="disabled" value="${experienceOrder.moneyExperience }" class="form-control"/>
                                       <%--  <sys:inputverify id="moneyExperience"  forbidInput="true" name="moneyExperience" tip="请输入体验费" verifyType="9"  isSpring="true"></sys:inputverify> --%>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">预约定金</label>
                                    <div class="col-sm-9">
                                        <input type="text" disabled="disabled" value="${experienceOrder.moneyAppoint }" class="form-control"/>
                                        <%-- <sys:inputverify id="moneyAppoint"  forbidInput="true" name="moneyAppoint" tip="请输入预约定金" verifyType="9"  isSpring="true"></sys:inputverify> --%>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">预约服务费</label>
                                    <div class="col-sm-9">
                                        <input type="text" disabled="disabled" value="${experienceOrder.moneyAppointService }" class="form-control"/>
                                        <%-- <sys:inputverify id="moneyAppointService"  forbidInput="true" name="moneyAppointService" tip="请输入预约定金" verifyType="9"  isSpring="true"></sys:inputverify> --%>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">总金额</label>
                                    <div class="col-sm-9">
                                        <input type="text" disabled="disabled" value="${experienceOrder.moneyTotal }" class="form-control"/>
                                        <%-- <sys:inputverify id="moneyTotal"  forbidInput="true" name="moneyTotal" tip="请输入总金额" verifyType="9"  isSpring="true"></sys:inputverify> --%>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">已支付金额</label>
                                    <div class="col-sm-9">
                                        <input type="text" disabled="disabled" value="${experienceOrder.moneyPaid }" class="form-control"/>
                                        <%-- <sys:inputverify id="moneyPaid"  forbidInput="true" name="moneyPaid" tip="请输入已支付金额" verifyType="9"  isSpring="true"></sys:inputverify> --%>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">支付方式</label>
                                    <div class="col-sm-9">
                                        <input type="text" disabled="disabled" value="${fns:getDictLabel(experienceOrder.payType, 'bus_order_payType', '')  }" class="form-control"/>
                                        
                                        <%-- <sys:selectverify name="payType"  disabled="true" tip="请选择支付方式" verifyType="0" dictName="bus_order_payType" id="payType"></sys:selectverify> --%>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">支付渠道</label>
                                    <div class="col-sm-9">
                                        <input type="text" disabled="disabled" value="${fns:getDictLabel(experienceOrder.payChannel, 'bus_order_payChannel', '')  }" class="form-control"/>
                                        
                                        <%-- <sys:selectverify name="payChannel" disabled="true" tip="请选择支付渠道" verifyType="0" dictName="bus_order_payChannel" id="payChannel"></sys:selectverify> --%>
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
                                <c:if test="${empty experienceOrder.id}">
                                    <button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
                                </c:if>
                                <shiro:hasPermission name="bus:oe:experienceOrder:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
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