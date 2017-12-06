<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>货屉列表管理</title>
	<meta name="decorator" content="adminLte"/>
</head>
<body>
	
	<div class="content-wrapper sub-content-wrapper">
		<section class="content-header content-header-menu">
			<h1>
		        <small>
		        	<i class="fa-list-style"></i><a href="${ctx}/lgt/ps/warecounter/list">货屉列表</a>
		        </small>
		        <shiro:hasPermission name="lgt:ps:warecounter:edit">
			        <small>|</small>
		        	<small class="menu-active">
		        		<i class="fa fa-repeat"></i><a href="${ctx}/lgt/ps/warecounter/form?id=${warecounter.id}">货屉<shiro:hasPermission name="lgt:ps:warecounter:edit">${not empty warecounter.id?'修改':'添加'}</shiro:hasPermission></a>
		        	</small>
		        </shiro:hasPermission>
		    </h1>
		</section>
		<sys:tip content="${message}"/>	
		<section class="content">
			<div class="row">
				<div class="col-md-6">
					<form:form id="inputForm" modelAttribute="warecounter" action="${ctx}/lgt/ps/warecounter/save" method="post" class="form-horizontal" onsubmit="return formSubmit();">
						<form:hidden path="id"/>
						<div class="box box-success">
							<div class="box-header with-border zf-query">
								<h5>货屉表单信息</h5>
							</div>
							<div class="box-body">
							    <input id="id" name="warearea.warehouse.id" type="hidden" value="${warehouseId}"/>
								<sys:inputtree name="warearea.warehouse.id" url="${ctx}/lgt/ps/warehouse/warehouseListData" id="warehouse" label="所属仓库" labelValue="${warehouseCode}" labelWidth="2" inputWidth="9"
									 labelName="warearea.warehouse.code" value="${warehouseId}" tip="请选择仓库" isQuery="true" onchange="changeWarehouse"></sys:inputtree>
								
								<%-- <sys:inputtree name="warearea.id" url="${ctx}/lgt/ps/warearea/wareareaListData" id="warearea" label="所属货架" labelValue="" labelWidth="2" inputWidth="9" 
									labelName="warearea.code" value="" tip="请选择货架" postParam="{postName:[\"warehouse.id\"],inputId:[\"warehouseId\"]}" isQuery="true"></sys:inputtree>
									 --%>
									
								<sys:wareareatree name="warearea.id" url="${ctx}/lgt/ps/warearea/wareareaListData" id="warearea" label="所属货架" labelValue="" labelWidth="2" inputWidth="9" 
                                    labelName="warearea.code" value="" tip="请选择货架" postParam="{postName:[\"warehouse.id\"],inputId:[\"warehouseId\"]}" isQuery="true"></sys:wareareatree>
                                    
								
								<sys:selectmutil id="supplierSelect" title="选择供应商" url="${ctx}/lgt/si/supplier/select?pageKey=warecounterForm" isDisableCommitBtn="true" width="1200" height="700" isRefresh="false"></sys:selectmutil>
								
								<div class="form-group" id="supplierDiv">
                                    <label class="col-sm-2 control-label">供应商</label>
                                    <div class="col-sm-9">
                                        <div class="input-group">
                                            <input type="hidden" id="supplierId" name="supplier.id" value="${warecounter.supplier.id }"/>
                                            <input type="text" name="supplier.name" id="supplierName" value="${warecounter.supplier.name }" placeholder="非必填" class="form-control zf-input-readonly" readonly="true"/>
                                            <span class="input-group-btn">
                                                <button id="supplierBtn" type="button" class="btn btn-info btn-flat">选择供应商</button>
                                            </span>
                                        </div>
                                    </div>
                                </div>
								<sys:inputtree url="${ctx}/lgt/ps/category/categoryData" label="分类" tip="请选择分类" id="category" labelName="category.categoryName" name="category.id" labelWidth="2" inputWidth="9" verifyType="false"></sys:inputtree>
								
								
								<div class="form-group">
									<label class="col-sm-2 control-label">货屉编码</label>
									<div class="col-sm-9">
									    <sys:inputverify name="code" id="code" verifyType="0" tip="请输入货屉编码" isSpring="true" isMandatory="true"></sys:inputverify>
									</div>
								</div>
								<div class="form-group">
                                    <label class="col-sm-2 control-label">是否启用</label>
                                    <div class="col-sm-9 zf-check-wrapper-padding">
                                        <sys:selectverify name="usableFlag" tip="请选择是否启用" verifyType="" dictName="yes_no" id="usableFlag"></sys:selectverify>
                                    </div>
                                </div>
								<div class="form-group">
									<label class="col-sm-2 control-label">备注</label>
									<div class="col-sm-9">
										<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="form-control " placeholder="请输入备注"/>
									</div>
								</div>
							</div>
							<div class="box-footer">
		    					<div class="pull-left box-tools">
					        		<button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
					        	</div>
		    					<div class="pull-right box-tools">
					        		<button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
				               		<shiro:hasPermission name="lgt:ps:warearea:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
					        	</div>
		    				</div>
						</div>
					</form:form>
				</div>	
			</div>
		</section>
	</div>
	
	<script type="text/javascript">
		//点击仓库选择时，需清空区域
		function changeWarehouse(){
			$("#wareareaName").val("");
			$("#wareareaId").val("");
		}
		
        $(function(){
        	
            $('input').iCheck({
                radioClass : 'iradio_minimal-blue'
            });

            //初始化默认 
            var type = "${warecounter.warearea.type}";
            if(type == 2) {
            	$("#categorytreeInput").show();
            	$("#supplierDiv").show();
            } else {
            	$("#categorytreeInput").hide();
                $("#supplierDiv").hide();
            }
            
            
            $("#supplierBtn").on('click',function(){
                $("#supplierSelectModalUrl").val("${ctx}/lgt/si/supplier/select?pageKey=warecounterForm");//带参数请求URL设置方式
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
                window.localStorage.removeItem("warecounterForm");
            });
            
        });
        
        
        function formSubmit() {
        	var wh = $("#warehouseId").val();
        	if(wh == null || wh == "" || wh == undefined) {
        		ZF.showTip("请选择仓库!", "info");
        		return false;
        	}
        	var wa = $("#wareareaId").val();
        	if(wa == null || wa == "" || wa == undefined) {
                ZF.showTip("请选择货架!", "info");
                return false;
            }
        	var code = $("#code").val();
            if(code == null || code == "" || code == undefined) {
                ZF.showTip("请输入货屉编码!", "info");
                return false;
            }
            var usableFlag = $("#usableFlag").val();
            if(usableFlag == null || usableFlag == "" || usableFlag == undefined) {
                ZF.showTip("请选择是否启用!", "info");
                return false;
            }
        	return true;
        }
	</script>
	
</body>
</html>