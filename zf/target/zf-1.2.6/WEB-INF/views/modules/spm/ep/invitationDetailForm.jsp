<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>邀请人记录管理</title>
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
            <small><i class="fa-list-style"></i><a href="${ctx}/spm/ep/invitationDetail/">邀请人记录列表</a></small>
            <shiro:hasPermission name="spm:ep:invitationDetail:edit">
	            <small>|</small>
                <small class="menu-active">
                    <i class="fa fa-repeat"></i><a href="${ctx}/spm/ep/invitationDetail/form?id=${invitationDetail.id}">邀请人记录${not empty invitationDetail.id?'修改':'添加'}</a>
                </small>
            </shiro:hasPermission>
        </h1>
    </section>
    <sys:tip content="${message}"/>
    <section class="content">
        <div class="row">
            <div class="col-md-6">
                <form:form id="inputForm" modelAttribute="invitationDetail" action="${ctx}/spm/ep/invitationDetail/save" method="post" class="form-horizontal" onsubmit="return ZF.formSubmit();">
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
                                    <label class="col-sm-2 control-label">会员ID</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="member.id" name="member.id" tip="请输入会员ID" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">被邀请人openid</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="invitederOpenid" name="invitederOpenid" tip="请输入被邀请人openid" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                            
                        </div>
                        <div class="box-footer">
                            <div class="pull-left box-tools">
                                <button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
                            </div>
                            <div class="pull-right box-tools">
                                <c:if test="${empty invitationDetail.id}">
                                    <button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
                                </c:if>
                                <shiro:hasPermission name="spm:ep:invitationDetail:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
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