<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>货品出入库详情</title>
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
		<li><a href="${ctx}/lgt/ps/productWpIo/">货品出入库记录列表</a></li>
		<li class="active"><a href="${ctx}/lgt/ps/productWpIo/view?id=${productWpIo.id}">货品出入库详情</a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="productWpIo" action="${ctx}/lgt/ps/productWpIo/inSave" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">商品名称：</label>
			<div class="controls">
				<form:input path="product.goods.name" htmlEscape="false" maxlength="64" class="input-xlarge" disabled="true"/>
			</div>
		</div>		
		<div class="control-group">
			<label class="control-label">产品名称：</label>
			<div class="controls">
				<form:input path="product.produce.name" htmlEscape="false" maxlength="64" class="input-xlarge" disabled="true"/>
			</div>
		</div>					
		<div class="control-group">
			<label class="control-label">货品编号：</label>
			<div class="controls">
				<form:input path="product.code" htmlEscape="false" maxlength="64" class="input-xlarge" disabled="true"/>
			</div>
		</div>						
		<div class="control-group">
			<label class="control-label">货品原厂编码：</label>
			<div class="controls">
				<form:input path="product.factoryCode" htmlEscape="false" maxlength="64" class="input-xlarge" disabled="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">货品证书编号：</label>
			<div class="controls">
				<form:input path="product.certificateNo" htmlEscape="false" maxlength="64" class="input-xlarge" disabled="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">货品克重：</label>
			<div class="controls">
				<form:input path="product.weight" htmlEscape="false" maxlength="64" class="input-xlarge required" disabled="true"/>
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label">出入库货位：</label>
			<div class="controls">
				<form:input path="ioWareplace.wareplaceCode" htmlEscape="false" maxlength="64" class="input-xlarge required" disabled="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">操作人：</label>
			<div class="controls">
				<input name="ioTime" value="${fns:getUserById(productWpIo.ioUser.id).name}" type="text" readonly="readonly" class="input-xlarge required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">操作时间：</label>
			<div class="controls">
				<input name="ioTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required" disabled="disabled"
					value="<fmt:formatDate value="${productWpIo.ioTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">操作原因类型：</label>
			<div class="controls">
				<form:select path="ioReasonType" class="input-xlarge " disabled="true">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('lgt_ps_product_wp_io_ioReasonType')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">来源业务单号：</label>
			<div class="controls">
				<form:input path="ioBusinessorderId" htmlEscape="false" maxlength="64" class="input-xlarge " disabled="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注信息：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge " disabled="true"/>
			</div>
		</div>
		<div class="form-actions">
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>