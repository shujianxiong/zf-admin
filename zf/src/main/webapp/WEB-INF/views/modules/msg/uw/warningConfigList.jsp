<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>报警发送设置管理</title>
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
		
		function enable(url,id,message){
			confirm(message,"info",function(){
				$("#warningConfigId").val(id);
				$("#searchForm").attr("action",url);
				$("#searchForm").submit();
			});
		}
		
		function disable(url,id,message){
			confirm(message,"info",function(){
				$("#warningConfigId").val(id);
				$("#searchForm").attr("action",url);
				$("#searchForm").submit();
			});
		}
		
		function enableMonitor(url,id,message){
			confirm(message,"info",function(){
				$("#warningConfigId").val(id);
				$("#searchForm").attr("action",url);
				$("#searchForm").submit();
			});
		}
		
		function disableMonitor(url,id,message){
			confirm(message,"info",function(){
				$("#warningConfigId").val(id);
				$("#searchForm").attr("action",url);
				$("#searchForm").submit();
			});
		}
	</script>
</head>
<body>
<div class="content-wrapper sub-content-wrapper">
	<section class="content-header content-header-menu">
	      <h1>
	        <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/msg/uw/warningConfig/list">报警接收设置列表</a></small>
	        
	        <shiro:hasPermission name="msg:uw:warningConfig:edit"><small>|</small><small><i class="fa-form-edit"></i><a href="${ctx}/msg/uw/warningConfig/form">报警接收设置新增</a></small></shiro:hasPermission>
	      </h1>
    </section>
     <sys:tip content="${message}"/>

  	 <section class="content">
  	     <form:form id="searchForm" modelAttribute="warningConfig" action="${ctx}/msg/uw/warningConfig/" method="post" class="form-horizontal">
	    	<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
			<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
			<input type="hidden" id="warningConfigId" name="id" />
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
				                  <label for="title" class="col-sm-3 control-label">标题</label>
				                  <div class="col-sm-7">
