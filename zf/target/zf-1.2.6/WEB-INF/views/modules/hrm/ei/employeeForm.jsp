<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>员工入职管理</title>
    <meta name="decorator" content="adminLte"/>
    <script type="text/javascript">
        $(document).ready(function() {
            
            $('input').iCheck({
                checkboxClass : 'icheckbox_minimal-blue',
                radioClass : 'iradio_minimal-blue'
            });
            
            $("#liveAreaName").on("click", function() {
                selectAreainit({
                    "selectCallBack" : function(list) {
                        $("#liveAreaId").val(list[0].id);
                        $("#liveAreaName").val(list[0].text);
                    }
                })
            });
            
            $("#householdAddrName").on("click", function() {
                selectAreainit({
                    "selectCallBack" : function(list) {
                        $("#householdAddrId").val(list[0].id);
                        $("#householdAddrName").val(list[0].text);
                    }
                })
            });
            
            $("#insuranceAddrName").on("click", function() {
                selectAreainit({
                    "selectCallBack" : function(list) {
                        $("#insuranceAddrId").val(list[0].id);
                        $("#insuranceAddrName").val(list[0].text);
                    }
                })
            });
            
            $("#cpfAddrName").on("click", function() {
                selectAreainit({
                    "selectCallBack" : function(list) {
                        $("#cpfAddrId").val(list[0].id);
                        $("#cpfAddrName").val(list[0].text);
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
			<small><i class="fa-list-style"></i><a
				href="${ctx}/hrm/ei/employee/">员工入职列表</a></small>
			<shiro:hasPermission name="hrm:ei:employee:edit">
				<small>|</small>
				<small class="menu-active"><i class="fa fa-repeat"></i><a
					href="${ctx}/hrm/ei/employee/form?id=${employee.id}">员工入职${not empty employee.id?'修改':'添加'}</a></small>
			</shiro:hasPermission>
		</h1>
	</section>
	<sys:tip content="${message}"/>
    <section class="content">
        <div class="row">
            <div class="col-md-6">
                <form:form id="inputForm" modelAttribute="employee" action="${ctx}/hrm/ei/employee/save" method="post" class="form-horizontal" onsubmit="return ZF.formSubmit();">
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
                                    <label class="col-sm-2 control-label">用户</label>
                                    <div class="col-sm-9">
                                        <form:hidden id="userId" path="user.id" />
                                        <form:input id="userName" path="user.name" htmlEscape="false" 
                                            maxlength="100" class="form-control zf-input-readonly"
                                            placeholder="选择用户" readonly="true"/>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">民族</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="nation" name="nation" tip="请输入民族" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">政治面貌</label>
                                    <div class="col-sm-9">
                                        <sys:selectverify name="politicalStatus" tip="请选择政治面貌" verifyType="0" dictName="sys_user_info_politicalStatus" id="politicalStatus"></sys:selectverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">婚姻状况</label>
                                    <div class="col-sm-9">
                                        <sys:selectverify name="marriageStatus" tip="请选择婚姻状况" verifyType="0" dictName="sys_user_info_marriageStatus" id="marriageStatus"></sys:selectverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">身份证号码</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="idCard1" name="idCard1" tip="请输入身份证号码" verifyType="2"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">性别</label>
                                    <div class="col-sm-9">
                                        <sys:selectverify name="sex" tip="请选择性别" verifyType="0" dictName="sex" id="sex" ></sys:selectverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">出生月日</label>
                                    <div class="col-sm-9">
                                        <sys:datetime id="bornDate"  inputName="bornDate" value="${employee.bornDate}" format="YYYY-MM-DD" inputId="bornDate" tip="请输入出生月日"></sys:datetime>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">生日</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="birthday" name="birthday"  tip="请输入生日" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">年龄</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="age" name="age" tip="请输入年龄"  verifyType="4" maxlength="3"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">现居住地</label>
                                    <div class="col-sm-9">
                                        <form:hidden id="liveAreaId" path="liveArea.id" />
                                        <form:input id="liveAreaName" path="liveArea.name" htmlEscape="false" maxlength="100" class="form-control" placeholder="选择现居住地" />
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">现居住地详情</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="liveAreaDetail" name="liveAreaDetail" tip="请输入现居住地详情" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">户口性质</label>
                                    <div class="col-sm-9">
                                        <sys:selectverify name="householdType" tip="请选择户口性质" verifyType="0" dictName="sys_user_info_householdType" id="householdType"></sys:selectverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">户口所在地</label>
                                    <div class="col-sm-9">
                                        <form:hidden id="householdAddrId" path="householdAddr.id" />
                                        <form:input id="householdAddrName" path="householdAddr.name" htmlEscape="false" maxlength="100" class="form-control" placeholder="选择户口所在地" />
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">毕业院校</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="graduateCollege" name="graduateCollege" tip="请输入毕业院校" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">专业</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="professional" name="professional" tip="请输入专业" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">学历</label>
                                    <div class="col-sm-9">
                                        <sys:selectverify name="degree" tip="请选择学历" verifyType="0" dictName="hrm_ei_employee_degree" id="degree"></sys:selectverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">入职时间</label>
                                    <div class="col-sm-9">
                                        <sys:datetime id="employedDate" inputName="employedDate" tip="请选择入职时间，必选项" inputId="employedDateId" isMandatory="true" value="${employee.employedDate}"></sys:datetime>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">入职文件URL1</label>
                                    <div class="col-sm-9">
                                        <form:hidden id="employedFileUrl1" path="employedFileUrl1" htmlEscape="false" maxlength="255" class="form-control"/>
                						<sys:fileUpload input="employedFileUrl1" model="false" fileDirCode="rzwj" selectMultiple="false"></sys:fileUpload>
				
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">入职文件URL2</label>
                                    <div class="col-sm-9">
                                        <form:hidden id="employedFileUrl2" path="employedFileUrl2" htmlEscape="false" maxlength="255" class="form-control"/>
                						<sys:fileUpload input="employedFileUrl2" model="false" fileDirCode="rzwj" selectMultiple="false"></sys:fileUpload>
				
                                        
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">入职文件URL3</label>
                                    <div class="col-sm-9">
                                        <form:hidden id="employedFileUrl3" path="employedFileUrl3" htmlEscape="false" maxlength="255" class="form-control"/>
                						<sys:fileUpload input="employedFileUrl3" model="false" fileDirCode="rzwj" selectMultiple="false"></sys:fileUpload>
				
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">合同起始时间</label>
                                    <div class="col-sm-9">
                                        <sys:datetime id="contractStartDate" inputName="contractStartDate" tip="请选择合同起始时间，必选项" inputId="contractStartDateId" isMandatory="true" value="${employee.contractStartDate}"></sys:datetime>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">试用期到期时间</label>
                                    <div class="col-sm-9">
                                        <sys:datetime id="probationDueDate" inputName="probationDueDate" tip="请选择试用期到期时间，必选项" inputId="probationDueDateId" isMandatory="true" value="${employee.probationDueDate}"></sys:datetime>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">合同到期时间(提前20天提醒)</label>
                                    <div class="col-sm-9">
                                        <sys:datetime id="contractDueDate" inputName="contractDueDate" tip="请选择合同到期时间(提前20天提醒)，必选项" inputId="contractDueDateId" isMandatory="true" value="${employee.contractDueDate}"></sys:datetime>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">工龄</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="workAge" name="workAge" tip="请输入工龄" maxlength="3" verifyType="4"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">办公地</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="officeAddr" name="officeAddr" tip="请输入办公地" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">保险日期</label>
                                    <div class="col-sm-9">
                                        <sys:datetime id="insuranceDate" inputName="insuranceDate" tip="请选择保险日期，必选项" inputId="insuranceDateId" isMandatory="true" value="${employee.insuranceDate}"></sys:datetime>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">保险地点</label>
                                    <div class="col-sm-9">
                                        <form:hidden id="insuranceAddrId" path="insuranceAddr.id" />
                                        <form:input id="insuranceAddrName" path="insuranceAddr.name" htmlEscape="false" maxlength="100" class="form-control" placeholder="选择保险地点" />
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">公积金日期</label>
                                    <div class="col-sm-9">
                                        <sys:datetime id="cpfDate" inputName="cpfDate" tip="请选择公积金日期，必选项" inputId="cpfDateId" isMandatory="true" value="${employee.cpfDate}"></sys:datetime>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">公积金地点</label>
                                    <div class="col-sm-9">
                                         <form:hidden id="cpfAddrId" path="cpfAddr.id" />
                                        <form:input id="cpfAddrName" path="cpfAddr.name" htmlEscape="false" maxlength="100" class="form-control" placeholder="选择公积金地点" />
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
                                <c:if test="${empty employee.id}">
                                    <button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
                                </c:if>
                                <shiro:hasPermission name="hrm:ei:employee:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
                            </div>
                        </div>
                    </div>
                </form:form>
            </div>
        </div>
        
            
        <sys:userselect height="550" url="${ctx}/sys/area/treeData"
            width="550" isOffice="true" isMulti="false" title="区域选择"
            id="selectArea"></sys:userselect>
            
    </section>
    </div>
    
</body>
</html>