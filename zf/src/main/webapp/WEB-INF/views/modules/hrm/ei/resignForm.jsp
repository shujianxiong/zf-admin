<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>员工离职管理</title>
    <meta name="decorator" content="adminLte"/>
    <script type="text/javascript">
        $(document).ready(function() {
            
            $('input').iCheck({
                checkboxClass : 'icheckbox_minimal-blue',
                radioClass : 'iradio_minimal-blue'
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
			<small><i class="fa-list-style"></i><a
				href="${ctx}/hrm/ei/resign/">员工离职列表</a></small>
			<shiro:hasPermission name="hrm:ei:resign:edit">
				<small>|</small>
				<small class="menu-active"><i class="fa fa-repeat"></i><a
					href="${ctx}/hrm/ei/resign/form?id=${resign.id}">员工离职${not empty resign.id?'修改':'添加'}</a></small>
			</shiro:hasPermission>
		</h1>
	</section>
	<sys:tip content="${message}"/>
    <section class="content">
        <div class="row">
            <div class="col-md-6">
                <form:form id="inputForm" modelAttribute="resign" action="${ctx}/hrm/ei/resign/save" method="post" class="form-horizontal" onsubmit="return ZF.formSubmit();">
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
                                    <label class="col-sm-2 control-label">员工</label>
                                    <div class="col-sm-9">
                                        <form:hidden id="userId" path="employee.user.id" />
                                        <form:input id="userName" path="employee.user.name" htmlEscape="false" 
                                            maxlength="100" class="form-control zf-input-readonly"
                                            placeholder="选择员工" readonly="true"/>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">离职申请日期</label>
                                    <div class="col-sm-9">
                                        <sys:datetime id="applyDate" inputName="applyDate" tip="请选择离职申请日期，必选项" inputId="applyDateId" isMandatory="true" value="${resign.applyDate}"></sys:datetime>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">离职状态</label>
                                    <div class="col-sm-9">
                                        <form:select path="status" class="form-control">
                                            <form:option value="" label="请选择"/>
                                            <form:options items="${fns:getDictList('hrm_ei_resign_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                                        </form:select>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">离职原因</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="reason" name="reason" tip="请输入离职原因" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">主管领导审批意见</label>
                                    <div class="col-sm-9">
                                        <form:textarea path="approvalMsgZg" htmlEscape="false" rows="4" maxlength="200" class="form-control"/>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">部门领导审批意见</label>
                                    <div class="col-sm-9">
                                        <form:textarea path="approvalMsgBm" htmlEscape="false" rows="4" maxlength="200" class="form-control"/>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">总经理审批意见</label>
                                    <div class="col-sm-9">
                                        <form:textarea path="approvalMsgZjl" htmlEscape="false" rows="4" maxlength="200" class="form-control"/>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">董事长审批意见</label>
                                    <div class="col-sm-9">
                                        <form:textarea path="approvalMsgDsz" htmlEscape="false" rows="4" maxlength="200" class="form-control"/>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">正式离职日期</label>
                                    <div class="col-sm-9">
                                        <sys:datetime id="resignDate" inputName="resignDate" tip="请选择正式离职日期，必选项" inputId="resignDateId" isMandatory="true" value="${resign.resignDate}"></sys:datetime>
                                    </div>
                                </div>
                                <div class="form-group   zf-check-wrapper-padding ">
                                    <label class="col-sm-2 control-label">工作交接状态</label>
                                    <div class="col-sm-9">
                                        <form:radiobuttons path="workRelayStatus" items="${fns:getDictList('hrm_ei_resign_workRelay_status')}" itemLabel="label" itemValue="value" htmlEscape="false" class=""/>
                                    </div>
                                </div>
                                <div class="form-group   zf-check-wrapper-padding ">
                                    <label class="col-sm-2 control-label">办公用品交接状态</label>
                                    <div class="col-sm-9">
                                        <form:radiobuttons path="suppliesRelayStatus" items="${fns:getDictList('hrm_ei_resign_suppliesRelay_status')}" itemLabel="label" itemValue="value" htmlEscape="false" class=""/>
                                    </div>
                                </div>
                                <div class="form-group   zf-check-wrapper-padding ">
                                    <label class="col-sm-2 control-label">薪资结算状态</label>
                                    <div class="col-sm-9">
                                        <form:radiobuttons path="salaryPayStatus" items="${fns:getDictList('hrm_ei_resign_salaryPay_status')}" itemLabel="label" itemValue="value" htmlEscape="false" class=""/>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">离职文件URL1</label>
                                    <div class="col-sm-9">
                                   		<form:hidden id="resignFileUrl1" path="resignFileUrl1" htmlEscape="false" maxlength="255" class="form-control"/>
                                        <sys:fileUpload input="resignFileUrl1" model="false" fileDirCode="lzwj" selectMultiple="false"></sys:fileUpload>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">离职文件URL2</label>
                                    <div class="col-sm-9">
                                    	<form:hidden id="resignFileUrl2" path="resignFileUrl2" htmlEscape="false" maxlength="255" class="form-control"/>
                                        <sys:fileUpload input="resignFileUrl2" model="false" fileDirCode="lzwj" selectMultiple="false"></sys:fileUpload>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">离职文件URL3</label>
                                    <div class="col-sm-9">
                                    	<form:hidden id="resignFileUrl3" path="resignFileUrl3" htmlEscape="false" maxlength="255" class="form-control"/>
                                        <sys:fileUpload input="resignFileUrl3" model="false" fileDirCode="lzwj" selectMultiple="false"></sys:fileUpload>
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
                                <c:if test="${empty resign.id}">
                                    <button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
                                </c:if>
                                <shiro:hasPermission name="hrm:ei:resign:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
                            </div>
                        </div>
                    </div>
                </form:form>
            </div>
        </div>
            
        <sys:userselect height="550" url="${ctx}/sys/office/userTreeData"
            width="550" isOffice="false" isMulti="false" title="人员选择"
            id="selectUser" ></sys:userselect>
        
    </section>
    </div>
    
</body>
</html>