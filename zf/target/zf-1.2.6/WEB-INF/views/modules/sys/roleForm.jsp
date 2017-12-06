<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>角色管理</title>
	<meta name="decorator" content="adminLte"/>
	<%@include file="/WEB-INF/views/include/treeview.jsp" %>
	<script type="text/javascript">
		$(document).ready(function(){
// 			$("#name").focus();
// 			$("#inputForm").validate({
// 				rules: {
// 					name: {remote: "${ctx}/sys/role/checkName?oldName=" + encodeURIComponent("${role.name}")},
// 					enname: {remote: "${ctx}/sys/role/checkEnname?oldEnname=" + encodeURIComponent("${role.enname}")}
// 				},
// 				messages: {
// 					name: {remote: "角色名已存在"},
// 					enname: {remote: "英文名已存在"}
// 				},
// 				submitHandler: function(form){
// 					var ids = [], nodes = tree.getCheckedNodes(true);
// 					for(var i=0; i<nodes.length; i++) {
// 						ids.push(nodes[i].id);
// 					}
// 					$("#menuIds").val(ids);
// 					var ids2 = [], nodes2 = tree2.getCheckedNodes(true);
// 					for(var i=0; i<nodes2.length; i++) {
// 						ids2.push(nodes2[i].id);
// 					}
// 					$("#officeIds").val(ids2);
// 					loading('正在提交，请稍等...');
// 					form.submit();
// 				},
// 				errorContainer: "#messageBox",
// 				errorPlacement: function(error, element) {
// 					$("#messageBox").text("输入有误，请先更正。");
// 					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
// 						error.appendTo(element.parent().parent());
// 					} else {
// 						error.insertAfter(element);
// 					}
// 				}
// 			});




			var a=${fns:toJson(role)}

			var setting = {check:{enable:true,nocheckInherit:true},view:{selectedMulti:false},
					data:{simpleData:{enable:true}},callback:{beforeClick:function(id, node){
						tree.checkNode(node, !node.checked, true, true);
						return false;
					}}};
			
			// 用户-菜单
			var zNodes=[
					<c:forEach items="${menuList}" var="menu">{id:"${menu.id}", pId:"${not empty menu.parent.id?menu.parent.id:0}", name:"${not empty menu.parent.id?menu.name:'权限列表'}"},
		            </c:forEach>];
			// 初始化树结构
			var tree = $.fn.zTree.init($("#menuTree"), setting, zNodes);
			// 不选择父节点
			tree.setting.check.chkboxType = { "Y" : "ps", "N" : "s" };
			// 默认选择节点
			var ids = "${role.menuIds}".split(",");
			for(var i=0; i<ids.length; i++) {
				var node = tree.getNodeByParam("id", ids[i]);
				try{tree.checkNode(node, true, false);}catch(e){}
			}
			// 默认展开全部节点
			tree.expandAll(true);
			
			// 用户-机构
			var zNodes2=[
					<c:forEach items="${officeList}" var="office">{id:"${office.id}", pId:"${not empty office.parent?office.parent.id:0}", name:"${office.name}"},
		            </c:forEach>];
			// 初始化树结构
			var tree2 = $.fn.zTree.init($("#officeTree"), setting, zNodes2);
			// 不选择父节点
			tree2.setting.check.chkboxType = { "Y" : "ps", "N" : "s" };
			// 默认选择节点
			var ids2 = "${role.officeIds}".split(",");
			for(var i=0; i<ids2.length; i++) {
				var node = tree2.getNodeByParam("id", ids2[i]);
				try{tree2.checkNode(node, true, false);}catch(e){}
			}
			// 默认展开全部节点
			tree2.expandAll(true);
			// 刷新（显示/隐藏）机构
			refreshOfficeTree();
			$("#dataScope").change(function(){
				refreshOfficeTree();
			});
			
			
			$("#menuTree").on("click",function(){
				var ids = [], nodes = tree.getCheckedNodes(true);
				for(var i=0; i<nodes.length; i++) {
					ids.push(nodes[i].id);
				}
				$("#menuIds").val(ids);
				var ids2 = [], nodes2 = tree2.getCheckedNodes(true);
				for(var i=0; i<nodes2.length; i++) {
					ids2.push(nodes2[i].id);
				}
				$("#officeIds").val(ids2);
			})
			
		});
		function refreshOfficeTree(){
			if($("#dataScope").val()==9){
				$("#officeTree").show();
			}else{
				$("#officeTree").hide();
			}
		}
	</script>
