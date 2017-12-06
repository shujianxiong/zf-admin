<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>活动表管理</title>
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
            <small><i class="fa-list-style"></i><a href="${ctx}/spm/ai/activity/">活动表列表</a></small>
            <shiro:hasPermission name="spm:ai:activity:edit">
	            <small>|</small>
                <small class="menu-active">
                    <i class="fa fa-repeat"></i><a href="${ctx}/spm/ai/activity/form?id=${activity.id}">活动表${not empty activity.id?'修改':'添加'}</a>
                </small>
            </shiro:hasPermission>
        </h1>
    </section>
    <sys:tip content="${message}"/>
    <section class="content">
        <div class="row">
            <div class="col-md-6">
                <form:form id="inputForm" modelAttribute="activity" action="${ctx}/spm/ai/activity/save" method="post" class="form-horizontal" onsubmit="return ZF.formSubmit();">
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
                                    <label class="col-sm-2 control-label">编码</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="code" name="code" tip="请输入编码" verifyType="0" maxlength="20" isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">名称</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="name" name="name" tip="请输入名称" verifyType="0" maxlength="20" isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">类型</label>
                                    <div class="col-sm-9">
                                        <sys:selectverify id="type" name="type" dictName="spm_ai_activity_type" verifyType="0" tip="请选择展示类型"></sys:selectverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">标题</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="title" name="title" tip="请输入标题" verifyType="0" maxlength="50" isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">副标题</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="subtitle" name="subtitle" tip="请输入副标题" verifyType="0" maxlength="80" isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">简介</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="summary" name="summary" tip="请输入简介" verifyType="0" maxlength="255"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">展示图</label>
                                    <div class="col-sm-9">
                                        <form:hidden id="displayPhoto" path="displayPhoto" htmlEscape="false" maxlength="255" class="form-control"/>
                                        <sys:fileUpload input="displayPhoto" model="true" selectMultiple="false"></sys:fileUpload>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">展示类型</label>
                                    <div class="col-sm-9">
                                        <sys:selectverify id="displayType" name="displayType" dictName="spm_ai_activity_displayType" verifyType="0" tip="请选择展示类型"></sys:selectverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">介绍</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="introduce" name="introduce" tip="请输入介绍" verifyType="0" maxlength="255" isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">规则详情</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="ruleDetail" name="ruleDetail" tip="请输入规则详情" verifyType="0" maxlength="1000" isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">人数上限</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="maxNum" name="maxNum" tip="请输入人数上限，正整数" verifyType="4"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">起始时间</label>
                                    <div class="col-sm-9">
                                        <sys:datetime id="startTime" inputName="startTime" tip="请选择起始时间" inputId="startTimeId" isMandatory="true" value="${activity.startTime}"></sys:datetime>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">结束时间</label>
                                    <div class="col-sm-9">
                                        <sys:datetime id="endTime" inputName="endTime" tip="请选择结束时间" inputId="endTimeId" isMandatory="true" value="${activity.endTime}"></sys:datetime>
                                    </div>
                                </div>
                                <%--<div class="form-group    ">--%>
                                    <%--<label class="col-sm-2 control-label">启用状态</label>--%>
                                    <%--<div class="col-sm-9">--%>
                                        <%--<sys:inputverify id="activeFlag" name="activeFlag" tip="请输入启用状态" verifyType="0"  isSpring="true"></sys:inputverify>--%>
                                    <%--</div>--%>
                                <%--</div>--%>
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
                                <c:if test="${empty activity.id}">
                                    <button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
                                </c:if>
                                <shiro:hasPermission name="spm:ai:activity:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
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