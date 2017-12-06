<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>货位列表管理</title>
	<meta name="decorator" content="adminLte"/>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
		<section class="content-header content-header-menu">
			<h1>
		        <small><i class="fa-list-style"></i><a href="${ctx}/lgt/ps/wareplace/wareplaceList">货位列表</a></small>
		        <small>|</small>
		        <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/lgt/ps/wareplace/form?id=${wareplace.id}">货位<shiro:hasPermission name="lgt:ps:wareplace:edit">${not empty wareplace.id?'修改':'新增'}</shiro:hasPermission></a></small>
		      </h1>
		</section>
		<sys:tip content="${message}"/>	
		<section class="content">
			<div class="row">
				<div class="col-md-6">
					<form:form id="inputForm" modelAttribute="wareplace" action="${ctx}/lgt/ps/wareplace/save" method="post" class="form-horizontal" onsubmit="return formSubmit();">
						<form:hidden path="id"/>
						<div class="box box-success">
							<div class="box-header with-border zf-query">
								
							</div>
							<div class="box-body">
							    <input id="id" name="wareplace.warehouse.id" type="hidden" value="${warehouseId}"/>
								<sys:inputtree name="warecounter.warearea.warehouse.id" url="${ctx}/lgt/ps/warehouse/warehouseListData" id="warehouse" label="所属仓库" labelValue="${warehouseCode}" labelWidth="2" inputWidth="9"
									 labelName="warecounter.warearea.warehouse.code" value="${warehouseId}" tip="请选择仓库" isQuery="true" onchange="changeWarehouse"></sys:inputtree>
								
								<sys:inputtree name="warecounter.warearea.id" url="${ctx}/lgt/ps/warearea/wareareaListData" id="warearea" label="所属区域" labelValue="" labelWidth="2" inputWidth="9" 
									labelName="warecounter.warearea.code" value="" tip="请选择区域" postParam="{postName:[\"warehouse.id\"],inputId:[\"warehouseId\"]}" isQuery="true" onchange="changeWarearea"></sys:inputtree>
								
								<sys:inputtree name="warecounter.id" url="${ctx}/lgt/ps/warecounter/warecounterListData" id="warecounter" label="所属货架" labelValue="" labelName="warecounter.code" labelWidth="2" inputWidth="9" 
									value="" tip="请选择货架" postParam="{postName:[\"warearea.id\"],inputId:[\"wareareaId\"]}" isQuery="true"></sys:inputtree>
									
								<div class="form-group">
									<label class="col-sm-2 control-label">货位编号</label>
									<div class="col-sm-9">
										<form:input path="code" htmlEscape="false" maxlength="100" class="form-control" placeholder="请输入货位编号"/>
									</div>
								</div>
								<%-- <div class="form-group">
									<label class="col-sm-2 control-label">货位电子码</label>
									<div class="col-sm-9">
										<form:input path="scanCode" htmlEscape="false" maxlength="255" class="form-control" placeholder="请输入货位电子码信息"/>
									</div>
								</div> --%>
								<div class="form-group">
                                    <label class="col-sm-2 control-label">是否启用</label>
                                    <div class="col-sm-9 zf-check-wrapper-padding">
                                        <%-- <form:radiobuttons id="usableFlag" path="usableFlag" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false" placeholder="请输入启用标志"/> --%>
                                        <sys:selectverify name="usableFlag" tip="请选择是否启用" verifyType="0" dictName="yes_no" id="usableFlag"></sys:selectverify>
                                    </div>
                                </div>
								<div class="form-group">
									<label class="col-sm-2 control-label">是否锁定</label>
									<div class="col-sm-9 zf-check-wrapper-padding">
										<%-- <form:radiobuttons id="lockFlag" path="lockFlag" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false" placeholder="请输入锁定标志"/> --%>
										<sys:selectverify name="lockFlag" tip="请选择是否锁定" verifyType="0" dictName="yes_no" id="lockFlag"></sys:selectverify>
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-sm-2 control-label">备注信息</label>
									<div class="col-sm-9">
										<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="form-control" placeholder="请输入备注信息"/>
									</div>
								</div>
							</div>
							<div class="box-footer">
		    					<div class="pull-left box-tools">
					        		<button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
					        	</div>
		    					<div class="pull-right box-tools">
					        		<button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
				               		<button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button>
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
			$(":radio").iCheck({
				radioClass : 'iradio_minimal-blue',
			});
			
		});
		
		//点击仓库选择时，需清空区域、货架、货位
		function changeWarehouse(){
			$("#wareareaName").val("");
			$("#wareareaId").val("");
			$("#warecounterName").val("");
			$("#warecounterId").val("");
		}
		//点击区域选择时，需清空货架、货位
		function changeWarearea(){
			$("#warecounterName").val("");
			$("#warecounterId").val("");
		}
		
		function formSubmit() {
			var wh = $("#warehouseId").val();
            if(wh == null || wh == "" || wh == undefined) {
                ZF.showTip("请选择仓库!", "info");
                return false;
            }
            var wa = $("#wareareaId").val();
            if(wa == null || wa == "" || wa == undefined) {
                ZF.showTip("请选择货架!", "info");
                return false;
            }
            var wc = $("#warecounterId").val();
            if(wc == null || wc == "" || wc == undefined) {
                ZF.showTip("请选择货屉!", "info");
                return false;
            }
            
            var code = $("#code").val();
            if(code == null || code == "" || code == undefined) {
                ZF.showTip("请输入货位编号!", "info");
                return false;
            }
            var usableFlag = $("#usableFlag").val();
            console.log(usableFlag);
            if(usableFlag == null || usableFlag == "" || usableFlag == undefined) {
                ZF.showTip("请选择是否启用!", "info");
                return false;
            }
            var lockFlag = $("#lockFlag").val();
            console.log(lockFlag);
            if(lockFlag == null || lockFlag == "" || lockFlag == undefined) {
                ZF.showTip("请选择是否锁定!", "info");
                return false;
            }
            return true;
		}
	</script>
</body>
</html>