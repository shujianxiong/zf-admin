<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>系统业务参数表管理</title>
	<meta name="decorator" content="adminLte"/>
</head>
<body>
<div class="content-wrapper sub-content-wrapper">
	<section class="content-header content-header-menu">
	  <h1>
		<small><i class="fa-list-style"></i><a href="${ctx}/sys/config/list">系统业务参数设置列表</a></small>
        <small>|</small>
		<small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/sys/config/form?id=${config.id}">系统业务参数设置${not empty config.id?'修改':'新增' }</a></small>
      </h1>
	</section>
	<sys:tip content="${message}"/>	
	<section class="content">
		<div class="row">
			<div class="col-md-6">
				<form:form id="inputForm" modelAttribute="config" action="${ctx}/sys/config/save" method="post" class="form-horizontal" onsubmit="return ZF.formSubmit()">
					<form:hidden path="id"/>
					<div class="box box-success">
						<div class="box-header with-border zf-query">
							<h5>业务参数录入表单</h5>
						</div>
						<div class="box-body">
							<div class="form-group">
								<label for="code" class="col-sm-2 control-label">参数编码：</label>
								<div class="col-sm-9">
									<sys:inputverify name="code" id="code" verifyType="0" tip="请输入参数编码，必填项" isSpring="true"></sys:inputverify>
								</div>
							</div>
							<div class="form-group">
								<label for="configType" class="col-sm-2 control-label">参数类型：</label>
								<div class="col-sm-9">
									<sys:selectverify name="configType" tip="请选择参数类型，必填项" verifyType="0" dictName="sys_config_type" id="configType" ></sys:selectverify>
								</div>
							</div>
							<div class="form-group">
								<label for="configValue" class="col-sm-2 control-label">参数值：</label>
								<div class="col-sm-9">
									<sys:inputverify name="configValue" id="configValue" verifyType="99" tip="请输入参数值，必填项" isSpring="true"></sys:inputverify>
								</div>
							</div>
							<div class="form-group">
								<label for="description" class="col-sm-2 control-label">参数说明：</label>
								<div class="col-sm-9">
									<form:input path="description" htmlEscape="false" maxlength="200" class="form-control " placeholder="请输入参数说明"/>
								</div>
							</div>
							<div class="form-group">
								<label for="remarks" class="col-sm-2 control-label">备注信息：</label>
								<div class="col-sm-9">
									<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="form-control" placeholder="请输入备注"/>
								</div>
							</div>
						</div>
						<div class="box-footer">
		    				<div class="box-footer">
			    				<div class="pull-left box-tools">
					        		<button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
					        	</div>
		    					<div class="pull-right box-tools">
				        			<button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
				               		<shiro:hasPermission name="lgt:ps:lgtPsCategory:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
					        	</div>
				            </div>
			            </div>
					</div>
				</form:form>
			</div>
		</div>
	</section>	
	
</div>

	
</body>
</html>