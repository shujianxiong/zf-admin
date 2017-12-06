<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>供应商信誉分流水管理</title>
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
            <small><i class="fa-list-style"></i><a href="${ctx}/lgt/si/creditPointDetail/">供应商信誉分流水列表</a></small>
            <shiro:hasPermission name="lgt:si:creditPointDetail:edit">
	            <small>|</small>
                <small class="menu-active">
                    <i class="fa fa-repeat"></i><a href="${ctx}/lgt/si/creditPointDetail/form?id=${creditPointDetail.id}">供应商信誉分流水${not empty creditPointDetail.id?'修改':'添加'}</a>
                </small>
            </shiro:hasPermission>
        </h1>
    </section>
    <sys:tip content="${message}"/>
    <section class="content">
        <div class="row">
            <div class="col-md-6">
                <form:form id="inputForm" modelAttribute="creditPointDetail" action="${ctx}/lgt/si/creditPointDetail/save" method="post" class="form-horizontal" onsubmit="return ZF.formSubmit();">
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
                                    <label class="col-sm-2 control-label">供应商ID</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="supplier.id" name="supplier.id" tip="请输入供应商ID" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">变动类型（增/减）</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="changeType" name="changeType" tip="请输入变动类型（增/减）" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">变动信誉分数量</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="changeCreditPoint" name="changeCreditPoint" tip="请输入变动信誉分数量" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">变动后信誉分</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="lastCreditPoint" name="lastCreditPoint" tip="请输入变动后信誉分" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">变动原因</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="changeReasonType" name="changeReasonType" tip="请输入变动原因" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">变动时间</label>
                                    <div class="col-sm-9">
                                        <sys:datetime id="changeTime" inputName="changeTime" tip="请选择变动时间" inputId="changeTimeId" isMandatory="true" value="${creditPointDetail.changeTime}"></sys:datetime>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">操作人类型（员工/系统）</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="operaterType" name="operaterType" tip="请输入操作人类型（员工/系统）" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">来源业务编号</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="operateSourceNo" name="operateSourceNo" tip="请输入来源业务编号" verifyType="0"  isSpring="true"></sys:inputverify>
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
                                <c:if test="${empty creditPointDetail.id}">
                                    <button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
                                </c:if>
                                <shiro:hasPermission name="lgt:si:creditPointDetail:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
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