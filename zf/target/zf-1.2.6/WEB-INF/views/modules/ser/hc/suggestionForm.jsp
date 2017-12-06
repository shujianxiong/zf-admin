<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>帮助中心建议管理</title>
    <meta name="decorator" content="adminLte"/>
    <script type="text/javascript">
        $(document).ready(function() {
            
            $('input').iCheck({
                checkboxClass : 'icheckbox_minimal-blue',
                radioClass : 'iradio_minimal-blue'
            });
            
            $("#officeName").on("click", function() {
                selectOfficeinit({
                    "selectCallBack" : function(list) {
                        $("#officeId").val(list[0].id);
                        $("#officeName").val(list[0].text);
                    }
                })
            });
            
            $("#areaName").on("click", function() {
                selectAreainit({
                    "selectCallBack" : function(list) {
                        $("#areaId").val(list[0].id);
                        $("#areaName").val(list[0].text);
                    }
                })
            });
            
            $("#userName").on("click", function() {
                selectUserinit({
                    "selectCallBack" : function(list) {
                        $("#userId").val(list[0].id);
                        $("#userName").val(list[0].text);
                    }
                })
            });
            
            
        });
    </script>
</head>
<body>
    <div class="content-wrapper sub-content-wrapper">
    <section class="content-header content-header-menu">
        <h1>
            <small><i class="fa-list-style"></i><a href="${ctx}/ser/hc/suggestion/">帮助中心建议列表</a></small>
            <shiro:hasPermission name="ser:hc:suggestion:edit">
	            <small>|</small>
                <small class="menu-active">
                    <i class="fa fa-repeat"></i><a href="${ctx}/ser/hc/suggestion/form?id=${suggestion.id}">帮助中心建议${not empty suggestion.id?'修改':'添加'}</a>
                </small>
            </shiro:hasPermission>
        </h1>
    </section>
    <sys:tip content="${message}"/>
    <section class="content">
        <div class="row">
            <div class="col-md-6">
                <form:form id="inputForm" modelAttribute="suggestion" action="${ctx}/ser/hc/suggestion/save" method="post" class="form-horizontal" onsubmit="return ZF.formSubmit();">
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
                                    <label for="musercode" class="col-sm-2 control-label">会员账号</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="musercode" name="member.usercode" value="${fns:getMemberById(suggestion.member.id).usercode}" tip="请输入会员账号，必填项" verifyType="99" isMandatory="true" isSpring="false" maxlength="20"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">内容</label>
                                    <div class="col-sm-9">
                                        <form:textarea path="content" htmlEscape="false" rows="4" maxlength="200" class="form-control"/>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">图片<span data-toggle="tooltip" title="" class="badge bg-light-blue" data-original-title="适用于:帮助中心">?</span></label>
                                    <div class="col-sm-8">
                                        <form:hidden id="photoUrls" path="photoUrls" htmlEscape="false" maxlength="255" class="form-control"/>
                                        <sys:fileUpload input="photoUrls" model="true" selectMultiple="true"></sys:fileUpload>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">联系电话</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="tel" name="tel" tip="请输入联系电话" verifyType="99"  isMandatory="false" isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">处理状态</label>
                                    <div class="col-sm-9">
                                        <sys:selectverify name="dealStatus" tip="请选择处理状态" verifyType="99" isMandatory="false" dictName="ser_hc_suggestion_dealStatus" id="dealStatus"></sys:selectverify>
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
                                <c:if test="${empty suggestion.id}">
                                    <button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
                                </c:if>
                                <shiro:hasPermission name="ser:hc:suggestion:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
                            </div>
                        </div>
                    </div>
                </form:form>
            </div>
        </div>
        
        <sys:userselect height="550" url="${ctx}/sys/office/treeData"
            width="550" isOffice="true" isMulti="false" title="机构选择"
            id="selectOffice" dataType="Office"></sys:userselect>
            
        <sys:userselect height="550" url="${ctx}/sys/area/treeData"
            width="550" isOffice="true" isMulti="false" title="区域选择"
            id="selectArea"></sys:userselect>
            
        <sys:userselect height="550" url="${ctx}/sys/office/userTreeData"
            width="550" isOffice="false" isMulti="false" title="人员选择"
            id="selectUser" ></sys:userselect>
        
    </section>
    </div>
    
</body>
</html>