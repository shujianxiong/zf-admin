<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>发货单管理</title>
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
            <small><i class="fa-list-style"></i><a href="${ctx}/bus/ol/sendOrder/">发货单列表</a></small>
            <shiro:hasPermission name="bus:ol:sendOrder:edit">
	            <small>|</small>
                <small class="menu-active">
                    <i class="fa fa-repeat"></i><a href="${ctx}/bus/ol/sendOrder/form?id=${sendOrder.id}">发货单${not empty sendOrder.id?'修改':'添加'}</a>
                </small>
            </shiro:hasPermission>
        </h1>
    </section>
    <sys:tip content="${message}"/>
    <section class="content">
        <div class="row">
            <div class="col-md-6">
                <form:form id="inputForm" modelAttribute="sendOrder" action="${ctx}/bus/ol/sendOrder/save" method="post" class="form-horizontal" onsubmit="return ZF.formSubmit();">
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
                                    <label class="col-sm-2 control-label">发货单编号</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="sendOrderNo" name="sendOrderNo" tip="请输入发货单编号" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">来源订单类型</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="orderType" name="orderType" tip="请输入来源订单类型（体验/预约/购买/预购）" verifyType="0"  isSpring="true"></sys:inputverify>
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
                                    <label class="col-sm-2 control-label">出库状态（待发货/发货中/发货完成）</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="status" name="status" tip="请输入出库状态（待发货/发货中/发货完成）" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">收货人</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="receiveName" name="receiveName" tip="请输入收货人" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">收货电话</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="receiveTel" name="receiveTel" tip="请输入收货电话" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">收货地址省市区</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="receiveAreaStr" name="receiveAreaStr" tip="请输入收货地址省市区" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">收货地址详情</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="receiveAreaDetail" name="receiveAreaDetail" tip="请输入收货地址详情" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">用户备注</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="memberRemarks" name="memberRemarks" tip="请输入用户备注" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">所属拣货单ID</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="pickOrder.id" name="pickOrder.id" tip="请输入所属拣货单ID" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">所属拣货序号</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="pickNo" name="pickNo" tip="请输入所属拣货序号" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">快递公司</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="expressCompany" name="expressCompany" tip="请输入快递公司" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">快递单号</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="expressNo" name="expressNo" tip="请输入快递单号" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">出库时间</label>
                                    <div class="col-sm-9">
                                        <sys:datetime id="expressTime" inputName="expressTime" tip="请选择出库时间" inputId="expressTimeId" isMandatory="true" value="${sendOrder.expressTime}"></sys:datetime>
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
                                <c:if test="${empty sendOrder.id}">
                                    <button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
                                </c:if>
                                <shiro:hasPermission name="bus:ol:sendOrder:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
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