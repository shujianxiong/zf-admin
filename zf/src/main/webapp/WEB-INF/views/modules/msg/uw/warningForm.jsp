<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>员工报警中心管理</title>
	<meta name="decorator" content="adminLte"/>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
		<section class="content-header content-header-menu">
			<h1>
				<small><i class="fa-list-style"></i><a href="${ctx}/msg/uw/myWarning/list">预警列表</a></small>
				<small>|</small>
				<small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/msg/uw/myWarning/form?id=${warning.id}">预警处理</a></small>
			</h1>
		</section>
		<sys:tip content="${message }"></sys:tip>
		<section class="content">
			<div class="row">
				<div class="col-md-6">
					<form:form id="inputForm" modelAttribute="warning" action="${ctx}/msg/uw/myWarning/save" method="post" class="form-horizontal" onsubmit="return ZF.formSubmit()">
						<form:hidden path="id"/>
<%-- 						<form:hidden path="dealEndTime"/> --%>
						<input type="hidden" name="dealEndTime" value="<fmt:formatDate value="${warning.dealEndTime}" pattern="yyyy-MM-dd HH:mm:ss"/>">
						<form:hidden path="status"/>
						<div class="box box-success">
							<div class="box-header with-border">
								<h5>处理结果录入表单</h5>
							</div>
							<div class="box-body">
								<div class="form-group">
									<label for="dealResultType" class="col-sm-2 control-label">处理结果类型</label>
									<div class="col-sm-9">
										<sys:selectverify name="dealResultType" tip="请选择处理结果类型，必填项" verifyType="0" dictName="msg_uw_warning_dealResultType" id="dealResultType"></sys:selectverify>
									</div>
								</div>
								<div class="form-group">
									<label for="dealResultRemarks" class="col-sm-2 control-label">处理结果备注</label>
									<div class="col-sm-9">
										<sys:inputverify name="dealResultRemarks" tip="请录入处理结果备注，必填项" verifyType="0" maxlength="10" id="dealResultRemarks"></sys:inputverify>
									</div>
								</div>
							</div>
							<div class="box-footer">
			    				<div class="pull-left box-tools">
					        		<button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
					        	</div>
		    					<div class="pull-right box-tools">
				        			<button type="button" class="btn btn-default btn-sm" onclick="resetForm()"><i class="fa fa-refresh"></i>重置</button>
				               		<shiro:hasPermission name="msg:uw:warning:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
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