</head>
<body>

	<div class="content-wrapper sub-content-wrapper">
		<section class="content-header content-header-menu">
			<h1>
		        <small><i class="fa-role"></i><a href="${ctx}/sys/role/">角色列表</a></small>
		        <shiro:hasPermission name="sys:role:edit"><small>|</small>
				<small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/sys/role/form?id=${role.id}"><shiro:hasPermission name="sys:role:edit">角色${not empty role.id?'修改':'新增'}</shiro:hasPermission></a></small></shiro:hasPermission>
		      </h1>
		</section>
		<sys:tip content="${message}"/>
		<section class="content">
			
			<div class="row">
				<div class="col-md-6">
					<form:form id="inputForm" modelAttribute="role" action="${ctx}/sys/role/save" method="post" class="form-horizontal" onsubmit="return ZF.formSubmit()">
						<form:hidden path="id"/>
						<div class="box box-info">
							<div class="box-header with-border zf-query">
								<h5>角色信息录入表单</h5>
							</div>
							<div class="box-body">
								<sys:inputtree url="${ctx }/sys/office/treeData" label="归属机构" tip="请选择机构" id="office" inputWidth="9" labelWidth="2" labelName="office.name" name="office.id"></sys:inputtree>
								<div class="form-group">
									<label class="col-sm-2 control-label">角色名称</label>
									<div class="col-sm-9">
										<input id="oldName" name="oldName" type="hidden" value="${role.name}">
										<sys:inputverify name="name" id="name" verifyType="0" tip="请输入角色名称，必填项" isSpring="true"></sys:inputverify>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-2 control-label">英文名称</label>
									<div class="col-sm-9">
										<input id="oldEnname" name="oldEnname" type="hidden" value="${role.enname}">
										<sys:inputverify name="enname" id="enname" verifyType="0" tip="请输入英文名称，必填项" isSpring="true"></sys:inputverify>
									</div>
								</div>
								<%-- <div class="form-group">
									<label class="col-sm-2 control-label">角色类型</label>
									<div class="col-sm-9">
										<form:input path="roleType" htmlEscape="false" maxlength="50" class="required"/>
										<span class="help-inline" title="activiti有3种预定义的组类型：security-role、assignment、user 如果使用Activiti Explorer，需要security-role才能看到manage页签，需要assignment才能claim任务">
											工作流组用户组类型（security-role：管理员、assignment：可进行任务分配、user：普通用户）</span>
										<form:select path="roleType" class="form-control select2">
											<form:option value="assignment">任务分配</form:option>
											<form:option value="security-role">管理角色</form:option>
											<form:option value="user">普通角色</form:option>
										</form:select>
									</div>
								</div> --%>
								<div class="form-group">
									<label class="col-sm-2 control-label">是否系统数据</label>
									<div class="col-sm-9">
										<form:select path="sysData" class="form-control select2">
											<form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
										</form:select>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-2 control-label">是否可用</label>
									<div class="col-sm-9">
										<form:select path="useable" class="form-control select2">
											<form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
										</form:select>
									</div>
								</div>
								<%-- <div class="form-group">
									<label class="col-sm-2 control-label">数据范围</label>
									<div class="col-sm-9">
										<form:select path="dataScope" class="form-control select2">
											<form:options items="${fns:getDictList('sys_data_scope')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
										</form:select>
									</div>
								</div> --%>
								<div class="form-group">
									<label class="col-sm-2 control-label">角色授权</label>
									<div class="col-sm-9">
										<div id="menuTree" class="ztree" style="margin-top:3px;float:left;"></div>
										<form:hidden path="menuIds"/>
										<div id="officeTree" class="ztree" style="margin-left:100px;margin-top:3px;float:left;"></div>
										<form:hidden path="officeIds"/>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-2 control-label">备注</label>
									<div class="col-sm-9">
										<form:textarea path="remarks" htmlEscape="false" rows="3" maxlength="200" class="form-control"/>
									</div>
								</div>
							</div>
							<div class="box-footer">
			    				<div class="pull-left box-tools">
					        		<button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
					        	</div>
		    					<div class="pull-right box-tools">
				        			<button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
									<c:if test="${(role.sysData eq fns:getDictValue('是', 'yes_no', '1') && fns:getUser().admin)||!(role.sysData eq fns:getDictValue('是', 'yes_no', '1'))}">
				               			<shiro:hasPermission name="sys:role:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
			               			</c:if>
					        	</div>
				            </div>
						</div>
					</form:form>
				</div>
			</div>
		
			
		</section>
	</div>
	
	
</body>
</html>