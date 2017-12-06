<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>托盘管理管理</title>
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
            <small><i class="fa-list-style"></i><a href="${ctx}/bus/pm/plateManage/">托盘管理列表</a></small>
            <shiro:hasPermission name="bus:pm:plateManage:edit">
	            <small>|</small>
                <small class="menu-active">
                    <i class="fa fa-repeat"></i><a href="${ctx}/bus/pm/plateManage/form?id=${plateManage.id}">托盘管理${not empty plateManage.id?'修改':'添加'}</a>
                </small>
            </shiro:hasPermission>
        </h1>
    </section>
    <sys:tip content="${message}"/>
    <section class="content">
        <div class="row">
            <div class="col-md-6">
                <form:form id="inputForm" modelAttribute="plateManage" action="${ctx}/bus/pm/plateManage/save" method="post" class="form-horizontal" onsubmit="return ZF.formSubmit();">
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
                                    <label class="col-sm-2 control-label">托盘编号</label>
                                    <div class="col-sm-9">
                                        <c:choose>
                                            <c:when test="${empty plateManage.id}">
                                                <sys:inputverify id="plateNo" name="plateNo" tip="请输入托盘编号" verifyType="0"  isSpring="true"></sys:inputverify>
                                            </c:when>
                                            <c:otherwise>
                                                <form:input path="plateNo" class="form-control" disabled="true" />
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">托盘状态</label>
                                    <div class="col-sm-9">
                                        <c:choose>
                                            <c:when test="${empty plateManage.id}">
                                                <form:select path="plateStatus">
                                                    <form:option value="0">停用</form:option>
                                                    <form:option value="1">启用</form:option>
                                                </form:select>
                                            </c:when>
                                            <c:otherwise>
                                                <form:select path="plateStatus" disabled="true">
                                                    <form:option value="0">停用</form:option>
                                                    <form:option value="1">启用</form:option>
                                                </form:select>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">托盘使用情况</label>
                                    <div class="col-sm-9">
                                        <c:choose>
                                            <c:when test="${empty plateManage.id}">
                                                <form:select path="plateUsed">
                                                    <form:option value="0">空闲</form:option>
                                                    <form:option value="1">使用中</form:option>
                                                </form:select>
                                            </c:when>
                                            <c:otherwise>
                                                <form:select path="plateUsed" disabled="true">
                                                    <form:option value="0">空闲</form:option>
                                                    <form:option value="1">使用中</form:option>
                                                </form:select>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                                <div class="form-group">
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
                                <c:if test="${empty plateManage.id}">
                                    <button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
                                </c:if>
                                <shiro:hasPermission name="bus:pm:plateManage:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
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