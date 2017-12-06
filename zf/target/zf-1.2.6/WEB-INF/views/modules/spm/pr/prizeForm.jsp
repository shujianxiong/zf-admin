<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>奖品管理</title>
	<meta name="decorator" content="adminLte"/>
	<script type="text/javascript" src="${ctxStatic}/ckeditor/ckeditor.js"></script>
	<script type="text/javascript">
		/* $(document).ready(function() {
			editor = CKEDITOR.replace( 'introduce', {
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
			
		}); */
		
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
			<small><i class="fa-list-style"></i><a href="${ctx}/spm/pr/prize/list">奖品列表</a></small>
			
			<shiro:hasPermission name="spm:pr:prize:edit"><small>|</small><small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/spm/pr/prize/form?id=${prize.id}">奖品${not empty prize.id?'修改':'添加'}</a></small></shiro:hasPermission>
		</h1>
	</section>
	<sys:tip content="${message}"/>
	<section class="content">
		<div class="row">
			<div class="col-md-6">
				<form:form id="inputForm" modelAttribute="prize" action="${ctx}/spm/pr/prize/save" method="post" class="form-horizontal" onsubmit="return ZF.formSubmit();">
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
								<label class="col-sm-2 control-label">奖品编号</label>
								<div class="col-sm-9">
									<form:hidden path="code"/>
									<form:input path="code" class="form-control zf-input-readonly" readonly="true" disabled="true"/>
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-sm-2 control-label">奖品名称</label>
								<div class="col-sm-9">
									<sys:inputverify name="name" id="name" verifyType="0" tip="请输入奖品名称,必填项" isMandatory="true" isSpring="true"></sys:inputverify>
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-sm-2 control-label">奖品类型</label>
								<div class="col-sm-9">
									<sys:selectverify name="type" tip="请选择奖品类型，必选项" verifyType="0" dictName="SPM_PR_PRIZE_TYPE" id="type" isMandatory="true" value="${prize.type }"></sys:selectverify>
								</div>
							</div>
							
<!-- 	    					<div class="form-group"> -->
<!-- 								<label class="col-sm-2 control-label">奖品状态</label> -->
<!-- 								<div class="col-sm-9 zf-check-wrapper-padding"> -->
<%-- 									<form:radiobuttons path="status" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" class="minimal"  htmlEscape="false"/> --%>
<!-- 								</div> -->
<!-- 							</div> -->
							
							<div class="form-group">
								<label class="col-sm-2 control-label">展示金额</label>
								<div class="col-sm-9">
									<sys:inputverify name="displayPrice" id="displayPrice" verifyType="9" maxlength="4" tip="请输入展示金额，必填项" isSpring="true"></sys:inputverify>
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-sm-2 control-label">预览图</label>
								<div class="col-sm-9">
									<%-- <form:hidden id="mainPhoto" path="mainPhoto" htmlEscape="false" maxlength="255"/>
									<sys:ckfinder input="mainPhoto" type="images" uploadPath="/spm/pr/prize" selectMultiple="false" readonly="false" maxHeight="100" maxWidth="100"/> --%>
									
									<form:hidden id="mainPhoto" path="mainPhoto" htmlEscape="false" maxlength="255" class="form-control"/>
                                    <sys:fileUpload input="mainPhoto" model="true" selectMultiple="false"></sys:fileUpload>
									
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-sm-2 control-label">展示图片</label>
								<div class="col-sm-9">
									<%-- <form:hidden id="displayPhotos" path="displayPhotos" htmlEscape="false" maxlength="255"/>
									<sys:ckfinder input="displayPhotos" type="images" uploadPath="/spm/pr/prize" selectMultiple="false" readonly="false" maxHeight="100" maxWidth="100"/> --%>
									
									<form:hidden id="displayPhotos" path="displayPhotos" htmlEscape="false" maxlength="255" class="form-control"/>
                                    <sys:fileUpload input="displayPhotos" model="true" selectMultiple="false"></sys:fileUpload>
									
								</div>
							</div>
							
	    					<div class="form-group">
								<label class="col-sm-2 control-label">所需积分</label>
								<div class="col-sm-9">
									<sys:inputverify name="costPoint" id="costPoint" verifyType="4" maxlength="9" tip="请输入所需积分，必填项" isSpring="true"></sys:inputverify>
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-sm-2 control-label">库存数量</label>
								<div class="col-sm-9">
									<sys:inputverify name="stockNum" id="stockNum" verifyType="4" maxlength="9" tip="请输入库存数量，必填项" isSpring="true"></sys:inputverify>
									<form:hidden path="usableNum"/>
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-sm-2 control-label">奖品介绍</label>
								<div class="col-sm-9">
									<form:textarea path="introduce" class="form-control" rows="3" maxlength="200"  />
									<%-- <textarea id="introduce" name="introduce" maxlength="200" >${prize.introduce }</textarea> --%>
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
		    					<c:if test="${empty prize.id }">
						        	<button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
		    					</c:if>
				               	<shiro:hasPermission name="spm:pr:prize:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
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
		$('input').iCheck({
			checkboxClass : 'icheckbox_minimal-blue',
			radioClass : 'iradio_minimal-blue'
		});
		
		$("#stockNum").on("change", function() {
			if($(this).val() <= 0) {
				$(this).addClass("zf-input-err");
				ZF.showTip("库存数量需要大于0", "info");
				return false;
			}
		});
		
	});
	
	/* function formSubmit() {
		var verify=true;
		var inputs=$("input[data-verify=false]");
		for(var i=0;i<inputs.length;i++){
			if($(inputs[i]).attr('data-type') == "date"){
				$(inputs[i]).parent().trigger('dp.change');
			}else{
				$(inputs[i]).trigger('change');
			}
			verify=false;
		}
		var selects=$("select[data-verify=false]");
		for(var i=0;i<selects.length;i++){
			$(selects[i]).trigger('change');
			verify=false;
		}
		
		var intro = CKEDITOR.instances.introduce.getData();
		if(intro.length <= 0) {
			ZF.showTip("请填写奖品介绍，必填项", "info");
			verify = false;
		}
		
		return verify;
		
		
	} */
</script>

</body>
</html>