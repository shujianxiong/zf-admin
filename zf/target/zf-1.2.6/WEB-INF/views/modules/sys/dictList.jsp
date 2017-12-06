<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>字典管理</title>
	<meta name="decorator" content="adminLte"/>
	<script type="text/javascript">
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
	    	return false;
	    }
	</script>
</head>
<body>
	
	<!-- Content Wrapper. Contains page content -->
	<div class="content-wrapper sub-content-wrapper">
	    
	    <section class="content-header content-header-menu">
			<h1>
		        <small class="menu-active">
		        	<i class="fa fa-repeat"></i><a href="${ctx}/sys/dict/">字典列表</a>
		        </small>
		        <shiro:hasPermission name="sys:dict:edit">
			        <small>|</small>
			        <small>
			        	<i class="fa-form-edit"></i><a href="${ctx}/sys/dict/form?sort=10">字典添加</a>
			        </small>
			    </shiro:hasPermission>
	      	</h1>
		</section>
	    
	    <sys:tip content="${message}"/>
	    
	    <section class="content">
	    	<form:form id="searchForm" modelAttribute="dict" action="${ctx}/sys/dict/" method="post" class="form-horizontal">
	    	<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
			<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
	    	<div class="box box-info">
	    		<div class="box-header with-border zf-query">
		          <h5>查询条件</h5>
		          <div class="box-tools pull-right">
		            <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
		            <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-remove"></i></button>
		          </div>
		        </div>
		        <div class="box-body">
		        	<div class="row">
		        		<div class="col-md-4">
		        			<div class="form-group">
			                  <label for="searchParam" class="col-sm-3 control-label">描述</label>
			                  <div class="col-sm-7">
			                    <input name="description" data-toggle="tooltip"  type="text" value="${dict.description }" class="form-control" placeholder="输入描述内容模糊匹配查询" />
			                  </div>
			                </div>
		        		</div>
		        		<div class="col-md-4">
		        			<div class="form-group">
			                  <label for="type" class="col-sm-3 control-label">类型</label>
			                  <div class="col-sm-7">
			                    <form:select path="type" class="form-control select2">
			                    	<form:option value="" label="所有"/>
									<form:options items="${typeList}" htmlEscape="false"/>
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
	    		<div class="box-body">
	    			<div class="table-responsive">
		    			<table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
							<thead>
								<tr>
								<th>键值</th>
								<th>标签</th>
								<th>类型</th>
								<th>描述</th>
								<th>排序</th>
								<shiro:hasPermission name="sys:dict:edit"><th>操作</th></shiro:hasPermission>
							</tr>
							</thead>
							<tbody>
							<c:forEach items="${page.list}" var="dict">
								<tr>
									<td>${dict.value}</td>
									<td>${dict.label}</td>
									<td>${dict.type}</td>
									<td>${dict.description}</td>
									<td>${dict.sort}</td>
									<shiro:hasPermission name="sys:dict:edit">
									<td>
										<div class="btn-group zf-tableButton">
											<button type="button" class="btn btn-xs btn-info" onclick="window.location.href='${ctx}/sys/dict/form?id=${dict.id}'">修改</button>
											<button type="button" class="btn btn-xs btn-info dropdown-toggle" data-toggle="dropdown">
							                   <span class="caret"></span>
							                </button>
							                <ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
							                	<li><a href="${ctx}/sys/dict/delete?id=${dict.id}&type=${dict.type}" onclick="return confirmx('确认要删除该字典吗？', this.href)">删除</a></li>
							    				<li><a href="<c:url value='${fns:getAdminPath()}/sys/dict/form?type=${dict.type}&sort=${dict.sort+10}'><c:param name='description' value='${dict.description}'/></c:url>">添加键值</a></li>
							                </ul>
										</div>
									</td>
									</shiro:hasPermission>
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
<script>
	  $(function () {
		  //表格初始化
		ZF.parseTable("#contentTable", {
			"paging" : false,
			"lengthChange" : false,
			"searching" : false,
			"ordering" : true,
			"order": [[ 4, "asc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
			"columnDefs":[
				{"orderable":false,targets:0},
				{"orderable":false,targets:1},
				{"orderable":false,targets:2},
				{"orderable":false,targets:3},
				{"orderable":false,targets:5}
            ],
			"info" : false,
			"autoWidth" : false,
			"multiline" : true,//是否开启多行表格
			"isRowSelect" : false//是否开启行选中
		})
		  	
	  	
	  });
</script>
</body>
</html>