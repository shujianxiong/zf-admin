<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>供应商管理</title>
<meta name="decorator" content="adminLte" />
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
		<section class="content-header content-header-menu">
			<h1>
				<small><i class="fa-list-style"></i><a
					href="${ctx}/lgt/si/supplier/">供应商列表</a></small> 
				<shiro:hasPermission name="lgt:si:supplier:edit">
					<small>|</small>
					<small class="menu-active"><i class="fa fa-repeat"></i><a
						href="${ctx}/lgt/si/supplier/form?id=${supplier.id}">供应商${not empty supplier.id?'修改':'添加'}</a></small>
				</shiro:hasPermission>
			</h1>
		</section>
		<sys:tip content="${message}" />
		<section class="content">
			<div class="row">
				<div class="col-md-12">
					<form:form id="inputForm" modelAttribute="supplier"
						action="${ctx}/lgt/si/supplier/save" method="post"
						class="form-horizontal" onsubmit="return formSubmit(this);">
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
								<div class="row">
									<div class="col-md-4">
										<div class="form-group">
											<label for="name" class="col-sm-3 control-label">供应商名称</label>
											<div class="col-sm-8">
												<sys:inputverify name="name" tip="请输入供应商名称，必填项" maxlength="50" verifyType="0" id="nameInput" isSpring="true"></sys:inputverify>
											</div>
										</div>
									</div>
									<div class="col-md-4">	
										<sys:inputtree name="supplierCategory.id" url="${ctx}/lgt/ps/category/categoryData"
											id="supplierCategoryID" label="供应商分类" labelValue="" labelWidth="3"
											inputWidth="8" labelName="supplierCategory.categoryName" value="" tip="请选择分类，必填项" isMultiselect="false"  verifyType="true"></sys:inputtree>
									</div>
									<div class="col-md-4">		
										<div class="form-group">
											<label class="col-sm-3 control-label">供应商类型</label>
											<div class="col-sm-8">
												<sys:selectverify name="type" tip="请选择供应商类型，必填项" verifyType="true" dictName="lgt_si_supplier_type" id="type"></sys:selectverify>
											</div>
										</div>
									</div>
								</div>
								
								<div class="row">
									<div class="col-md-4">	
										<div class="form-group">
											<label class="col-sm-3 control-label">信誉等级</label>
											<div class="col-sm-8">
												<sys:selectverify name="level" tip="请选择信誉等级，必填项" verifyType="true" dictName="lgt_si_supplier_level" id="level"></sys:selectverify>
											</div>
										</div>
									</div>
									
									<div class="col-md-4">  
	                                    <div class="form-group">
	                                        <label for="name" class="col-sm-3 control-label">默认账期(天)</label>
	                                        <div class="col-sm-8">
	                                            <sys:inputverify name="defaultAccount" tip="请输入默认账期" verifyType="4" maxlength="5" id="defaultAccount" isSpring="true" isMandatory="false"></sys:inputverify>
	                                        </div>
	                                    </div>
	                                </div>
	                                
	                                <div class="col-md-4">  
	                                    <div class="form-group">
	                                        <label for="name" class="col-sm-3 control-label">默认账期利率</label>
	                                        <div class="col-sm-8">
	                                            <sys:inputverify name="defaultAccountRate" tip="请输入默认账期利率, 比如0.001" maxlength="8" verifyType="5" id="defaultAccountRate" isSpring="true" isMandatory="false"></sys:inputverify>
	                                        </div>
	                                    </div>
	                                </div>
                                </div>
                                
                                <div class="row">
	                                <div class="col-md-4">  
	                                    <div class="form-group">
	                                        <label for="name" class="col-sm-3 control-label">回货周期(天)</label>
	                                        <div class="col-sm-8">
	                                            <sys:inputverify name="returnPeriod" tip="请输入回货周期" verifyType="4" maxlength="5" id="returnPeriod" isSpring="true" isMandatory="false"></sys:inputverify>
	                                        </div>
	                                    </div>
	                                </div>
	                                
	                                <div class="col-md-4">  
	                                    <div class="form-group">
	                                        <label for="name" class="col-sm-3 control-label">信誉积分</label>
	                                        <div class="col-sm-8">
	                                            <input type="hidden" name="creditPoint" class="form-control" value="${supplier.creditPoint }"/>
	                                            <input type="text" id="creditPoint"  name="cp" class="form-control" disabled="disabled" value="${supplier.creditPoint }"/>
	                                            <%-- <sys:inputverify name="creditPoint" tip="请输入信誉积分" verifyType="4"  maxlength="3" id="creditPoint" isSpring="true" isMandatory="false"></sys:inputverify> --%>
	                                        </div>
	                                    </div>
	                                </div>
									
									<div class="col-md-4">	
										<div  class="form-group">
											<label for="activeFlag" class="col-sm-3 control-label">是否启用</label>
											<div class="col-sm-8 zf-check-wrapper-padding">
												<form:radiobuttons path="activeFlag" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"  delimiter="&nbsp;&nbsp;&nbsp;&nbsp;" />
											</div>
										</div>
									</div>
                                </div>
                                
                                <div class="row">
									<div class="col-md-4">	
										<div class="form-group">
											<label for="name" class="col-sm-3 control-label">供应商别名</label>
											<div class="col-sm-8">
												<sys:inputverify name="nickName" tip="请输入供应商别名" maxlength="50" verifyType="0" id="nickNameInput" isSpring="true" isMandatory="false"></sys:inputverify>
											</div>
										</div>
									</div>
									
									<div class="col-md-4">	
										<div class="form-group">
											<label class="col-sm-3 control-label">国家/地区</label>
											<div class="col-sm-8">
												<sys:selectverify name="country" tip="请选择国家/地区，必选项" verifyType="true" dictName="country" id="country"></sys:selectverify>
											</div>
										</div>
									</div>
									<div class="col-md-4">	
										<div class="form-group">
											<label class="col-sm-3 control-label">品牌分级</label>
											<div class="col-sm-8">
												<sys:selectverify name="brandLevel" tip="请选择品牌分级，必选项" verifyType="true" dictName="lgt_si_supplier_brandLevel" id="brandLevel"></sys:selectverify>
											</div>
										</div>
									</div>
                                </div>
                                
                                <div class="row">
									<div class="col-md-4">	
										<div class="form-group">
											<label class="col-sm-3 control-label">公司地址</label>
											<div class="col-sm-8">
												<sys:inputverify name="address" tip="请输入公司地址，必填项" maxlength="200" verifyType="0" id="addressInput" isSpring="true"></sys:inputverify>
											</div>
										</div>
									</div>
									<div class="col-md-4">	
										<div class="form-group">
											<label class="col-sm-3 control-label">联系电话</label>
											<div class="col-sm-8">
												<sys:inputverify name="tel" tip="请输入手机号码， 必填项" maxlength="25" verifyType="99" isMandatory="false" id="telInput" isSpring="true"></sys:inputverify>
											</div>
										</div>
									</div>
									<div class="col-md-4">	
										<div class="form-group">
											<label class="col-sm-3 control-label">传真</label>
											<div class="col-sm-8">
												<sys:inputverify name="fax" tip="请输入传真,如：0755-8888888" verifyType="6" id="faxInput" isSpring="true" isMandatory="false"></sys:inputverify>
											</div>
										</div>
									</div>
                                </div>
                                
                                <div class="row">
									<div class="col-md-4">	
										<div class="form-group">
											<label class="col-sm-3 control-label">邮箱</label>
											<div class="col-sm-8">
												<sys:inputverify name="email" tip="请输入邮箱,如xxx@qq.com" verifyType="3" id="emailInput" isSpring="true" isMandatory="false"></sys:inputverify>
											</div>
										</div>
									</div>
									<div class="col-md-4">	
										<div class="form-group">
											<label class="col-sm-3 control-label">公司网址</label>
											<div class="col-sm-8">
												<sys:inputverify name="website" tip="请输入公司网址" maxlength="100" verifyType="99" id="websiteInput" isSpring="true" isMandatory="false"></sys:inputverify>
											</div>
										</div>
									</div>
									<div class="col-md-4">	
									
										<div class="form-group">
											<label class="col-sm-3 control-label">产品主材质</label>
											<div class="col-sm-8">
												<sys:inputverify name="produceMaterial" maxlength="20" tip="请输入产品主材质，必填项" verifyType="0" id="produceMaterialInput" isSpring="true"></sys:inputverify>
											</div>
										</div>
									</div>
                                </div>
                                
                                <div class="row">
									<div class="col-md-4">	
										<div class="form-group">
											<label class="col-sm-3 control-label">价格区间</label>
											<div class="col-sm-8">
											     <sys:inputverify id="priceRange" name="priceRange" tip="请输入价格区间，如1000-20000"  verifyType="0" isSpring="true"></sys:inputverify>
											</div>
										</div>
									</div>
									<div class="col-md-4">	
										<div class="form-group">
											<label class="col-sm-3 control-label">采购方式</label>
											<div class="col-sm-8">
												<sys:selectverify name="purchaseType" tip="请选择采购方式，必选项" verifyType="true" dictName="lgt_si_supplier_purchaseType" id="purchaseType"></sys:selectverify>
											</div>
										</div>
									</div>
									<div class="col-md-4">	
										<div class="form-group">
											<label class="col-sm-3 control-label">合作意愿</label>
											<div class="col-sm-8">
												<sys:selectverify name="cooperateDesire" tip="请选择合作意愿，必选项" verifyType="true" dictName="lgt_si_supplier_cooperateDesire" id="cooperateDesire"></sys:selectverify>
											</div>
										</div>
									</div>
                                </div>
                                
                                <div class="row">
									<div class="col-md-4">	
										<div class="form-group">
											<label class="col-sm-3 control-label">供应商描述</label>
											<div class="col-sm-8">
												<form:input path="description" htmlEscape="false" rows="4"
													maxlength="255" class="form-control " />
											</div>
										</div>
									</div>
									<div class="col-md-4">	
										<div class="form-group">
				    						<label class="col-sm-3 control-label">LOGO</label>
											<div class="col-sm-8">
												<%-- <form:hidden id="logoImage" path="logo" htmlEscape="false" maxlength="255" class="form-control"/>
												<sys:ckfinder input="logoImage" type="images" uploadPath="/lgt/si/supplier" selectMultiple="false" readonly="false" maxHeight="100" maxWidth="100"/> --%>
												
												<form:hidden id="logo" path="logo" htmlEscape="false" maxlength="255" class="form-control"/>
	                                            <sys:fileUpload input="logo" model="true" selectMultiple="false"></sys:fileUpload>
												
											</div>
			    						</div>
			    					</div>
			    					<div class="col-md-4">	
										<div class="form-group">
				    						<label class="col-sm-3 control-label">供应商图片展示</label>
											<div class="col-sm-8">
												<%-- <form:hidden id="displayPhotosImage" path="displayPhotos" htmlEscape="false" maxlength="255" class="form-control"/>
												<sys:ckfinder input="displayPhotosImage" type="images" uploadPath="/lgt/si/supplier" selectMultiple="true" readonly="false" maxHeight="100" maxWidth="100"/> --%>
												
												<form:hidden id="displayPhotos" path="displayPhotos" htmlEscape="false" maxlength="255" class="form-control"/>
	                                            <sys:fileUpload input="displayPhotos" model="true" selectMultiple="true"></sys:fileUpload>
												
											</div>
			    						</div>
			    					</div>
                                </div>
                                
                                <div class="row">
									<div class="col-md-4">	
										<div class="form-group">
											<label class="col-sm-3 control-label">备注信息</label>
											<div class="col-sm-8">
												<form:textarea path="remarks" htmlEscape="false" rows="4"
													maxlength="255" class="form-control" />
											</div>
										</div>
									</div>
                                </div>
								
								
							</div>
							
						</div>
						<div class="box box-success">
							<div class="box-body">
								<!--
                            	作者：offline
                            	时间：2016-03-31
                            	描述：供应商通讯录界面
                            -->
								<div class="control-group">
									<label class="control-label">供应商通讯录</label>
									<div class="controls">
										<table id="contentTable"
											class="table table-striped table-bordered table-condensed zf-tbody-font-size">
											<thead>
												<tr>
													<th class="hide"></th>
													<th>联系人姓名</th>
													<th>角色</th>
													<th>岗位</th>
													<th>联系电话</th>
													<th>所在区域</th>
													<th>联系地址</th>
													<th>备注信息</th>
													<shiro:hasPermission name="lgt:si:supplier:edit">
														<th>&nbsp;</th>
													</shiro:hasPermission>
												</tr>
											</thead>
											<tbody id="supplierContactsList">
												<%-- 模板行位置 --%>
												<input type="hidden" name="listcount" id="listcount" value="${fn:length(supplier.supplierContactsList)}" />
												<c:forEach items="${supplier.supplierContactsList }" var="sc" varStatus="index">
													<tr id="tr_${index.index}">
														<td class="hide">
															<input data-verify="true" id="sc_id_${index.index}" name="supplierContactsList[${index.index}].id" type="hidden" value="${sc.id }"/>
															<input data-verify="true" id="sc_delFlag_${index.index}" name="supplierContactsList[${index.index}].delFlag" type="hidden" value="${sc.delFlag }"/>
														</td>
														<td>
															<input data-type="item" data-verify="true" id="sc_name_${index.index}" name="supplierContactsList[${index.index}].name" type="text" value="${sc.name }" maxlength="50" class="form-control"/>
														</td>
														<td>
															<select  data-type="sel" id="sc_role_${index.index }" name="supplierContactsList[${index.index}].role" class="form-control select2" style="width: 246px;">
																<option value="" label="请选择角色"/>
																<c:forEach items="${fns:getDictList('lgt_si_supplier_contacts_role')}" var="role">
																	<option value="${role.value }" <c:if test="${role.value eq sc.role }">selected='selected'</c:if> >${role.label }</option>
																</c:forEach>
															</select>
														</td>
														<td>
															
															<select data-type="sel" id="sc_job_${index.index }" name="supplierContactsList[${index.index}].job" class="form-control select2" style="width: 246px;">
																<option value="" label="请选择岗位"/>
																<c:forEach items="${fns:getDictList('lgt_si_supplier_contacts_job')}" var="job">
																	<option value="${job.value }" <c:if test="${job.value eq sc.job }">selected="selected"</c:if>>${job.label }</option>
																</c:forEach>
															</select>
														</td>
														<td>
															<input data-verify="true" data-type="tel" id="sc_telephone_${index.index}" name="supplierContactsList[${index.index}].telephone" type="text" value="${sc.telephone}" maxlength="50" class="form-control"/>
														</td>
														<td>
															<input data-verify="true" id="sc_sysAreaId_${index.index}" name="supplierContactsList[${index.index}].area.id" type="hidden" value="${sc.area.id}" maxlength="64" class="form-control"/>
															<input data-type="item" data-verify="true" id="sc_sysAreaName_${index.index}" placeholder="请选择区域" name="supplierContactsList[${index.index}].area.name" type="text" value="${sc.area.name}" onclick="selectArea(this);" maxlength="64" class="form-control zf-input-readonly" readonly="readonly"/>
														</td>
														<td>
															<input data-type="item" data-verify="true" id="sc_sysAreaDetail_${index.index}" name="supplierContactsList[${index.index}].sysAreaDetail" type="text" value="${sc.sysAreaDetail}" maxlength="255" class="form-control"/>
														</td>
														<td>
															<textarea id="sc_remarks_${index.index}" name="supplierContactsList[${index.index}].remarks" rows="1" maxlength="255" class="form-control">${sc.remarks}</textarea>
														</td>
														<shiro:hasPermission name="lgt:si:supplier:edit">
															<td class='text-center' style='width:15px;'><span id='' class='close' onclick='delRow(this, ${index.index});' title='删除' style='display:block' >&times;</span></td>
														</shiro:hasPermission>
													</tr>
												</c:forEach>
											</tbody>
											<shiro:hasPermission name="lgt:si:supplier:edit">
											<tfoot>
												<tr>
													<td colspan="16"><button type="button" class="btn btn-sm btn-success" onclick="addRow();"><i class="fa fa-plus">新增</i></button></td>
												</tr>
											</tfoot>
											</shiro:hasPermission>
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
									<c:if test="${empty supplier.id}">
										<button type="button" class="btn btn-default btn-sm"
											onclick="ZF.resetForm()">
											<i class="fa fa-refresh"></i>重置
										</button>
									</c:if>
									<shiro:hasPermission name="lgt:si:supplier:edit">
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
		
		<sys:userselect height="550" url="${ctx}/sys/area/treeData"
			width="550" isOffice="true" isMulti="false" title="区域选择"
			id="selectArea"></sys:userselect>
	</div>
	<script type="text/javascript">
	
	$(function() {
		$('input').iCheck({
			checkboxClass : 'icheckbox_minimal-blue',
			radioClass : 'iradio_minimal-blue'
		});
	});
	
	function selectArea(curTd) {
		var idStr = $(curTd).attr("id");
		var index = idStr.split("_")[2];
		selectAreainit({
			"selectCallBack" : function(list) {
				$("#sc_sysAreaId_"+index).val(list[0].id);
				$("#sc_sysAreaName_"+index).val(list[0].text);
				$("#sc_sysAreaId_"+index).attr("data-verify", "true");
				$("#sc_sysAreaName_"+index).attr("data-verify", "true");
				
				if($("#sc_sysAreaName_"+index+"Err").length>=0){
					$("#sc_sysAreaName_"+index+"").removeClass("zf-input-err");
					$("#sc_sysAreaName_"+index+"Err").remove();
					$("#sc_sysAreaName_"+index+"").attr("data-verify","false");
				}
			}
		});
	};
	
	function addRow() {
		var tr_id = $("#supplierContactsList>tr:last").attr("id");
		if(tr_id){
			tr_id = tr_id.split('_')[1];	
		}
		if(!tr_id || isNaN(tr_id)){
			tr_id = 0;
		}
		var ct = $("#listcount").val();
		var xh = 0;
		tr_id++;
		if(ct > 0){
			xh = tr_id + 1;
		}else{		
			xh = tr_id;
		}
		var html;
		html = "<tr id='tr_"+tr_id+"' >";
		html += "<td class='hide'><input id='sc_id_"+tr_id+"' name='supplierContactsList["+tr_id+"].id' type='hidden' class='form-control'/><input id='sc_delFlag_"+tr_id+"' name='supplierContactsList["+tr_id+"].delFlag' type='hidden' value='0' class='form-control'/></td>";
		html += "<td><input data-type='item' data-verify='false' placeholder='请输入姓名，必填' id='sc_name_"+tr_id+"' name='supplierContactsList["+tr_id+"].name' type='text' maxlength='50' class='form-control' /></td>";
		
		html += "<td><select data-type='sel' id='sc_role_"+tr_id+"' name='supplierContactsList["+tr_id+"].role' data-value='' class='form-control select2' ><option value=''>请选择角色</option><c:forEach items='${fns:getDictList("lgt_si_supplier_contacts_role")}' var='dict'><option value='${dict.value}'>${dict.label}</option></c:forEach></select></td>";
		html += "<td><select data-type='sel' id='sc_job_"+tr_id+"' name='supplierContactsList["+tr_id+"].job' data-value='' class='form-control select2' ><option value=''>请选择岗位</option><c:forEach items='${fns:getDictList("lgt_si_supplier_contacts_job")}' var='dict'><option value='${dict.value}' >${dict.label}</option></c:forEach></select></td>";
		
		html += "<td><input data-type='tel' data-verify='false' placeholder='请输入手机号码，必填' id='sc_telephone_"+tr_id+"' name='supplierContactsList["+tr_id+"].telephone' type='text' value='' maxlength='50' class='form-control'/></td>";
		
		html += "<td><input id='sc_sysAreaId_"+tr_id+"' name='supplierContactsList["+tr_id+"].area.id' type='hidden' value='' maxlength='64' class='form-control'/><input data-type='item' id='sc_sysAreaName_"+tr_id+"' name='supplierContactsList["+tr_id+"].area.name' type='text' value='' placeholder='请选择区域' maxlength='64' class='form-control zf-input-readonly' onclick='selectArea(this);' readonly='readonly'/></td>";
		
// 		html += "<td><sys\":\"inputtree url='${ctx}/sys/area/treeData' label='联系地址区域' labelWidth='3' inputWidth='7' tip='请选择联系地址区域' id='sc_sysAreaId_"+tr_id+"' labelName='supplierContactsList["+tr_id+"].area.code' name='supplierContactsList["+tr_id+"].area.id'></sys\":\"inputtree></td>";

		html += "<td><input data-type='item' data-verify='false' placeholder='请填写详细地址' id='sc_sysAreaDetail_"+tr_id+"' name='supplierContactsList["+tr_id+"].sysAreaDetail' type='text' value='' maxlength='255' class='form-control'/></td>";
		
		html += "<td><textarea id='sc_remarks_"+tr_id+"' name='supplierContactsList["+tr_id+"].remarks' rows='1' maxlength='255' class='form-control'></textarea></td>";
		
		html += "<shiro:hasPermission name='lgt:si:supplier:edit'><td class='text-center' style='width:15px;'><span id='' class='close' onclick='delTr(this, "+tr_id+");' title='删除' style='display:block' >&times;</span></td></shiro:hasPermission>";
		html += "</tr>"; 
		$("#supplierContactsList").append(html);
		$("select").select2();
		
		//给input绑定change事件
		$("input[data-type=item]").on("change",function(){
			var id=$(this).attr("id");
			if(!ZF.formVerify(true,"0",$(this).val())){
				$(this).addClass("zf-input-err")
				if($("#"+id+"Err").length<0)
					$(this).after("<label id=\""+id+"Err\" class=\"control-label zf-label-err\"><i class=\"fa fa-times-circle-o\"></i>此项为必填项，请输入</label>")
				$(this).attr("data-verify","false");
			}else{
				if($("#"+id+"Err").length>=0){
					$(this).removeClass("zf-input-err");
					$("#"+id+"Err").remove();
					$(this).attr("data-verify","true");
				}
			}
		});
		
		//给input绑定change事件
		/* $("input[data-type=tel]").on("change",function(){
			var id=$(this).attr("id");
			if(!ZF.formVerify(true,"12",$(this).val())){
				$(this).addClass("zf-input-err")
				if($("#"+id+"Err").length<0)
					$(this).after("<label id=\""+id+"Err\" class=\"control-label zf-label-err\"><i class=\"fa fa-times-circle-o\"></i>此项必填，请输入正确的号码</label>")
				$(this).attr("data-verify","false");
			}else{
				if($("#"+id+"Err").length>=0){
					$(this).removeClass("zf-input-err");
					$("#"+id+"Err").remove();
					$(this).attr("data-verify","true");
				}
			}
		}); */

		
		$("select[data-type=sel]").on("change",function(){
			var id = $(this).attr("id");
			if($("#"+id+"Err").length>0){
				$("#"+id+"Err").remove();
				$(this).attr("data-verify","true");
			}
 		});
		
	};
	
	//从数据库抓取出来的数据，施行逻辑删除，界面隐藏
	function delRow(curTd, delFlagId) {
		//删除操作：第一步是将删除标志位置为1，第二步是在界面隐藏该记录，提交时，会自动更新删除掉得。
		$("#sc_delFlag_"+delFlagId).val(1);
		$(curTd).parent("td").parent("tr").addClass("hide");
	};
	
	//新增的模板行直接直接物理删除
	function delTr(curTd, delFlagId) {
		$(curTd).parent("td").parent("tr").remove();
	};
	
	//表单验证
	function formSubmit(form){
		var verify = true;
		
		var inputs=$("input[data-verify=false]",form);
		for(var i=0;i<inputs.length;i++){
			$(inputs[i]).trigger('change');
			verify=false;
		}
		var selects=$("select[data-verify=false]",form);
		for(var i=0;i<selects.length;i++){
			$(selects[i]).trigger('change');
			verify=false;
		}
		$("input[data-type=item]", "#inputForm").each(function() {
			var elem = $(this);
			var eVal = elem.val();
			var id = elem.attr("id");
			if(eVal.length==0) {
				elem.addClass("zf-input-err");
				if($("#"+id+"Err").length<=0)
					elem.after("<label id=\""+id+"Err\" class=\"control-label zf-label-err\"><i class=\"fa fa-times-circle-o\"></i>此项为必填项，请输入</label>")
				elem.attr("data-verify","false");
				verify = false;
				console.log(333333333);
			} else {
				if($("#"+id+"Err").length>0){
					$(this).removeClass("zf-input-err");
					$("#"+id+"Err").remove();
					$(this).attr("data-verify","true");
				}
			}
		});
		/* $("input[data-type=tel]","#inputForm").each(function() {
			var elem = $(this);
			var eVal = elem.val();
			var id = elem.attr("id");
			if(eVal.length==0) {
				elem.addClass("zf-input-err");
				if($("#"+id+"Err").length<=0)
					elem.after("<label id=\""+id+"Err\" class=\"control-label zf-label-err\"><i class=\"fa fa-times-circle-o\"></i>此项为必填项，请输入正确的号码</label>")
				elem.attr("data-verify","false");
				verify = false;
			} else {
				if($("#"+id+"Err").length>0){
					$(this).removeClass("zf-input-err");
					$("#"+id+"Err").remove();
					$(this).attr("data-verify","true");
				}
			}
		}); */
		$("select[data-type=sel]","#inputForm").each(function() {
			var elem = $(this);
			var eVal = elem.val();
			var id = elem.attr("id");
			if(eVal.length==0) {
				if($("#"+id+"Err").length<=0)
					elem.next().after("<label id=\""+id+"Err\" class=\"control-label zf-label-err\"><i class=\"fa fa-times-circle-o\"></i>请选择，必选项</label>")
				elem.attr("data-verify","false");
				verify = false;
			} else {
				if($("#"+id+"Err").length>0){
					$("#"+id+"Err").remove();
					$(this).attr("data-verify","true");
				}
			}
		});
		return verify;
	}
</script>
</body>
</html>