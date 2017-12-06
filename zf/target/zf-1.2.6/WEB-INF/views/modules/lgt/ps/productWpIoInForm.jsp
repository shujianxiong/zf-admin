<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>货品入库管理</title>
	<meta name="decorator" content="adminLte"/>
</head>

<body>
	<div class="content-wrapper sub-content-wrapper">
	    <section class="content-header content-header-menu">
	    	<h1>
		        <small>
		        	<i class="fa-list-style"></i><a href="${ctx}/lgt/ps/productWpIo/">货品出入库记录列表</a>
		        </small>
		        <small>|</small>
		        <small class="menu-active">
		        	<i class="fa fa-repeat"></i><a href="${ctx}/lgt/ps/productWpIo/inForm">货品入库</a>
		        </small>
		        <small>|</small>
		        <small>
		        	<i class="fa-out-house"></i><a href="${ctx}/lgt/ps/productWpIo/outForm">货品出库</a>
		        </small>
	      	</h1>
	    </section>
	    
	    <sys:tip content="${message}"/>

		<section class="content">
			<form:form id="inputForm" modelAttribute="productWpIo" action="${ctx}/lgt/ps/productWpIo/inSave" method="post" class="form-horizontal">
			<form:hidden path="id"/>
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
    							<label class="col-sm-2 control-label">所属产品</label>
								<div class="col-sm-9">
									<input type="hidden" id="productProduceId" name="product.produce.id" value=""/>
									<sys:inputverify id="chooseProduceBtn" name="" tip="请选择入库产品，必填项" isMandatory="true" verifyType="0" isSpring="true" forbidInput="true"></sys:inputverify>
									<sys:selectmutil id="produceSelect" title="产品选择" url="" isDisableCommitBtn="true" width="1200" height="700" ></sys:selectmutil>	
								</div>
    						</div>
			            	<div class="form-group">
    							<label class="col-sm-2 control-label">操作原因类型</label>
								<div class="col-sm-9">
									<form:select path="ioReasonType" htmlEscape="false" maxlength="50" class="form-control select2">
										<form:option value="" label="请选择"/>
										<form:options items="${inDictList}" itemLabel="label" itemValue="value" htmlEscape="false"/>
									</form:select>
								</div>
    						</div>
    						<div class="form-group">
    							<label class="col-sm-2 control-label">入库货品类型</label>
								<div class="col-sm-9">
									<sys:selectverify name="inType" tip="请选择入库货品的类型，必填项" isMandatory="true" verifyType="0" dictName="lgt_ps_product_wp_io_inType" id="inType"></sys:selectverify>
								</div>
    						</div>    
			            	<div class="form-group">
    							<label class="col-sm-2 control-label">货品入库后状态</label>
								<div class="col-sm-9">
									<sys:selectverify name="inStatus" tip="请选择货品入库后的状态，必填项" isMandatory="true" verifyType="0" dictName="lgt_ps_product_status" id="inStatus"></sys:selectverify>
								</div>
    						</div>    						
    						<div class="form-group">
    							<label class="col-sm-2 control-label">货品克重</label>
								<div class="col-sm-9">
									<sys:inputverify id="productWeight" name="product.weight" tip="请输入货品克重，必填项" isMandatory="true" verifyType="5" isSpring="true" value=""></sys:inputverify>
								</div>
    						</div>
    						
    						<sys:selectmutil id="supplierSelect" title="选择供应商" url="${ctx}/lgt/si/supplier/select?pageKey=productWpIoInFormForS" isDisableCommitBtn="true" width="1200" height="700" isRefresh="false"></sys:selectmutil>
                                
                            <div class="form-group" id="supplierDiv">
                                <label class="col-sm-2 control-label">供应商</label>
                                <div class="col-sm-9">
                                    <div class="input-group">
                                        <input type="hidden" id="supplierId" name="supplier.id" value="${productWpIo.supplier.id }"/>
                                        <input type="text" name="supplier.name" id="supplierName" value="${productWpIo.supplier.name }" placeholder="必填" class="form-control zf-input-readonly" readonly="true"/>
                                        <span class="input-group-btn">
                                            <button id="supplierBtn" type="button" class="btn btn-info btn-flat">选择供应商</button>
                                        </span>
                                    </div>
                                </div>
                            </div>
    						
    						<div class="form-group">
                                <label for="scanCode" class="col-sm-2 control-label">货品采购价</label>
                                <div class="col-sm-9">
                                    <sys:inputverify name="product.pricePurchase" maxlength="10" isMandatory="false" id="ppricePurchase" verifyType="9" tip="货品采购价,默认两位小数"></sys:inputverify>
                                </div>
                            </div>
    						
    						<div class="form-group">
    							<label class="col-sm-2 control-label">货品原厂编码</label>
								<div class="col-sm-9">
									<sys:inputverify id="productFactoryCode" name="product.factoryCode" tip="请输入货品原厂编码" verifyType="0" isSpring="true" isMandatory="false"></sys:inputverify>
								</div>
    						</div>
    						<div class="form-group">
    							<label class="col-sm-2 control-label">货品证书编号</label>
								<div class="col-sm-9">
									<sys:inputverify id="productCertificateNo" name="product.certificateNo" tip="请输入货品证书编号" verifyType="0" isSpring="true" isMandatory="false"></sys:inputverify>
								</div>
    						</div>
    						<!-- 
    						<sys:inputtree id="warehouse" 	name="" 				url="${ctx}/lgt/ps/warehouse/warehouseListData" 	postParam="" onchange="warehouseOnchange" 								isQuery="false" inputWidth="9" labelWidth="2" label="入库仓库" labelValue="" labelName="" value="" tip="请选择仓库，必填项" title="入库仓库"></sys:inputtree>
    						<sys:inputtree id="warearea" 	name="" 				url="${ctx}/lgt/ps/warearea/wareareaListData" 		postParam="{postName:[\"warehouse.id\"],inputId:[\"warehouseId\"]}" 	isQuery="true" 	inputWidth="9" labelWidth="2" label="入库区域" labelValue="" labelName="" value="" tip="请选择货架，必填项" title="入库货架"></sys:inputtree>
    						<sys:inputtree id="warecounter"	name="" 				url="${ctx}/lgt/ps/warecounter/warecounterListData"	postParam="{postName:[\"warearea.id\"],inputId:[\"wareareaId\"]}" 		isQuery="true" 	inputWidth="9" labelWidth="2" label="入库货柜" labelValue="" labelName="" value="" tip="请选择货屉，必填项" title="入库货屉"></sys:inputtree>
    						<sys:inputtree id="wareplace" 	name="ioWareplace.id" 	url="${ctx}/lgt/ps/wareplace/wareplaceListData" 	postParam="{postName:[\"warecounter.id\"],inputId:[\"warecounterId\"]}" isQuery="true" 	inputWidth="9" labelWidth="2" label="入库货位" labelValue="" labelName="" value="" tip="请选择货位，必填项" title="入库货位"></sys:inputtree>
    						 -->
    						<div class="form-group">
    							<label class="col-sm-2 control-label">操作人</label>
								<div class="col-sm-9">
									<input type="hidden" id="ioUserId" name="ioUser.id"/>
									<sys:inputverify id="ioUserInput" name="" tip="请选择操作人" verifyType="0" isSpring="true" isMandatory="false" forbidInput="true"></sys:inputverify>
									<sys:userselect id="ioUser" url="${ctx}/sys/office/userTreeData" isMulti="false" title="人员选择" height="550" width="550"></sys:userselect>
								</div>
    						</div>
    						<div class="form-group">
    							<label class="col-sm-2 control-label">操作时间</label>
								<div class="col-sm-9">
									<sys:datetime id="ioTime" inputId="ioTime" inputName="ioTime" tip="操作时间" isMandatory="false"></sys:datetime>
								</div>
    						</div>
			            	<div class="form-group">
    							<label class="col-sm-2 control-label">来源业务单号</label>
								<div class="col-sm-9">
									<sys:inputverify id="ioBusinessorderId" name="ioBusinessorderId" tip="请输入来源业务单号" verifyType="0" isSpring="true" isMandatory="false"></sys:inputverify>
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
			               		<button type="button" onclick="return submitForm();" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button>
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
    		
    		// 选择产品
    		$("#chooseProduceBtn").on('click',function(){
    			$("#produceSelectModalUrl").val("${ctx}/lgt/ps/produce/selectRadio?pageKey=productWpIoInForm");//带参数请求URL设置方式
    	        $("#produceSelectModal").modal('toggle');//显示模态框
    		});
    		
    		// 选择产品Modal<iframe>回调事件
    		$("#produceSelectModal #commitBtn").on("click",function(){
    			$("#produceSelectModal").modal("hide");				// 隐藏模态框
    			var content = $("#produceSelectModalIframe").contents().find("body");
    			$("input[type=radio]", content).each(function(){
    				if($(this).prop("checked")){
	    				iframeSelected($(this).val(), $(this).attr("data-code")+"("+$(this).attr("data-fullname")+")");
    				}
    			});
    			//清楚check  table缓存
    			window.localStorage.removeItem("productWpIoInForm");
    		});
    		
    		
    		$("#supplierBtn").on('click',function(){
                $("#supplierSelectModalUrl").val("${ctx}/lgt/si/supplier/select?pageKey=productWpIoInFormForS");//带参数请求URL设置方式
                $("#supplierSelectModal").modal('toggle');//显示模态框
            });
            
            $("#supplierSelectModal #commitBtn").on("click",function () {
                $("#supplierSelectModal").modal("hide");       
                var content = $("#supplierSelectModalIframe").contents().find("body");
                $("input[type=radio]", content).each(function(){
                    if($(this).prop("checked")){
                        $("#supplierId").val($(this).val());
                        $("#supplierName").val($(this).attr("data-name"));
                    }
                });
                //清楚check  table缓存
                window.localStorage.removeItem("productWpIoInFormForS");
            });
    		
    		// 设置操作人(弹出公司人员选择树)
    		$("#ioUserInput").on('click',function(){
    			ioUserinit({
				   	"selectCallBack":function(list){
		   				if(list.length>0){
							$("#ioUserId").val(list[0].id);
 				   			$("#ioUserInput").val(list[0].text);
 				   		}
					}
				});
    		});
    	});
    	
    	// 选择产品 iframe选择产品后回调方法
   		function iframeSelected(produceId, produceCode){
   			$("#productProduceId").val(produceId);
   			$("#chooseProduceBtn").val(produceCode);
   			//$("#chooseProduceBtn").trigger("change");
   			
   			$("#productProduceId").removeClass("zf-input-err");
   			$("#productProduceIdErr").remove();
   			
    	}
    	
   		// 仓库变动时的方法调用
   		function warehouseOnchange(){
   			// 清空仓库区域、货柜、货位
   			$("#wareareaId").val("");
			$("#wareareaName").val("");
			$("#warecounterId").val("");
			$("#warecounterName").val("");
			$("#wareplaceId").val("");
			$("#wareplaceName").val("");
   		}
   		
   		// 提交表单
   		function submitForm(){
			if($("#ioReasonType").val() == null || $("#ioReasonType").val() == ""){
				ZF.showTip("请选择操作原因类型！","info");	
				return false;
			} 
			
			var flag = ZF.formSubmit();
			$("button[type=submit]").attr('disabled',false);
			
			//if($("#warehouseId").val() == null || $("#warehouseId").val() == ""){
			//	ZF.showTip("请选择入库仓库！","danger");	
			//	return;
			//}
			//if($("#wareareaId").val() == null || $("#wareareaId").val() == ""){
			//	ZF.showTip("请选择入库区域！","danger");	
			//	return;
			//}
			//if($("#warecounterId").val() == null || $("#warecounterId").val() == ""){
			//	ZF.showTip("请选择入库货柜！","danger");	
			//	return;
			//}
			//if($("#wareplaceId").val() == null || $("#wareplaceId").val() == ""){
			//	ZF.showTip("请选择入库货位！","danger");	
			//	return;
			//}
			if(flag) {
				confirm("货品入库后对应入库记录不可修改和删除，是否确认入库？","warning",function(){
					$("#inputForm").submit();
				});
			}
   		}
	</script>
</body>
</html>