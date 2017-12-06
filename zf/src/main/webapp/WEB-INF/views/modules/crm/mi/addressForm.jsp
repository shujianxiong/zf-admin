<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>会员地址详情</title>
	<meta name="decorator" content="adminLte"/>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
		<section class="content-header content-header-menu">
			<h1>
				<small><i class="fa-list-style"></i><a href="${ctx}/crm/mi/address/">会员收货地址列表</a></small>
				<small>|</small>
				<small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/crm/mi/address/form?id=${address.id}">会员收货地址详情</a></small>
		      </h1>
		</section>
		<sys:tip content="${message}"/>	
		<section class="content">
			<div class="row">
				<div class="col-md-6">
					<form:form id="inputForm" modelAttribute="address" action="${ctx}/crm/mi/address/form?id=${address.id}" method="post" class="form-horizontal">
						<form:hidden path="id"/>	
						<div class="box box-primary">
							<div class="box-header with-border zf-query">
								<h5>会员收货地址详情</h5>
							</div>
							<div class="box-body">
								<div class="form-group">
									<label for="member.usercode" class="col-sm-2 control-label">会员账号</label>
									<div class="col-sm-9">
										<form:input path="member.usercode" htmlEscape="false" maxlength="64" class="form-control" readonly="true"/>
									</div>
								</div>
								<div class="form-group">
									<label for="member.name" class="col-sm-2 control-label">会员姓名</label>
									<div class="col-sm-9">
										<form:input path="member.name" htmlEscape="false" maxlength="64" class="form-control" readonly="true"/>
									</div>
								</div>
								<div class="form-group">
									<label for="addressArea" class="col-sm-2 control-label">收货地址区域</label>
									<div class="col-sm-9">
										<form:input path="addressArea" htmlEscape="false" maxlength="64" class="form-control" readonly="true"/>
									</div>
								</div>
								<div class="form-group">
									<label for="addressDetail" class="col-sm-2 control-label">收货地址详情</label>
									<div class="col-sm-9">
										<form:input path="addressDetail" htmlEscape="false" maxlength="64" class="form-control" readonly="true"/>
									</div>
								</div>
								<div class="form-group">
                                    <label for="addressDetail" class="col-sm-2 control-label">邮政编码</label>
                                    <div class="col-sm-9">
                                        <form:input path="zipCode" htmlEscape="false" maxlength="64" class="form-control" readonly="true"/>
                                    </div>
                                </div>
								<div class="form-group">
									<label for="receiveName" class="col-sm-2 control-label">收货人</label>
									<div class="col-sm-9">
										<form:input path="receiveName" htmlEscape="false" maxlength="64" class="form-control" readonly="true"/>
									</div>
								</div>
								<div class="form-group">
									<label for="receiveTel" class="col-sm-2 control-label">收货联系电话</label>
									<div class="col-sm-9">
										<form:input path="receiveTel" htmlEscape="false" maxlength="64" class="form-control" readonly="true"/>
									</div>
								</div>
								<div class="form-group">
									<label for="member.usercode" class="col-sm-2 control-label">是否默认</label>
									<div class="col-sm-9 zf-check-wrapper-padding">
										<form:radiobuttons path="defaultFlag" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false" class="minimal"/>
									</div>
								</div>
								<div class="form-group">
									<label for="remarks" class="col-sm-2 control-label">备注</label>
									<div class="col-sm-9">
										<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="form-control " readonly="true"/>
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

	<script>
	$(function () {
	 //iCheck for checkbox and radio inputs
	   $('input[type="radio"].minimal').iCheck({
	     radioClass: 'iradio_minimal-blue'
	   });
	 
	   $('input[type="radio"].minimal').iCheck('disable');
	 	
	 });
	</script>
</body>
</html>