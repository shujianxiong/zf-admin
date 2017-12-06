<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>机构管理</title>
	<meta name="decorator" content="adminLte"/>
</head>
<body>
<div class="content-wrapper sub-content-wrapper">
<section class="content-header content-header-menu">
		<h1>
			<small><i class="fa-office"></i><a href="${ctx}/sys/office/list">机构列表</a></small>
			
			<shiro:hasPermission name="sys:office:edit"><small>|</small><small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/sys/office/form?id=${office.id}&parent.id=${office.parent.id}">机构${not empty office.id?'修改':'添加'}</a></small></shiro:hasPermission>
		</h1>
	</section>
	<sys:tip content="${message}"/>
	<section class="content">
		<div class="row">
			<div class="col-md-6">
			
				<form:form id="inputForm" modelAttribute="office" action="${ctx}/sys/office/save" method="post" class="form-horizontal"  onsubmit="return formSubmit();">
					<div class="box box-success">
						<div class="box-header with-border zf-query">
		    				<h5>请完善表单填写</h5>
				            <div class="box-tools">
				               <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
				            </div>
		    			</div>
						<div class="box-body">
				
							<form:hidden path="id"/>
							<sys:message content="${message}"/>
							<div class="form-group">
								<label class="col-sm-2 control-label">上级机构</label>
								<div class="col-sm-9">
									<form:hidden id="officeId" path="parent.id" />
									<form:input id="officeName" path="parent.name"
										htmlEscape="false" maxlength="100" class="form-control zf-input-readonly"
										placeholder="选择上级区域" readonly="true"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">归属区域</label>
								<div class="col-sm-9">
									   <%-- <div class="col-sm-4" style="padding-left: 0px;">
											<select id="province">
											   <option value="">请选择</option>
											   <c:forEach items="${provinceList }" var="area">
											       <option value="${area.id }">${area.name }</option>
											   </c:forEach>
											</select>
									   </div>
									   <div class="col-sm-4" style="padding-left: 0px;">
											<select id="city">
											     <option value="-1">请选择</option>
											     <c:forEach items="${cityList }" var="area">
                                                     <option value="${area.id }">${area.name }</option>
                                                 </c:forEach>
		                                    </select>
									    </div>
	                                    <div class="col-sm-4" style="padding-left: 0px;padding-right: 0px;">
		                                    <select id="district" name="area.id">
		                                          <option value="-1">请选择</option>
		                                          <c:forEach items="${districtList }" var="area">
                                                      <option value="${area.id }">${area.name }</option>
                                                  </c:forEach>
		                                    </select>
		                                 </div> --%>
		                                 
		                                 <sys:cascading name="area.id" value="${office.area.id }" parentIds="${office.area.parentIds }" provinceList="${provinceList }" cityList="${cityList }" districtList="${districtList }"></sys:cascading>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">机构名称</label>
								<div class="col-sm-9">
									<sys:inputverify id="name" name="name" tip="请输入机构名称，必填项" verifyType="0"  isSpring="true"></sys:inputverify>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">机构编码</label>
								<div class="col-sm-9">
									<sys:inputverify id="code" name="code" tip="请输入机构编码，必填项" verifyType="0"  isSpring="true"></sys:inputverify>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">机构类型</label>
								<div class="col-sm-9">
									<form:select path="type" class="form-control">
										<form:options items="${fns:getDictList('sys_office_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
									</form:select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">机构级别</label>
								<div class="col-sm-9">
									<form:select path="grade" class="form-control">
										<form:options items="${fns:getDictList('sys_office_grade')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
									</form:select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">是否可用</label>
								<div class="col-sm-9 zf-check-wrapper-padding">
									<form:radiobuttons path="useable" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false" class="minimal" delimiter="&nbsp;&nbsp;&nbsp;&nbsp;" />
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">主负责人</label>
								<div class="col-sm-9">
									<form:hidden id="primaryPersonId" path="primaryPerson.id" />
									<sys:inputverify name="primaryPerson.name" id="primaryPersonName" verifyType="0" tip="请选择负责人，必填项" isSpring="true" forbidInput="true"></sys:inputverify>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">副负责人</label>
								<div class="col-sm-9">
									<form:hidden id="deputyPersonId" path="deputyPerson.id" />
									<form:input id="deputyPersonName" path="deputyPerson.name"
										htmlEscape="false" maxlength="100" class="form-control zf-input-readonly"
										placeholder="选择负责人" readonly="true"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">联系地址</label>
								<div class="col-sm-9">
									<sys:inputverify id="address" name="address" tip="请输入联系地址" verifyType="0"  isSpring="true"  isMandatory="false"></sys:inputverify>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">邮政编码</label>
								<div class="col-sm-9">
									<sys:inputverify id="zipCode" name="zipCode" tip="请输入邮政编码" verifyType="0"  isSpring="true"  isMandatory="false"></sys:inputverify>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">负责人</label>
								<div class="col-sm-9">
									<sys:inputverify id="master" name="master" tip="请输入负责人" verifyType="0"  isSpring="true"  isMandatory="false"></sys:inputverify>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">电话</label>
								<div class="col-sm-9">
									<sys:inputverify id="phone" name="phone" tip="请输入正确的电话号码, 必填项,如:152xxxxxxxx" verifyType="1"  isSpring="true" ></sys:inputverify>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">传真</label>
								<div class="col-sm-9">
									<sys:inputverify id="fax" name="fax" tip="请输入传真" verifyType="0"  isSpring="true" isMandatory="false"></sys:inputverify>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">邮箱</label>
								<div class="col-sm-9">
									<sys:inputverify id="email" name="email" tip="请输入邮箱" verifyType="0"  isSpring="true" isMandatory="false"></sys:inputverify>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">备注</label>
								<div class="col-sm-9">
									<form:textarea path="remarks" htmlEscape="false"  maxlength="200" class="form-control"/>
								</div>
							</div>
							<c:if test="${empty office.id}">
								<div class="form-group">
									<label class="col-sm-2 control-label">添加下级部门</label>
									<div class="col-sm-9 zf-check-wrapper-padding">
										<form:checkboxes path="childDeptList" items="${fns:getDictList('sys_office_common')}" itemLabel="label" itemValue="value" htmlEscape="false" delimiter="&nbsp;&nbsp;&nbsp;&nbsp;"/>
									</div>
								</div>
							</c:if>
						</div>
						
						<div class="box-footer">
							<div class="pull-left box-tools">
					        	<button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
					        </div>
		    				<div class="pull-right box-tools">
		    					<c:if test="${empty office.id }">
						        	<button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
		    					</c:if>
				               	<shiro:hasPermission name="sys:office:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
					        </div>
						</div>
					</div>
							
				</form:form>
				
			</div>
		</div>
		
		<sys:userselect height="550" url="${ctx}/sys/office/treeData"
			width="550" isOffice="true" isMulti="false" title="机构选择" isTopSelectable="true"
			id="selectOffice" dataType="Office"></sys:userselect>
			
		<sys:userselect height="550" url="${ctx}/sys/office/userTreeData"
			width="550" isOffice="false" isMulti="false" title="人员选择"
			id="selectUser" ></sys:userselect>
	</section>
	</div>
	
	<script type="text/javascript">
		$(function() {
			
			$('input').iCheck({
				checkboxClass : 'icheckbox_minimal-blue',
				radioClass : 'iradio_minimal-blue'
			});
			
			/* var parentIds = "${office.area.parentIds}";
			if(parentIds != null && parentIds != '' && parentIds != undefined) {
				var idsArr = parentIds.substring(4, parentIds.length-1).split(',');
				var len = idsArr.length;
				if(len == 1) {
					$("#province").select2('val', idsArr[0]);
				} else if(len == 2) {
					$("#province").select2('val', idsArr[0]);
					$("#city").select2('val', idsArr[1]);
				} 
				$("#district").select2('val', "${office.area.id}");
			}
			 */
			
			
			$("#officeName").on("click", function() {
				selectOfficeinit({
					"selectCallBack" : function(list) {
						$("#officeId").val(list[0].id);
						$("#officeName").val(list[0].text);
					}
				})
			});
			
			$("#primaryPersonName").on("click", function() {
				selectUserinit({
					"selectCallBack" : function(list) {
						$("#primaryPersonId").val(list[0].id);
						$("#primaryPersonName").val(list[0].text);
						$("#primaryPersonName").attr("data-verify","true");
						$("#primaryPersonName").removeClass("zf-input-err");
	   					if($("#primaryPersonNameErr").length>0){
	   						$("#primaryPersonNameErr").remove();
	   					}
					}
				})
			});
			
			$("#deputyPersonName").on("click", function() {
				selectUserinit({
					"selectCallBack" : function(list) {
						$("#deputyPersonId").val(list[0].id);
						$("#deputyPersonName").val(list[0].text);
					}
				})
			});
			
			
			/* $("#province").on("change", function() {
				console.log("选中的省份ID："+$(this).val());
				ZF.ajaxQuery(false,"${ctx}/sys/area/listAreaByParentId",$.parseJSON('{"parent.id":"'+$(this).val()+'"}'),function(data){
					console.log(data);
					var opStr = "<option value='-1'>请选择</option>";
					for(var i = 0; i < data.length; i++) {
						  opStr += "<option value='"+data[i].id+"'>"+data[i].name+"</option>";
					}
					$("#city").html(opStr);
					$("#city").select2('val', '-1');
	            },function(){
	            	//TODO
	            });
			});
			
			
			$("#city").on("change", function() {
				console.log("选中的市区ID："+$(this).val());
                ZF.ajaxQuery(false,"${ctx}/sys/area/listAreaByParentId",$.parseJSON('{"parent.id":"'+$(this).val()+'"}'),function(data){
                	console.log(data);
                	var opStr = "<option value='-1'>请选择</option>";
                    for(var i = 0; i < data.length; i++) {
                          opStr += "<option value='"+data[i].id+"'>"+data[i].name+"</option>";
                    }
                    $("#district").html(opStr);
                    $("#district").select2('val', '-1');
                },function(){
                    //TODO
                });
            }); */
			
		});
		
		
		function formSubmit() {
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
			}
			return flag;
		}
	</script>
</body>
</html>