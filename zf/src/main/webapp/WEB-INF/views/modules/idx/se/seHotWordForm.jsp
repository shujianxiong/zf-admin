<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>搜索热词管理</title>
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
            <small><i class="fa-list-style"></i><a href="${ctx}/idx/se/seHotWord/">搜索热词列表</a></small>
            <shiro:hasPermission name="idx:se:seHotWord:edit"><small>|</small><small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/idx/se/seHotWord/form?id=${seHotWord.id}">搜索热词${not empty seHotWord.id?'修改':'添加'}</a></small></shiro:hasPermission>
        </h1>
    </section>
    <sys:tip content="${message}"/>
    <section class="content">
        <div class="row">
            <div class="col-md-6">
                <form:form id="inputForm" modelAttribute="seHotWord" action="${ctx}/idx/se/seHotWord/save" method="post" class="form-horizontal" onsubmit="return ZF.formSubmit();">
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
                                    <label class="col-sm-2 control-label">热词名称</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="name" name="name" tip="请输入热词名称" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">热词类型</label>
                                    <div class="col-sm-9">
                                        <sys:selectverify name="type" tip="请选择热词类型" verifyType="0" dictName="idx_se_hot_word_type" id="type"></sys:selectverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">关联关键词</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="relateKeywords" name="relateKeywords" tip="请输入关联关键词，多个关键词之间用,分割" verifyType="99"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">排列序号</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="orderNo" name="orderNo" maxlength="8" tip="请输入正确的序号,整数，必填项" verifyType="4"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">点击量</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="clickNum" name="clickNum" tip="请输入点击量" verifyType="4" maxlength="10"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">是否启用</label>
                                    <div class="col-sm-9">
                                        <sys:selectverify name="usableFlag" tip="请选择是否启用" verifyType="0" dictName="yes_no" id="usableFlag"></sys:selectverify>
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
                                <c:if test="${empty seHotWord.id}">
                                    <button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
                                </c:if>
                                <shiro:hasPermission name="idx:se:seHotWord:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
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