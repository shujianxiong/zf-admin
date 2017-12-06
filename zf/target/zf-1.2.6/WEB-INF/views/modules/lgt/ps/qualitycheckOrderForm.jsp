<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>货品质检单管理</title>
	<meta name="decorator" content="adminLte"/>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
		<section class="content-header content-header-menu">
			<h1>
				<small><i class="fa-list-style"></i><a href="${ctx}/lgt/ps/qualitycheckOrder/">货品质检单列表</a></small> 
				<small>|</small>
				<small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/lgt/ps/qualitycheckOrder/form?id=${qualitycheckOrder.id}">货品质检单质检编辑</a></small>
			</h1>
		</section>
		<sys:tip content="${message}" />
		<section class="content">
			<div class="row">
				<div class="col-md-6">
					<form:form id="inputForm" modelAttribute="qualitycheckOrder"
						action="${ctx}/lgt/ps/qualitycheckOrder/save" method="post"
						class="form-horizontal" onsubmit="return ZF.formSubmit();">
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
								<%-- <div class="form-group">
									<label for="name" class="col-sm-2 control-label">质检员</label>
									<div class="col-sm-9">
										<form:hidden id="qcUserId" path="qcUser.id" />
										<form:input id="qcUserName" path="qcUser.name"
												htmlEscape="false" maxlength="100" class="form-control zf-input-readonly"
												placeholder="请选择员工" readonly="true"/>
									</div>
								</div> --%>
								<div  class="form-group">
									<label for="qcBusinessType" class="col-sm-2 control-label">质检类型</label>
									<div class="col-sm-9">	
										<form:select path="qcBusinessType" class="form-control select2">
											<form:options items="${fns:getDictList('lgt_ps_qualitycheck_order_qcType')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
										</form:select>
									</div>
								</div>
								<%-- <div  class="form-group">
									<label for="qcStatus" class="col-sm-2 control-label">质检状态</label>
									<div class="col-sm-9">
										<form:select path="qcStatus" class="form-control select2">
											<form:options items="${fns:getDictList('lgt_ps_qualitycheck_order_qcStatus')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
										</form:select>
									</div>
								</div> --%>
								
								<div  class="form-group">
									<label for="weighFlag" class="col-sm-2 control-label">是否称重</label>
									<div class="col-sm-9">
										<form:radiobuttons path="weighFlag" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false" class="minimal" delimiter="&nbsp;&nbsp;&nbsp;&nbsp;" />
									</div>
								</div>
								<div  class="form-group">
									<label for="surfacecheckFlag" class="col-sm-2 control-label">是否检验外观</label>
									<div class="col-sm-9">
										<form:radiobuttons path="surfacecheckFlag"  items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false" class="minimal" delimiter="&nbsp;&nbsp;&nbsp;&nbsp;" />
									</div>
								</div>
								<div  class="form-group">
									<label for="codecheckFlag" class="col-sm-2 control-label">是否核对裸石编码</label>
									<div class="col-sm-9">
										<form:radiobuttons path="codecheckFlag" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false" class="minimal" delimiter="&nbsp;&nbsp;&nbsp;&nbsp;" />
									</div>
								</div>
								<%-- <div  class="form-group">
									<label for="qcTime" class="col-sm-2 control-label">质检时间</label>
									<div class="col-sm-9" style="display: inline;">
										<sys:datetime inputId="qcTime" inputName="qcTime" tip="请选择质检时间" value="${qualitycheckOrder.qcTime}" id="qcTimeId"></sys:datetime>
									</div>
								</div> --%>
								<div  class="form-group">
									<label for="finishTime" class="col-sm-2 control-label">完成时间</label>
									<div class="col-sm-9" style="display: inline;">
										<sys:datetime inputId="finishTime" inputName="finishTime" tip="请选择完成时间" value="${qualitycheckOrder.finishTime}" id="finishTimeId"></sys:datetime>
									</div>
								</div>
								<div  class="form-group">
									<label for="activeFlag" class="col-sm-2 control-label">质检结果</label>
									<div class="col-sm-9">
										<form:select path="qcResult" class="form-control select2">
											<form:options items="${fns:getDictList('lgt_ps_qualitycheck_order_qcResult')}"  itemLabel="label" itemValue="value" htmlEscape="false"/>
										</form:select>
									</div>
								</div>
								<div class="form-group">
									<label for="remarks" class="col-sm-2 control-label">备注</label>
									<div class="col-sm-9">
										<form:textarea path="remarks" rows="4" maxlength="200" class="form-control"/>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-md-12">
						<div class="box box-success">
							<div class="box-body">
								<div class="control-group">
									<label class="control-label">货品质检详情表</label>
									<div class="controls">
										<table id="contentTable"
											class="table table-striped table-bordered table-condensed zf-tbody-font-size">
											<thead>
												<tr>
													<th class="hide"></th>
													<th>货品编码</th>
													<th>货品原重数据</th>
													<th>货品称重数据</th>
													<th>货品称重结果</th>
													<th>货品质检外观</th>
													<!-- <th>货品外观质检图片</th> -->
													<th>原裸石编码</th>
													<th>核对裸石编码</th>
													<th>裸石编码核对结果</th>
													<th>质检凭证</th>
													<th>质检结果</th>
													<th>损耗估算</th>
													<th>备注信息</th>
												</tr>
											</thead>
											<tbody id="qualitycheckDetailList">
												<c:forEach items="${qualitycheckOrder.qualitycheckDetailList }" var="qtd"  varStatus="index">
													<tr>
														<td class="hide">
															<input data-verify="true" id="qtd_id_${index.index}" name="qualitycheckDetailList[${index.index}].id" type="hidden" value="${qtd.id }"/>
															<input data-verify="true" id="qtd_delFlag_${index.index}" name="qualitycheckDetailList[${index.index}].delFlag" type="hidden" value="${qtd.delFlag }"/>
														</td>
														<td>${qtd.product.code }</td>
														<td>${qtd.weightOriginal }</td>
														<td>
															<sys:inputverify name="qualitycheckDetailList[${index.index}].weightCheck" id="qtd_weightCheck_${index.index}" verifyType="10" tip="请输入实际称重，格式如0.2555" maxlength="11"></sys:inputverify>
															<%-- <input type="text"
															id="qtd_weightCheck_${index.index}"
															name="qualitycheckDetailList[${index.index}].weightCheck"
															style="width: 107px;" class="form-control"  maxlength="10"/> --%>
														</td>
															
														<td>
															<sys:selectverify name="qualitycheckDetailList[${index.index}].weightResult" tip="请选择称重结果" verifyType="0" dictName="lgt_ps_qualitycheckDetail_weightResult" id="qtd_weightResult_${index.index}"></sys:selectverify>
														</td>
															
														<td>
															<sys:selectverify name="qualitycheckDetailList[${index.index}].surfaceCheck" tip="请选择检查结果" verifyType="0" dictName="lgt_ps_qualitycheckDetail_surfaceCheck" id="qtd_surfaceCheck_${index.index}"></sys:selectverify>
														</td>
															
														<%-- <td><input type="text"
															id="qtd_surfaceCheckUrls_${index.index}"
															name="qualitycheckDetailList[${index.index}].surfaceCheckUrls"
															style="width: 107px;" class="form-control" /></td> --%>
															
														<td>${qtd.codeOriginal }</td>
														<td>
															<sys:inputverify name="qualitycheckDetailList[${index.index}].codeCheck" id="qtd_codeCheck_${index.index}" verifyType="0" tip="请输入实际物品编码" maxlength="255"></sys:inputverify>
															<%-- <input type="text"
															id="qtd_codeCheck_${index.index}"
															name="qualitycheckDetailList[${index.index}].codeCheck"
															style="width: 107px;" class="form-control" maxlength="10"/> --%>
															
														</td>
														<td>
															<sys:selectverify name="qualitycheckDetailList[${index.index}].codeResult" tip="请选择裸石编码核对结果" verifyType="0" dictName="lgt_ps_qualitycheckDetail_codeResult" id="qtd_codeResult_${index.index}"></sys:selectverify>
														</td>
															
														<td>
															<sys:inputverify name="qualitycheckDetailList[${index.index}].qcVoucher" id="qtd_qcVoucher_${index.index}" verifyType="0" tip="请输入质检凭证" maxlength="255"></sys:inputverify>
															<%-- <input type="text"
															id="qtd_qcVoucher_${index.index}"
															name="qualitycheckDetailList[${index.index}].qcVoucher"
															style="width: 107px;" class="form-control" maxlength="10"/> --%>
															
														</td>
															
														<td>
															<sys:selectverify name="qualitycheckDetailList[${index.index}].qcResult" tip="请选择质检结果" verifyType="0" dictName="lgt_ps_qualitycheckOrder_qcResult" id="qtd_qcResult_${index.index}"></sys:selectverify>
														</td>
															
														<td>
															<sys:inputverify name="qualitycheckDetailList[${index.index}].lossEvaluation" id="qtd_lossEvaluation_${index.index}" verifyType="9" tip="请输入耗损估算，比如：100.00" maxlength="11"></sys:inputverify>
															<%-- <input type="text"
															id="qtd_lossEvaluation_${index.index}"
															name="qualitycheckDetailList[${index.index}].lossEvaluation"
															style="width: 107px;" class="form-control" maxlength="10"/> --%>
															
														</td>
															
														<td>
															<sys:inputverify name="qualitycheckDetailList[${index.index}].remarks" id="qtd_remarks_${index.index}" verifyType="0"  isMandatory="false" tip="请输入备注信息"></sys:inputverify>
															<%-- <input type="text"
															id="qtd_remarks_${index.index}"
															name="qualitycheckDetailList[${index.index}].remarks"
															style="width: 107px;" class="form-control"  maxlength="10"/> --%>
															
														</td>
													</tr>
												</c:forEach>
											</tbody>
										</table>
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
									<c:if test="${qualitycheckOrder.id eq null }">
										<button type="button" class="btn btn-default btn-sm"
											onclick="ZF.resetForm()">
											<i class="fa fa-refresh"></i>重置
										</button>
									</c:if>
									<shiro:hasPermission name="lgt:ps:lgtPsQualitycheckOrder:edit">
										<button type="submit" class="btn btn-info btn-sm" id="saveBtn">
											<i class="fa fa-save"></i>保存
										</button>
									</shiro:hasPermission>
								</div>
							</div>
						</div>
					</form:form>
				</div>
			</div>
			<sys:userselect height="550" url="${ctx}/sys/office/userTreeData"
			width="550" isOffice="false" isMulti="false" title="人员选择"
			id="selectUser" ></sys:userselect>
		</section>
		<script type="text/javascript">
			$(function() {
				$('input').iCheck({
					checkboxClass : 'icheckbox_minimal-blue',
					radioClass : 'iradio_minimal-blue'
				});
				
				$("#qcUserName").on("click", function() {
					selectUserinit({
						"selectCallBack" : function(list) {
							$("#qcUserId").val(list[0].id);
							$("#qcUserName").val(list[0].text);
							$("#qcUserName").attr("data-verify","true");
							$("#qcUserName").removeClass("zf-input-err");
		   					if($("#qcUserNameErr").length>0){
		   						$("#qcUserNameErr").remove();
		   					}
						}
					})
				});
				
				
				$("#saveBtn").click(function() {
					confirm("请核对输入是否完整，正确，\n 一旦提交，数据将不可更改！", "warning", function() {
						$("#inputForm").submit();
					});
				});
			});
			
		</script>
	</div>
</body>
</html>