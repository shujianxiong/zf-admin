<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>邀请码列表</title>
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
	</script>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
		<section class="content-header content-header-menu">
			 <h1>
				<small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/spm/ic/inviteCode/listAll">邀请码列表</a></small>
		      </h1>
		</section>
		
		<sys:tip content="${message}" />
		
		<section class="content">
			<form:form id="searchForm" modelAttribute="inviteCode" action="${ctx}/spm/ic/inviteCode/listAll" method="post" class="form-horizontal">
		    	<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
				<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
				<input id="id" name="id" type="hidden"/>
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
				                  	<label for="searchParameter.keyWord" class="col-sm-3 control-label">关键字</label>
				                  	<div class="col-sm-7">
				                  		<form:input path="searchParameter.keyWord" class="form-control" placeholder="请输入邀请码或者活动名称查询" />
				                  	</div>
								</div>
							</div>
							<%-- <div class="col-md-4">
								<div class="form-group">
				                  	<label for="createrType" class="col-sm-3 control-label">创建类型</label>
				                  	<div class="col-sm-7">
				                  		<form:select path="createrType" class="form-control select2">
											<form:option value="" label="所有"/>
											<form:options items="${fns:getDictList('SPM_IC_INVITE_CODE_TYPE') }" itemLabel="label" itemValue="value" htmlEscape="false"/>
										</form:select>
				                  	</div>
								</div>
							</div> --%>
							<div class="col-md-4">
								<div class="form-group">
				                  	<label for="useFlag" class="col-sm-3 control-label">使用标记</label>
				                  	<div class="col-sm-7">
				                  		<form:select path="useFlag" class="form-control select2">
											<form:option value="" label="所有"/>
											<form:options items="${fns:getDictList('yes_no') }" itemLabel="label" itemValue="value" htmlEscape="false"/>
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
								<th>活动邀请人</th>
								<th>邀请码</th>
								<th>适用活动名称</th>
								<th>活动起始时间</th>
								<th>活动结束时间</th>
								<th>创建类型</th>
								<th>使用标记</th>
								<th>被邀请人</th>
								<th>使用时间</th>
								<th style="display:none;">创建者</th>
								<th style="display:none;">创建时间</th>
								<th style="display:none;">更新者</th>
								<th style="display:none;">更新时间</th>
								<!-- <th style="display:none;">备注</th> -->
								<th>操作</th>
							</tr>
						</thead>
						<tbody>
						<c:forEach items="${page.list}" var="inviteCode" varStatus="status">
							<tr data-index="${status.index }">
								<td class="details-control text-center">
											<i class="fa fa-plus-square-o text-success"></i>
										</td>
								<td>
									${fns:getUserById(inviteCode.createrId).name}
								</td>
								<td>
									${inviteCode.inviteCode}
								</td>
								<td title="${inviteCode.activity.name }">
									${fns:abbr(inviteCode.activity.name, 30) }
								</td>
								<td>
									<fmt:formatDate value="${inviteCode.activity.startTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
								</td>
								<td>
									<fmt:formatDate value="${inviteCode.activity.endTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
								</td>
								<td>
									${fns:getDictLabel(inviteCode.createrType,'SPM_IC_INVITE_CODE_TYPE','') }
								</td>
								<td>
									<c:choose>
										<c:when test="${inviteCode.useFlag eq '1' }">
											<span class="label label-success">${fns:getDictLabel(inviteCode.useFlag,'spm_ic_invite_code_useFlag','') }</span>
										</c:when>
										<c:when test="${inviteCode.useFlag eq '0'}">
											<span class="label label-primary">${fns:getDictLabel(inviteCode.useFlag,'spm_ic_invite_code_useFlag','') }</span>
										</c:when>
									</c:choose>
								</td>
								<td>
									${inviteCode.useMember.usercode }
								</td>
								<td>
									<fmt:formatDate value="${inviteCode.useTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
								</td>
								<td data-hide="true">
									${fns:getUserById(inviteCode.createBy.id).name }
								</td>
								<td data-hide="true">
									<fmt:formatDate value="${inviteCode.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
								</td>
								<td data-hide="true">
									${fns:getUserById(inviteCode.updateBy.id).name }
								</td>
								<td data-hide="true">
									<fmt:formatDate value="${inviteCode.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
								</td>
								<%-- <td  data-hide="true"">
									${inviteCode.remarks}
								</td> --%>
								<td>
					              	<div class="btn-group zf-tableButton">
				                  		<button type="button" class="btn btn-xs btn-info" onclick="window.location.href='${ctx}/spm/ic/inviteCode/info?id=${inviteCode.id}'">详情</button>
					                  	<button type="button" class="btn btn-xs btn-info dropdown-toggle" data-toggle="dropdown">
					                    	<span class="caret"></span>
					                  	</button>
					                    <%-- <shiro:hasPermission name="spm:ic:inviteCode:edit">
					                    	<c:if test="${inviteCode.useFlag eq '0' }">
					                  			<ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
					                    			<li><a href="#this" data-href="${ctx}/spm/ic/inviteCode/form" data-message="" data-json="{'id':'${inviteCode.id }'}" onclick="return ZF.xconfirm(this);">修改</a></li>
					                  				<li><a href="#this" data-href="${ctx}/spm/ic/inviteCode/delete" data-message="确认要删除该邀请码记录吗？" data-json="{'id':'${inviteCode.id }'}" onclick="return ZF.xconfirm(this);">删除</a></li>
					                  			</ul>
				                    		</c:if>
					                    </shiro:hasPermission> --%>
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
	
	<script type="text/javascript">
	  $(function () {
		 //表格初始化
		ZF.parseTable("#contentTable", {
			"paging" : false,
			"lengthChange" : false,
			"searching" : false,
			"ordering" : true,
			"order": [[4, "desc"]],//指定默认初始化按第几列排序，默认排序升序，降序
			"columnDefs":[
	  			{"orderable":false,targets:0},
	  			{"orderable":false,targets:1},
				{"orderable":false,targets:2},
				{"orderable":false,targets:3},
				{"orderable":false,targets:6},
	            {"orderable":false,targets:7},
				{"orderable":false,targets:8},
				{"orderable":false,targets:14}
	           ],
			"info" : false,
			"autoWidth" : false,
			"multiline" : true,//是否开启多行表格
			"isRowSelect" : false//是否开启行选中
		});
	  });
	</script>
</body>
</html>