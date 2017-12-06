<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>审批项配置列表</title>
	<meta name="decorator" content="adminLte"/>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
		<section class="content-header content-header-menu">
	      <h1>
				<small class="menu-active"><i class="fa fa-repeat"></i><a
					href="${ctx}/bas/ap/approveConfig/list">审批配置列表</a></small>
				<shiro:hasPermission name="bas:ap:approveConfig:view">
					<small>|</small>
					<small><i class="fa-form-edit"></i><a
						href="${ctx}/bas/ap/approveConfig/form">新建审批项</a></small>
				</shiro:hasPermission>
			</h1>
	    </section>
	    <sys:tip content="${message}"/>
	    <section class="content">
	    	<form:form id="searchForm" modelAttribute="approveConfig" action="${ctx}/bas/ap/approveConfig/list" method="post" class="form-horizontal">
	    		<input type="hidden" id="approveConfigId" name="id" />
	    		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
				<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
				<div class="box box-info">
					<div class="box-header with-border zf-query">
						<h5>查询条件</h5>
						<div class="box-tools pull-right">
							<button type="button" class="btn btn-box-tool"data-widget="collapse"><i class="fa fa-minus"></i></button>
							<button type="button" class="btn btn-box-tool"data-widget="remove"><i class="fa fa-remove"></i></button>
						</div>
					</div>
					<div class="box-body">
						<div class="row">
							<div class="col-md-4">
								<div class="form-group">
									<label for="searchParam" class="col-sm-3 control-label" >审批项名称</label>
									<div class="col-sm-7">
										<form:input id="approveNameText" path="approveName" htmlEscape="false" maxlength="100" class="form-control" placeholder="审批项名称查询"/>
									</div>     
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-group">
									<label for="searchParam" class="col-sm-3 control-label" >业务类型</label>
									<div class="col-sm-7">
										<form:select id="type" path="businessType" htmlEscape="false" maxlength="50" class="form-control select2">
											<form:option value="" label="请选择"/>
											<form:options items="${fns:getDictList('bas_ap_approve_businessType')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
										</form:select>
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
				</div>
	    	</form:form>
	    	<div class="box box-soild">
	    		<div class="table-responsive">
	    			<table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
	    				<thead>
							<tr>
								<th class="zf-dataTables-multiline"></th>
								<th>审批项名称</th>
								<th>是否开启</th>
								<th>审批业务类型</th>
								<th>审批状态类型</th>
								<th>指定审批人</th>
								<th style="display:none">创建者</th>
								<th style="display:none">创建时间</th>
								<th style="display:none">更新者</th>
								<th style="display:none">更新时间</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${page.list}" var="approveConfig" varStatus="status">
								<tr data-index="${status.index }">
									<td class="details-control text-center">
										<i class="fa fa-plus-square-o text-success"></i>
									</td>
									<td>
										${approveConfig.approveName}
									</td>
									<td id="${approveConfig.id }Td">
										<c:if test="${approveConfig.usableFlag=='0' }">
											<span class="label label-primary">${fns:getDictLabel(approveConfig.usableFlag, 'yes_no', '')}</span>
										</c:if>
										<c:if test="${approveConfig.usableFlag=='1' }">
											<span class="label label-success">${fns:getDictLabel(approveConfig.usableFlag, 'yes_no', '')}</span>
										</c:if>
									</td>
									<td>
										${fns:getDictLabel(approveConfig.businessType, 'bas_ap_approve_businessType', '')}
									</td>
									<td>
										${fns:getDictLabel(approveConfig.businessStatus, 'bas_ap_approve_businessStatus', '')}
									</td>
									<td>
										 ${fns:getUserById(approveConfig.approveUser.id).name}
									</td>
									<td data-hide="true">
										${fns:getUserById(approveConfig.createBy.id).name}
									</td>
									<td data-hide="true">
										<fmt:formatDate value="${approveConfig.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>
									<td data-hide="true">
										${fns:getUserById(approveConfig.updateBy.id).name}
									</td>
									<td data-hide="true"> 
										<fmt:formatDate value="${approveConfig.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>
									<td>
										<div class="btn-group">
										  <shiro:hasPermission name="bas:ap:approveConfig:edit">
										  <c:if test="${approveConfig.usableFlag=='0' }">
										  	<button type="button" class="btn btn-sm btn-info" onclick="edit('${ctx }/bas/ap/approveConfig/updateFlag','${approveConfig.id}')">开启</button>
										  </c:if>
										  <c:if test="${approveConfig.usableFlag=='1' }">
										  	<button type="button" class="btn btn-sm btn-info" onclick="edit('${ctx }/bas/ap/approveConfig/updateFlag','${approveConfig.id}')">关闭</button>
										  </c:if>
						                  </shiro:hasPermission>
						                  <button type="button" class="btn btn-sm btn-info dropdown-toggle" data-toggle="dropdown">
						                    <span class="caret"></span>
						                  </button>
						                  <ul class="dropdown-menu btn-info" role="menu">
						                    <li><a href="${ctx}/bas/ap/approveConfig/form?id=${approveConfig.id}" style="color:#fff">修改</a></li>
						                    <shiro:hasPermission name="lgt:ps:lgtPsProperty:edit">
						                    <li><a href="${ctx}/bas/ap/approveConfig/delete?id=${approveConfig.id}" style="color:#fff" onclick="return ZF.delRow('确认要删除该配置吗？',this.href)">删除</a></li>
						                    </shiro:hasPermission>
						                  </ul>
						                </div>
									</td>
								</tr>
							</c:forEach>
	    			</table>
	    		</div>
				
	    	</div>
	    </section>
	</div>
	<script type="text/javascript">
		 //表格初始化
	 	var t=ZF.parseTable("#contentTable",{
			"paging" : false,
			"lengthChange" : false,
			"searching" : false,//关闭搜索
			"order": [[ 1, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
			"ordering" : false,//开启排序
			"info" : false,
			"autoWidth" : false,
			"multiline":true,//是否开启多行表格
			"isRowSelect":true,//是否开启行选中
			"rowSelect":function(tr){},//行选中回调
			"rowSelectCancel":function(tr){}//行取消选中回调
	 	});
		 
	 	//修改
		function edit(url,id){
			$("#approveConfigId").val(id);
			$("#searchForm").attr("action",url);
			$("#searchForm").submit();
		}
	</script>
</body>
</html>