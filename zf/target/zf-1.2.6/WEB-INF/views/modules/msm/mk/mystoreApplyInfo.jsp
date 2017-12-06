<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>个人微店申请管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/msm/mk/mystoreApply/">个人微店申请列表</a></li>
		<li class="active"><a href="${ctx}/msm/mk/mystoreApply/form?id=${mystoreApply.id}">个人微店申请查看</a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="mystoreApply" action="${ctx}/msm/mk/mystoreApply/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<legend>会员基本信息详情</legend>
		<fieldset>
			<table class="table-form">
				<tr>
					<td class="tit">会员账号：</td><td>
						<form:input path="applyMember.usercode" htmlEscape="false" maxlength="64" class="input-xlarge " readonly="true"/>
					</td>
					<td class="tit">真实姓名：</td><td>
						<form:input path="mystoreKeeper.name" htmlEscape="false" maxlength="64" class="input-xlarge " readonly="true"/>
					</td>
					<td class="tit">性别：</td><td>
						<form:input path="mystoreKeeper.sex" htmlEscape="false" maxlength="64" class="input-xlarge " readonly="true"/>
					</td>
				</tr>
				<tr>
					<td class="tit">年龄：</td><td>
						<form:input path="mystoreKeeper.age" htmlEscape="false" maxlength="64" class="input-xlarge " readonly="true"/>
					</td>
					<td class="tit">联系电话：</td><td>
						<form:input path="mystoreKeeper.tel" htmlEscape="false" maxlength="64" class="input-xlarge " readonly="true"/>
					</td>
					<td class="tit">备用联系电话：</td><td>
						<form:input path="mystoreKeeper.reserveTel" htmlEscape="false" maxlength="64" class="input-xlarge " readonly="true"/>
					</td>
				</tr>
				<tr>
					<td class="tit">家庭住址编号：</td><td>
							<sys:treeselect id="mystoreKeeper.addressArea" name="mystoreKeeper.addressArea.id" value="${mystoreApply.mystoreKeeper.addressArea.id}" labelName="" labelValue="${fns:getAreaById(mystoreApply.mystoreKeeper.addressArea.id).name}"
								title="区域" url="/sys/area/treeData" cssClass="" allowClear="true" notAllowSelectParent="true"/>
					</td>
					<td class="tit">家庭住址详情：</td><td>
						<form:input path="mystoreKeeper.addressAreaDetail" htmlEscape="false" maxlength="64" class="input-xlarge " readonly="true"/>
					</td>
				</tr>
			</table>
		</fieldset>
		
		<legend>系统审核详情</legend>
		<div class="control-group">
			<label class="control-label">申请时间：</label>
			<div class="controls">
				<input name="applyTime" type="text" disabled="disabled" maxlength="20" class="input-medium Wdate required"
					value="<fmt:formatDate value="${mystoreApply.applyTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">申请状态：</label>
			<div class="controls">
				<form:select path="status" class="input-xlarge " disabled="true">
							<form:option value="" label=""/>
							<form:options items="${fns:getDictList('msm_mk_mystore_apply_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">相关图片：</label>
			<div class="controls">
				<%-- <form:hidden id="photoUrl" path="photoUrl" htmlEscape="false" maxlength="255" class="input-xlarge"/>
				<sys:ckfinder input="photoUrl" type="files" uploadPath="/msm/mk/photoUrl" selectMultiple="true" readonly="true"/> --%>
				
				<form:hidden id="photoUrl" path="photoUrl" htmlEscape="false" maxlength="255" class="form-control"/>
                <sys:fileUpload input="photoUrl" model="true" selectMultiple="true"></sys:fileUpload>
				
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">审批员工：</label>
			<div class="controls">
				<form:input path="checkUser.id" value="${fns:getUserById(mystoreApply.checkUser.id).name}" disabled="true" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">审批备注：</label>
			<div class="controls">
				<form:textarea path="checkRemarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "  disabled="true"/>
			</div>
		</div>
		<div class="form-actions">
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>