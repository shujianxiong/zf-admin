<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>货品管理</title>
	<meta name="decorator" content="adminLte"/>
	<script type="text/javascript">
	   var status = ${fns:toJson(product.status)};
	   //如果货品状态为 “已售出” 或者 “已移除” ， 则不允许修改  “货品原厂编码”  “货品证书编号”
	   function init() {
		   if(status.length > 0 && (status == 4 || status == 5)) {
			   $("#factoryCode").attr("readonly","readonly");
			   $("#certificateNo").attr("readonly","readonly");
		   }
	   }
	   
	   $(function() {
		   init();
	   });
	   
	   
	</script>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
		<section class="content-header">
			<h1>
				<small><i class="fa-list-style"></i><a href="${ctx}/lgt/ps/product/list">货品列表</a></small>
				
	        	<shiro:hasPermission name="lgt:ps:product:edit"><small>|</small><small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/lgt/ps/product/form?id=${product.id}">货品修改</a></small></shiro:hasPermission>
			</h1>
		</section>
		<sys:tip content="${message}"/>	
		<section class="content">
			<div class="row">
				<div class="col-md-6">
					<form:form id="inputForm" modelAttribute="product" action="${ctx}/lgt/ps/product/save" method="post" class="form-horizontal">
						<form:hidden path="id"/>
						<input type="hidden" name="token" value="${token }"/>
						<div class="box box-success">
							<div class="box-header with-border zf-query">
								<h5>货品录入表单</h5>
								<div class="box-tools pull-right">
									<button type="button" class="btn btn-box-tool"data-widget="collapse"><i class="fa fa-minus"></i></button>
								</div>
							</div>
							<div class="box-body">
								<div class="form-group">
									<label for="code" class="col-sm-2 control-label">货品编码</label>
									<div class="col-sm-9">
										<form:input path="code" htmlEscape="false" maxlength="255" class="form-control" placeholder="货品编码" readonly="true"/>
									</div>
								</div>
								<div class="form-group">
									<label for="scanCode" class="col-sm-2 control-label">货品电子码</label>
									<div class="col-sm-9">
										<form:input path="scanCode" htmlEscape="false" maxlength="255" class="form-control" placeholder="" readonly="true"/>
									</div>
								</div>
								<div class="form-group">
                                    <label for="scanCode" class="col-sm-2 control-label">采购价</label>
                                    <div class="col-sm-9">
										<c:choose>
											<c:when test="${ product.updateStatus eq '1'}">
												<sys:inputverify name="pricePurchase" id="pricePurchase" verifyType="9" tip="请输入采购价，两位小数，必填项" isMandatory="true" isSpring="true" maxlength="11"></sys:inputverify>
											</c:when>
											<c:otherwise>
												<sys:inputverify name="pricePurchase" id="pricePurchase" verifyType="9" tip="请输入采购价，两位小数，必填项" isMandatory="true" isSpring="true" forbidInput="true" maxlength="11"></sys:inputverify>
											</c:otherwise>
										</c:choose>
                                    </div>
                                </div>
								<div class="form-group">
									<label for="goods.name" class="col-sm-2 control-label">商品名称</label>
									<div class="col-sm-9">
										<form:input path="goods.name" htmlEscape="false" maxlength="64" class="form-control" placeholder="商品名称" readonly="true"/>
									</div>
								</div>
								<div class="form-group">
									<label for="goods.code" class="col-sm-2 control-label">商品编号</label>
									<div class="col-sm-9">
										<form:input path="goods.code" htmlEscape="false" maxlength="64" class="form-control" placeholder="商品编号" readonly="true"/>
									</div>
								</div>
								<div class="form-group">
									<label for="produce.code" class="col-sm-2 control-label">产品编号</label>
									<div class="col-sm-9">
										<form:input path="produce.code" htmlEscape="false" maxlength="64" class="form-control" placeholder="商品名称" readonly="true"/>
									</div>
								</div>
								<div class="form-group">
									<label for="status" class="col-sm-2 control-label">当前状态</label>
									<div class="col-sm-9">
										<form:select path="status" class="form-control select2" disabled="true"> 
											<form:option value="" label="请选择"/>
											<form:options items="${fns:getDictList('lgt_ps_product_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
										</form:select>
									</div>
								</div>
								<div class="form-group">
									<label for="wareplace.code" class="col-sm-2 control-label">货位编号</label>
									<div class="col-sm-9">
										<form:input path="wareplace.code" htmlEscape="false" maxlength="64" class="form-control" placeholder="货位编号"  readonly="true"/>
									</div>
								</div>
								<div class="form-group">
									<label for="holdUser.name" class="col-sm-2 control-label">持有员工</label>
									<div class="col-sm-9">
										<input name="holdUser.name" value="${fns:getUserById(product.holdUser.id).name }" readonly="readonly" class="form-control"/>
									</div>
								</div>
								<div class="form-group">
									<label for="weight" class="col-sm-2 control-label">货品克重</label>
									<div class="col-sm-9">
										<c:choose>
											<c:when test="${ product.updateStatus eq '1'}">
												<sys:inputverify name="weight" id="weight" verifyType="10" tip="请输入货品克重，四位小数，必填项" isMandatory="true" isSpring="true" maxlength="9"></sys:inputverify>
											</c:when>
											<c:otherwise>
												<sys:inputverify name="weight" id="weight" verifyType="10" tip="请输入采购价，四位小数，必填项" isMandatory="true" isSpring="true" forbidInput="true" maxlength="9" ></sys:inputverify>
											</c:otherwise>
										</c:choose>

									</div>
								</div>
								<div class="form-group">
                                    <label for="weight" class="col-sm-2 control-label">货品供应商</label>
                                    <div class="col-sm-9">
                                        <input type="hidden" name="supplier.id" value="${product.supplier.id }"/>
                                        <input type="text" name="supplier.name" value="${product.supplier.name }" class="form-control" disabled="disabled"/>
                                    </div>
                                </div>
								<div class="form-group">
									<label for="factoryCode" class="col-sm-2 control-label">货品原厂编码</label>
									<div class="col-sm-9">
										<form:input path="factoryCode" id="factoryCode" htmlEscape="false" maxlength="64" class="form-control" placeholder="请输入货品原厂编码"/>
									</div>
								</div>
								<div class="form-group">
									<label for="certificateNo" class="col-sm-2 control-label">货品证书编号</label>
									<div class="col-sm-9">
										<form:input path="certificateNo" id="certificateNo" htmlEscape="false" maxlength="64" class="form-control" placeholder="请输入货品证书编号"/>
									</div>
								</div>
								<div class="form-group">
									<label for="remarks" class="col-sm-2 control-label">备注信息</label>
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
								    <c:if test="${empty product.id }">
						        		<button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
								    </c:if>
				               		<button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button>
					        	</div>
							</div>
						</div>
					</form:form>
				</div>
			</div>
		</section>
	</div>
	
	
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
<!-- 		<div class="control-group"> -->
<!-- 			<label class="control-label">持有员工姓名：</label> -->
<!-- 			<div class="controls"> -->
<%-- 				<form:input path="holdUser.name" htmlEscape="false" maxlength="64" class="input-xlarge " disabled="true"/> --%>
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 		<div class="control-group"> -->
<!-- 			<label class="control-label">货品克重：</label> -->
<!-- 			<div class="controls"> -->
<%-- 				<form:input path="weight" htmlEscape="false" class="input-xlarge " disabled="true"/> --%>
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 		<div class="control-group"> -->
<!-- 			<label class="control-label">货品原厂编码：</label> -->
<!-- 			<div class="controls"> -->
<%-- 				<form:input path="factoryCode" htmlEscape="false" class="input-xlarge " disabled="true"/> --%>
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 		<div class="control-group"> -->
<!-- 			<label class="control-label">货品证书编号：</label> -->
<!-- 			<div class="controls"> -->
<%-- 				<form:input path="certificateNo" htmlEscape="false" class="input-xlarge "/> --%>
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 		<div class="control-group"> -->
<!-- 			<label class="control-label">备注信息：</label> -->
<!-- 			<div class="controls"> -->
<%-- 				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/> --%>
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 		<div class="form-actions"> -->
<%-- 			<shiro:hasPermission name="lgt:ps:product:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission> --%>
<!-- 			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/> -->
<!-- 		</div> -->
	
</body>
</html>