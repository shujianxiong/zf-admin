<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>红包分享模板管理</title>
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
            <small><i class="fa-list-style"></i><a href="${ctx}/spm/sr/redpacketShareTemp/">红包分享模板列表</a></small>
            
            <shiro:hasPermission name="spm:sr:redpacketShareTemp:edit"><small>|</small><small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/spm/sr/redpacketShareTemp/form?id=${redpacketShareTemp.id}">红包分享模板${not empty redpacketShareTemp.id?'修改':'添加'}</a></small></shiro:hasPermission>
        </h1>
    </section>
    <sys:tip content="${message}"/>
    <section class="content">
        <div class="row">
            <div class="col-md-6">
                <form:form id="inputForm" modelAttribute="redpacketShareTemp" action="${ctx}/spm/sr/redpacketShareTemp/save" method="post" class="form-horizontal" onsubmit="return ZF.formSubmit();">
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
                                    <label class="col-sm-2 control-label">模板名称</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="name" name="name" tip="请输入模板名称" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">金额类型</label>
                                    <div class="col-sm-9">
                                        <sys:selectverify name="amountType" tip="请选择红包金额类型" verifyType="0" dictName="spm_sr_redpacket_amountType" id="amountType"></sys:selectverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">红包金额</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="amount" name="amount" tip="请输入红包金额" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">最大金额</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="maxAmount" name="maxAmount" tip="请输入红包最大金额" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">最小金额</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="minAmount" name="minAmount" tip="请输入红包最小金额" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">抢红包类型</label>
                                    <div class="col-sm-9">
                                        <sys:selectverify name="shareType" tip="请选择抢红包类型" verifyType="0" dictName="spm_sr_redpacket_shareType" id="shareType"></sys:selectverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">有效时间（天）</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="activeDays" name="activeDays" tip="请输入红包有效时间（天）" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">数量类型</label>
                                    <div class="col-sm-9">
                                        <sys:selectverify name="numType" tip="请选择红包数量类型" verifyType="0" dictName="spm_sr_redpacket_numType" id="numType"></sys:selectverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">数量</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="num" name="num" tip="请输入红包数量" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">最大数量</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="maxNum" name="maxNum" tip="请输入红包最大数量" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">最小数量</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="minNum" name="minNum" tip="请输入红包最小数量" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">使用状态</label>
                                    <div class="col-sm-9">
                                         <sys:selectverify name="tempStatus" tip="请选择模板使用状态" verifyType="0" dictName="spm_sr_tempStatus" id="tempStatus"></sys:selectverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">活动启用时间</label>
                                    <div class="col-sm-9">
                                        <sys:datetime id="redpacketStartTime" inputName="redpacketStartTime" tip="请选择活动启用时间，必选项" inputId="redpacketStartTimeId" isMandatory="true" value="${redpacketShareTemp.redpacketStartTime}"></sys:datetime>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">红包类型</label>
                                    <div class="col-sm-9">
                                        <sys:selectverify name="redpacketType" tip="请选择红包类型" verifyType="0" dictName="spm_sr_redpacket_redpacketType" id="redpacketType"></sys:selectverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">规则说明</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="ruleExplain" name="ruleExplain" tip="请输入规则说明" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">活动说明</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="activeExplain" name="activeExplain" tip="请输入活动说明" verifyType="0"  isSpring="true"></sys:inputverify>
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
                                <c:if test="${empty redpacketShareTemp.id}">
                                    <button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
                                </c:if>
                                <shiro:hasPermission name="spm:sr:redpacketShareTemp:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
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