<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>字典管理</title>
	<meta name="decorator" content="adminLte"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#value").focus();
			/* $("#inputForm").validate({
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
			}); */
		});
	</script>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
		<section class="content-header content-header-menu">
	      <h1>
	        <shiro:hasPermission name="sys:dict:view"><small><i class="fa-dict"></i><a href="${ctx}/sys/dict/">字典列表</a></small></shiro:hasPermission>
	        <small>|</small>
	        <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/bas/photoLibrary/form?id=${dict.id}">字典${not empty dict.id?'修改':'添加'}</a></small>
	      </h1>
	    </section>
	    
	    <sys:tip content="${message}"/>
	    
	    <section class="content">
	    	<div class="row">
	    		<div class="col-md-6">
	    			<form:form id="inputForm" modelAttribute="dict" action="${ctx}/sys/dict/save" method="post" class="form-horizontal" onsubmit="return ZF.formSubmit()">
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
								<label for="value" class="col-sm-2 control-label">键值</label>
								<div class="col-sm-8">
									<sys:inputverify name="value" id="valueId" verifyType="0" tip="请填写健值" isSpring="true"></sys:inputverify>
								</div>
							</div>
							
							<div class="form-group">
								<label for="value" class="col-sm-2 control-label">标签</label>
								<div class="col-sm-8">
									<sys:inputverify name="label" id="labelId" verifyType="0" tip="请填写标签" isSpring="true"></sys:inputverify>
								</div>
							</div>
							
							<div class="form-group">
								<label for="value" class="col-sm-2 control-label">类型</label>
								<div class="col-sm-8">
									<sys:inputverify name="type" id="typeId" verifyType="0" tip="请填写类型" isSpring="true"></sys:inputverify>
								</div>
							</div>
							
							<div class="form-group">
								<label for="value" class="col-sm-2 control-label">排序</label>
								<div class="col-sm-8">
									<sys:inputverify name="sort" id="sortId" verifyType="4" tip="请填写排序,格式为:正整数" isSpring="true"></sys:inputverify>
								</div>
							</div>
							
							<div class="form-group">
								<label for="value" class="col-sm-2 control-label">描述</label>
								<div class="col-sm-8">
									<sys:inputverify name="description" id="descriptionId" verifyType="0" tip="请填写描述" isSpring="true"></sys:inputverify>
								</div>
							</div>
							
							<div class="form-group">
								<label for="inputPassword3" class="col-sm-2 control-label">备注</label>
								<div class="col-sm-8">
									<form:textarea path="remarks" htmlEscape="false" rows="3" maxlength="200" class="form-control"/>
								</div>
							</div>
	    				</div>
	    				<div class="box-footer">
	    					<div class="pull-left box-tools">
				        		<button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
				        	</div>
	    					<div class="pull-right box-tools">
	    						<c:if test="${empty dict.id }">
					        		<button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
	    						</c:if>
			               		<shiro:hasPermission name="sys:dict:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
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