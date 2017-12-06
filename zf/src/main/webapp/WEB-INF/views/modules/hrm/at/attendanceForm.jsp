<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>考勤管理</title>
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
				href="${ctx}/hrm/at/attendance/">考勤列表</a></small>
			<shiro:hasPermission name="hrm:at:attendance:edit">
				<small>|</small>
				<small class="menu-active"><i class="fa fa-repeat"></i><a
					href="${ctx}/hrm/at/attendance/form?id=${attendance.id}">考勤${not empty attendance.id?'修改':'添加'}</a></small>
			</shiro:hasPermission>
		</h1>
	</section>
	<sys:tip content="${message}"/>
    <section class="content">
        <div class="row">
            <div class="col-md-6">
                <form:form id="inputForm" modelAttribute="attendance" action="${ctx}/hrm/at/attendance/save" method="post" class="form-horizontal" onsubmit="return ZF.formSubmit();">
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
                                        <c:choose>
                                            <c:when test="${empty attendance.id }">
                                                <form:hidden id="userId" path="sysUser.id" />
                                                <form:input id="userName" path="sysUser.name" htmlEscape="false"  maxlength="100" class="form-control zf-input-readonly"
                                                            placeholder="选择员工" readonly="true"/>
                                            </c:when>
                                            <c:otherwise>
                                                <form:hidden path="sysUser.id"/>
                                                <form:input path="sysUser.name" readonly="true" class="form-control zf-input-readonly"/>
                                            </c:otherwise>
                                        </c:choose>
                                        
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">考勤日期</label>
                                    <div class="col-sm-9">
                                        <sys:datetime id="attendanceDate" inputName="attendanceDate" tip="请选择考勤日期，必选项" inputId="attendanceDateId" isMandatory="true" value="${attendance.attendanceDate}"></sys:datetime>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">考勤类型</label>
                                    <div class="col-sm-9">
                                        <sys:selectverify name="attendanceType" tip="请选择考勤类型" verifyType="0" dictName="hrm_at_attendance_type" id="attendanceType"></sys:selectverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">考勤时间</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="attendanceTime" name="attendanceTime" tip="请输入考勤时间" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">考勤结果</label>
                                    <div class="col-sm-9">
                                        <sys:selectverify name="result" tip="请选择考勤结果" verifyType="0" dictName="hrm_at_attendance_result_type" id="result"></sys:selectverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">数据来源类型</label>
                                    <div class="col-sm-9">
                                        <sys:selectverify name="sourceType" tip="请选择数据来源类型" verifyType="0" dictName="hrm_at_attendance_source_type" id="sourceType"></sys:selectverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">数据来源详情</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="sourceDetail" name="sourceDetail" tip="请输入数据来源详情" verifyType="0"  isSpring="true"></sys:inputverify>
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
                                <c:if test="${empty attendance.id}">
                                    <button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
                                </c:if>
                                <shiro:hasPermission name="hrm:at:attendance:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
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