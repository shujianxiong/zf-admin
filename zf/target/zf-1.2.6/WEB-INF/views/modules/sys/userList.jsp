<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>用户管理</title>
	<meta name="decorator" content="adminLte"/>
	<script type="text/javascript">
		function page(n,s){
			if(n) $("#pageNo").val(n);
			if(s) $("#pageSize").val(s);
			$("#searchForm").attr("action","${ctx}/sys/user/list");
			$("#searchForm").submit();
	    	return false;
	    }
		
		function changeFlag(message,href){
			confirm(message,"info",function(){
				window.location.href=href;
			});
			return false;
		}
	</script>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
		<section  class="content-header content-header-menu">
			<h1>
				<small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/sys/user/list">用户列表</a></small>
				<shiro:hasPermission name="sys:user:edit">
				    <small>|</small>
				    <small><i class="fa-form-edit"></i><a href="${ctx}/sys/user/form">用户${not empty user.id?'修改':'添加'}</a></small>
				</shiro:hasPermission>
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
				
				<sys:userselect height="550" url="${ctx}/sys/office/treeData"
					width="550" isOffice="true" isMulti="false" title="部门选择" isTopSelectable="true"
					id="selectOffice" dataType="Office"></sys:userselect>
				
				<form:form id="searchForm" modelAttribute="user" action="${ctx}/sys/user/list" method="post" class="form-horizontal">
					<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
					<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
					<input id="userCategory" name="userCategory" type="hidden" value="U"/>
					<div class="box-body">
						<div class="row">
							<div class="col-md-4">
								<div class="form-group">
									<label for="loginName" class="col-sm-3 control-label" >关键字</label>
									<div class="col-sm-7">
										<form:input id="loginName" path="loginName" htmlEscape="false" maxlength="255" class="form-control"   placeholder="请输入登录名或者姓名"/>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div  class="form-group">
									<label for="officeName" class="col-sm-3 control-label">归属部门</label>
									<div class="col-sm-7">
										<form:hidden id="officeId" path="office.id" />
										<form:input id="officeName" path="office.name"
											htmlEscape="false" maxlength="100" class="form-control zf-input-readonly"
											placeholder="选择归属部门" readonly="true"/>
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
					<div class="row">
						<div class="col-sm-12 pull-right">
				          	<button type="button" class="btn btn-sm btn-info" onclick="operat(1);"><i class="fa fa-check-square">详情</i></button>
				            <shiro:hasPermission name="sys:user:edit">
				                <button type="button" class="btn btn-sm btn-dropbox" onclick="operat(2);"><i class="fa fa-edit">修改</i></button>
					   		    <button type="button" class="btn btn-sm btn-github" onclick="operat(3);"><i class="fa fa-remove">删除</i></button>
							</shiro:hasPermission>
						</div>
					</div>
					<div class="table-responsive">
						<table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
							<thead>
								<tr>
									<th>登录名</th>
									<th>姓名</th>
									<!-- <th>角色</th> -->
									<th>用户类型</th>
									<th>电话</th>
									<th>手机</th>
									<th>归属公司</th>
									<th>归属部门</th>
									<th>是否允许登录后台</th>
									<th>是否允许登录APP</th>
									<th>操作</th>
								</tr>
							</thead>
						    <tbody>
						    	<c:forEach items="${page.list}" var="user">
									<tr data-id="${user.id }">
										<!--  -->
										<td>
											<%-- <a href="${ctx}/sys/user/infoSimple?id=${user.id}"> --%>
											${user.loginName}
											<!-- </a> -->
										</td>
										<td>${user.name}</td>
										<%-- <td>${user.role.name }</td> --%>
										<td>
										
											<c:if test="${user.userType eq '1'}"><!-- 系统管理 -->
												<span class="label label-success">${fns:getDictLabel(user.userType, 'sys_user_type', '无')}</span>
											</c:if> 
											<c:if test="${user.userType eq '2'}"><!-- 部门经理 -->
												<span class="label label-primary">${fns:getDictLabel(user.userType, 'sys_user_type', '无')}</span>
											</c:if>
											<c:if test="${user.userType eq '3'}"><!-- 普通用户 -->
												<span class="label label-info">${fns:getDictLabel(user.userType, 'sys_user_type', '无')}</span>
											</c:if> 
										
										</td>
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
											  <shiro:hasPermission name="sys:user:edit">
												<div class="btn-group zf-tableButton">
												  <button type="button" class="btn btn-sm btn-info" onclick="window.location.href='${ctx}/sys/user/form?id=${user.id}'">修改</button>
								                  <button type="button" class="btn btn-sm btn-info dropdown-toggle" data-toggle="dropdown">
								                    <span class="caret"></span>
								                  </button>
							                  	  <ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
								                    <li><a href="${ctx}/sys/user/delete?id=${user.id}" style="color:#fff" onclick="return ZF.delRow('确认要删除该用户账号吗？',this.href)">删除</a></li>
								                    <li>
								                    	<c:choose>
								                    		<c:when test="${user.loginFlag == 1 }">
								                    			<a href="${ctx}/sys/user/changeFlag?id=${user.id}&loginFlag=0" style="color:#fff" onclick="return changeFlag('确认要禁止该用户登录后台的权限吗？',this.href)">
								                    				禁止登录后台
								                    			</a>
								                    		</c:when>
								                    		<c:when test="${user.loginFlag == 0 || user.loginFlag == null}">
								                    			<a href="${ctx}/sys/user/changeFlag?id=${user.id}&loginFlag=1" style="color:#fff" onclick="return changeFlag('确认要启用该用户登录后台的权限吗？',this.href)">
								                    				开启登录后台
								                    			</a>
								                    		</c:when>
								                    	</c:choose>
								                    </li>
								                    <li>
								                    	<c:choose>
								                    		<c:when test="${user.loginAppFlag == 1 }">
								                    			<a href="${ctx}/sys/user/changeFlag?id=${user.id}&loginAppFlag=0" style="color:#fff" onclick="return changeFlag('确认要禁止该用户登录APP的权限吗？',this.href)">
								                    				禁止登录APP
								                        		</a>
								                    		</c:when>
								                    		<c:when test="${user.loginAppFlag == 0  || user.loginAppFlag == null}">
								                    			<a href="${ctx}/sys/user/changeFlag?id=${user.id}&loginAppFlag=1" style="color:#fff" onclick="return changeFlag('确认要启用该用户登录APP的权限吗？',this.href)">
								                    				开启登录APP
								                        		</a>
								                    		</c:when>
								                    	</c:choose>
								                    </li>
								                    <li><a href="${ctx}/sys/user/resetPwd?id=${user.id}">重置密码</a></li>
								                    <li><a href="${ctx}/sys/user/infoSimple?id=${user.id}">详情</a></li>
								                  </ul>
								                </div>
							                </shiro:hasPermission>
							                <shiro:lacksPermission name="sys:user:edit">
							                	<div class="btn-group zf-tableButton">
												  <button type="button" class="btn btn-sm btn-info" onclick="window.location.href='${ctx}/sys/user/infoSimple?id=${user.id}'">详情</button>
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
			    </div>
				<div class="box-footer">
        			<div class="dataTables_paginate paging_simple_numbers">${page}</div>
        		</div>
			</div>
		</section>
	</div>
	<script type="text/javascript">
		$(function() {
			
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
					
				},
				"rowSelectCancel" : function(tr) {
					
				}
			})
				
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
		
		//获取行选中ID
		function getSelectTrId(){
			var trs=$("tr");
			for(var i=0;i<trs.length;i++){
				if($(trs[i]).hasClass('selected')){
					return $(trs[i]).attr("data-id");
				}
			}
			return "";
		}
		
		function operat(type) {
			var selVal = getSelectTrId();
			if(selVal == null || selVal == "" || selVal == undefined) {
                ZF.showTip("请先选择要操作的用户记录！", "info");
                return false;
            } else {
				if(type == 1) {
					window.location.href = "${ctx}/sys/user/infoSimple?id="+getSelectTrId();
				} else if(type == 2) {
					window.location.href = "${ctx}/sys/user/form?id="+getSelectTrId();
				} else if(type == 3) {
					confirm("确认要删除该用户账号吗？", "info", function() {
						window.location.href = "${ctx}/sys/user/delete?id="+getSelectTrId();
					});
				} else {
					ZF.showTip("请先选择要操作的用户记录！", "info");
					return false;
				}
            }
		}
	</script>
</body>
</html>