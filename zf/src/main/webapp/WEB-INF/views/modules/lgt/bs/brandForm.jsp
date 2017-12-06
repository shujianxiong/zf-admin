<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>品牌管理</title>
	<meta name="decorator" content="adminLte"/>
</head>
<body>
	
	<div class="content-wrapper sub-content-wrapper">
	<section class="content-header content-header-menu">
		<h1>
			<small><i class="fa-list-style"></i><a href="${ctx}/lgt/bs/brand/list">品牌列表</a></small>
			<shiro:hasPermission name="sys:user:edit"><small>|</small><small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/lgt/bs/brand/form?id=${brand.id}">品牌${not empty brand.id?'修改':'添加'}</a></small></shiro:hasPermission>
		</h1>
	</section>
	<sys:tip content="${message}"/>
	<section class="content">
		<div class="row">
			<div class="col-md-6">
				<form:form id="inputForm" modelAttribute="brand" action="${ctx}/lgt/bs/brand/save" method="post" class="form-horizontal" onsubmit="return formSubmit()">
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
                                <label class="col-sm-2 control-label">品牌Logo</label>
                                <div class="col-sm-9">
                                    <form:hidden id="logo" path="logo" htmlEscape="false" maxlength="255" class="form-control"/>
                                    <sys:fileUpload input="logo" model="true" selectMultiple="false"></sys:fileUpload>
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <label class="col-sm-2 control-label">品牌头部图</label>
                                <div class="col-sm-9">
                                    <form:hidden id="topPhoto" path="topPhoto" htmlEscape="false" maxlength="255" class="form-control"/>
                                    <sys:fileUpload input="topPhoto" model="true" selectMultiple="false"></sys:fileUpload>
                                </div>
                            </div>
							
							<div class="form-group">
								<label for="nameInput" class="col-sm-2 control-label">品牌名称</label>
								<div class="col-sm-9">
									<sys:inputverify id="nameInput" name="name" tip="请输入品牌名称，必填项" verifyType="0"  isSpring="true"></sys:inputverify>
								</div>
							</div>
							<div class="form-group">
								<label for="nameInput" class="col-sm-2 control-label">品牌公司名称</label>
								<div class="col-sm-9">
									<sys:inputverify id="companyNameInput" name="companyName" tip="请输入品牌公司名称，必填项" verifyType="0"  isSpring="true"></sys:inputverify>
								</div>
							</div>
							
							<div class="form-group">
								<label for="typeInput" class="col-sm-2 control-label">品牌类型</label>
								<div class="col-sm-9">
									<sys:selectverify name="type" tip="请选择品牌类型" verifyType="0" dictName="lgt_bs_brand_type" id="type"></sys:selectverify>
								</div>
							</div>
							
							<div class="form-group">
								<label for="nameInput" class="col-sm-2 control-label">品牌状态</label>
								<div class="col-sm-9">
									<sys:selectverify name="brandStatus" tip="请选择品牌状态" verifyType="0" dictName="brand_status" id="brandStatusId"></sys:selectverify>
								</div>
							</div>
							<div class="form-group">
								<label for="nameInput" class="col-sm-2 control-label">品牌简介</label>
								<div class="col-sm-9">
									<form:textarea path="introduction" htmlEscape="false" rows="4" maxlength="255" class="form-control "/>
								</div>
							</div>
							<div class="form-group">
								<label for="nameInput" class="col-sm-2 control-label">备注信息</label>
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
		    					<c:if test="${empty brand.id}">
		    						<button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
		    					</c:if>
				               	<shiro:hasPermission name="lgt:si:supplier:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
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
		
		
		function formSubmit() {
			var verify=true;
			var form = $("#inputForm");
			
			var logo = $("#logo").val();
			console.log(logo);
			if(logo == null || logo == "" || logo == undefined) {
				ZF.showTip("请先上传品牌Logo", "info");
				return false;
			}
			
	        var inputs=$("input[data-verify=false]",form);
	        for(var i=0;i<inputs.length;i++){
	            if($(inputs[i]).attr('data-type') == "date"){
	                $(inputs[i]).parent().trigger('dp.change');
	            }else{
	                $(inputs[i]).trigger('change');
	            }
	            verify=false;
	        }
	        var selects=$("select[data-verify=false]",form);
	        for(var i=0;i<selects.length;i++){
	            $(selects[i]).trigger('change');
	            verify=false;
	        }
	        
	        return verify;
		}
	</script>
</div>
</body>
</html>