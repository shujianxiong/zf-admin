<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>菜单管理</title>
	<meta name="decorator" content="adminLte"/>
</head>
<body>
	
	<div class="content-wrapper sub-content-wrapper">
		<section class="content-header content-header-menu">
			<h1>
				<small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/sys/menu/">菜单列表</a></small>
				<small>|</small>
				<small><i class="fa fa-plus"></i><a href="${ctx}/sys/menu/info?id=${menu.id}">菜单详情</a></small>
			</h1>
		</section>
		<sys:tip content="${message}"/>
		<section class="content">
			<div class="row">
				<div class="col-md-6">
					<form:form id="inputForm" modelAttribute="menu" method="post" class="form-horizontal">
						<form:hidden path="id"/>
						<div class="box box-success">
							<div class="box-header with-border zf-query">
								<h5>菜单录入表单</h5>
							</div>
							<div class="box-body">
								<div class="form-group">
									<label for="parent.name" class="col-sm-2 control-label">上级菜单</label>
									<div class="col-sm-9">
										<form:input path="parent.name" class="form-control" readonly="true"/>
									</div>
								</div>
								<div class="form-group">
									<label for="name" class="col-sm-2 control-label">名称</label>
									<div class="col-sm-9">
										<form:input path="name" class="form-control" readonly="true"/>
									</div>
								</div>
								<div class="form-group">
									<label for="href" class="col-sm-2 control-label">链接</label>
									<div class="col-sm-9">
										<form:input path="href" class="form-control" readonly="true"/>
									</div>
								</div>
								<div class="form-group">
									<label for="target" class="col-sm-2 control-label">目标</label>
									<div class="col-sm-9">
										<form:input path="target" htmlEscape="false" maxlength="10" class="form-control" readonly="true"/>
									</div>
								</div>
								<div class="form-group">
									<label for="icon" class="col-sm-2 control-label">图标</label>
									<div class="col-sm-9">
										<sys:iconselect id="icon" name="icon" value="${menu.icon}" />
									</div>
								</div>
								<div class="form-group">
									<label for="sort" class="col-sm-2 control-label">排序</label>
									<div class="col-sm-9">
										<form:input path="sort" class="form-control" readonly="true"/>
									</div>
								</div>
								<div class="form-group">
									<label for="isShow" class="col-sm-2 control-label">可见</label>
									<div class="col-sm-9 zf-check-wrapper-padding">
										<form:radiobuttons path="isShow" items="${fns:getDictList('show_hide')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required"/>
									</div>
								</div>
								<div class="form-group">
									<label for="permission" class="col-sm-2 control-label">权限</label>
									<div class="col-sm-9">
										<form:input path="permission" htmlEscape="false" maxlength="10" class="form-control" readonly="true"/>
									</div>
								</div>
								<div class="form-group">
									<label for="permission" class="col-sm-2 control-label">备注</label>
									<div class="col-sm-9">
										<form:textarea path="remarks" htmlEscape="false" rows="3" maxlength="200" class="form-control" readonly="true"/>
									</div>
								</div>
								
							</div>
							<div class="box-footer">
			    				<div class="pull-left box-tools">
					        		<button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
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
			$('input').iCheck({
				checkboxClass : 'icheckbox_minimal-blue',
				radioClass : 'iradio_minimal-blue'
			});
			$('input').iCheck('disable');
		})
	</script>
	
</body>
</html>