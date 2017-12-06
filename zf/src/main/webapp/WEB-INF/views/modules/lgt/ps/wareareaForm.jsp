<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>货架管理</title>
	<meta name="decorator" content="adminLte"/>
</head>
<body>

	<div class="content-wrapper sub-content-wrapper">
		<section class="content-header content-header-menu">
			<h1>
		        <small>
		        	<i class="fa-list-style"></i><a href="${ctx}/lgt/ps/warearea/">货架列表</a>
		        </small>
		        <shiro:hasPermission name="lgt:ps:warearea:edit">
			        <small>|</small>
		        	<small class="menu-active">
		        		<i class="fa fa-repeat"></i><a href="${ctx}/lgt/ps/warearea/form?id=${warearea.id}">货架<shiro:hasPermission name="lgt:ps:warearea:edit">${not empty warearea.id?'修改':'添加'}</shiro:hasPermission></a>
		        	</small>
		        </shiro:hasPermission>
		    </h1>
		</section>
		<sys:tip content="${message}"/>
		<section class="content">
			<div class="row">
				<div class="col-md-6">
					<form:form id="inputForm" modelAttribute="warearea" action="${ctx}/lgt/ps/warearea/save" method="post" class="form-horizontal">
						<form:hidden path="id"/>		
						<div class="box box-success">
							<div class="box-header">
								
							</div>
							<div class="box-body">
							    <input id="id" name="warearea.warehouse.id" type="hidden" value="${warehouseId}"/>
								<sys:inputtree name="warehouse.id" url="${ctx}/lgt/ps/warehouse/warehouseListData" id="warehouse" label="所属仓库" labelValue="${warehouseCode}" labelWidth="2" inputWidth="9"
									 labelName="warehouse.name" value="${warehouseId}" tip="请选择仓库" ></sys:inputtree>
								<div class="form-group">
									<label class="col-sm-2 control-label">货架编码</label>
									<div class="col-sm-9">
										<form:input path="code" htmlEscape="false" maxlength="50" class="form-control" placeholder="请输入货架编码"/>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-2 control-label">货架类型</label>
									<div class="col-sm-9">
										<form:select id="type" path="type" htmlEscape="false" maxlength="50" class="form-control select2" onchange="changeType()">
											<form:option value="" label="请选择"/>
											<form:options items="${fns:getDictList('lgt_ps_warearea_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
										</form:select>
									</div>
								</div>
								
								<sys:inputtree url="${ctx}/lgt/ps/category/categoryData" label="分类" tip="请选择分类" id="categories" labelName="categories.categoryName" name="categories.id" labelWidth="2" inputWidth="9" verifyType="true"></sys:inputtree>
								
								<div class="form-group">
                                    <label class="col-sm-2 control-label">是否启用</label>
                                    <div class="col-sm-9 zf-check-wrapper-padding">
                                        <form:radiobuttons path="usableFlag" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false" placeholder="请输入启用标志"/>
                                    </div>
                                </div>
								<div class="form-group">
									<label class="col-sm-2 control-label">备注</label>
									<div class="col-sm-9">
										<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="form-control" placeholder="请输入备注"/>
									</div>
								</div>
							</div>
							<div class="box-footer">
		    					<div class="pull-left box-tools">
					        		<button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
					        	</div>
		    					<div class="pull-right box-tools">
					        		<button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
				               		<shiro:hasPermission name="lgt:ps:warearea:edit"><button type="button" onclick="submitForm()" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
					        	</div>
		    				</div>
						</div>
					</form:form>
				</div>
			</div>
		</section>
	</div>


	<ul class="nav nav-tabs">
		<li><a href="${ctx}/lgt/ps/warearea/">货架管理列表</a></li>
		<li class="active"><a href="${ctx}/lgt/ps/warearea/form?id=${warearea.id}">货架管理<shiro:hasPermission name="lgt:ps:warearea:edit">${not empty warearea.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="lgt:ps:warearea:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<script type="text/javascript">
	
        $(function(){
            $('input').iCheck({
                radioClass : 'iradio_minimal-blue'
            });
            
            var typeVar = $("#type").val();
        	if(typeVar == '1'){
	        	$("#categoriestreeInput").show();        		
        	}else {
        		$("#categoriestreeInput").hide();  
        	}
            
        });
        
        // 变动货架类型
        function changeType(){
        	var typeVar = $("#type").val();
        	if(typeVar == '1'){
        		// 正常货架，选择分类
	        	$("#categoriestreeInput").show();        		
        	}else {
        		// 坏货货架，不选分类
        		$("#categoriestreeInput").hide();  
        	}
        }
        
     	// 提交表单
   		function submitForm(){
   			// 所属仓库
   			if($("#warehouseId").val() == null || $("#warehouseId").val() == ""){
				ZF.showTip("请选择所属仓库！","info");	
				return;
			}
   			// 货架编码
   			if($("#code").val() == null || $("#code").val() == ""){
				ZF.showTip("请录入货架编码！","info");	
				return;
			}
   			// 货架类型
   			if($("#type").val() == null || $("#type").val() == ""){
				ZF.showTip("请选择货架类型！","info");	
				return;
			}
   			if($("#type").val() == '1'){
        		// 正常货架，选择分类
	        	if($("#categoriesId").val() == null || $("#categoriesId").val() == ""){
					ZF.showTip("请选择货架要存放的货品分类！","info");	
					return;
				}
        	}
   			
   			$("#inputForm").submit();
     	}
     </script>
</body>
</html>