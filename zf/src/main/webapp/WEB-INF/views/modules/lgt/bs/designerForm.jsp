<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>设计师管理</title>
	<meta name="decorator" content="adminLte"/>
	<script type="text/javascript" src="${ctxStatic}/ckeditor/ckeditor.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			editor = CKEDITOR.replace( 'detail', {
	            on: {
	                instanceReady: function( ev ) {
	                    this.dataProcessor.writer.setRules( 'p', {
	                        indent: false,
	                        breakBeforeOpen: false,   //<p>之前不加换行
	                        breakAfterOpen: false,    //<p>之后不加换行
	                        breakBeforeClose: false,  //</p>之前不加换行
	                        breakAfterClose: false    //</p>之后不加换行7
	                    });
	                }
	            }
	        });
		});
	</script>
</head>
<body>

	<div class="content-wrapper sub-content-wrapper">
	<section class="content-header content-header-menu">
		<h1>
			<small><i class="fa-list-style"></i><a href="${ctx}/lgt/bs/designer/list">设计师列表</a></small>
			<shiro:hasPermission name="sys:user:edit"><small>|</small><small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/lgt/bs/designer/form?id=${designer.id}">设计师${not empty designer.id?'修改':'添加'}</a></small></shiro:hasPermission>
		</h1>
	</section>
	<sys:tip content="${message}"/>
	<section class="content">
		<div class="row">
			<div class="col-md-6">
				<form:form id="inputForm" modelAttribute="designer" action="${ctx}/lgt/bs/designer/save" method="post" class="form-horizontal" onsubmit="return ZF.formSubmit()">
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
								<label for="nameInput" class="col-sm-2 control-label">姓名</label>
								<div class="col-sm-9">
									<sys:inputverify id="nameInput" name="name" tip="请输入姓名,必填项" verifyType="0"  isSpring="true"></sys:inputverify>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">性别</label>
								<div class="col-sm-9 zf-check-wrapper-padding">
									<form:radiobuttons path="sex" items="${fns:getDictList('sex')}" itemLabel="label" itemValue="value" htmlEscape="false" class="form-control"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">年龄</label>
								<div class="col-sm-9">
									<sys:inputverify id="ageInput" name="age" tip="请输入年龄，格式为数字" verifyType="0"  maxlength="3" isSpring="true"></sys:inputverify>
								</div>
							</div>
							<div class="form-group">
								<label for="nameInput" class="col-sm-2 control-label">国籍</label>
								<div class="col-sm-9">
									<form:select path="country" htmlEscape="false" maxlength="50" class="form-control select2">
										<form:option value="" label="请选择"/>
										<form:options items="${fns:getDictList('country')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
									</form:select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">设计风格</label>
								<div class="col-sm-9">
									<form:select path="designStyle" htmlEscape="false" maxlength="50" class="form-control select2">
										<form:option value="" label="请选择"/>
										<form:options items="${fns:getDictList('lgt_bs_designer_designStyle')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
									</form:select>
								</div>
							</div>
							<div class="form-group">
								<label for="nameInput" class="col-sm-2 control-label">标签</label>
								<div class="col-sm-9">
									<sys:inputverify id="tagsInput" name="tags" tip="请输入标签" verifyType="0"  isSpring="true"></sys:inputverify>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">头像</label>
								<div class="col-sm-9">
									<%-- <form:hidden id="gravatar" path="gravatar" htmlEscape="false" maxlength="255" class="input-xlarge"/>
									<sys:ckfinder input="gravatar" type="images" uploadPath="/lgt/bs/designer/gravatar" selectMultiple="false" readonly="false"/> --%>
									
									<form:hidden id="gravatar" path="gravatar" htmlEscape="false" maxlength="255" class="form-control"/>
                                    <sys:fileUpload input="gravatar" model="true" selectMultiple="false"></sys:fileUpload>
									
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">列表图</label>
								<div class="col-sm-9">
									<%-- <form:hidden id="listPhoto" path="listPhoto" htmlEscape="false" maxlength="255" class="input-xlarge"/>
									<sys:ckfinder input="listPhoto" type="images" uploadPath="/lgt/bs/designer/listPhoto" selectMultiple="false" readonly="false"/> --%>
									
									<form:hidden id="listPhoto" path="listPhoto" htmlEscape="false" maxlength="255" class="form-control"/>
                                    <sys:fileUpload input="listPhoto" model="true" selectMultiple="false"></sys:fileUpload>
									
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">形象图</label>
								<div class="col-sm-9">
									<%-- <form:hidden id="headPhoto" path="headPhoto" htmlEscape="false" maxlength="255" class="input-xlarge"/>
									<sys:ckfinder input="headPhoto" type="images" uploadPath="/lgt/bs/designer/headPhoto" selectMultiple="false" readonly="false"/> --%>
									
									<form:hidden id="headPhoto" path="headPhoto" htmlEscape="false" maxlength="255" class="form-control"/>
                                    <sys:fileUpload input="headPhoto" model="true" selectMultiple="false"></sys:fileUpload>
									
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">简介</label>
								<div class="col-sm-9">
									<form:textarea path="summary" class="form-control" rows="3"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">详情</label>
								<div class="col-sm-9">
									<textarea name="detail">${designer.detail }</textarea>
									<sys:preview height="1200" width="700" title="设计师详情" id="detail"></sys:preview>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">是否启用</label>
								<div class="col-sm-9 zf-check-wrapper-padding">
									<form:radiobuttons path="usableFlag" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">是否推荐</label>
								<div class="col-sm-9 zf-check-wrapper-padding">
									<form:radiobuttons path="recommendFlag" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">排列序号</label>
								<div class="col-sm-9">
									<sys:inputverify id="orderNoInput" name="orderNo" tip="请输入正确的序号,整数，必填项" verifyType="0"  maxlength="8" isSpring="true"></sys:inputverify>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">备注信息</label>
								<div class="col-sm-9">
									<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="form-control"/>
								</div>
							</div>
						</div>
						<div class="box-footer">
							<div class="pull-left box-tools">
					        	<button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
					        </div>
		    				<div class="pull-right box-tools">
		    					<c:if test="${empty designer.id}">
		    						<button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
		    					</c:if>
				               	<shiro:hasPermission name="lgt:bs:designer:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
					        </div>
						</div>
					</div>
				</form:form>
			</div>
		</div>
	</section>
	<script type="text/javascript">
		$(function() {
			$('input').iCheck({
				checkboxClass : 'icheckbox_minimal-blue',
				radioClass : 'iradio_minimal-blue'
			});
		});
	</script>
</div>
</body>
</html>