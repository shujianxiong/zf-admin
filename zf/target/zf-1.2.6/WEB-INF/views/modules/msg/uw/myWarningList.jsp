<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>员工报警中心管理</title>
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
				<small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/msg/uw/myWarning/list">预警列表</a></small>
			</h1>
		</section>
	    <sys:tip content="${message}"/>
		<section class="content">
			 <form:form id="searchForm" modelAttribute="warning" action="${ctx}/msg/uw/myWarning/" method="post" class="form-horizontal">
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
					                  <label for="searchParam" class="col-sm-3 control-label">标题</label>
					                  <div class="col-sm-7">
					                    <form:input path="title" type="text" class="form-control zf-input-readonly" placeholder="输入标题进行匹配查询" />
					                  </div>
					                </div>
				        		</div>
				        		<div class="col-md-4">
				        			<div class="form-group">
					                  <label for="type" class="col-sm-3 control-label">警报类型</label>
					                  <div class="col-sm-7">
					                    <form:select path="type" class="form-control select2" style="width: 100%;">
											<form:option value="" label="所有"/>
											<form:options items="${fns:getDictList('msg_uw_warning_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
										</form:select>
					                  </div>
					                </div>
				        		</div>
				        		<div class="col-md-4">
				        			<div class="form-group">
					                  <label for="sendUser.id" class="col-sm-3 control-label">发送用户</label>
					                  <div class="col-sm-7">
					                  	<input type="hidden" id="sendUserId" name="sendUser.id">
										<input id="sendUserBtn" type="text" data-value="" value="" placeholder="按发送人查询" class="form-control zf-input-readonly" readonly="readonly"/>
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
									<th>标题</th>
									<th>内容</th>
									<th>报警项</th>
									<th>警报类型</th>
									<th>发送用户</th>
									<th>当前状态</th>
									<th>触发时间</th>
									<th>查看时间</th>
									<th>处理完成时间</th>
									<th style="display: none;">结果备注</th>
									<shiro:hasPermission name="msg:uw:mywarning:edit"><th>操作</th></shiro:hasPermission>
									<th style="display: none;">创建者</th>
									<th style="display: none;">创建时间</th>
									<th style="display: none;">更新者</th>
									<th style="display: none;">更新时间</th>
									<th style="display: none;">备注</th>
							</tr>
							</thead>
							<tbody>
								<c:forEach items="${page.list}" var="warning" varStatus="status">
									<tr data-index="${status.index }">
										<td class="details-control text-center">
											<i class="fa fa-plus-square-o text-success"></i>
										</td>
										<td>
											${warning.title}
										</td>
										<td title="${warning.content}">
											${fns:abbr(warning.content,32)}
										</td>
										<td>
											${fns:getDictLabel(warning.category, 'msg_uw_warning_category', '')}
										</td>
										<td>
											<c:choose>
												<c:when test="${warning.type eq '0'}">
													<span class="label label-info">${fns:getDictLabel(warning.type, 'msg_uw_warning_type', '')}</span>
												</c:when>
												<c:when test="${warning.type eq '1'}">
													<span class="label label-primary">${fns:getDictLabel(warning.type, 'msg_uw_warning_type', '')}</span>
												</c:when>
												<c:when test="${warning.type eq '2'}">
													<span class="label label-primary">${fns:getDictLabel(warning.type, 'msg_uw_warning_type', '')}</span>
												</c:when>
												<c:when test="${warning.type eq '3'}">
													<span class="label label-danger">${fns:getDictLabel(warning.type, 'msg_uw_warning_type', '')}</span>
												</c:when>
											</c:choose>
										</td>
										<td>
											${fns:getUserById(warning.sendUser.id).name}
										</td>
										<td>
											<c:if test="${warning.status eq '1'}">
												<span class="label label-primary">${fns:getDictLabel(warning.status, 'msg_uw_warning_status', '')}</span>
											</c:if>
											<c:if test="${warning.status eq '2'}">
												<span class="label label-warning">${fns:getDictLabel(warning.status, 'msg_uw_warning_status', '')}</span>
											</c:if>
											<c:if test="${warning.status eq '3'}">
												<span class="label label-success">${fns:getDictLabel(warning.status, 'msg_uw_warning_status', '')}</span>
											</c:if>
										</td>
										<td>
											<fmt:formatDate value="${warning.pushTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
										</td>
										<td>
											<fmt:formatDate value="${warning.viewTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
										</td>
										<td>
											<fmt:formatDate value="${warning.dealEndTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
										</td>
										<td data-hide="true">
											${warning.dealResultRemarks}
										</td>
										<shiro:hasPermission name="msg:uw:mywarning:edit">
										<td>
						              		<div class="btn-group zf-tableButton">
							                  <button type="button" class="btn btn-xs btn-info" onclick="window.location.href='${ctx}/msg/uw/myWarning/info?id=${warning.id}'">详情</button>
							                  <button type="button" class="btn btn-xs btn-info dropdown-toggle" data-toggle="dropdown">
							                    <span class="caret"></span>
							                  </button>
							                  <ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
							                  		<c:if test="${warning.status ne '3'}">
							                  			<li><a href="${ctx}/msg/uw/myWarning/toDeal?id=${warning.id}">处理</a></li>
							                  		</c:if>
							                    <li><a href="${ctx}/msg/uw/myWarning/delete?id=${warning.id}" style="color:#fff" onclick="return ZF.delRow('确认要删除该记录吗？',this.href)">删除</a></li>
							                  </ul>
							                </div>
										</td>
										</shiro:hasPermission>
										<td data-hide="true">
											${fns:getUserById(warning.createBy.id).name }
										</td>
										<td data-hide="true">
											<fmt:formatDate value="${warning.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
										</td>
										<td data-hide="true">
											${fns:getUserById(warning.updateBy.id).name }
										</td>
										<td data-hide="true">
											<fmt:formatDate value="${warning.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
										</td>
										<td data-hide="true">
											${warning.remarks}
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
	 <sys:userselect id="sendUser" url="${ctx}/sys/office/userTreeData" isMulti="false" title="人员选择" height="550" width="550"></sys:userselect>
<script>
	  $(function () {
		  //表格初始化
	 	var t=ZF.parseTable("#contentTable",{
			"paging" : false,
			"lengthChange" : false,
			"searching" : false,//关闭搜索
			"order": [[ 15, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
			"columnDefs":[
				{"orderable":false,targets:0},
				{"orderable":false,targets:1},
				{"orderable":false,targets:2},
				{"orderable":false,targets:3},
				{"orderable":false,targets:4},
				{"orderable":false,targets:5},
				{"orderable":false,targets:6},
				{"orderable":false,targets:11}
          ],
			"ordering" : true,//开启排序
			"info" : false,
			"autoWidth" : false,
			"multiline":true,//是否开启多行表格
			"isRowSelect":true,//是否开启行选中
			"rowSelect":function(tr){},//行选中回调
			"rowSelectCancel":function(tr){}//行取消选中回调
		});
	  	
	  	$("#sendUserBtn").on("click",function(){
	  		sendUserinit({
		   		"selectCallBack":function(list){
   					if(list.length>0){
   						$("#sendUserId").val(list[0].id);
   						$("#sendUserBtn").val(list[0].text);
			   		}
				}
			});
	  	})
	  	
	  });
</script>
</body>
</html>