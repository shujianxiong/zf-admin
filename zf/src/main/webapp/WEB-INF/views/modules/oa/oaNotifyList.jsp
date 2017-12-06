<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>通知管理</title>
	<meta name="decorator" content="adminLte"/>
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
	<div class="nav-tabs-custom tab-success">
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/oa/oaNotify/${oaNotify.self?'self':''}">通知列表</a></li>
		<c:if test="${!oaNotify.self}"><shiro:hasPermission name="oa:oaNotify:edit"><li><a href="${ctx}/oa/oaNotify/form">通知添加</a></li></shiro:hasPermission></c:if>
	</ul>
	</div>
	<!-- Content Wrapper. Contains page content -->
	<div class="content-wrapper">
		<section class="content-header">
	      <h1>
	        	通告管理
	        <small>我的通告列表</small>
	      </h1>
	    </section>
	    
	    <sys:tip content="${message}"/>
	    <form:form id="searchForm" modelAttribute="oaNotify" action="${ctx}/oa/oaNotify/${oaNotify.self?'self':''}" method="post" class="form-horizontal">
	    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
	    <section class="content">
	    	<div class="box box-info">
	    		<div class="box-header with-border">
		          <h3 class="box-title">查询条件面板</h3>
		          <div class="box-tools pull-right">
		            <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
		            <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-remove"></i></button>
		          </div>
		        </div>
		        <div class="box-body">
		        	<div class="row">
		        		<div class="col-md-4">
		        			<div class="form-group">
			                  <label for="searchParam" class="col-sm-2 control-label">关键字</label>
			                  <div class="col-sm-5">
			                    <input name="title" type="text" value="" class="form-control" placeholder="请输入标题匹配查询" />
			                  </div>
			                </div>
		        		</div>
		        		<div class="col-md-4">
		        			<div class="form-group">
			                  <label for="level" class="col-sm-2 control-label">类型</label>
			                  <div class="col-sm-5">
			                    <form:select path="type" class="form-control select2" style="width: 100%;">
									<form:option value="" label="所有"/>
									<form:options items="${fns:getDictList('oa_notify_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
								</form:select>
			                  </div>
			                </div>
		        		</div>
		        		<!-- radio -->
		              	<c:if test="${!requestScope.oaNotify.self}"><div class="form-group">
			                <label>
			                  	状态：
			                  <form:radiobuttons path="status" items="${fns:getDictList('oa_notify_status')}" itemLabel="label" itemValue="value" htmlEscape="false" class="minimal"/>
			                </label>
		              </div></c:if>
		        	</div>
		        </div>
		        <div class="box-footer">
		        	<div class="pull-right box-tools">
		        		<button type="button" class="btn btn-default" onclick="clearQueryParam()">重置</button>
	               		<button type="submit" class="btn btn-info">查询</button>
		        	</div>
	            </div>
	    	</div>
	    	
	    	<div class="box box-solid">
	    		<div class="box-body">
	    			<table id="contentTable" cellspacing="0" class="table table-bordered table-hover table-striped">
						<thead>
							<tr>
							<th>标题</th>
							<th>类型</th>
							<th>状态</th>
							<th>查阅状态</th>
							<th>更新时间</th>
							<c:if test="${!oaNotify.self}"><shiro:hasPermission name="oa:oaNotify:edit"><th>操作</th></shiro:hasPermission></c:if>
						</tr>
						</thead>
						<tbody>
						<c:forEach items="${page.list}" var="oaNotify">
							<tr>
								<td><a href="${ctx}/oa/oaNotify/${requestScope.oaNotify.self?'view':'form'}?id=${oaNotify.id}">
									${fns:abbr(oaNotify.title,50)}
								</a></td>
								<td>
									${fns:getDictLabel(oaNotify.type, 'oa_notify_type', '')}
								</td>
								<td>
									${fns:getDictLabel(oaNotify.status, 'oa_notify_status', '')}
								</td>
								<td>
									<c:if test="${requestScope.oaNotify.self}">
										${fns:getDictLabel(oaNotify.readFlag, 'oa_notify_read', '')}
									</c:if>
									<c:if test="${!requestScope.oaNotify.self}">
										${oaNotify.readNum} / ${oaNotify.readNum + oaNotify.unReadNum}
									</c:if>
								</td>
								<td>
									<fmt:formatDate value="${oaNotify.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
								</td>
								<c:if test="${!requestScope.oaNotify.self}"><shiro:hasPermission name="oa:oaNotify:edit">
								<td>
									<div class="input-group">
						                <div class="input-group-btn">
						                  <button type="button" class="btn bg-purple-active dropdown-toggle" data-toggle="dropdown">操作
						                    <span class="fa fa-caret-down"></span></button>
						                  <ul class="dropdown-menu">
						                    <li><a href="${ctx}/oa/oaNotify/form?id=${oaNotify.id}">修改</a></li>
											<li><a href="${ctx}/oa/oaNotify/delete?id=${oaNotify.id}" onclick="return confirmx('确认要删除该通知吗？', this.href)">删除</a></li>
						                  </ul>
						                </div>
					              	</div>
								</td>
								</shiro:hasPermission></c:if>
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
	    </form:form>
	</div>
	
<script>
	  $(function () {
		 //表格初始化
	    var t=$('#contentTable').DataTable({
	      "paging": false,
	      "lengthChange": false,
	      "searching": false,
	      "ordering": false,
	      "info": false,
	      "autoWidth": false
	    });
	    
	  	//表格单选功能
	    $('#contentTable tbody').on( 'click', 'tr', function (){
	        if ($(this).hasClass('selected')) {
	            $(this).removeClass('selected');
	        }else{
	        	$('#contentTable tr.selected').removeClass('selected');
	            $(this).addClass('selected');
	        }
	    });
	  	
	  //iCheck for checkbox and radio inputs
	    $('input[type="checkbox"].minimal, input[type="radio"].minimal').iCheck({
	      checkboxClass: 'icheckbox_minimal-blue',
	      radioClass: 'iradio_minimal-blue'
	    });
	  	
	  });
</script>
</body>
</html>