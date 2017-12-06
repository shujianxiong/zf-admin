<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>系统业务参数表管理</title>
	<meta name="decorator" content="adminLte"/>
	<style type="text/css">
		tr{ 
		    cursor: pointer;    /*手形*/   
		} 
	</style>
	<script type="text/javascript">
		$(document).ready(function() {
	        
	    });
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
<div class="content-wrapper sub-content-wrapper">
	<section class="content-header content-header-menu">
    	<h1>
			<small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/sys/config/list">系统业务参数设置列表</a></small>
        	<small>|</small>
			<small><i class="fa-form-edit"></i><a href="${ctx}/sys/config/form">系统业务参数设置新增</a></small>
      	</h1>
    </section>
    
   	<section class="content">
    	<div class="box box-info">
    		<div class="box-header with-border zf-query">
	          <h5>查询条件</h5>
	           <div class="box-tools pull-right">
		            <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
		            <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-remove"></i></button>
	          	</div>
	        </div>
	        
		    <form:form id="searchForm" modelAttribute="config" action="${ctx}/sys/config/list" method="post" class="form-horizontal">
		    	<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
				<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		        <div class="box-body">
		        	<div class="row">
		        		<div class="col-md-4">
		        			<div class="form-group">
	        				  <label for="code" class="col-sm-3 control-label">关键词</label>
	        				  <div class="col-sm-7">
			                    <form:input path="code" htmlEscape="false" maxlength="50" class="form-control" placeholder="支持参数编码、参数值、参数说明查询"/>
			                  </div>
		        			</div>
		        		</div>
		        		<div class="col-md-4">
		        			<div class="form-group">
		        				<label for="configType" class="col-sm-3 control-label">参数类型</label>
		        				<div class="col-sm-7">
				                    <form:select path="configType" class="form-control select2">
										<form:option value="" label="所有"/>
										<form:options items="${fns:getDictList('sys_config_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
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
    		</form:form>
	    </div>
	     
		<div class="box box-solid">
    		<div class="box-body">
    			<div class="table-responsive">
	    			<table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
		    			<thead>
							<tr>
								<th>参数编码</th>
								<th>参数类型</th>
								<th>参数值</th>
								<th>参数说明</th>
								<th>创建者</th>
								<th>创建时间</th>
								<th>更新者</th>
								<th>更新时间</th>
								<th>备注信息</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${page.list}" var="config">
								<tr>
									<td>
										${config.code}
									</td>
									<td>
										${fns:getDictLabel(config.configType, 'sys_config_type', '')}
									</td>
									<td title="${config.configValue }">
										${fns:abbr(config.configValue,30)}
									</td>
									<td>
										${config.description}
									</td>
									<td>
										${fns:getUserById(config.createBy.id).name}
									</td>
									<td>
										<fmt:formatDate value="${config.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>
									<td>
										${fns:getUserById(config.updateBy.id).name}
									</td>
									<td>
										<fmt:formatDate value="${config.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>
									<td title="${config.remarks }">
										${fns:abbr(config.remarks,15)}
									</td>
									<td>
						              	<div class="btn-group zf-tableButton">
					                  		<button type="button" class="btn btn-xs btn-info" onclick="window.location.href='${ctx}/sys/config/info?id=${config.id}'">详情</button>
						                  	<button type="button" class="btn btn-xs btn-info dropdown-toggle" data-toggle="dropdown">
						                    	<span class="caret"></span>
						                  	</button>
						                    <shiro:hasPermission name="sys:config:edit">
							                  	<ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
													<li><a href="#this" onclick="window.location.href='${ctx}/sys/config/form?id=${config.id}'">修改</a></li>
													<li><a  href="${ctx}/sys/config/delete?id=${config.id}" onclick="return ZF.delRow('确认要删除该记录吗？', this.href)">删除</a></li>
							                  	</ul>
						                    </shiro:hasPermission>
						                </div>
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
<script>
$(function () {
	// 缩略图展示
	ZF.bigImg();
	
 	// 表格初始化
		var t=ZF.parseTable("#contentTable",{
		"paging" : false,
		"lengthChange" : false,
		"searching" : false,				// 关闭搜索
		"order": [[ 5, "desc" ]],			// 指定默认初始化按第几列排序，默认排序升序，降序
		"columnDefs":[
			{"orderable":false,targets:0},	// 第0、8、17、18列不排序
			{"orderable":false,targets:1},
			{"orderable":false,targets:2},
			{"orderable":false,targets:3},
			{"orderable":false,targets:4},
			{"orderable":false,targets:6},
			{"orderable":false,targets:8},
			{"orderable":false,targets:9}
         ],
		"ordering" : true,					// 开启排序
		"info" : false,
		"autoWidth" : false,
		"multiline":true,					// 是否开启多行表格
		"isRowSelect":true,					// 是否开启行选中
		"rowSelect":function(tr){},			// 行选中回调
		"rowSelectCancel":function(tr){}	// 行取消选中回调
	});
 });
</script>
</body>
</html>