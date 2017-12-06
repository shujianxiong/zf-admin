<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>供应商合同管理</title>
<meta name="decorator" content="adminLte" />
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
		<section class="content-header content-header-menu">
			<h1>
				<small><i class="fa-list-style"></i><a
					href="${ctx}/lgt/si/supplierContract/">供应商合同列表</a></small> 
				<shiro:hasPermission name="lgt:si:supplierContract:edit">
					<small>|</small>
					<small class="menu-active"><i class="fa fa-repeat"></i><a
						href="${ctx}/lgt/si/supplierContract/form?id=${supplier.id}">供应商合同${not empty supplierContract.id?'修改':'添加'}</a></small>
				</shiro:hasPermission>
			</h1>
		</section>
		<sys:tip content="${message}" />
		<section class="content">
			<div class="row">
				<div class="col-md-6">
					<form:form id="inputForm" modelAttribute="supplierContract" action="${ctx}/lgt/si/supplierContract/save" method="post" class="form-horizontal" onsubmit="return formSubmit();">
						<div class="box box-success">
							<div class="box-header with-border zf-query">
								<h5>请完善表单填写</h5>
								<div class="box-tools">
									<button type="button" class="btn btn-box-tool"
										data-widget="collapse">
										<i class="fa fa-minus"></i>
									</button>
								</div>
							</div>

							<div class="box-body">
								<form:hidden path="id" />
								<div class="form-group">
					                <label for="supplierId" class="col-sm-2 control-label">供应商</label>
					                <div class="col-sm-9">
					                	<select name="supplier.id" id="supplierId" class="form-control select2">
							                 <option value="" >请选择供应商</option>
							                 <c:forEach items="${supplierList }" var="su">
							                 	<option value="${su.id }" <c:if test="${su.id eq supplierContract.supplier.id}">selected</c:if>>${su.name }</option>
							                 </c:forEach>
						                </select>
					                </div>
					            </div>
					            <div class="form-group">
		    						<label class="col-sm-2 control-label">采购单</label>
									<div class="col-sm-9">
										<div class="input-group">
											<input type="hidden" id="purchaseOrderId" name="purchaseOrder.id" value="${supplierContract.purchaseOrder.id }"/>
											<input type="text" name="purchaseOrder.orderNo" id="purchaseOrderNo" value="${supplierContract.purchaseOrder.orderNo }" placeholder="非必填" class="form-control zf-input-readonly" readonly="true"/>
											<span class="input-group-btn">
												<button id="purchaseOrderButton" type="button" class="btn btn-info btn-flat">选择采购单据</button>
											</span>
										</div>
									</div>
								</div>
								<sys:selectmutil id="purchaseOrderSelect" title="采购单列表" url="" isDisableCommitBtn="true" width="1200" height="700" ></sys:selectmutil>
								<div class="form-group">
									<label class="col-sm-2 control-label">合同类型</label>
									<div class="col-sm-9">
										<sys:selectverify name="type" tip="请选择合同类型，必填项" verifyType="true" dictName="lgt_si_supplier_contract_type" id="type"></sys:selectverify>
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-sm-2 control-label">合同编号</label>
									<div class="col-sm-9">
										<form:input path="contractNo" readonly="true" class="form-control zf-input-readonly"/>
										<%-- <sys:inputverify name="contractNo" id="contractNo" verifyType="0" tip="请输入合同编号，必填项" isSpring="true" isMandatory="true"></sys:inputverify> --%>
									</div>
								</div>
								
								<c:choose>
									<c:when test="${empty supplierContract.id}">
										<%-- <div class="form-group">
											<label class="col-sm-2 control-label">合同编号</label>
											<div class="col-sm-9">
												<div class="input-group">
													<sys:inputverify name="contractNo" id="contractNo" verifyType="0" tip="请输入合同编号，必填项"></sys:inputverify>
													<input type="text" name="contractNo" id="contractNo" class="form-control" value="${supplierContract.contractNo }" placeholder="请输入合同编号，必填项"/>
													<span class="input-group-btn">
														<button id="autoContractNo" type="button" class="btn btn-info btn-flat">自动生成</button>
													</span>
												</div>
											</div>
										</div> --%>
										
										<div class="form-group">
				    						<label class="col-sm-2 control-label">合同文件</label>
											<div class="col-sm-9">
												<%-- <form:hidden id="fileImage" path="file" htmlEscape="false"/>
												<sys:ckfinder input="fileImage" inputName="name" inputValue="${supplierContract.name }" type="files" uploadPath="/lgt/si/supplierContract" selectMultiple="false" readonly="false" maxHeight="10" maxWidth="20"/> --%>
												<form:hidden id="fileUrl" path="fileUrl" htmlEscape="false" maxlength="255" class="form-control"/>
                                                <sys:fileUpload input="fileUrl" model="false" selectMultiple="false" fileDirCode="cght"></sys:fileUpload>
											</div>
			    						</div>
									</c:when>
									<c:otherwise>
										<%-- <div class="form-group">
				    						<label class="col-sm-2 control-label">合同编号</label>
											<div class="col-sm-9">
												<sys:inputverify name="contractNo" id="contractNo" verifyType="0" tip="" isMandatory="true" isSpring="true" forbidInput="true"></sys:inputverify>
											</div>
			    						</div> --%>
			    						<div class="form-group">
				    						<label class="col-sm-2 control-label">合同文件</label>
											<div class="col-sm-9">
											    <input type="hidden" id="fileUrl" value="${supplierContract.fileLibrary.fileUrl }"/>
											    <input type="hidden" id="fileLibraryId" name="fileLibrary.id" value="${supplierContract.fileLibrary.id }"/>
												<a href="#" download="${supplierContract.fileLibrary.name}" href="${imgHost }${supplierContract.fileLibrary.fileUrl}">${supplierContract.fileLibrary.name }</a>
											</div>
			    						</div>
									</c:otherwise>
								</c:choose>
								<div class="form-group">
		    						<label class="col-sm-2 control-label">合同名称</label>
									<div class="col-sm-9">
										<sys:inputverify name="name" id="name" verifyType="0" tip="请输入合同名称，必填项" isSpring="true" forbidInput="false" ></sys:inputverify>
									</div>
	    						</div>
	    						<div class="form-group">
		    						<label class="col-sm-2 control-label">生效时间</label>
									<div class="col-sm-9">
										<sys:datetime id="effectStartTime" inputName="effectStartTime" tip="请选择生效时间，必选项" inputId="effectStartTimeId" isMandatory="true" value="${supplierContract.effectStartTime }"></sys:datetime>
									</div>
	    						</div>
	    						<div class="form-group">
		    						<label class="col-sm-2 control-label">失效时间</label>
									<div class="col-sm-9">
										<sys:datetime id="effectEndTime" inputName="effectEndTime" tip="请选择失效时间，必选项" inputId="effectEndTimeId" isMandatory="true"  value="${supplierContract.effectEndTime }" minDate="${supplierContract.effectStartTime }"></sys:datetime>
									</div>
	    						</div>
								<div class="form-group">
									<label class="col-sm-2 control-label">备注信息</label>
									<div class="col-sm-9">
										<form:input path="remarks" htmlEscape="false" rows="4"
											maxlength="255" class="form-control " />
									</div>
								</div>
							</div>
							<div class="box-footer">
								<div class="pull-left box-tools">
									<button type="button" class="btn btn-default btn-sm"
										onclick="javascript:history.go(-1)">
										<i class="fa fa-mail-reply"></i>返回
									</button>
								</div>
								<div class="pull-right box-tools">
									<c:if test="${empty supplierContract.id }">
										<button type="button" class="btn btn-default btn-sm"
											onclick="ZF.resetForm();">
											<i class="fa fa-refresh"></i>重置
										</button>
									</c:if>
									<shiro:hasPermission name="lgt:si:supplierContract:edit">
										<button type="submit" class="btn btn-info btn-sm">
											<i class="fa fa-save"></i>保存
										</button>
									</shiro:hasPermission>
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
		
		$("#supplierId").on("change", function() {
			$("#purchaseOrderId").val("");
			$("#purchaseOrderNo").val("");
			var sid = $(this).val();
			if(sid != null && sid != "") {
				$("#supplierIdErr").remove();
	            $("#supplierId").attr("data-verify","true");
	            $("span[role=combobox]",$("#supplierId").next()).removeClass("zf-input-err");
			}
		});
		
		$("#purchaseOrderButton").on('click',function(){
			var sval = $("#supplierId").val();
			if(sval.length <= 0) {
				$("#supplierId").addClass("zf-input-err");
				ZF.showTip("请先选择供应商", "info");
				return false;
			}
			$("#purchaseOrderSelectModalUrl").val("${ctx}/lgt/po/purchaseOrderExe/select?supplier.id="+sval)//带参数请求URL设置方式
        	$("#purchaseOrderSelectModal").modal('toggle');//显示模态框
		});
		
		$("#purchaseOrderSelectModal #commitBtn").on("click",function () {
			$("#purchaseOrderSelectModal").modal("hide");		
			var content = $("#purchaseOrderSelectModalIframe").contents().find("body");
			$("input[type=radio]", content).each(function(){
				if($(this).prop("checked")){
					var selVal = $(this).val();
					var arr = selVal.split("=");
					$("#purchaseOrderId").val(arr[0]);
					$("#purchaseOrderNo").val(arr[1]);
				}
			});
		});
		
		/* $("#autoContractNo").on("click", function() {
			ZF.ajaxQuery(false, "${ctx}/lgt/si/supplierContract/autoContractNo",null, function(text) {
				$("#contractNo").attr("readonly","true");
				$("#contractNo").addClass("zf-input-readonly");
				$("#contractNo").val(text);
			});
		}); */
		
	});	
	
	function formSubmit() {
		var verify=true;
		
		var file = $("#fileUrl").val();
        if(file == null || file == "") {
            ZF.showTip("请上传合同文件!","info");
            return false;
        }
		
		var name = $("#name").val();
		if(name.length > 0) {
			$("#name").attr("data-verify","true");
		}
		
		if($("#supplierId").val() == null || $("#supplierId").val() == ""){
			$("span[role=combobox]",$("#supplierId").next()).addClass("zf-input-err");
			if($("#supplierIdErr").length <= 0)
				$("#supplierId").next().after("<label id=\"supplierIdErr\" class=\"control-label zf-label-err\"><i class=\"fa fa-times-circle-o\"></i>请选择供应商，必选项</label>")
			$("#supplierId").attr("data-verify","false");
			verify=false;
		} else {
			$("#supplierIdErr").remove();
			$("#supplierId").attr("data-verify","true");
		}
		
		$("input[data-verify=false]").each(function(){
			console.log("验证未通过的表单input组件:"+$(this).attr("name"));
			if($(this).attr('data-type') == "date"){
				$(this).parent().trigger('dp.change');
			} else {
				$(this).trigger('change');
			}
			verify=false;
		});
		
		$("select[data-verify=false]").each(function() {
			console.log("验证未通过的表单select组件:"+$(this).attr("name"));
			$(this).trigger('change');
			verify=false;
		});
		
		
		/* var noInput = $("#contractNo");
		if(noInput.val() == null || noInput.val() == "") {
			noInput.addClass("zf-input-err");
			if($("#contractNoErr").length<=0)
				noInput.parent().after("<label id=\"contractNoErr\" class=\"control-label zf-label-err\"><i class=\"fa fa-times-circle-o\"></i>请输入合同编号，必填项</label>");
			noInput.attr("data-verify", "false");
			verify = false;
		} */
		
		return verify;
	}
	
	function xz(url) {
        return window.open(url);
    }
	
</script>
</body>
</html>