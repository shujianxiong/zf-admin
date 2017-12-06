<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>员工消息发送设置管理</title>
	<meta name="decorator" content="adminLte"/>
	<style type="text/css">
		tr{ 
		    cursor: pointer;    /*手形*/   
		} 
	</style>
	<script type="text/javascript">
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
		
		function enable(url,id,message){
			confirm(message,"info",function(){
				$("#messageConfigId").val(id);
				$("#searchForm").attr("action",url);
				$("#searchForm").submit();
			})
		}
		
		function disable(url,id,message){
			confirm(message,"info",function(){
				$("#messageConfigId").val(id);
				$("#searchForm").attr("action",url);
				$("#searchForm").submit();
			})
		}
	</script>
</head>
<body>
<div class="content-wrapper sub-content-wrapper">
	<section class="content-header content-header-menu">
      <h1>
        <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/msg/um/messageConfig/list">员工消息接收设置列表</a></small>
        
        <shiro:hasPermission name="msg:um:messageConfig:edit"><small>|</small><small><i class="fa-form-edit"></i><a href="${ctx}/msg/um/messageConfig/form">员工消息接收设置新增</a></small></shiro:hasPermission>
      </h1>
    </section>
	
	<section class="content">
		<form:form id="searchForm" modelAttribute="messageConfig" action="${ctx}/msg/um/messageConfig/" method="post" class="form-horizontal">
			<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
			<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
			<input type="hidden" id="messageConfigId" name="id" />
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
			                    <form:input path="title" htmlEscape="false" maxlength="50" placeholder="请输入消息标题查询" class="form-control"/>
			                  </div>
		        			</div>
		        		</div>
		        		<div class="col-md-4">
		        			<div class="form-group">
	        				  <label for="category" class="col-sm-3 control-label">消息类别</label>
	        				  <div class="col-sm-7">
			                    <form:select path="category" class="form-control select2">
									<form:option value="" label="所有"/>
									<form:options items="${fns:getDictList('msg_um_message_category')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
								</form:select>
			                  </div>
		        			</div>
		        		</div>
		        		<div class="col-md-4">
		        			<div class="form-group">
		        				<label for="type" class="col-sm-3 control-label">消息类型</label>
		        				<div class="col-sm-7">
				                    <form:select path="type" class="form-control select2">
										<form:option value="" label="所有"/>
										<form:options items="${fns:getDictList('msg_um_message_config_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
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
									<th class="zf-dataTables-multiline"></th>
									<th>消息类别</th>
									<th>消息类型</th>
									<th>标题</th>
									<th>内容文本模型</th>
									<th>接收角色</th>
									<th>启用标记</th>
									<th style="display: none">创建者</th>
									<th style="display: none">创建时间</th>
									<th style="display: none">更新者</th>
									<th style="display: none">更新时间</th>
									<th style="display: none">备注信息</th>
									<shiro:hasPermission name="msg:um:messageConfig:edit"><th>操作</th></shiro:hasPermission>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${page.list}" var="messageConfig" varStatus="status">
									<tr data-index="${status.index }">
										<td class="details-control text-center">
											<i class="fa fa-plus-square-o text-success"></i>
										</td>
										<td>
											${fns:getDictLabel(messageConfig.category, 'msg_um_message_category', '')}
										</td>
										<td>
											${fns:getDictLabel(messageConfig.type, 'msg_um_message_config_type', '')}
										</td>
										<td>
											${messageConfig.title}
										</td>
										<td>
											${messageConfig.contentModel}
										</td>
										<td>
											${messageConfig.receiveRole.name}
										</td>
										<td>
											<c:choose>
												<c:when test="${messageConfig.usableFlag eq '1' }">
													<span class="label label-success">${fns:getDictLabel(messageConfig.usableFlag, 'yes_no', '')}</span>
												</c:when>
												<c:when test="${messageConfig.usableFlag eq '0' }">
													<span class="label label-primary">${fns:getDictLabel(messageConfig.usableFlag, 'yes_no', '')}</span>
												</c:when>
											</c:choose>
										</td>
										<td data-hide="true">
											${fns:getUserById(messageConfig.createBy.id).name }
										</td>
										<td data-hide="true">
											<fmt:formatDate value="${messageConfig.createDate }" pattern="yyyy-MM-dd HH:mm:ss"/>
										</td>
										<td data-hide="true">
											${fns:getUserById(messageConfig.updateBy.id).name }
										</td>
										<td data-hide="true">
											<fmt:formatDate value="${messageConfig.updateDate }" pattern="yyyy-MM-dd HH:mm:ss"/>
										</td>
										<td data-hide="true">
											${messageConfig.remarks}
										</td>
										<shiro:hasPermission name="msg:um:messageConfig:edit">
											<td>
								              	<div class="btn-group zf-tableButton">
							                  		<button type="button" class="btn btn-xs btn-info" onclick="window.location.href='${ctx}/msg/um/messageConfig/info?id=${messageConfig.id}'">详情</button>
								                  	<button type="button" class="btn btn-xs btn-info dropdown-toggle" data-toggle="dropdown">
								                    	<span class="caret"></span>
								                  	</button>
								                  	<ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
									                    <shiro:hasPermission name="msg:um:messageConfig:edit">
									                    	<c:choose>
																<c:when test="${messageConfig.usableFlag == 0 }">
																	<li><a href="#this" onclick="enable('${ctx}/msg/um/messageConfig/enable','${messageConfig.id}','确定要启用吗？')">启用</a></li>
																</c:when>
																<c:otherwise>
																	<li><a href="#this" onclick="disable('${ctx}/msg/um/messageConfig/disable','${messageConfig.id}','确定要停用吗？')">停用</a></li>
																</c:otherwise>
															</c:choose>
															<li><a href="${ctx }/msg/um/messageConfig/form?id=${messageConfig.id}" >修改</a></li>
															<li><a href="${ctx }/msg/um/messageConfig/delete?id=${messageConfig.id}" onclick="return ZF.delRow('确定要删除该记录吗',this.href)">删除</a></li>
									                    </shiro:hasPermission>
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