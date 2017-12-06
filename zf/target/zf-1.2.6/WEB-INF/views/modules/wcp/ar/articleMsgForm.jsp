<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>图文消息管理</title>
	<meta name="decorator" content="adminLte"/>
	<script type="text/javascript">
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
<div class="content-wrapper sub-content-wrapper">
	<section  class="content-header content-header-menu">
		<h1>
			<small><i class="fa-list-style"></i><a href="${ctx}/wcp/ar/articleMsg/list">图文消息列表</a></small>
			
			<shiro:hasPermission name="wcp:ar:articleMsg:edit"><small>|</small><small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/wcp/ar/articleMsg/form?id=${articleMsg.id}">图文消息${not empty articleMsg.id?'修改':'添加'}</a></small></shiro:hasPermission>
		</h1>
	</section>
	<sys:tip content="${message}"/>
	<section class="content">
		<div class="row">
			<div class="col-md-6">
				<form:form id="inputForm" modelAttribute="articleMsg" action="${ctx}/wcp/ar/articleMsg/save" method="post" class="form-horizontal" onsubmit="return ZF.formSubmit();">
					<div class="box box-success">
						<div class="box-header with-border zf-query">
		    				<h5>请完善表单填写</h5>
				            <div class="box-tools">
				               <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
				            </div>
		    			</div>
						<div class="box-body">
							<form:hidden path="id" />
							<div class="form-group">
								<label class="col-sm-2 control-label">名称</label>
								<div class="col-sm-9">
									<sys:inputverify id="name" name="name" tip="请输入活动名称，必填项" verifyType="99" maxlength="80" isSpring="true"></sys:inputverify>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">标题</label>
								<div class="col-sm-9">
									<sys:inputverify id="title" name="title" tip="请输入活动名称，必填项" verifyType="99" maxlength="80" isSpring="true"></sys:inputverify>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">描述</label>
								<div class="col-sm-9">
									<form:textarea path="description" id="description" rows="3" maxlength="200"  class="form-control"></form:textarea>
								</div>
							</div>
							<div class="form-group">
	    						<label class="col-sm-2 control-label">封面图</label>
								<div class="col-sm-9">
									<%-- <form:hidden id="pic" path="pic" htmlEscape="false" maxlength="255" class="form-control"/>
									<sys:ckfinder input="pic" type="images" uploadPath="/wcp/ar/articleMsg" selectMultiple="false" readonly="false" maxHeight="200" maxWidth="100"/> --%>
									
									<form:hidden id="pic" path="pic" htmlEscape="false" maxlength="255" class="form-control"/>
                                    <sys:fileUpload input="pic" model="true" selectMultiple="false"></sys:fileUpload>
									
								</div>
	    					</div>
	    					<div class="form-group">
								<label class="col-sm-2 control-label">跳转链接</label>
								<div class="col-sm-9">
									<sys:inputverify id="linkUrl" name="linkUrl" tip="请输入跳转链接，必填项" verifyType="99" maxlength="255" isSpring="true"></sys:inputverify>
								</div>
							</div>
	    					<div class="form-group">
								<label class="col-sm-2 control-label">排序权重</label>
								<div class="col-sm-9 zf-check-wrapper-padding">
									<sys:inputverify id="orderWeight" name="orderWeight" tip="请输入排序权重，格式为数字,必填项" verifyType="4" maxlength="9" isSpring="true"></sys:inputverify>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">备注</label>
								<div class="col-sm-9">
									<form:textarea path="remarks" htmlEscape="false" rows="3" maxlength="200" class="form-control"/>
								</div>
							</div>
						</div>
						<div class="box-footer">
							<div class="pull-left box-tools">
					        	<button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
					        </div>
		    				<div class="pull-right box-tools">
		    					<c:if test="${empty articleMsg.id }">
						        	<button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
		    					</c:if>
				               	<shiro:hasPermission name="wcp:ar:articleMsg:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
					        </div>
						</div>
					</div>
				</form:form>
			</div>
		</div>
	</section>
	</div>
<script type="text/javascript">
	$(function() {
		
	});
</script>
</body>
</html>