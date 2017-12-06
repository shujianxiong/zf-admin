<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>活动调研记录管理</title>
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
				<small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx }/spm/ac/activityResearchRc/list">活动参与记录列表</a></small>
		      </h1>
		</section>
	    <sys:tip content="${message}"/>
		<section class="content">
			<form:form id="searchForm" modelAttribute="activityResearchRc" action="${ctx }/spm/ac/activityResearchRc/list" method="post" class="form-horizontal">
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
				                  <label for="searchParameter.keyWord" class="col-sm-3 control-label">关键字</label>
				                  <div class="col-sm-7">
				                  	  <form:input path="searchParameter.keyWord" class="form-control" placeholder="请输入会员账号或活动名称查询"/>
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
									<th>参与人账号</th>
									<th>活动名称</th>
									<th>活动类型</th>
									<th>活动标题</th>
									<th>参与状态</th>
									<th>创建者</th>
									<th>创建时间</th>
									<th>更新者</th>
									<th>更新时间</th>
									<th>备注</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach items="${page.list}" var="activityResearchRc">
								<tr>
									<td>
										${activityResearchRc.member.usercode}
									</td>
									<td title="${activityResearchRc.activityResearch.activity.name }">
										${fns:abbr(activityResearchRc.activityResearch.activity.name,16) }
									</td>
									<td>
										<c:choose>
											<c:when test="${activityResearchRc.activityResearch.activity.activityType eq '1' }">
												<span class="label label-primary">${fns:getDictLabel(activityResearchRc.activityResearch.activity.activityType,'spm_ai_activity_activityType','') }</span>
											</c:when>
											<c:otherwise>
												<span class="label label-success">${fns:getDictLabel(activityResearchRc.activityResearch.activity.activityType,'spm_ai_activity_activityType','') }</span>
											</c:otherwise>
										</c:choose>
										
									</td>
									<td title="${activityResearchRc.activityResearch.activity.title}">
										${fns:abbr(activityResearchRc.activityResearch.activity.title,32) }
									</td>
									<td>
										<c:choose>
											<c:when test="${ activityResearchRc.status eq '1'}">
												<span class="label label-primary">${fns:getDictLabel(activityResearchRc.status,'spm_ac_activity_research_rc_status','') }</span>
											</c:when>
											<c:when test="${ activityResearchRc.status eq '2'}">
												<span class="label label-success">${fns:getDictLabel(activityResearchRc.status,'spm_ac_activity_research_rc_status','') }</span>
											</c:when>
										</c:choose>
									</td>
									<td>
										${fns:getUserById(activityResearchRc.createBy.id).name }
									</td>
									<td>
										<fmt:formatDate value="${activityResearchRc.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>
									<td>
										${fns:getUserById(activityResearchRc.updateBy.id).name }
									</td>
									<td>
										<fmt:formatDate value="${activityResearchRc.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>
									<td title="${activityResearchRc.remarks }">
										${fns:abbr(activityResearchRc.remarks,48)}
									</td>
									<td>
						              	<div class="btn-group zf-tableButton">
					                  		<button type="button" class="btn btn-xs btn-info" onclick="window.location.href='${ctx}/spm/ac/activityResearchRc/info?id=${activityResearchRc.id}'">详情</button>
						                  	<button type="button" class="btn btn-xs btn-info dropdown-toggle" data-toggle="dropdown">
						                    	<span class="caret"></span>
						                  	</button>
						                    <shiro:hasPermission name="spm:ac:activityResearchRc:edit">
							                  	<ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
														<li><a  href="${ctx}/spm/ac/activityResearchRc/delete?id=${activityResearchRc.id}" onclick="return ZF.delRow('确认要删除该活动参与记录吗？', this.href)">删除</a></li>
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
	 //表格初始化
	ZF.parseTable("#contentTable", {
		"paging" : false,
		"lengthChange" : false,
		"searching" : false,
		"ordering" : true,
		"order": [[ 6, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
		"columnDefs":[
  			{"orderable":false,targets:0},
			{"orderable":false,targets:1},
			{"orderable":false,targets:2},
			{"orderable":false,targets:3},
			{"orderable":false,targets:4},
			{"orderable":false,targets:5},
			{"orderable":false,targets:7},
			{"orderable":false,targets:9},
			{"orderable":false,targets:10}
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