<!-- 				                    <input name="title" type="text" value="" class="form-control" placeholder="请输入标题查询" /> -->
				                    <form:input path="title" class="form-control" placeholder="请输入标题查询" />
				                  </div>
				                </div>
			        		</div>
		        			<div class="col-md-4">
		        				<div class="form-group">
		        					<label for="category" class="col-sm-3 control-label">警报类别</label>
			        				<div class="col-sm-7">
					                   <form:select path="category" class="form-control select2">
											<form:option value="" label="所有"/>
											<form:options items="${fns:getDictList('msg_uw_warning_config_category')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
										</form:select>
					                </div>
		        				</div>
		        			</div>
		        			<div class="col-md-4">
		        				<div class="form-group">
		        					<label for="type" class="col-sm-3 control-label">警报类型</label>
			        				<div class="col-sm-7">
					                   <form:select path="type" class="form-control select2">
											<form:option value="" label="所有"/>
											<form:options items="${fns:getDictList('msg_uw_warning_config_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
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
		   			<table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
		   				<thead>
							<tr>
								<th class="zf-dataTables-multiline"></th>
								<th>警报类别</th>
								<th>警报类型</th>
								<th>标题</th>
								<th>内容文本模型</th>
								<th>接收类型</th>
								<th>接收人</th>
								<th>是否启用</th>
								<th>监控标记</th>
								<th style="display: none">创建者</th>
								<th style="display: none">创建时间</th>
								<th style="display: none">更新者</th>
								<th style="display: none">更新时间</th>
								<th style="display: none">备注信息</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody>
						<c:forEach items="${page.list}" var="warningConfig" varStatus="status">
							<tr data-index="${status.index }">
								<td class="details-control text-center">
									<i class="fa fa-plus-square-o text-success"></i>
								</td>
								<td>
									<c:choose>
										<c:when test="${warningConfig.category eq '0' }">
											<span class="label label-primary">${fns:getDictLabel(warningConfig.category, 'msg_uw_warning_config_category', '')}</span>
										</c:when>
										<c:when test="${warningConfig.category eq '1' }">
											<span class="label label-info">${fns:getDictLabel(warningConfig.category, 'msg_uw_warning_config_category', '')}</span>
										</c:when>
									</c:choose>
								</td>
								<td>
									${fns:getDictLabel(warningConfig.type, 'msg_uw_warning_config_type', '')}
								</td>
								<td>
									${warningConfig.title}
								</td>
								<td>
									${warningConfig.contentModel}
								</td>
								<td>
									${fns:getDictLabel(warningConfig.receiveType, 'msg_uw_warning_config_receiveType', '')}
								</td>
								<td>
									${fns:getUserById(warningConfig.receiveUser.id).name}
								</td>
								<td>
									<c:choose>
										<c:when test="${warningConfig.usableFlag eq '0' }">
											<span class="label label-primary">${fns:getDictLabel(warningConfig.usableFlag, 'yes_no', '')}</span>
										</c:when>
										<c:otherwise>
											<span class="label label-success">${fns:getDictLabel(warningConfig.usableFlag, 'yes_no', '')}</span>
										</c:otherwise>
									</c:choose>
								</td>
								<td>
									<c:choose>
										<c:when test="${warningConfig.monitorFlag eq '0' }">
											<span class="label label-primary">${fns:getDictLabel(warningConfig.monitorFlag, 'yes_no', '')}</span>
										</c:when>
										<c:otherwise>
											<span class="label label-success">${fns:getDictLabel(warningConfig.monitorFlag, 'yes_no', '')}</span>
										</c:otherwise>
									</c:choose>
								</td>
								<td data-hide="true">
									${fns:getUserById(warningConfig.createBy.id).name }
								</td>
								<td data-hide="true">
									<fmt:formatDate value="${warningConfig.createDate }" pattern="yyyy-MM-dd HH:mm:ss"/>
								</td>
								<td data-hide="true">
									${fns:getUserById(warningConfig.updateBy.id).name }
								</td>
								<td data-hide="true">
									<fmt:formatDate value="${warningConfig.updateDate }" pattern="yyyy-MM-dd HH:mm:ss"/>
								</td>
								<td data-hide="true" title="${warningConfig.remarks}">
									${warningConfig.remarks}
								</td>
								<td>
					              	<div class="btn-group zf-tableButton">
				                  		<button type="button" class="btn btn-xs btn-info" onclick="window.location.href='${ctx}/msg/uw/warningConfig/info?id=${warningConfig.id}'">详情</button>
					                  	<button type="button" class="btn btn-xs btn-info dropdown-toggle" data-toggle="dropdown">
					                    	<span class="caret"></span>
					                  	</button>
					                    <shiro:hasPermission name="msg:uw:warningConfig:edit">
						                  	<ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
						                    	<c:choose>
													<c:when test="${warningConfig.monitorFlag ==0 }">
														<li><a href="#this" onclick="enableMonitor('${ctx}/msg/uw/warningConfig/enableMonitor','${warningConfig.id}','确定要启用监控吗？')">启用监控</a></li>
													</c:when>
													<c:otherwise>
														<li><a href="#this" onclick="disableMonitor('${ctx}/msg/uw/warningConfig/disableMonitor','${warningConfig.id}','确定要停用监控吗？')">停用监控</a></li>
													</c:otherwise>
												</c:choose>
						                    	<c:choose>
													<c:when test="${warningConfig.usableFlag == 0 }">
														<li><a href="#this" onclick="enable('${ctx}/msg/uw/warningConfig/enable','${warningConfig.id}','确定要启用吗？')">启用</a></li>
													</c:when>
													<c:otherwise>
														<li><a href="#this" onclick="disable('${ctx}/msg/uw/warningConfig/disable','${warningConfig.id}','确定要停用吗？')">停用</a></li>
													</c:otherwise>
												</c:choose>
												<li><a href="${ctx }/msg/uw/warningConfig/form?id=${warningConfig.id}" >修改</a></li>
												<%-- <li><a href="${ctx }/msg/uw/warningConfig/delete?id=${warningConfig.id}" onclick="return ZF.delRow('确定要删除该记录吗',this.href)">删除</a></li> --%>
						                  	</ul>
					                    </shiro:hasPermission>
					                </div>
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
</div>

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
			"isRowSelect" : false//是否开启行选中
		})
  });
</script>
</body>
</html>