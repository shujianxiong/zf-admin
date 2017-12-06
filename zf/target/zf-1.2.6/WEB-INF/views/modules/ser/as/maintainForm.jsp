<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>售后维修工单管理</title>
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
		<li><a href="${ctx}/ser/as/maintain/">售后维修工单列表</a></li>
		<li class="active"><a href="${ctx}/ser/as/maintain/form?id=${maintain.id}">售后维修工单<shiro:hasPermission name="ser:as:maintain:edit">${not empty maintain.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="ser:as:maintain:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="maintain" action="${ctx}/ser/as/maintain/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">工单编号：</label>
			<div class="controls">
				<form:input path="workorder.workorderNo" htmlEscape="false" maxlength="64" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">维护状态：</label>
			<div class="controls">
				<form:select path="maintainStatus" class="input-xlarge required">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('ser_as_maintain_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">维护人：</label>
			<div class="controls">
				<sys:treeselect id="maintainUserId" name="maintainUser.id" value="${maintain.maintainUser.id}" labelName="maintainUser.name" labelValue="${maintain.maintainUser.name}"
					title="用户" url="/sys/office/treeData?type=3" cssClass="required" allowClear="true" notAllowSelectParent="true"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">派单时间：</label>
			<div class="controls">
				<input name="startTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
					value="<fmt:formatDate value="${maintain.startTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">完成时间：</label>
			<div class="controls">
				<input name="finishTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${maintain.finishTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">维护类型：</label>
			<div class="controls">
				<form:select path="maintainType" class="input-xlarge required">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('ser_as_maintain_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">维护结果：</label>
			<div class="controls">
				<form:select path="result" class="input-xlarge required">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('ser_as_maintain_result')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">相关图片url：</label>
			<div class="controls">
				<%-- <form:hidden id="photosUrl" path="photosUrl" htmlEscape="false" maxlength="1000" class="input-xlarge"/>
				<sys:ckfinder input="photosUrl" type="files" uploadPath="/ser/maintain" selectMultiple="true"/> --%>
				
				<form:hidden id="photosUrl" path="photosUrl" htmlEscape="false" maxlength="255" class="form-control"/>
                <sys:fileUpload input="photosUrl" model="true" selectMultiple="true"></sys:fileUpload>
				
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">顾客评价ID：</label>
			<div class="controls">
				<form:input path="maintainJudgeId" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注信息：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="ser:as:maintain:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>