<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>用户管理</title>
	<meta name="decorator" content="adminLte"/>
</head>
<body>
<div class="content-wrapper sub-content-wrapper">
	<section class="content-header content-header-menu">
		<h1>
			<small><i class="fa-userList"></i><a href="${ctx}/sys/user/list">用户列表</a></small>
			
			<shiro:hasPermission name="sys:user:edit"><small>|</small><small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/sys/user/form?id=${user.id}">用户${not empty user.id?'修改':'添加'}</a></small></shiro:hasPermission>
		</h1>
	</section>
	<sys:tip content="${message}"/>
	<section class="content">
		<div class="row">
			<div class="col-md-6">
				<form:form id="inputForm" modelAttribute="user" action="${ctx}/sys/user/save" method="post" class="form-horizontal" onsubmit="return formSubmit()">
					<div class="box box-success">
						<div class="box-header with-border zf-query">
		    				<h5>请完善表单填写</h5>
				            <div class="box-tools">
				               <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
				            </div>
		    			</div>
						
						<div class="box-body">
							
							<form:hidden id="id" path="id" />
							
							<input id="userCategory" name="userCategory" type="hidden" value="U"/>
							
							<div class="form-group">
	    						<label class="col-sm-2 control-label">头像</label>
								<div class="col-sm-9">
									<form:hidden id="photo" path="photo" htmlEscape="false" maxlength="255" class="form-control"/>
                                    <sys:fileUpload input="photo" model="false" selectMultiple="false" fileDirCode="profilePhoto"></sys:fileUpload>
									
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
									<sys:inputverify id="no" name="no" tip="请输入工号，必填项" verifyType="0"  isSpring="true"></sys:inputverify>
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
									<%-- <input id="loginName" name="loginName" type="text" value="${user.loginName}" class="form-control zf-input-readonly" <c:if test="${user.id ne null }">readonly</c:if>> --%>
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
							
							<c:if test="${empty user.id }">
								<div class="form-group">
									<label for="newPasswordInput" class="col-sm-2 control-label">密码</label>
									<div class="col-sm-9">
									     <input type="password" name="newPassword" id="newPasswordInput" placeholder="请输入密码，必填项"  htmlEscape="false" data-verify="false" class="form-control"/>
									</div>
								</div>
								<div class="form-group">
		    						<label class="col-sm-2 control-label">确认密码</label>
									<div class="col-sm-9">
										<input type="password" id="confirmPassWord" placeholder="请输入确认密码，必填项"   htmlEscape="false" class="form-control" />
									</div>
		    					</div>
							</c:if>
							
							
							<div class="form-group">
								<label for="emailInput" class="col-sm-2 control-label">邮箱</label>
								<div class="col-sm-9">
									<sys:inputverify name="email" tip="请输入邮箱，必填项，比如：xxx@qq.com" verifyType="3" id="emailInput"  isSpring="true"></sys:inputverify>
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
									<form:radiobuttons id="loginFlag" path="loginFlag" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false" class="minimal" delimiter="&nbsp;&nbsp;&nbsp;&nbsp;" />
								</div>
							</div>
							
							<div class="form-group">
								<label for="loginAppFlag" class="col-sm-2 control-label">是否允许登录App</label>
								<div class="col-sm-9 zf-check-wrapper-padding">
									<form:radiobuttons id="loginAppFlag" path="loginAppFlag" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false" class="minimal" delimiter="&nbsp;&nbsp;&nbsp;&nbsp;" />
								</div>
							</div>
							
							<div class="form-group">
								<label for="userType" class="col-sm-2 control-label">用户类型</label>
								<div class="col-sm-9">
									<form:select id="userType" path="userType" class="form-control select2">
										<form:option value="" label="请选择"/>
										<form:options items="${fns:getDictList('sys_user_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
									</form:select>
								</div>
							</div>
							
							<div class="form-group">
								<label for="roleIdList" class="col-sm-2 control-label">用户角色</label>
								<div class="col-sm-9 zf-check-wrapper-padding">
                                    <form:select id="roleIdList" path="roleList" class="form-control select2">
                                        <c:forEach items="${allRoles }" var="role">
                                            <form:option value="${role.id }">${role.name }</form:option>
                                        </c:forEach>
                                    </form:select>
								</div>
							</div>
							
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
		    					<c:if test="${empty user.id }">
						        	<button type="button" class="btn btn-default btn-sm" onclick="resetForm()"><i class="fa fa-refresh"></i>重置</button>
		    					</c:if>
				               	<shiro:hasPermission name="sys:user:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
					        </div>
						</div>
					</div>
				</form:form>
			</div>
		</div>
		
		<sys:userselect height="550" url="${ctx}/sys/office/userTreeData"
			width="550" isOffice="true" isMulti="false" title="公司/部门选择" isTopSelectable="true"
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
					url:"${ctx}/sys/user/checkLoginName?loginName="+ encodeURIComponent(ln),
					datatype:"json",
	       		    success:function(data) {
	       		    	if(data == "true") {
	       		    		ZF.showTip("恭喜你，该用户名"+ln+"唯一，可用","success");
	       		    		$("#loginNameErr").remove();
	       		    	} else {
	       		    		$(this).focus();
	       		    		$("#loginName").addClass("zf-input-err");
	       		    		if($("#loginNameErr").length<=0)
	                            $("#loginName").after("<label id=\"loginNameErr\" class=\"control-label zf-label-err\"><i class=\"fa fa-times-circle-o\"></i>用户名《"+ln+"》已存在，请更正</label>");
	                        return false;
	       		    	}
	       		    }
				}); 
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
						$("#newPasswordInput").after("<label id=\"newPasswordInputErr\" class=\"control-label zf-label-err\"><i class=\"fa fa-times-circle-o\"></i>请输入密码，必填项</label>");
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
						$("#newPasswordInput").after("<label id=\"newPasswordInputErr\" class=\"control-label zf-label-err\"><i class=\"fa fa-times-circle-o\"></i>请输入密码，必填项</label>");
					return false;
				} else {
					$("#newPasswordInputErr").remove();
				}
				if(cpwd == '' || cpwd == null || cpwd == undefined) {
					if($("#confirmPassWordErr").length<=0)
						$("#confirmPassWord").after("<label id=\"confirmPassWordErr\" class=\"control-label zf-label-err\"><i class=\"fa fa-times-circle-o\"></i>请输入确认密码，必填项</label>");
					return false;
				} else {
					$("#confirmPassWordErr").remove();
				}
				
				if(pwd != cpwd){
					if($("#confirmPassWordErr").length<=0)
						$("#confirmPassWord").after("<label id=\"confirmPassWordErr\" class=\"control-label zf-label-err\"><i class=\"fa fa-times-circle-o\"></i>两次密码不一致,请核查</label>");
					return false;
				} else {
					$("#confirmPassWordErr").remove();
				}
				
			});
			
			$("#userType").on("change", function() {
				var val = $(this).val();
				if(val == null  || val == "" || val == undefined) {
					if($("#userTypeErr").length<=0)
                        $("#userType").next().after("<label id=\"userTypeErr\" class=\"control-label zf-label-err\"><i class=\"fa fa-times-circle-o\"></i>请选择用户类型，必选项</label>");
                    return false;
				} else {
					$("#userTypeErr").remove();
				}
			});
			
			$("#roleIdList").on("change", function() {
                var val = $(this).val();
                if(val == null  || val == "" || val == undefined) {
                    if($("#roleIdListErr").length<=0)
                        $("#roleIdList").next().after("<label id=\"roleIdListErr\" class=\"control-label zf-label-err\"><i class=\"fa fa-times-circle-o\"></i>请选择用户角色，必选项</label>");
                    return false;
                } else {
                	$("#roleIdListErr").remove();
                }
            });
			
		});
		
		
		function formSubmit() {
			var form = $("#inputForm");
			var verify=true;
	        var inputs=$("input[data-verify=false]",form);
	        for(var i=0;i<inputs.length;i++){
	            if($(inputs[i]).attr('data-type') == "date"){
	                $(inputs[i]).parent().trigger('dp.change');
	            }else{
	                $(inputs[i]).trigger('change');
	            }
	            verify=false;
	        }
	        var selects=$("select[data-verify=false]",form);
	        for(var i=0;i<selects.length;i++){
	            $(selects[i]).trigger('change');
	            verify=false;
	        }
	        
	        var userType = $("#userType").val();
	        var roleIdList = $("#roleIdList").val();
	        
	        var id = $("#id").val();
	        if(id == null || id == "" || id == undefined) {
	        	var pwd = $("#newPasswordInput").val();
                var cpwd = $("#confirmPassWord").val();
                
                if(pwd == '' || pwd == null || pwd == undefined) {
                    if($("#newPasswordInputErr").length<=0)
                        $("#newPasswordInput").after("<label id=\"newPasswordInputErr\" class=\"control-label zf-label-err\"><i class=\"fa fa-times-circle-o\"></i>请输入密码，必填项</label>");
                    verify=false;
                } 
                
                if(cpwd == '' || cpwd == null || cpwd == undefined) {
                    if($("#confirmPassWordErr").length<=0)
                        $("#confirmPassWord").after("<label id=\"confirmPassWordErr\" class=\"control-label zf-label-err\"><i class=\"fa fa-times-circle-o\"></i>请输入确认密码，必填项</label>");
                    verify=false;
                } 
                
                if(pwd != cpwd){
                    if($("#confirmPassWordErr").length<=0)
                        $("#confirmPassWord").after("<label id=\"confirmPassWordErr\" class=\"control-label zf-label-err\"><i class=\"fa fa-times-circle-o\"></i>两次密码不一致,请核查</label>");
                    verify=false;
                } 
		        
	        }
	        
	        if(userType == null || userType == '' || userType == undefined) {
	        	if($("#userTypeErr").length<=0)
                    $("#userType").next().after("<label id=\"userTypeErr\" class=\"control-label zf-label-err\"><i class=\"fa fa-times-circle-o\"></i>请选择用户类型，必选项</label>");
	        	verify=false;
            }
	        if(roleIdList == null || roleIdList == '' || roleIdList == undefined) {
	        	if($("#roleIdListErr").length<=0)
                    $("#roleIdList").next().after("<label id=\"roleIdListErr\" class=\"control-label zf-label-err\"><i class=\"fa fa-times-circle-o\"></i>请选择用户角色，必选项</label>");
                verify = false;
            }
	        return verify;
		}
		
		function resetForm() {
			var form = $("#inputForm");
	        if(form==null||form.length<=0){
	            console.log("method resetForm parame form is null 请传入表单对象");
	            return;
	        }
	        $("input[type=text]:not(#no)",form).val("");
	        $("input[type=hidden]",form).val("");
	        $('input',form).each(function(){
	            if($(this).attr("data-verify")=="true"){
	                $(this).trigger('change');
	            }
	        });
	        $("textarea").val('');
	        $("select",form).val("");
	        $("select",form).each(function() {
	        	 $(this).select2("val", "");
	        });
	        $("#userTypeErr").remove();
	        $("#roleIdListErr").remove();
	        
	        $("#newPasswordInput").val("");
	        $("#confirmPassWord").val("");
		}
	</script>
</div>
</body>
</html>