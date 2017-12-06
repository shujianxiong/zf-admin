<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>仓库列表管理</title>
	<meta name="decorator" content="adminLte"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#submitBtn").on("click",function(){
				console.log($("#responsibelUserId").val());
				var flag = ZF.formSubmit();
				$("button[type=submit]").attr('disabled',false);
	            if(flag) {
	                var province = $("#province").val();
	                if(province == null || province == '-1') {
	                    ZF.showTip("请选择归属区域!", "info");
	                    return false;
	                }
	                var city = $("#city").val();
	                if(city == null || city == '-1') {
	                    ZF.showTip("请选择归属区域!", "info");
	                    return false;
	                }
	                var district = $("#district").val();
	                if(district == null || district == '-1') {
	                    ZF.showTip("请选择归属区域!", "info");
	                    return false;
	                }
					if($("#idHidden").val() == null || $("#idHidden").val() == ""){
						// 新增仓库
						confirm("确定新增对应仓库？新增仓库会同时初始化该仓库的产品库存数据，该过程耗时取决于系统产品数量，请耐心等待！","warning",function(){
							$("#inputForm").submit();
						});					
					}else {
						// 修改仓库
						$("#inputForm").submit();
					}
	            }
			});
			//$("#name").focus();
// 			$("#inputForm").validate({
// 				submitHandler: function(form){
// 					loading('正在提交，请稍等...');
// 					form.submit();
// 				},
// 				errorContainer: "#messageBox",
// 				errorPlacement: function(error, element) {
// 					$("#messageBox").text("输入有误，请先更正。");
// 					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
// 						error.appendTo(element.parent().parent());
// 					} else {
// 						error.insertAfter(element);
// 					}
// 				}
// 			});
		});
	</script>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
		<section class="content-header content-header-menu">
			<h1>
		        <small>
		        	<i class="fa-list-style"></i><a href="${ctx}/lgt/ps/warehouse/">仓库列表</a>
		        </small>
		        <shiro:hasPermission name="lgt:ps:warehouse:edit">
			        <small>|</small>
		        	<small class="menu-active">
		        		<i class="fa fa-repeat"></i><a href="${ctx}/lgt/ps/warehouse/form?id=${warehouse.id}">仓库<shiro:hasPermission name="lgt:ps:warehouse:edit">${not empty warehouse.id?'修改':'添加'}</shiro:hasPermission></a>
		        	</small>
		        </shiro:hasPermission>
		    </h1>
		</section>
		<sys:tip content="${message}"/>	
		<section class="content">
			<div class="row">
				<div class="col-md-6">
					<form:form id="inputForm" modelAttribute="warehouse" action="${ctx}/lgt/ps/warehouse/save" method="post" class="form-horizontal" onsubmit="">
						<input type="hidden" id="idHidden" name="id" value="${warehouse.id }"/>
						<div class="box box-success">
							<div class="box-header with-border zf-query">
								仓库${not empty warehouse.id?'修改':'添加'}
							</div>
							<div class="box-body">
								<div class="form-group">
									<label class="col-sm-2 control-label">仓库编码</label>
									<div class="col-sm-9">
										<sys:inputverify name="code" isSpring="true" tip="请输入仓库编码，必填项" verifyType="0" id="codeInput" isMandatory="true"></sys:inputverify>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-2 control-label">仓库名称</label>
									<div class="col-sm-9">
										<sys:inputverify name="name" isSpring="true" tip="请输入仓库名称，必填项" verifyType="0" id="nameInput" isMandatory="true"></sys:inputverify>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-2 control-label">仓库类型</label>
									<div class="col-sm-9">
										<sys:selectverify name="type" tip="请选择仓库类型，必填项" isMandatory="true" verifyType="0" dictName="lgt_ps_warehouse_type" id="typeSelect"></sys:selectverify>
									</div>
								</div>
								<%-- <sys:inputtree name="area.id" url="${ctx}/sys/area/treeData" id="warearea" label="所处区域" labelValue="" labelWidth="2" inputWidth="9" 
										labelName="area.name" value="" tip="请选择区域" verifyType="0"></sys:inputtree> --%>
										
							    <div class="form-group">
                                <label class="col-sm-2 control-label">所处区域</label>
                                <div class="col-sm-9">
                                     <sys:cascading name="area.id" value="${warehouse.area.id }" parentIds="${warehouse.area.parentIds }" provinceList="${provinceList }" cityList="${cityList }" districtList="${districtList }"></sys:cascading>
                                </div>
                            </div> 
										
								<div class="form-group">
									<label class="col-sm-2 control-label">地址详情</label>
									<div class="col-sm-9">
										<sys:inputverify name="areaDetail" tip="请输入地址详情，必填项" isMandatory="true" verifyType="0" id="areaDetailInput" isSpring="ture" value="${warehouse.areaDetail }"></sys:inputverify>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-2 control-label">仓库布局图</label>
									<div class="col-sm-9">
										<%-- <form:hidden id="layoutPhoto" path="layoutPhoto" htmlEscape="false" maxlength="255"/>
										<sys:ckfinder input="layoutPhoto" type="files" uploadPath="/lgt/ps/warehouse" selectMultiple="false" readonly="false"/> --%>
										
										<form:hidden id="layoutPhoto" path="layoutPhoto" htmlEscape="false" maxlength="255" class="form-control"/>
                                        <sys:fileUpload input="layoutPhoto" model="true" selectMultiple="false"></sys:fileUpload>
										
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-2 control-label">负责人</label>
									<div class="col-sm-9">
										<input type="hidden" id="responsibelUserId" name="responsibleUser.id" value="${warehouse.responsibleUser.id }"/>
										<sys:inputverify name="responsibleUser.name" tip="请选择负责人，必填项" isMandatory="true" verifyType="0" id="responsibelUserName" forbidInput="true" value="${warehouse.responsibleUser.name }"></sys:inputverify>
				            			<sys:userselect id="responsibleUser" url="${ctx}/sys/office/userTreeData" isMulti="false" title="人员选择" height="550" width="550"></sys:userselect>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-2 control-label">负责人电话</label>
									<div class="col-sm-9">
										<sys:inputverify name="responsibleMobile" tip="请输入负责人电话" verifyType="0" id="responsibleMobileInput" isSpring="true"></sys:inputverify>
									</div>
								</div>
								<div class="form-group">
		   							<label class="col-sm-2 control-label">排列序号</label>
									<div class="col-sm-9">
										<sys:inputverify id="orderNo" name="orderNo" maxlength="8" tip="请输入正确的序号,整数，必填项" verifyType="4" isSpring="true" isMandatory="true"></sys:inputverify>
									</div>
		   						</div>
								<div class="form-group">
									<label class="col-sm-2 control-label">是否启用</label>
									<div class="col-sm-9 zf-check-wrapper-padding">
										<form:radiobuttons path="usableFlag" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false" placeholder="请输入启用标志"/>
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
					        		<button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
				               		<shiro:hasPermission name="lgt:ps:warehouse:edit"><button type="button" id="submitBtn" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
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
                radioClass : 'iradio_minimal-blue'
            });
			
			$("#responsibelUserName").on("click",function(){
				responsibleUserinit({
			   		"selectCallBack":function(list){
	   					$("#responsibelUserName").val(list[0].text);
	   					$("#responsibelUserId").val(list[0].id);
	   					
	   					
	   					$("#responsibelUserName").removeClass("zf-input-err");
	   					$("#responsibelUserNameErr").remove();
					}
				});
			})
		})
	</script>
</body>
</html>