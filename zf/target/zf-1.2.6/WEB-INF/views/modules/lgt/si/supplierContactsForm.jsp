<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>供应商通讯录管理</title>
	<meta name="decorator" content="adminLte"/>
</head>
<body>
<div class="content-wrapper sub-content-wrapper">
	<section class="content-header content-header-menu">
		<h1>
			<small><i class="fa-list-style"></i><a href="${ctx}/lgt/si/supplierContacts/">供应商通讯录列表</a></small>
			
			<shiro:hasPermission name="lgt:si:supplierContacts:edit"><small>|</small><small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/lgt/si/supplierContacts/form?id=${supplierContacts.id}">供应商联系人${not empty supplierContacts.id?'修改':'添加'}</a></small></shiro:hasPermission>
		</h1>
	</section>
	<sys:tip content="${message}"/>
	<section class="content">
		<div class="row">
			<div class="col-md-6">
				<form:form id="inputForm" modelAttribute="supplierContacts" action="${ctx}/lgt/si/supplierContacts/save" method="post" class="form-horizontal" onsubmit="return ZF.formSubmit()">
					<div class="box box-success">
						<div class="box-header with-border zf-query">
		    				<h5>请完善表单填写</h5>
				            <div class="box-tools">
				               <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
				            </div>
		    			</div>
						
						<div class="box-body">
							<form:hidden path="id"/>
							<sys:inputtree name="supplier.id" url="${ctx}/lgt/si/supplier/treeData"
								id="supplier" label="供应商名称" labelValue="" labelWidth="2" 
								inputWidth="9" labelName="supplier.name" value="" tip="请选择供应商名称，必选项" verifyType="true"></sys:inputtree>
								
							<div class="form-group">
								<label for="name" class="col-sm-2 control-label">联系人姓名</label>
								<div class="col-sm-9">
									<sys:inputverify id="nameInput" name="name" maxlength="30" tip="请输入联系人姓名，必填项" verifyType="0" isSpring="true"></sys:inputverify>
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-sm-2 control-label">角色</label>
								<div class="col-sm-9">
									<sys:selectverify name="role" tip="请选择角色，必填项" verifyType="-1" dictName="lgt_si_supplier_contacts_role" id="role"></sys:selectverify>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">岗位</label>
								<div class="col-sm-9">
									<sys:selectverify name="job" tip="请选择岗位，必填项" verifyType="-1" dictName="lgt_si_supplier_contacts_job" id="job"></sys:selectverify>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">联系电话</label>
								<div class="col-sm-9">
									<sys:inputverify id="telephoneInput" name="telephone" maxlength="25" tip="请输入手机号码" isMandatory="false" verifyType="99" isSpring="true"></sys:inputverify>
								</div>
							</div>
							
							<sys:inputtree url="${ctx}/sys/area/treeData" label="所在区域" labelWidth="2" inputWidth="9" tip="请选择所在区域" id="areaId" labelName="area.name" name="area.id" verifyType="true"></sys:inputtree>
							
							<div class="form-group">
								<label class="col-sm-2 control-label">联系地址</label>
								<div class="col-sm-9">
									<sys:inputverify name="sysAreaDetail" maxlength="150" tip="请输入联系地址，必填项" verifyType="0" id="sysAreaDetail"  isSpring="true"></sys:inputverify>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">备注信息</label>
								<div class="col-sm-9">
									<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="form-control "/>
								</div>
							</div>
						</div>
						<div class="box-footer">
							<div class="pull-left box-tools">
					        	<button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
					        </div>
		    				<div class="pull-right box-tools">
		    					<c:if test="${empty supplierContacts.id }">
						        	<button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
		    					</c:if>
				               	<shiro:hasPermission name="lgt:si:supplierContacts:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
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