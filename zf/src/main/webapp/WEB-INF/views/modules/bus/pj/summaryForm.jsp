<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>评价摘要管理</title>
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
            <small><i class="fa-list-style"></i><a href="${ctx}/bus/pj/summary/">评价摘要列表</a></small>
            <shiro:hasPermission name="bus:pj:summary:edit">
	            <small>|</small>
                <small class="menu-active">
                    <i class="fa fa-repeat"></i><a href="${ctx}/bus/pj/summary/form?id=${summary.id}">评价摘要${not empty summary.id?'修改':'添加'}</a>
                </small>
            </shiro:hasPermission>
        </h1>
    </section>
    <sys:tip content="${message}"/>
    <section class="content">
        <div class="row">
            <div class="col-md-6">
                <form:form id="inputForm" modelAttribute="summary" action="${ctx}/bus/pj/summary/save" method="post" class="form-horizontal" onsubmit="return ZF.formSubmit();">
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
                                    <label class="col-sm-2 control-label">类型</label>
                                    <div class="col-sm-9">
                                        <c:choose>
                                            <c:when test="${empty summary.id }">
                                                 <sys:selectverify name="type" tip="请选择类型,必选项" verifyType="0" dictName="bus_pj_summary_type" id="type"></sys:selectverify>
                                            </c:when>
                                            <c:otherwise>
		                                        <input type="hidden" name="type" value="${summary.type }"/>
		                                        <sys:selectverify name="type" tip="请选择类型,必选项" verifyType="0" dictName="bus_pj_summary_type" id="type" disabled="true"></sys:selectverify>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">所属等级</label>
                                    <div class="col-sm-9">
                                        <c:choose>
                                            <c:when test="${empty summary.id }">
                                                 <sys:selectverify name="level" tip="请选择所属等级,必选项" verifyType="0" dictName="bus_pj_produce_judge_level" id="level"></sys:selectverify>
                                            </c:when>
                                            <c:otherwise>
                                                <input type="hidden" name="level" value="${summary.level }"/>
                                                <sys:selectverify name="level" tip="请选择所属等级,必选项" verifyType="0" dictName="bus_pj_produce_judge_level" id="level" disabled="true"></sys:selectverify>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">名称</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="name" name="name" tip="请输入名称,非特殊字符,必填项" verifyType="0"  maxlength="50" isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">启用状态</label>
                                    <div class="col-sm-9">
                                        <sys:selectverify name="activeFlag" tip="请选择启用状态,必选项" verifyType="0" dictName="yes_no" id="activeFlag"></sys:selectverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">排序</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="orderNo" name="orderNo" tip="请输入排序,非零整数,必填项" verifyType="4" maxlength="6"  isSpring="true"></sys:inputverify>
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
                                <c:if test="${empty summary.id}">
                                    <button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
                                </c:if>
                                <shiro:hasPermission name="bus:pj:summary:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
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