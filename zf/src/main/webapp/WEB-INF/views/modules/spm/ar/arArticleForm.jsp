<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>宣传推广文章管理</title>
	<meta name="decorator" content="adminLte"/>
	<script type="text/javascript" src="${ctxStatic}/ckeditor/ckeditor.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			editor = CKEDITOR.replace( 'content', {
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
				<small>
					<i class="fa-list-style"></i><a href="${ctx}/spm/ar/arArticle/">宣传文章列表</a>
				</small>
				<shiro:hasPermission name="spm:ar:arArticle:edit">
					<small>|</small>
					<small class="menu-active">
						<i class="fa fa-repeat"></i><a href="${ctx}/spm/ar/arArticle/form?id=${arArticle.id}">宣传文章<c:if test="${empty arArticle.id }">添加</c:if><c:if test="${not empty arArticle.id }">修改</c:if></a>
					</small>
				</shiro:hasPermission>
			</h1>
		</section>
		
		<sys:tip content="${message}" />

		<section class="content">
			<form:form id="inputForm" onsubmit="return ZF.formSubmit()" modelAttribute="arArticle" action="${ctx}/spm/ar/arArticle/save" method="post" class="form-horizontal">
			<form:hidden path="id"/>
			<div class="row">
		    	<div class="col-md-12">
		            <div class="box box-success">
			            <div class="box-header with-border zf-query">
			            	<h5>文章基础设置</h5>
			              	<div class="box-tools">
			                	<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
			              	</div>
			            </div>
			            <div class="box-body">
			            	<div class="row">
			            		<div class="col-md-4">
		    						<div class="form-group">
		    							<label class="col-sm-3 control-label">文章编码</label>
										<div class="col-sm-8">
											<sys:inputverify id="code" name="code" tip="请输入宣传文章编码" verifyType="0" isSpring="true" isMandatory="false"></sys:inputverify>
										</div>
		    						</div>
		    					</div>
		    					<div class="col-md-4">
		    						<div class="form-group">
		    							<label class="col-sm-3 control-label">文章名称</label>
										<div class="col-sm-8">
											<sys:inputverify id="name" name="name" tip="请输入宣传文章名称，必填项" verifyType="0" isSpring="true" isMandatory="true"></sys:inputverify>
										</div>
		    						</div>
		    					</div>
		    					<div class="col-md-4">
		    						<div class="form-group">
		    							<label class="col-sm-3 control-label">文章类别</label>
										<div class="col-sm-8">
											<form:select path="category" htmlEscape="false" maxlength="50" class="form-control select2">
												<form:option value="" label="请选择"/>
												<form:options items="${fns:getDictList('spm_ar_article_category')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
											</form:select>
										</div>
		    						</div>
		    					</div>
		    				</div>
		    				<div class="row">
		    					<div class="col-md-4">
		    						<div class="form-group">
		    							<label class="col-sm-3 control-label">文章标签</label>
										<div class="col-sm-7">
											<sys:inputverify id="tags" name="tags" tip="请输入宣传文章标签，以,分割" verifyType="0" isSpring="true" isMandatory="false"></sys:inputverify>
										</div>
										<label class="control-label">（,分割）</label>
		    						</div>
		    					</div>
		    					<div class="col-md-4">
		    						<div class="form-group">
		    							<label class="col-sm-3 control-label">标题</label>
										<div class="col-sm-8">
											<sys:inputverify id="title" name="title" tip="请输入宣传文章标题，必填项" verifyType="0" isSpring="true" isMandatory="true"></sys:inputverify>
										</div>
		    						</div>
		    					</div>
		    					<div class="col-md-4">
		    						<div class="form-group">
		    							<label class="col-sm-3 control-label">副标题</label>
										<div class="col-sm-8">
											<sys:inputverify id="subtitle" name="subtitle" tip="请输入宣传文章副标题" verifyType="0" isSpring="true" isMandatory="false"></sys:inputverify>
										</div>
		    						</div>
		    					</div>
		    					<div class="col-md-4">
		    					</div>
		    				</div>
		    				<div class="row">
		    					<div class="col-md-4">
		    						<div class="form-group">
		    							<label class="col-sm-3 control-label">发布时间</label>
										<div class="col-sm-8">
											<sys:datetime id="publishTimeSys" inputId="publishTime" inputName="publishTime" tip="请选择发布时间，必选项" isMandatory="true" value="${arArticle.publishTime}"></sys:datetime>
										</div>
		    						</div>
		    					</div>
		    					<div class="col-md-4">
		    						<div class="form-group">
										<label class="col-sm-3 control-label">启用状态</label>
										<div class="col-sm-8 zf-check-wrapper-padding">
											<form:radiobuttons path="activeFlag" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required"/>
										</div>
									</div>
		    					</div>
		    					<div class="col-md-4">
		    						<div class="form-group">
		    							<label class="col-sm-3 control-label">排列序号</label>
										<div class="col-sm-8">
											<sys:inputverify id="orderNo" name="orderNo" maxlength="8" tip="请输入正确的序号,整数，必填项" verifyType="4" isSpring="true" isMandatory="false"></sys:inputverify>
										</div>
		    						</div>
		    					</div>
		    				</div>
						</div>
		            </div>
	            </div>
            </div>
            <div class="row">
		    	<div class="col-md-12">
		            <div class="box box-success">
			            <div class="box-header with-border zf-query">
			            	<h5>文章内容设置</h5>
			              	<div class="box-tools">
			                	<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
			              	</div>
			            </div>
			            <div class="box-body">
			            	<div class="row">
		    					<div class="col-md-12">
		    						<div class="form-group">
		    							<label class="col-sm-1 control-label">分享小图</label>
										<div class="col-sm-8">
											<%-- <form:hidden id="shareSPhoto" path="shareSPhoto" htmlEscape="false" maxlength="255" class="input-xlarge"/>
											<sys:ckfinder input="shareSPhoto" type="images" uploadPath="/spm/ar/arArticle" selectMultiple="false"/> --%>
											
											<form:hidden id="shareSPhoto" path="shareSPhoto" htmlEscape="false" maxlength="255" class="form-control"/>
                                            <sys:fileUpload input="shareSPhoto" model="true" selectMultiple="false"></sys:fileUpload>
											
										</div>
		    						</div>
		    					</div>
		    				</div>
		    				<div class="row">
		    					<div class="col-md-12">
		    						<div class="form-group">
		    							<label class="col-sm-1 control-label">分享中图</label>
										<div class="col-sm-8">
											<%-- <form:hidden id="shareMPhoto" path="shareMPhoto" htmlEscape="false" maxlength="255" class="input-xlarge"/>
											<sys:ckfinder input="shareMPhoto" type="images" uploadPath="/spm/ar/arArticle" selectMultiple="false"/> --%>
											
											<form:hidden id="shareMPhoto" path="shareMPhoto" htmlEscape="false" maxlength="255" class="form-control"/>
                                            <sys:fileUpload input="shareMPhoto" model="true" selectMultiple="false"></sys:fileUpload>
											
										</div>
		    						</div>
		    					</div>
		    				</div>
			            	<div class="row">
		    					<div class="col-md-12">
		    						<div class="form-group">
		    							<label class="col-sm-1 control-label">简介</label>
										<div class="col-sm-8">
											<form:textarea path="summary" htmlEscape="false" rows="4" maxlength="200" class="form-control"/>
										</div>
		    						</div>
		    					</div>
		    				</div>
		    				<div class="row">
		    					<div class="col-md-12">
		    						<div class="form-group">
		    							<label class="col-sm-1 control-label">内容</label>
										<div class="col-sm-8">
											<textarea id="content" name="content">${arArticle.content }</textarea>
										</div>
		    						</div>
		    					</div>
		    				</div>
		    				<div class="row">
		    					<div class="col-md-12">
		    						<div class="form-group">
		    							<label class="col-sm-1 control-label">备注信息</label>
										<div class="col-sm-8">
											<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="form-control "/>
										</div>
		    						</div>
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
		$(function(){
			$('input').iCheck({
				checkboxClass : 'icheckbox_minimal-blue',
				radioClass : 'iradio_minimal-blue'
			});
		});
		
		function submitForm(){
			if(validateForm()){				
				$("#inputForm").submit();			
			}
		}
		
		function validateForm(){
			if($("#name").val() == null || $("#name").val() == ""){
				ZF.showTip("请设置文章名称！","info");
				return false;
			}
			if($("#category").val() == null || $("#category").val() == ""){
				ZF.showTip("请选择文章类别！","info");
				return false;
			}
			if($("#tags").val() == null || $("#tags").val() == ""){
				ZF.showTip("请设置文章标签！","info");
				return false;
			}
			if($("#title").val() == null || $("#title").val() == ""){
				ZF.showTip("请设置文章标题！","info");
				return false;
			}
			if($("#publishTime").val() == null || $("#publishTime").val() == ""){
				ZF.showTip("请设置发布时间！","info");
				return false;
			}
			if($("#summary").val() == null || $("#summary").val() == ""){
				ZF.showTip("请填写文章简介！","info");
				return false;
			}
// 			if($("#content").innerHTML() == null || $("#content").val() == ""){
// 				ZF.showTip("请填写文章内容！","info");
// 				return false;
// 			}
			return true;
		}
	</script>
</body>
</html>