<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>员工消息发送设置管理</title>
	<meta name="decorator" content="adminLte"/>
</head>
<body>
<div class="content-wrapper sub-content-wrapper">
	<section class="content-header content-header-menu">
	  <h1>
        <small><i class="fa-list-style"></i><a href="${ctx}/msg/um/messageConfig">员工消息接收设置列表</a></small>
        
        <shiro:hasPermission name="msg:um:messageConfig:edit"><small>|</small><small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/msg/um/messageConfig/form?id=${messageConfig.id}">员工消息接收设置${not empty messageConfig.id?'修改':'新增' }</a></small></shiro:hasPermission>
      </h1>
	</section>
	<sys:tip content="${message }" />
	<section class="content">
		<div class="row">
			<div class="col-md-6">
				<form:form id="inputForm" modelAttribute="messageConfig" action="${ctx}/msg/um/messageConfig/save" method="post" class="form-horizontal" onsubmit="return ZF.formSubmit()">
					<form:hidden path="id"/>
					<div class="box box-success">
					<div class="box-header with-border zf-query">
						<h5>接收设置录入表单</h5>
					</div>
					<div class="box-body">
						<div class="form-group">
							<label for="category" class="col-sm-2 control-label">消息类别</label>
							<div class="col-sm-9">
								<sys:selectverify name="category" tip="请选择消息类别，必填项" verifyType="0" dictName="msg_um_message_category" id="category"></sys:selectverify>
							</div>
						</div>
						<div class="form-group">
							<label for="type" class="col-sm-2 control-label">消息类型</label>
							<div class="col-sm-9">
								<sys:selectverify name="type" tip="请选择消息类型，必填项" verifyType="0" dictName="msg_um_message_config_type" id="type"></sys:selectverify>
							</div>
						</div>
						<div class="form-group">
							<label for="title" class="col-sm-2 control-label">标题</label>
							<div class="col-sm-9">
								<sys:inputverify name="title" id="title" verifyType="99" tip="请输入标题，必填项" isSpring="true"></sys:inputverify>
							</div>
						</div>
						<div class="form-group">
							<label for="contentModel" class="col-sm-2 control-label">内容文本模型</label>
							<div class="col-sm-9">
								<sys:inputverify name="contentModel" id="contentModel" verifyType="99" tip="请输入内容文本模型，必填项" isSpring="true"></sys:inputverify>
							</div>
						</div>
						<div class="form-group">
							<label for="receiveRole" class="col-sm-2 control-label">接收角色</label>
							<div class="col-sm-9">
								<form:radiobuttons path="receiveRole" items="${allRoles}" itemLabel="name" itemValue="id" htmlEscape="false" class="minimal"/>
							</div>
						</div>
						<div class="form-group">
							<label for="usableFlag" class="col-sm-2 control-label">启用标记</label>
							<div class="col-sm-9">
								<form:radiobuttons path="usableFlag" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false" class="minimal"/>
							</div>
						</div>
						<div class="form-group">
							<label for="remarks" class="col-sm-2 control-label">备注信息</label>
							<div class="col-sm-9">
								<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="form-control"/>
							</div>
						</div>
					</div>
					<div class="box-footer">
	    				<div class="pull-left box-tools">
			        		<button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
			        	</div>
    					<div class="pull-right box-tools">
			        		<button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
		               		<shiro:hasPermission name="msg:uw:warningConfig:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
			        	</div>
		            </div>
				</div>
			</form:form>
			</div>
		</div>
	</section>
	
	
</div>

	<script type="text/javascript">
		$(function(){
			 //iCheck for checkbox and radio inputs
		    $('input[type="checkbox"].minimal, input[type="radio"].minimal').iCheck({
				  radioClass : 'iradio_square-blue'
		    });
		})
	</script>
</body>
</html>