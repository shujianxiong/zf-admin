<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>时尚导师表管理</title>
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
		<li><a href="${ctx}/idx/mt/mentor/">时尚导师表列表</a></li>
		<li class="active"><a href="${ctx}/idx/mt/mentor/form?id=${mentor.id}">时尚导师表<shiro:hasPermission name="idx:mt:mentor:edit">${not empty mentor.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="idx:mt:mentor:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="mentor" action="${ctx}/idx/mt/mentor/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">姓名：</label>
			<div class="controls">
				<form:input path="name" htmlEscape="false" maxlength="50" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">性别：</label>
			<div class="controls">
				<form:radiobuttons path="sex" items="${fns:getDictList('sex')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">国籍：</label>
			<div class="controls">
				<form:input path="country" htmlEscape="false" maxlength="20" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">首页展示图：</label>
			<div class="controls">
				<%-- <form:hidden id="indexPhoto" path="indexPhoto" htmlEscape="false" maxlength="255" class="input-xlarge"/>
				<sys:ckfinder input="indexPhoto" type="files" uploadPath="/idx/mt/mentor" selectMultiple="true"/> --%>
				
				<form:hidden id="indexPhoto" path="indexPhoto" htmlEscape="false" maxlength="255" class="form-control"/>
                <sys:fileUpload input="indexPhoto" model="true" selectMultiple="true"></sys:fileUpload>
				
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">头像：</label>
			<div class="controls">
				<%-- <form:hidden id="gravatar" path="gravatar" htmlEscape="false" maxlength="255" class="input-xlarge"/>
				<sys:ckfinder input="gravatar" type="files" uploadPath="/idx/mt/mentor" selectMultiple="true"/> --%>
				
				<form:hidden id="gravatar" path="gravatar" htmlEscape="false" maxlength="255" class="form-control"/>
                <sys:fileUpload input="gravatar" model="true" selectMultiple="true"></sys:fileUpload>
				
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">头像背景图：</label>
			<div class="controls">
				<%-- <form:hidden id="bgPhoto" path="bgPhoto" htmlEscape="false" maxlength="255" class="input-xlarge"/>
				<sys:ckfinder input="bgPhoto" type="files" uploadPath="/idx/mt/mentor" selectMultiple="true"/> --%>
				
				<form:hidden id="bgPhoto" path="bgPhoto" htmlEscape="false" maxlength="255" class="form-control"/>
                <sys:fileUpload input="bgPhoto" model="true" selectMultiple="true"></sys:fileUpload>
				
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">标签（|分割）：</label>
			<div class="controls">
				<form:input path="tags" htmlEscape="false" maxlength="50" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">列表简介：</label>
			<div class="controls">
				<form:textarea path="listSummary" htmlEscape="false" rows="4" maxlength="500" class="input-xxlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">列表展示图1：</label>
			<div class="controls">
				<%-- <form:hidden id="listDisplayPhoto1" path="listDisplayPhoto1" htmlEscape="false" maxlength="255" class="input-xlarge"/>
				<sys:ckfinder input="listDisplayPhoto1" type="files" uploadPath="/idx/mt/mentor" selectMultiple="true"/> --%>
				
				<form:hidden id="listDisplayPhoto1" path="listDisplayPhoto1" htmlEscape="false" maxlength="255" class="form-control"/>
                <sys:fileUpload input="listDisplayPhoto1" model="true" selectMultiple="true"></sys:fileUpload>
				
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">列表展示图2：</label>
			<div class="controls">
				<%-- <form:hidden id="listDisplayPhoto2" path="listDisplayPhoto2" htmlEscape="false" maxlength="255" class="input-xlarge"/>
				<sys:ckfinder input="listDisplayPhoto2" type="files" uploadPath="/idx/mt/mentor" selectMultiple="true"/> --%>
				
				<form:hidden id="listDisplayPhoto2" path="listDisplayPhoto2" htmlEscape="false" maxlength="255" class="form-control"/>
                <sys:fileUpload input="listDisplayPhoto2" model="true" selectMultiple="true"></sys:fileUpload>
				
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">是否推荐：</label>
			<div class="controls">
				<form:radiobuttons path="commendFlag" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">详情简介（富文本）：</label>
			<div class="controls">
				<form:textarea path="summary" htmlEscape="false" rows="4" class="input-xxlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">详情经历（富文本）：</label>
			<div class="controls">
				<form:textarea path="experience" htmlEscape="false" rows="4" class="input-xxlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">详情记录（富文本）：</label>
			<div class="controls">
				<form:textarea path="record" htmlEscape="false" rows="4" class="input-xxlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">详情指导图（2张）：</label>
			<div class="controls">
				<%-- <form:hidden id="photos" path="photos" htmlEscape="false" maxlength="1000" class="input-xlarge"/>
				<sys:ckfinder input="photos" type="files" uploadPath="/idx/mt/mentor" selectMultiple="true"/> --%>
				
				<form:hidden id="photos" path="photos" htmlEscape="false" maxlength="255" class="form-control"/>
                <sys:fileUpload input="photos" model="true" selectMultiple="true"></sys:fileUpload>
				
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">详情评价（富文本）：</label>
			<div class="controls">
				<form:textarea path="appraise" htmlEscape="false" rows="4" class="input-xxlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注信息：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="idx:mt:mentor:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>