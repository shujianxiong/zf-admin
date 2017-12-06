<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>邀请注册模板管理</title>
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
            <small><i class="fa-list-style"></i><a href="${ctx}/spm/sr/registerShareTemp/">邀请注册模板列表</a></small>
            
            <shiro:hasPermission name="spm:sr:registerShareTemp:edit"><small>|</small><small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/spm/sr/registerShareTemp/form?id=${registerShareTemp.id}">邀请注册模板${not empty registerShareTemp.id?'修改':'添加'}</a></small></shiro:hasPermission>
        </h1>
    </section>
    <sys:tip content="${message}"/>
    <section class="content">
        <div class="row">
            <div class="col-md-6">
                <form:form id="inputForm" modelAttribute="registerShareTemp" action="${ctx}/spm/sr/registerShareTemp/save" method="post" class="form-horizontal" onsubmit="return ZF.formSubmit();">
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
                                    <label class="col-sm-2 control-label">使用状态</label>
                                    <div class="col-sm-9">
                                        <sys:selectverify name="tempStatus" tip="请选择使用状态" verifyType="0" dictName="spm_sr_tempStatus" id="tempStatus"></sys:selectverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">奖励金额</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="rewardAmount" name="rewardAmount" tip="请输入奖励金额" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">启用时间</label>
                                    <div class="col-sm-9">
                                        <sys:datetime id="activeStartTime" inputName="activeStartTime" tip="请选择活动启用时间，必选项" inputId="activeStartTimeId" isMandatory="true" value="${registerShareTemp.activeStartTime}"></sys:datetime>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">有效时间（天）</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="activeDays" name="activeDays" tip="请输入有效时间（天）" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">奖励类型</label>
                                    <div class="col-sm-9">
                                        <sys:selectverify name="rewardType" tip="请选择奖励类型" verifyType="0" dictName="spm_sr_register_rewardType" id="rewardType"></sys:selectverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">分享URL</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="shareUrl" name="shareUrl" tip="请输入分享URL" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">分享标题</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="shareTitle" name="shareTitle" tip="请输入分享标题" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">分享简介</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="shareSummary" name="shareSummary" tip="请输入分享简介" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">分享ICON</label>
                                    <div class="col-sm-9">
                                        <form:hidden id="shareIcon" path="shareIcon" htmlEscape="false" maxlength="255" class="form-control"/>
                                        <sys:fileUpload input="shareIcon" model="true" selectMultiple="false"></sys:fileUpload>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">分享广告图</label>
                                    <div class="col-sm-9">
                                        <form:hidden id="sharePhoto" path="sharePhoto" htmlEscape="false" maxlength="255" class="form-control"/>
                                        <sys:fileUpload input="sharePhoto" model="true" selectMultiple="false"></sys:fileUpload>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">分享背景色</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="shareColor" name="shareColor" tip="请输入分享背景色" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">规则说明</label>
                                    <div class="col-sm-9">
                                        <form:textarea path="ruleExplain" htmlEscape="false" rows="4" maxlength="200" class="form-control"/>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">活动说明</label>
                                    <div class="col-sm-9">
                                        <form:textarea path="activeExplain" htmlEscape="false" rows="4" maxlength="200" class="form-control"/>
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
                                <c:if test="${empty registerShareTemp.id}">
                                    <button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
                                </c:if>
                                <shiro:hasPermission name="spm:sr:registerShareTemp:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
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