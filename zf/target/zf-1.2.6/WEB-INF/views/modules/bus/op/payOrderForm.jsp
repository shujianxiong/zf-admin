<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>付款单管理</title>
    <meta name="decorator" content="adminLte"/>
    <script type="text/javascript">
        $(document).ready(function() {
            
            $('input').iCheck({
                checkboxClass : 'icheckbox_minimal-blue',
                radioClass : 'iradio_minimal-blue'
            });
            
            $("#officeName").on("click", function() {
                selectOfficeinit({
                    "selectCallBack" : function(list) {
                        $("#officeId").val(list[0].id);
                        $("#officeName").val(list[0].text);
                    }
                })
            });
            
            $("#areaName").on("click", function() {
                selectAreainit({
                    "selectCallBack" : function(list) {
                        $("#areaId").val(list[0].id);
                        $("#areaName").val(list[0].text);
                    }
                })
            });
            
            $("#userName").on("click", function() {
                selectUserinit({
                    "selectCallBack" : function(list) {
                        $("#userId").val(list[0].id);
                        $("#userName").val(list[0].text);
                    }
                })
            });
            
            
        });
    </script>
</head>
<body>
    <div class="content-wrapper sub-content-wrapper">
    <section class="content-header content-header-menu">
        <h1>
            <small><i class="fa-list-style"></i><a href="${ctx}/bus/op/payOrder/">付款单列表</a></small>
            <shiro:hasPermission name="bus:op:payOrder:edit">
	            <small>|</small>
                <small class="menu-active">
                    <i class="fa fa-repeat"></i><a href="${ctx}/bus/op/payOrder/form?id=${payOrder.id}">付款单${not empty payOrder.id?'修改':'添加'}</a>
                </small>
            </shiro:hasPermission>
        </h1>
    </section>
    <sys:tip content="${message}"/>
    <section class="content">
        <div class="row">
            <div class="col-md-6">
                <form:form id="inputForm" modelAttribute="payOrder" action="${ctx}/bus/op/payOrder/save" method="post" class="form-horizontal" onsubmit="return ZF.formSubmit();">
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
                                    <label class="col-sm-2 control-label">付款单编号</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="no" name="no" tip="请输入付款单编号" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">来源订单类型（体验/预约..）</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="orderType" name="orderType" tip="请输入来源订单类型（体验/预约..）" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">来源订单ID</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="orderId" name="orderId" tip="请输入来源订单ID" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">来源订单编号</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="orderNo" name="orderNo" tip="请输入来源订单编号" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">支付金额类型</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="moneyType" name="moneyType" tip="请输入支付金额类型" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">支付金额</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="money" name="money" tip="请输入支付金额" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">支付状态</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="status" name="status" tip="请输入支付状态" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">支付时间</label>
                                    <div class="col-sm-9">
                                        <sys:datetime id="payTime" inputName="payTime" tip="请选择支付时间" inputId="payTimeId" isMandatory="true" value="${payOrder.payTime}"></sys:datetime>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">支付返回时间</label>
                                    <div class="col-sm-9">
                                        <sys:datetime id="returnTime" inputName="returnTime" tip="请选择支付返回时间" inputId="returnTimeId" isMandatory="true" value="${payOrder.returnTime}"></sys:datetime>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">支付返回结果</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="returnResult" name="returnResult" tip="请输入支付返回结果" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">支付人openid</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="openid" name="openid" tip="请输入支付人openid" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">可退款标记</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="refundFlag" name="refundFlag" tip="请输入可退款标记" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">自动退款状态</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="refundAutoStatus" name="refundAutoStatus" tip="请输入自动退款状态" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">自动退款金额</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="refundAutoMoney" name="refundAutoMoney" tip="请输入自动退款金额" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">自动退款时间</label>
                                    <div class="col-sm-9">
                                        <sys:datetime id="refundAutoTime" inputName="refundAutoTime" tip="请选择自动退款时间" inputId="refundAutoTimeId" isMandatory="true" value="${payOrder.refundAutoTime}"></sys:datetime>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">人工退款状态</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="refundArtificialStatus" name="refundArtificialStatus" tip="请输入人工退款状态" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">人工退款金额</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="refundArtificialMoney" name="refundArtificialMoney" tip="请输入人工退款金额" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">人工退款时间</label>
                                    <div class="col-sm-9">
                                        <sys:datetime id="refundArtificialTime" inputName="refundArtificialTime" tip="请选择人工退款时间" inputId="refundArtificialTimeId" isMandatory="true" value="${payOrder.refundArtificialTime}"></sys:datetime>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">人工退款备注</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="refundArtificialRemarks" name="refundArtificialRemarks" tip="请输入人工退款备注" verifyType="0"  isSpring="true"></sys:inputverify>
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
                                <c:if test="${empty payOrder.id}">
                                    <button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
                                </c:if>
                                <shiro:hasPermission name="bus:op:payOrder:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
                            </div>
                        </div>
                    </div>
                </form:form>
            </div>
        </div>
        
        <sys:userselect height="550" url="${ctx}/sys/office/treeData"
            width="550" isOffice="true" isMulti="false" title="机构选择"
            id="selectOffice" dataType="Office"></sys:userselect>
            
        <sys:userselect height="550" url="${ctx}/sys/area/treeData"
            width="550" isOffice="true" isMulti="false" title="区域选择"
            id="selectArea"></sys:userselect>
            
        <sys:userselect height="550" url="${ctx}/sys/office/userTreeData"
            width="550" isOffice="false" isMulti="false" title="人员选择"
            id="selectUser" ></sys:userselect>
        
    </section>
    </div>
    
</body>
</html>