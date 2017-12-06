<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>红包分享模板管理</title>
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
		<li><a href="${ctx}/spm/sr/redpacketShareTemp/">红包分享模板列表</a></li>
		<li class="active"><a href="${ctx}/spm/sr/redpacketShareTemp/form?id=${redpacketShareTemp.id}">红包分享模板<shiro:hasPermission name="spm:sr:redpacketShareTemp:edit">${not empty redpacketShareTemp.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="spm:sr:redpacketShareTemp:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="redpacketShareTemp" action="${ctx}/spm/sr/redpacketShareTemp/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
				<fieldset>
			<table class="table-form">
				<tr>
					<td class="tit">模板名称：</td><td>
						<form:input path="name" htmlEscape="false" maxlength="50" class="input-xlarge required"/>
						<span class="help-inline"><font color="red">*</font> </span>
					</td>
					<td class="tit">红包金额类型：</td><td>
						<form:select path="amountType" class="input-xlarge required">
							<form:option value="" label=""/>
							<form:options items="${fns:getDictList('spm_sr_redpacket_amountType')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
						<span class="help-inline"><font color="red">*</font> </span>
					</td>
					<td class="tit">抢红包类型：</td><td>
						<form:select path="shareType" class="input-xlarge required">
							<form:option value="" label=""/>
							<form:options items="${fns:getDictList('spm_sr_redpacket_shareType')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
						<span class="help-inline"><font color="red">*</font> </span>
					</td>
				</tr>
				<tr>
					<td class="tit">红包类型：</td><td>
						<form:select path="redpacketType" class="input-xlarge required">
							<form:option value="" label=""/>
							<form:options items="${fns:getDictList('spm_sr_redpacket_redpacketType')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
						<span class="help-inline"><font color="red">*</font> </span>
					</td>
					<td class="tit">活动启用时间：</td><td>
						<input name="redpacketStartTime" type="text" maxlength="20" class="input-medium Wdate required" 
							value="<fmt:formatDate value="${redpacketShareTemp.redpacketStartTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
							onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});" style="width:258px;"/>
						<span class="help-inline"><font color="red">*</font> </span>
					</td>
					<td class="tit">红包数量类型：</td><td>
						<form:select path="numType" class="input-xlarge required">
							<form:option value="" label=""/>
							<form:options items="${fns:getDictList('spm_sr_redpacket_numType')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
						<span class="help-inline"><font color="red">*</font> </span>
					</td>
				</tr>
				<tr>
					<td class="tit">红包金额：</td><td>
						<form:input path="amount" htmlEscape="false" class="input-xlarge required"/>
					</td>
					<td class="tit">红包数量：</td><td>
						<form:input path="num" htmlEscape="false" maxlength="11" class="input-xlarge required digits"/>
					</td>
					<td class="tit" rowspan="3">规则说明：</td><td rowspan="3">
						<form:textarea path="ruleExplain" htmlEscape="false" rows="2" maxlength="255" class="input-xxlarge " style="width:288px;height:88px"/>
					</td>
				</tr>
				<tr>
					<td class="tit">红包最大金额：</td><td>
						<form:input path="maxAmount" htmlEscape="false" class="input-xlarge required "/>
					</td>
					<td class="tit">红包最大数量：</td><td>
						<form:input path="maxNum" htmlEscape="false" maxlength="11" class="input-xlarge required digits"/>
					</td>
				</tr>
				<tr>
					<td class="tit">红包最小金额：</td><td>
						<form:input path="minAmount" htmlEscape="false" class="input-xlarge required"/>
					</td>
					<td class="tit">红包最小数量：</td><td>
						<form:input path="minNum" htmlEscape="false" maxlength="11" class="input-xlarge required digits"/>
					</td>
				</tr>
				<tr>
					<td class="tit">红包有效时间：</td><td>
						<form:input path="activeDays" htmlEscape="false" maxlength="11" class="input-xlarge digits required"/>
						<span class="help-inline"><font color="red">*</font> </span>
					</td>
					<td class="tit">活动说明：</td><td>
						<form:textarea path="activeExplain" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge " style="width:288px;height:88px"/>
					</td>
					<td class="tit">备注信息：</td><td>
						<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge " style="width:288px;height:88px"/>
					</td>
				</tr>
			</table>
		</fieldset>
		<div class="form-actions">
			<shiro:hasPermission name="spm:sr:redpacketShareTemp:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>