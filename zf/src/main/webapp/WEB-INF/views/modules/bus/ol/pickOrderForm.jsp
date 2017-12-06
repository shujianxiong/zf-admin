<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>拣货单管理</title>
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
            <small><i class="fa-list-style"></i><a href="${ctx}/bus/ol/pickOrder/">拣货单列表</a></small>
            <shiro:hasPermission name="bus:ol:pickOrder:edit">
	            <small>|</small>
                <small class="menu-active">
                    <i class="fa fa-repeat"></i><a href="${ctx}/bus/ol/pickOrder/form?id=${pickOrder.id}">拣货单${not empty pickOrder.id?'修改':'添加'}</a>
                </small>
            </shiro:hasPermission>
        </h1>
    </section>
    <sys:tip content="${message}"/>
    <section class="content">
        <div class="row">
            <div class="col-md-6">
                <form:form id="inputForm" modelAttribute="pickOrder" action="${ctx}/bus/ol/pickOrder/save" method="post" class="form-horizontal" onsubmit="return ZF.formSubmit();">
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
                                    <label class="col-sm-2 control-label">拣货单编号</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="pickOrderNo" name="pickOrderNo" tip="请输入拣货单编号" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">拣货人</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="pickBy.id" name="pickBy.id" tip="请输入拣货人" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">拣货开始时间</label>
                                    <div class="col-sm-9">
                                        <sys:datetime id="pickStartTime" inputName="pickStartTime" tip="请选择拣货开始时间" inputId="pickStartTimeId" isMandatory="true" value="${pickOrder.pickStartTime}"></sys:datetime>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">拣货完成时间</label>
                                    <div class="col-sm-9">
                                        <sys:datetime id="pickEndTime" inputName="pickEndTime" tip="请选择拣货完成时间" inputId="pickEndTimeId" isMandatory="true" value="${pickOrder.pickEndTime}"></sys:datetime>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">打包人</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="packageBy.id" name="packageBy.id" tip="请输入打包人" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">打包开始时间</label>
                                    <div class="col-sm-9">
                                        <sys:datetime id="packageStartTime" inputName="packageStartTime" tip="请选择打包开始时间" inputId="packageStartTimeId" isMandatory="true" value="${pickOrder.packageStartTime}"></sys:datetime>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">打包完成时间</label>
                                    <div class="col-sm-9">
                                        <sys:datetime id="packageEndTime" inputName="packageEndTime" tip="请选择打包完成时间" inputId="packageEndTimeId" isMandatory="true" value="${pickOrder.packageEndTime}"></sys:datetime>
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
                                <c:if test="${empty pickOrder.id}">
                                    <button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
                                </c:if>
                                <shiro:hasPermission name="bus:ol:pickOrder:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
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