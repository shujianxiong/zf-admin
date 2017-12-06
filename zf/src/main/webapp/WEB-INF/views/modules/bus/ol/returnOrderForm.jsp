<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>退货单管理</title>
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
            <small><i class="fa-list-style"></i><a href="${ctx}/bus/ol/returnOrder/">退货单列表</a></small>
            <shiro:hasPermission name="bus:ol:returnOrder:edit">
	            <small>|</small>
                <small class="menu-active">
                    <i class="fa fa-repeat"></i><a href="${ctx}/bus/ol/returnOrder/form?id=${returnOrder.id}">退货单${not empty returnOrder.id?'修改':'添加'}</a>
                </small>
            </shiro:hasPermission>
        </h1>
    </section>
    <sys:tip content="${message}"/>
    <section class="content">
        <div class="row">
            <div class="col-md-6">
                <form:form id="inputForm" modelAttribute="returnOrder" action="${ctx}/bus/ol/returnOrder/save" method="post" class="form-horizontal" onsubmit="return ZF.formSubmit();">
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
                                    <label class="col-sm-2 control-label">退货单编号</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="returnOrderNo" name="returnOrderNo" tip="请输入退货单编号" verifyType="0"  isSpring="true"></sys:inputverify>
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
                                    <label class="col-sm-2 control-label">来源订单产品ID</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="orderProduceId" name="orderProduceId" tip="请输入来源订单产品ID" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">产品ID</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="produce.id" name="produce.id" tip="请输入产品ID" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">数量</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="num" name="num" tip="请输入数量" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">退货状态</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="status" name="status" tip="请输入退货状态" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">退货原因类型</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="reasonType" name="reasonType" tip="请输入退货原因类型" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">退货原因详情</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="reasonDetail" name="reasonDetail" tip="请输入退货原因详情" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">物流快递公司</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="expressCompany" name="expressCompany" tip="请输入物流快递公司" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">物流单号</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="expressNo" name="expressNo" tip="请输入物流单号" verifyType="0"  isSpring="true"></sys:inputverify>
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
                                <c:if test="${empty returnOrder.id}">
                                    <button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
                                </c:if>
                                <shiro:hasPermission name="bus:ol:returnOrder:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
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