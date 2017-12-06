<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>供应商账号管理</title>
	<meta name="decorator" content="adminLte"/>
</head>
<body>
<div class="content-wrapper sub-content-wrapper">
	<section class="content-header content-header-menu">
		<h1>
			<small><i class="fa-list-style"></i><a href="${ctx}/lgt/si/supplier/supplierAccountList">供应商账号列表</a></small>
			
			<shiro:hasPermission name="lgt:si:supplier:edit"><small>|</small><small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/lgt/si/supplier/supplierAccountForm">供应商账号${not empty user.id?'修改':'添加'}</a></small></shiro:hasPermission>
		</h1>
	</section>
	<sys:tip content="${message}"/>
	<section class="content">
		<div class="row">
			<div class="col-md-6">
				<form:form id="inputForm" modelAttribute="user" action="${ctx}/lgt/si/supplier/supplierAccountSave" method="post" class="form-horizontal" onsubmit="return formSubmit();">
					<div class="box box-success">
						<div class="box-header with-border zf-query">
		    				<h5>请完善表单填写</h5>
				            <div class="box-tools">
				               <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
				            </div>
		    			</div>
						
						<div class="box-body">
							
							<input id="userId" name="userId" type="hidden" value="${user.id }"/>
							
							
							<input id="userCategory" name="userCategory" type="hidden" value="S"/>
							
							<div class="form-group">
	    						<label class="col-sm-2 control-label">头像</label>
								<div class="col-sm-9">
									<%-- <form:hidden id="nameImage" path="photo" htmlEscape="false" maxlength="255" class="input-xlarge"/>
									<sys:ckfinder input="nameImage" type="images" uploadPath="/photo" selectMultiple="false" readonly="false" /> --%>
									
									<form:hidden id="photo" path="photo" htmlEscape="false" maxlength="255" class="form-control"/>
                                    <sys:fileUpload input="photo" model="true" selectMultiple="false"></sys:fileUpload>
									
								</div>
	    					</div>
							<div class="form-group">
								<label for="companyName" class="col-sm-2 control-label">归属公司</label>
								<div class="col-sm-9">
									<form:hidden id="companyId" path="company.id" />
									<form:input id="companyName" path="company.name"
										htmlEscape="false" maxlength="100" class="form-control"
										placeholder="选择归属公司" />
								</div>
							</div>
							<div class="form-group">
								<label for="officeName" class="col-sm-2 control-label">归属部门</label>
								<div class="col-sm-9">
									<form:hidden id="officeId" path="office.id" />
									<form:input id="officeName" path="office.name"
										htmlEscape="false" maxlength="100" class="form-control"
										placeholder="选择归属部门" />
								</div>
							</div>
							 
							<div class="form-group">
								<label for="noInput" class="col-sm-2 control-label">工号</label>
								<div class="col-sm-9">
									<input id="no" name="no" type="text" readonly="readonly" value="${user.no }" class="form-control zf-input-readonly"/>
								</div>
							</div>
							
							<div class="form-group">
								<label for="nameInput" class="col-sm-2 control-label">姓名</label>
								<div class="col-sm-9">
									<sys:inputverify id="nameInput" name="name" tip="请输入姓名，必填项" verifyType="0"  isSpring="true"></sys:inputverify>
								</div>
							</div>
							
							
							<div class="form-group">
								<label for="loginName" class="col-sm-2 control-label">登录名</label>
								<div class="col-sm-9">
									<c:choose>
										<c:when test="${empty user.id }">
											<sys:inputverify name="loginName" id="loginName" verifyType="0" tip="请输入登录名,必填项" isSpring="true" isMandatory="true"></sys:inputverify>
										</c:when>
										<c:otherwise>
											<sys:inputverify name="loginName" id="loginName" verifyType="0" tip="请输入登录名，必填项" isSpring="true" isMandatory="true" forbidInput="true"></sys:inputverify>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
							
							<c:choose>
								<c:when test="${empty user.id }">
									<div class="form-group">
										<label for="newPasswordInput" class="col-sm-2 control-label">密码</label>
										<div class="col-sm-9">
											<form:password path="newPassword" id="newPasswordInput" htmlEscape="false" data-verify="false" class="form-control"/>
										</div>
									</div>
									<div class="form-group">
			    						<label class="col-sm-2 control-label">确认密码</label>
										<div class="col-sm-9">
											<input type="password" id="confirmPassWord" htmlEscape="false" class="form-control" />
										</div>
			    					</div>
								</c:when>
								<c:otherwise>
									<input type="hidden" name="newPassword" value="${user.password }"/>
								</c:otherwise>
							</c:choose>
							
							
							<div class="form-group">
								<label for="emailInput" class="col-sm-2 control-label">邮箱</label>
								<div class="col-sm-9">
									<sys:inputverify name="email" tip="请输入邮箱，必填项" verifyType="3" id="emailInput"  isSpring="true"></sys:inputverify>
								</div>
							</div>
							
							<div class="form-group">
								<label for="phoneInput" class="col-sm-2 control-label">电话</label>
								<div class="col-sm-9">
									<sys:inputverify id="phoneInput" name="phone" tip="请输入电话，必填项,例如: 0571-xxxxxxx" verifyType="7"   isSpring="true"></sys:inputverify>
								</div>
							</div>
								
							<div class="form-group">
								<label for="mobileInput" class="col-sm-2 control-label">手机</label>
								<div class="col-sm-9">
									<sys:inputverify id="mobileInput" name="mobile" tip="请输入手机，必填项,例如: 152xxxxxxxx" verifyType="1"   isSpring="true"></sys:inputverify>
								</div>
							</div>
							
							<div class="form-group">
								<label for="loginFlag" class="col-sm-2 control-label">是否允许登录后台</label>
								<div class="col-sm-9 zf-check-wrapper-padding">
									<form:radiobuttons path="loginFlag" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false" class="minimal" delimiter="&nbsp;&nbsp;&nbsp;&nbsp;" />
								</div>
							</div>
							
							<div class="form-group">
								<label for="loginAppFlag" class="col-sm-2 control-label">是否允许登录App</label>
								<div class="col-sm-9 zf-check-wrapper-padding">
									<form:radiobuttons path="loginAppFlag" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false" class="minimal" delimiter="&nbsp;&nbsp;&nbsp;&nbsp;" />
								</div>
							</div>
							
							<div class="form-group">
								<label for="userType" class="col-sm-2 control-label">用户类型</label>
								<div class="col-sm-9">
									<form:select path="userType" class="form-control select2" readonly="true">
										<form:option value="" label="请选择"/>
										<form:options items="${fns:getDictList('sys_user_type')}" itemLabel="label" itemValue="value" htmlEscape="false" />
									</form:select>
								</div>
							</div>
							
							<%-- <div class="form-group">
								<label for="roleIdList" class="col-sm-2 control-label">用户角色</label>
								<div class="col-sm-9">
					                 <c:forEach items="${allRoles }" var="r">
					                 	<input type="hidden" name="roleIdList" value="${r.id }" checked="checked" readonly="readonly" class="zf-input-readonlly" />${r.name }
					                 </c:forEach>
									<form:checkboxes path="roleIdList" items="${allRoles}" itemLabel="name" itemValue="id" htmlEscape="false" class="minimal" delimiter="&nbsp;&nbsp;&nbsp;&nbsp;"  readonly="readonly"/>
								</div>
							</div> --%>
							
							<c:if test="${user.id eq null }">
								<div class="form-group">
					                <label for="supplierId" class="col-sm-2 control-label">待分配账号供应商</label>
					                <div class="col-sm-9">
					                	<select name="supplier.id" id="supplierId" class="form-control select2">
							                 <option value="" selected="selected">请选择供应商</option>
							                 <c:forEach items="${supplierList }" var="su">
							                 	<option value="${su.id }" <c:if test="${su.id == supplier.id}">selected</c:if>>${su.name }</option>
							                 </c:forEach>
						                </select>
					                </div>
					            </div>
							</c:if>
							
							<div class="form-group">
	    						<label for="remarks" class="col-sm-2 control-label">备注信息</label>
								<div class="col-sm-9">
									<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="form-control "/>
								</div>
	    					</div>
							
							<c:if test="${not empty user.id}">
								<div class="form-group">
									<label class="col-sm-2 control-label">创建时间:</label>
									<div class="col-sm-9">
										<label><fmt:formatDate value="${user.createDate}" type="both" dateStyle="full"/></label>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-2 control-label">最后登陆:</label>
									<div class="col-sm-9">
										<label>IP: ${user.loginIp}&nbsp;&nbsp;&nbsp;&nbsp;时间：<fmt:formatDate value="${user.loginDate}" type="both" dateStyle="full"/></label>
									</div>
								</div>
							</c:if>
						</div>
						
						<div class="box-footer">
							<div class="pull-left box-tools">
					        	<button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
					        </div>
		    				<div class="pull-right box-tools">
		    					<c:if test="${empty user.id}">
		    						<button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
		    					</c:if>
				               	<shiro:hasPermission name="lgt:si:supplier:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
					        </div>
						</div>
					</div>
				</form:form>
			</div>
		</div>
		
		<sys:userselect height="550" url="${ctx}/sys/office/userTreeData"
			width="550" isOffice="true" isMulti="false" title="公司/部门选择"
			id="selectUser"></sys:userselect>
		
	</section>
	
	
	<script type="text/javascript">
		$(function() {
			
			$('input').iCheck({
				checkboxClass : 'icheckbox_minimal-blue',
				radioClass : 'iradio_minimal-blue'
			}); 
			
			
			$("#noInput").focus();
			
			$("#loginName").on("change",function(){
				var ln = $(this).val();
				if(ln.length <= 0) 
					return false;
				$.ajax({
					type:"post",
					contentType: "application/json; charset=utf-8",
					url:"${ctx}/lgt/si/supplier/checkLoginNameForSupplier?loginName="+ encodeURIComponent(ln),
					datatype:"json",
	       		    success:function(data) {
	       		    	if(data == "true") {
	       		    		ZF.showTip("恭喜你，该用户名"+ln+"唯一，可用","success");
	       		    	} else {
	       		    		$("#loginName").focus();
	       		    		$("#loginName").val("用户名《"+ln+"》已存在，请更正");
	       		    	}
	       		    }
				});
			});
			
			$("#companyName").on("click", function() {
				selectUserinit({
					"selectCallBack" : function(list) {
						$("#companyId").val(list[0].id);
						$("#companyName").val(list[0].text);
					}
				})
			});
			$("#officeName").on("click", function() {
				selectUserinit({
					"selectCallBack" : function(list) {
						$("#officeId").val(list[0].id);
						$("#officeName").val(list[0].text);
					}
				})
			});
			
		
			
			
			$("#newPasswordInput").on("change",function(){
				var pwd = $("#newPasswordInput").val();
				if(pwd == '' || pwd == null || pwd == undefined) {
					if($("#newPasswordInputErr").length<=0)
						$("#newPasswordInput").after("<label id=\"newPasswordInputErr\" class=\"control-label zf-label-err\"><i class=\"fa fa-times-circle-o\"></i>请输入密码</label>");
					return false;
				} else {
					$(this).attr("data-verify","true");
					$("#newPasswordInputErr").remove();
				}
				
			});
			
			$("#confirmPassWord").on("change",function(){
				var pwd = $("#newPasswordInput").val();
				var cpwd = $("#confirmPassWord").val();
				
				if(pwd == '' || pwd == null || pwd == undefined) {
					if($("#newPasswordInputErr").length<=0)
						$("#newPasswordInput").after("<label id=\"newPasswordInputErr\" class=\"control-label zf-label-err\"><i class=\"fa fa-times-circle-o\"></i>请输入密码</label>");
					return false;
				} else {
					$("#newPasswordInputErr").remove();
				}
				if(cpwd == '' || cpwd == null || cpwd == undefined) {
					if($("#confirmPassWordErr").length<=0)
						$("#confirmPassWord").after("<label id=\"confirmPassWordErr\" class=\"control-label zf-label-err\"><i class=\"fa fa-times-circle-o\"></i>请输入确认密码</label>");
					return false;
				} else {
					$("#confirmPassWordErr").remove();
				}
				
				if(pwd != cpwd){
					if($("#confirmPassWordErr").length<=0)
						$("#confirmPassWord").after("<label id=\"confirmPassWordErr\" class=\"control-label zf-label-err\"><i class=\"fa fa-times-circle-o\"></i>两次密码不一致</label>");
					return false;
				} else {
					$("#confirmPassWordErr").remove();
				}
				
			});
			
			$("#supplierId").on("change", function() {
				var selVal = $(this).val();
				var selId = $("#supplierId").attr("id");
				if(selVal == null || selVal == '' || selVal == undefined) {
					if($("#Err").length<=0)
						$("#supplierId").next().after("<label id=\"Err\" class=\"control-label zf-label-err\"><i class=\"fa fa-times-circle-o\"></i>请选择需绑定的供应商</label>");
					return false;
				} else {
					$("#Err").remove();
				}
			});
			
		});
		
		
		function formSubmit() {
			var verify = true;
			if($("#supplierId").length > 0) {
				var selVal = $("#supplierId").val();
				if(selVal == null || selVal == '' || selVal == undefined) {
					if($("#Err").length<=0)
						$("#supplierId").next().after("<label id=\"Err\" class=\"control-label zf-label-err\"><i class=\"fa fa-times-circle-o\"></i>请选择需绑定的供应商</label>");
					verify = false;
				} else {
					if($("#Err").length>0)
						$("#Err").remove();
				}
			}
			var inputs=$("input[data-verify=false]","#inputForm");
			for(var i=0;i<inputs.length;i++){
				$(inputs[i]).trigger('change');
				verify=false;
			}
			var selects=$("select[data-verify=false]","#inputForm");
			for(var i=0;i<selects.length;i++){
				$(selects[i]).trigger('change');
				verify=false;
			}
			return verify;
		}
	</script>
</div>
</body>
</html>