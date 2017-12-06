<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>供应商账号管理</title>
	<meta name="decorator" content="adminLte"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#btnExport").click(function(){
				top.$.jBox.confirm("确认要导出用户数据吗？","系统提示",function(v,h,f){
					if(v=="ok"){
						$("#searchForm").attr("action","${ctx}/sys/user/export");
						$("#searchForm").submit();
					}
				},{buttonsFocus:1});
				top.$('.jbox-body .jbox-icon').css('top','55px');
			});
			$("#btnImport").click(function(){
				$.jBox($("#importBox").html(), {title:"导入数据", buttons:{"关闭":true}, 
					bottomText:"导入文件不能超过5M，仅允许导入“xls”或“xlsx”格式文件！"});
			});
		});
		function page(n,s){
			if(n) $("#pageNo").val(n);
			if(s) $("#pageSize").val(s);
			$("#searchForm").attr("action","${ctx}/lgt/si/supplier/supplierAccountList");
			$("#searchForm").submit();
	    	return false;
	    }
	</script>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
		<section  class="content-header content-header-menu">
			<h1>
				<small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/lgt/si/supplier/supplierAccountList">供应商账号列表</a></small>
				
				<shiro:hasPermission name="lgt:si:supplier:edit"><small>|</small><small><i class="fa-form-edit"></i><a href="${ctx}/lgt/si/supplier/supplierAccountForm">供应商账号${not empty supplier.id?'修改':'添加'}</a></small></shiro:hasPermission>
			</h1>
		</section>
		<sys:tip content="${message}"/>
		
		<section  class="content">
			<div class="box box-info">
				<div class="box-header with-border zf-query">
					<h5>查询条件</h5>
					<div class="box-tools pull-right">
						<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
						<button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-remove"></i></button>
					</div>
				</div>
				
				<sys:userselect height="550" url="${ctx}/sys/office/userTreeData"
					width="550" isOffice="true" isMulti="false" title="公司选择"
					id="selectCompany" dataType="Company"></sys:userselect>
					
				<sys:userselect height="550" url="${ctx}/sys/office/userTreeData"
					width="550" isOffice="true" isMulti="false" title="部门选择"
					id="selectOffice" dataType="Office"></sys:userselect>
				
				<form:form id="searchForm" modelAttribute="user" action="${ctx}/lgt/si/supplier/supplierAccountList" method="post" class="form-horizontal">
					<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
					<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
					<input id="userCategory" name="userCategory" type="hidden" value="S"/>
					<div class="box-body">
						<div class="row">
							<div class="col-md-4">
								<div  class="form-group">
									<label for="companyName" class="col-sm-3 control-label">归属公司</label>
									<div class="col-sm-7">
										<div class="input-group">
											<form:hidden id="companyId" path="company.id" />
											<form:input id="companyName" path="company.name" htmlEscape="false" maxlength="100" class="form-control zf-input-readonly"
												placeholder="选择归属公司" readonly="true"/>
											<span class="input-group-addon" onclick="selectCompany();"><i class="fa fa-search"></i></span>
										</div>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div  class="form-group">
									<label for="officeName" class="col-sm-3 control-label">归属部门</label>
									<div class="col-sm-7">
										<div class="input-group">
											<form:hidden id="officeId" path="office.id" />
											<form:input id="officeName" path="office.name" htmlEscape="false" maxlength="100" class="form-control zf-input-readonly"
												placeholder="选择归属部门" readonly="true"/>
											<span class="input-group-addon" onclick="selectOffice();"><i class="fa fa-search"></i></span>
										</div>
									</div>
								</div>
							</div>
							
							<div class="col-md-4">
								<div class="form-group">
									<label for="loginName" class="col-sm-3 control-label" >关键字</label>
									<div class="col-sm-7">
										<form:input id="loginName" path="loginName" htmlEscape="false" maxlength="255" class="form-control"   placeholder="请输入登录名或者姓名"/>
									</div>
								</div>
							</div>
							
						</div>
					</div>
					<div class="box-footer">
						<div class="pull-right box-tools">
			        		<button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
		               		<button type="submit" class="btn btn-info btn-sm"><i class="fa fa-search"></i>查询</button>
			        	</div>
					</div>
	            </form:form>
			</div>
		
			<div class="box box-soild">
				<div class="box-body">
					<div class="table-responsive">
						<table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
							<thead>
								<th>登录名</th>
								<th>关联供应商名称</th>
								<th>姓名</th>
								<th>电话</th>
								<th>手机</th>
								<th>归属公司</th>
								<th>归属部门</th>
								<th>是否允许登录后台</th>
								<th>是否允许登录APP</th>
								<%--<th>角色</th> --%>
								<th>操作</th>
							</thead>
						    <tbody>
						    	<c:forEach items="${page.list}" var="user">
									<tr>
										<!--  -->
										<td>
											<%-- <a href="${ctx}/lgt/si/supplier/supplierAccountInfo?uid=${user.id}"> --%>
											${user.loginName}
											<!-- </a> -->
										</td>
										<td>${user.supplier.name }</td>
										<td>${user.name}</td>
										<td>${user.phone}</td>
										<td>${user.mobile}</td>
										<td>${user.company.name}</td>
										<td>${user.office.name}</td>
										<td>
											<c:choose>
												<c:when test="${user.loginFlag eq '1'}">
													<span class="label label-success">${fns:getDictLabel(user.loginFlag, 'yes_no', '') }</span>
												</c:when>
												<c:when test="${user.loginFlag eq '0'}">
													<span class="label label-primary">${fns:getDictLabel(user.loginFlag, 'yes_no', '') }</span>
												</c:when>
											</c:choose>
										</td>
										<td>
											<c:choose>
												<c:when test="${user.loginAppFlag eq '1'}">
													<span class="label label-success">${fns:getDictLabel(user.loginAppFlag, 'yes_no', '') }</span>
												</c:when>
												<c:when test="${user.loginAppFlag eq '0'}">
													<span class="label label-primary">${fns:getDictLabel(user.loginAppFlag, 'yes_no', '') }</span>
												</c:when>
											</c:choose>
										</td>
										<td>
										  <shiro:hasPermission name="lgt:si:supplier:edit">
												<div class="btn-group zf-tableButton">
								                  <button type="button" class="btn btn-sm btn-info" onclick="window.location.href='${ctx}/lgt/si/supplier/supplierAccountForm?uid=${user.id}'">修改</button>
								                  <button type="button" class="btn btn-sm btn-info dropdown-toggle" data-toggle="dropdown">
								                    <span class="caret"></span>
								                  </button>
								                  <ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
								                    	<li>
								                    	    <a href="${ctx}/lgt/si/supplier/supplierAccountDelete?uid=${user.id}" style="color:#fff" onclick="return ZF.delRow('确认要删除该供应商账号吗？',this.href)">删除</a>
								                    	</li>
								                     	<li>
									                    	<c:choose>
									                    		<c:when test="${user.loginFlag == 1 }">
									                    			<a href="${ctx}/lgt/si/supplier/changeFlag?uid=${user.id}&loginFlag=0" style="color:#fff" onclick="return changeFlag('确认要禁止该用户登录后台的权限吗？',this.href)">
									                    				禁止登录后台
									                    			</a>
									                    		</c:when>
									                    		<c:when test="${user.loginFlag == 0 || user.loginFlag == null}">
									                    			<a href="${ctx}/lgt/si/supplier/changeFlag?uid=${user.id}&loginFlag=1" style="color:#fff" onclick="return changeFlag('确认要启用该用户登录后台的权限吗？',this.href)">
									                    				开启登录后台
									                    			</a>
									                    		</c:when>
									                    	</c:choose>
									                    </li>
								                     	<li>
								                     		<c:choose>
									                    		<c:when test="${user.loginAppFlag == 1 }">
									                    			<a href="${ctx}/lgt/si/supplier/changeFlag?uid=${user.id}&loginAppFlag=0" style="color:#fff" onclick="return changeFlag('确认要禁止该用户登录APP的权限吗？',this.href)">
									                    				禁止登录APP
									                        		</a>
									                    		</c:when>
									                    		<c:when test="${user.loginAppFlag == 0  || user.loginAppFlag == null}">
									                    			<a href="${ctx}/lgt/si/supplier/changeFlag?uid=${user.id}&loginAppFlag=1" style="color:#fff" onclick="return changeFlag('确认要启用该用户登录APP的权限吗？',this.href)">
									                    				开启登录APP
									                        		</a>
									                    		</c:when>
									                    	</c:choose>
								                     	</li>
								                     	<li><a href="${ctx}/lgt/si/supplier/supplierAccountInfo?uid=${user.id}">详情</a></li>
								                  </ul>
								                </div>
						                    </shiro:hasPermission>
						                    <shiro:lacksPermission name="lgt:si:supplier:edit">
						                    	<div class="btn-group zf-tableButton">
									                  <button type="button" class="btn btn-sm btn-info" onclick="window.location.href='${ctx}/lgt/si/supplier/supplierAccountInfo?uid=${user.id}'">详情</button>
									                  <button type="button" class="btn btn-sm btn-info dropdown-toggle" data-toggle="dropdown">
									                    <span class="caret"></span>
									                  </button>
									            </div>
						                    </shiro:lacksPermission>
						                </td>
									</tr>
								</c:forEach>
						    </tbody>
						</table> 
					</div>
					<div class="box-footer">
	        			<div class="dataTables_paginate paging_simple_numbers">${page}</div>
	        		</div>
			</div>
		</section>
		
		<script>
		  $(function () {
			    //表格初始化
				ZF.parseTable("#contentTable", {
					"paging" : false,
					"lengthChange" : false,
					"searching" : false,
					"ordering" : false,
					"info" : false,
					"autoWidth" : false,
					"multiline" : true,//是否开启多行表格
					"isRowSelect" : true,//是否开启行选中
					"rowSelect" : function(tr) {
						purchaseId = tr.attr("data-value");
					},
					"rowSelectCancel" : function(tr) {
						purchaseId = null;
					}
				})
		  });
		</script>
		
		<script type="text/javascript">
			$(function() {
				$("#companyName").on("click", function() {
					selectCompanyinit({
						"selectCallBack" : function(list) {
							$("#companyId").val(list[0].id);
							$("#companyName").val(list[0].text);
						}
					})
				});
				$("#officeName").on("click", function() {
					selectOfficeinit({
						"selectCallBack" : function(list) {
							$("#officeId").val(list[0].id);
							$("#officeName").val(list[0].text);
						}
					})
				});
			});
			
			function changeFlag(message,href){
				confirm(message,"info",function(){
					window.location.href=href;
				});
				return false;
			}
			
			function selectCompany() {
				selectCompanyinit({
					"selectCallBack" : function(list) {
						$("#companyId").val(list[0].id);
						$("#companyName").val(list[0].text);
					}
				});
			}
			
			function selectOffice() {
				selectOfficeinit({
					"selectCallBack" : function(list) {
						$("#officeId").val(list[0].id);
						$("#officeName").val(list[0].text);
					}
				});
			}
		</script>
		
	</div>
</body>
</html>