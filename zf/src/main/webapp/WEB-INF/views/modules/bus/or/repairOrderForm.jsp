<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>货品维修单管理</title>
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
            <small><i class="fa-list-style"></i><a href="${ctx}/bus/or/repairOrder/">货品维修单列表</a></small>
            <shiro:hasPermission name="bus:or:repairOrder:edit">
	            <small>|</small>
                <small class="menu-active">
                    <i class="fa fa-repeat"></i><a href="${ctx}/bus/or/repairOrder/form?id=${repairOrder.id}">货品维修单${not empty repairOrder.id?'修改':'添加'}</a>
                </small>
            </shiro:hasPermission>
        </h1>
    </section>
    <sys:tip content="${message}"/>
    <section class="content">
        <div class="row">
            <div class="col-md-6">
                <form:form id="inputForm" modelAttribute="repairOrder" action="${ctx}/bus/or/repairOrder/save" method="post" class="form-horizontal" onsubmit="return ZF.formSubmit();">
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
                                    <label class="col-sm-2 control-label">货品ID</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="product.id" name="product.id" tip="请输入货品ID" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">维修单状态</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="status" name="status" tip="请输入维修单状态" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">申请人</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="applyBy.id" name="applyBy.id" tip="请输入申请人" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">申请时间</label>
                                    <div class="col-sm-9">
                                        <sys:datetime id="applyTime" inputName="applyTime" tip="请选择申请时间" inputId="applyTimeId" isMandatory="true" value="${repairOrder.applyTime}"></sys:datetime>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">问题类型（破损/刮花）</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="breakdownType" name="breakdownType" tip="请输入问题类型（破损/刮花）" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">问题说明</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="breakdownDescription" name="breakdownDescription" tip="请输入问题说明" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">问题图片</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="breakdownPhotos" name="breakdownPhotos" tip="请输入问题图片" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">损耗估算</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="moneyLoss" name="moneyLoss" tip="请输入损耗估算" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">申请处理类型（返厂/维修）</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="applyType" name="applyType" tip="请输入申请处理类型（返厂/维修）" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">处理人</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="dealBy.id" name="dealBy.id" tip="请输入处理人" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">处理起始时间</label>
                                    <div class="col-sm-9">
                                        <sys:datetime id="dealStartTime" inputName="dealStartTime" tip="请选择处理起始时间" inputId="dealStartTimeId" isMandatory="true" value="${repairOrder.dealStartTime}"></sys:datetime>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">处理结束时间</label>
                                    <div class="col-sm-9">
                                        <sys:datetime id="dealEndTime" inputName="dealEndTime" tip="请选择处理结束时间" inputId="dealEndTimeId" isMandatory="true" value="${repairOrder.dealEndTime}"></sys:datetime>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">处理类型（返厂/维修）</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="dealType" name="dealType" tip="请输入处理类型（返厂/维修）" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">处理说明</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="dealDescription" name="dealDescription" tip="请输入处理说明" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">处理图片</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="dealPhotos" name="dealPhotos" tip="请输入处理图片" verifyType="0"  isSpring="true"></sys:inputverify>
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
                                <c:if test="${empty repairOrder.id}">
                                    <button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
                                </c:if>
                                <shiro:hasPermission name="bus:or:repairOrder:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
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