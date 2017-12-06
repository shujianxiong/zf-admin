<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>注册分享模板管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript" src="${ctxStatic}/jquery-colorpicker/jquery.colorpicker.js"></script>
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
	
	<script type="text/javascript">
	    $(function(){
	        $("#color").colorpicker({
	            fillcolor:true,
	            event:'mouseover',
	            target:$("#shareColor")
	        });
	    });
	</script>
	
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/spm/sr/registerShareTemp/">注册分享模板列表</a></li>
		<li class="active"><a href="${ctx}/spm/sr/registerShareTemp/form?id=${registerShareTemp.id}">注册分享模板<shiro:hasPermission name="spm:sr:registerShareTemp:edit">${not empty registerShareTemp.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="spm:sr:registerShareTemp:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="registerShareTemp" action="${ctx}/spm/sr/registerShareTemp/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<fieldset>
			<table class="table-form">
				<tr>
					<td class="tit">模板名称：</td><td>
						<form:input path="name"  htmlEscape="false" maxlength="50" class="input-xlarge required"/>
						<span class="help-inline"><font color="red">*</font> </span>
					</td>
					<td class="tit">奖励金额：</td><td>
						<form:input path="rewardAmount"  htmlEscape="false" class="input-xlarge required "/>
						<span class="help-inline"><font color="red">*</font> </span>
					</td>
					<td class="tit">活动启用时间：</td><td>
						<input name="activeStartTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
							value="<fmt:formatDate value="${registerShareTemp.activeStartTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
							onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});" style="width:268px;"/>
						<span class="help-inline"><font color="red">*</font> </span>
					</td>
				</tr>
				<tr>
					<td class="tit">有效时间（天）：</td><td>
						<form:input path="activeDays"  htmlEscape="false" maxlength="11" class="input-xlarge required digits"/>
						<span class="help-inline"><font color="red">*</font> </span>
					</td>
					<td class="tit">邀请奖励类型：</td><td>
						<form:select path="rewardType"  class="input-xlarge required">
							<form:option value="" label=""/>
							<form:options items="${fns:getDictList('spm_sr_register_rewardType')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
						<span class="help-inline"><font color="red">*</font> </span>
					</td>
					<td class="tit">分享URL：</td><td>
						<form:input path="shareUrl"  htmlEscape="false" maxlength="2000" class="input-xlarge "/>
					</td>
				</tr>
				
				<tr>
					<td class="tit">分享标题：</td><td>
						<form:input path="shareTitle"  htmlEscape="false" maxlength="100" class="input-xlarge "/>
					</td>
					
					<td class="tit" rowspan="2">分享ICON：</td><td rowspan="2">
						<%-- <form:hidden id="shareIcon" path="shareIcon"  htmlEscape="false" maxlength="255" class="input-xlarge"/>
						<sys:ckfinder input="shareIcon" type="files" uploadPath="/spm/sr/shareIcon" selectMultiple="false" /> --%>
						
						 <form:hidden id="shareIcon" path="shareIcon" htmlEscape="false" maxlength="255" class="form-control"/>
                         <sys:fileUpload input="shareIcon" model="true" selectMultiple="false"></sys:fileUpload>
						
					</td>
					<td class="tit" rowspan="2">分享广告图：</td><td rowspan="2">
						<%-- <form:hidden id="sharePhoto" path="sharePhoto"  htmlEscape="false" maxlength="255" class="input-xlarge"/>
						<sys:ckfinder input="sharePhoto" type="files" uploadPath="/spm/sr/sharePhoto" selectMultiple="false"/> --%>
						
						 <form:hidden id="sharePhoto" path="sharePhoto" htmlEscape="false" maxlength="255" class="form-control"/>
                         <sys:fileUpload input="sharePhoto" model="true" selectMultiple="false"></sys:fileUpload>
						
					</td>
				</tr>
				<tr>
					<td class="tit">分享简介：</td><td>
						<form:input path="shareSummary"  htmlEscape="false" maxlength="100" class="input-xlarge "/>
					</td>
				</tr>
				<tr>
					<td class="tit">分享背景色：</td><td>
						<blockquote style="padding-left:0px;border-left-width: 0px;margin-bottom: 0px;">
							<input type="text" id="shareColor" name="shareColor" value="${registerShareTemp.shareColor}" style="width:266px;" readOnly="readOnly" /><img src="${ctxStatic}/jquery-colorpicker/colorpicker.png" id="color" style="cursor:pointer"/>
	   					</blockquote>
					</td>
					<td class="tit" rowspan="2">活动说明：</td><td rowspan="2">
						<form:textarea path="activeExplain"  htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge " style="width:348px;"/>
					</td>
					<td class="tit" rowspan="2">备注信息：</td><td rowspan="2">
						<form:textarea path="remarks"  htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge " style="width:368px;"/>
					</td>
				</tr>
				<tr>
					<td class="tit">规则说明：</td><td>
						<form:input path="ruleExplain"  htmlEscape="false" class="input-xlarge "/>
					</td>
				</tr>
			</table>
		</fieldset>
		<div class="form-actions">
			<shiro:hasPermission name="spm:sr:registerShareTemp:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>