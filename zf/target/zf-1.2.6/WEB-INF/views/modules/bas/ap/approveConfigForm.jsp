<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>新增审批项</title>
	<meta name="decorator" content="adminLte"/>
	<script type="text/javascript">
	
	</script>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
		<section class="content-header content-header-menu">
	      <h1>
	        <small><i class="fa-list-style"></i><a href="${ctx}/bas/ap/approveConfig/list">审批配置列表</a></small> 
			<shiro:hasPermission name="bas:ap:approveConfig:view">
			    <small>|</small>
				<small class="menu-active"><i class="fa fa-repeat"></i><a
					href="${ctx}/bas/ap/approveConfig/form?id=${approveConfig.id}">新建审批项</a></small>
			</shiro:hasPermission>
			</h1>
	    </section>
	    <sys:tip content="${message}"/>
	    <section class="content">
	    	<div class="row">
	    		<div class="col-md-6">
	    			<form:form id="inputForm" modelAttribute="approveConfig" action="${ctx}/bas/ap/approveConfig/save" method="post" class="form-horizontal" onsubmit="return ZF.formSubmit()">
	    				<form:hidden path="id"/>
	    				<div class="box box-success">
		    				<div class="box-header with-border zf-query">
		    				<h5>请完善表单填写</h5>
				              <div class="box-tools">
				                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
				                </button>    
				              </div>
		    				</div>
		    				<div class="box-body">
		    					<div class="form-group">
	    							<label class="col-sm-2 control-label">审批项名称</label>
									<div class="col-sm-9">
										<sys:inputverify id="categoryNameInput" name="approveName" tip="请输入审批项名称，必填项" verifyType="0" isSpring="true" ></sys:inputverify>
									</div>
	    						</div>
	    						
	    						<div class="form-group">
									<label for="searchParam" class="col-sm-2 control-label" >审批业务类型</label>
									<div class="col-sm-9">
										<sys:selectverify name="businessType" tip="必须选择审批业务类型" verifyType="0" id="businessTypeSelect" dictName="bas_ap_approve_businessType"></sys:selectverify>
									</div>
								</div>
								
								<div class="form-group">
									<label for="searchParam" class="col-sm-2 control-label" >审批业务状态类型</label>
									<div class="col-sm-9">
										<sys:selectverify name="businessStatus" tip="必须选择审批业务状态类型" verifyType="0" id="businessStatusSelect" dictName="bas_ap_approve_businessStatus"></sys:selectverify>
									</div>
								</div>
								
								<div class="form-group">
									<label for="searchParam" class="col-sm-2 control-label" >审批接收人</label>
									<div class="col-sm-9">
										<form:hidden id="approveUserId" path="approveUser.id"/>
										<sys:inputverify id="approveUserInput" name="approveUser.name" value="${fns:getUserById(approveConfig.approveUser.id).name}" tip="请选择审批接收人，必填项" verifyType="0" isSpring="false" forbidInput="true" ></sys:inputverify>
										<sys:userselect id="inventoryUser" url="${ctx}/sys/office/userTreeData" isMulti="false" title="人员选择" height="550" width="550"></sys:userselect>
										
									</div>
								</div>
								
								<div class="form-group">
									<label for="searchParam" class="col-sm-2 control-label" >是否开启</label>
									<div class="col-sm-9">
										<form:radiobuttons path="usableFlag" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required" />
									</div>
								</div>
		    				</div>
		    				<div class="box-footer">
		    					<div class="pull-left box-tools">
					        		<button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
					        	</div>
		    					<div class="pull-right box-tools">
					        		<button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
				               		<shiro:hasPermission name="bas:ap:approveConfig:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
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
		
		$("#approveUserInput").on("click",function(){
			inventoryUserinit({
				"selectCallBack":function(data){
					$("#approveUserId").val(data[0].id)
					$("#approveUserInput").val(data[0].text)
					$("#approveUserInput").trigger('change');
				}
			});
		})
	})
	</script>
</body>
</html>