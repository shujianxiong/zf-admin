<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>产品列表管理-产品修改</title>
	<meta name="decorator" content="adminLte"/>
</head>

<body>
	<div class="content-wrapper sub-content-wrapper">
		<section class="content-header content-header-menu">
			<h1>
				<small>
					<i class="fa-list-style"></i><a href="${ctx}/lgt/ps/produce/list">产品列表</a>
				</small>
				<shiro:hasPermission name="lgt:ps:produce:edit">
					<small>|</small>
					<small class="menu-active">
						<i class="fa fa-repeat"></i><a href="${ctx}/lgt/ps/produce/form?id=${produce.id}">产品修改</a>
					</small>
				</shiro:hasPermission>
			</h1>
		</section>
	
		<sys:tip content="${message}"/>
	
		<section class="content">
		    <form:form id="inputForm" modelAttribute="produce" action="${ctx}/lgt/ps/produce/edit" method="post" onsubmit="return ZF.formSubmit()"  class="form-horizontal">
		    <form:hidden path="id"/>
		    <input type="hidden" name="token" value="${token }" />
		    <!-- 任务 -->
		    <div class="row">
		    	<div class="col-md-6">
		            <div class="box box-success">
			            <div class="box-header with-border zf-query">
			            	<h5>货品入库</h5>
			              	<div class="box-tools">
			                	<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
			              	</div>
			            </div>
			            <div class="box-body">
			            	<div class="form-group">
	   							<label class="col-sm-2 control-label">产品编码</label>
								<div class="col-sm-9">
									<sys:inputverify id="code" name="code" tip="请输入产品编码" verifyType="0" isSpring="true" isMandatory="false" forbidInput="true"></sys:inputverify>
								</div>
	   						</div>
	   						<div class="form-group">
	   							<label class="col-sm-2 control-label">产品名称</label>
								<div class="col-sm-9">
									<sys:inputverify id="name" name="name" tip="请输入产品名称" verifyType="0" isSpring="true" isMandatory="false"></sys:inputverify>
								</div>
	   						</div>
	   						<div class="form-group">
	   							<label class="col-sm-2 control-label">标准克重</label>
								<div class="col-sm-9">
									<sys:inputverify id="standardWeight" name="standardWeight" tip="请输入标准克重" verifyType="5" isSpring="true" isMandatory="false"></sys:inputverify>
								</div>
	   						</div>
	   						<div class="form-group">
    							<label class="col-sm-2 control-label">备注信息</label>
								<div class="col-sm-9">
									<textarea name="remarks" rows="4" maxlength="255" class="form-control input-xxlarge"></textarea>
								</div>
    						</div>
	  					</div>
						<div class="box-footer">
	    					<div class="pull-left box-tools">
				        		<button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
				        	</div>
	    					<div class="pull-right box-tools">
				        		<button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
			               		<button type="button" onclick="submitForm()" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button>
				        	</div>
	    				</div>
		            </div>
	            </div>
	        </div>
	        </form:form>
	    </section>
	</div>
	
   	<script type="text/javascript">
   		// 提交表单
   		function submitForm(){
   			$("#inputForm").submit();
   		}
	</script>
	
</body>
</html>