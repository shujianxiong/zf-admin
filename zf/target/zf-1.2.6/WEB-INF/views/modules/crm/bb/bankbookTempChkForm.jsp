<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>会员资金账户临时条目审核</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		var moneyTypes = ${fns:toJson(moneyType)};
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					var usercode = $("#usercode").val();
					var changeType = $("#changeType").val();
					var moneyType = $("#moneyType").val();
					var money = $("#money").val();
					var checkType = $("#checkType").val();
					var confirmMsg = "";
					if(checkType=="pass"){
						confirmMsg = "要审核通过的会员资金账户临时条目内容如下:"
										+"\n\n会员编号："+usercode
										+"\n变动类型："+changeType
										+"\n资金类型："+moneyType
										+"\n变动金额："+money
										+"\n\n确认审核通过后会员资金账户将进行对应资金变动，是否确认审核通过？"
					}else if(checkType=="refuse"){
						confirmMsg = "要审核拒绝的会员资金账户临时条目内容如下:"
										+"\n\n会员编号："+usercode
										+"\n变动类型："+changeType
										+"\n资金类型："+moneyType
										+"\n变动金额："+money
										+"\n\n确认审核拒绝后该临时条目不再可更改，是否确认审核拒绝？"
					}
					if(confirm(confirmMsg)){
						loading('正在提交，请稍等...');
						form.submit();
					}
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
		<li><a href="${ctx}/crm/bb/bankbookTempChk/">会员资金账户临时条目审核列表</a></li>
		<li class="active"><a href="${ctx}/crm/bb/bankbookTempChk/check?id=${bankbookTemp.id}">会员资金账户临时条目<shiro:hasPermission name="crm:bb:bankbookTempChk:check">${not empty bankbookTemp.id?'审核':'添加'}</shiro:hasPermission><shiro:lacksPermission name="crm:bb:bankbookTemp:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="bankbookTemp" action="${ctx}/crm/bb/bankbookTempChk/check" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<input id="checkType" name="checkType" type="hidden" value=""/>
		<div class="control-group">
			<label class="control-label">会员账号：</label>
			<div class="controls">
				<input id="usercode" type="text" value="${fns:getMemberById(bankbookTemp.bankbookBalance.member.id).usercode }" class="input-large required" disabled="disabled"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">变动类型：</label>
			<div class="controls">
				<input id="changeType" type="text" value="${fns:getDictLabel(bankbookTemp.changeType, 'crm_bb_bankbook_changeType', '')}" class="input-large required" disabled="disabled"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">资金类型：</label>
			<div class="controls">
				<input id="moneyType" type="text" value="${fns:getDictLabel(bankbookTemp.moneyType, 'crm_bb_bankbook_moneyType', '')}" class="input-large required" disabled="disabled"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">变动金额：</label>
			<div class="controls">
				<input id="money" type="text" value="${bankbookTemp.money }" class="input-large required" disabled="disabled"/>
			</div>
		</div>
	
		<div class="control-group">
			<label class="control-label">备注信息：</label>
			<div class="controls">
				<form:textarea id="remarks" path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge " disabled="true"/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="crm:bb:bankbookTempChk:check">
				<input id="btnSubmitPass" 	class="btn btn-primary" type="submit" value="审核通过" onclick="document.getElementById('checkType').value='pass';"/>&nbsp;
				<input id="btnSubmitNoPass" class="btn btn-primary" type="submit" value="审核拒绝" onclick="document.getElementById('checkType').value='refuse'"/>&nbsp;
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>