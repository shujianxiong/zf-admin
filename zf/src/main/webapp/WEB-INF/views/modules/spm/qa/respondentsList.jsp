<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>答卷列表管理</title>
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
				<small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/spm/qa/respondents/">答卷列表</a></small>
		      </h1>
		</section>
		<sys:tip content="${message}"/>
		<section class="content">
			<form:form id="searchForm" modelAttribute="respondents" action="${ctx}/spm/qa/respondents/" method="post" class="form-horizontal">
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
										<form:input path="searchParameter.keyWord" htmlEscape="false" maxlength="64" class="form-control" placeholder="请输入问卷名称或会员账号查询" />
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-group">
									<label for="answerChannel" class="col-sm-3 control-label">答题渠道</label>
									<div class="col-sm-7">
										<form:select path="answerChannel" class="form-control select2">
											<form:option value="" label="所有"/>
											<form:options items="${fns:getDictList('crm_mi_member_registerPlatform')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
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
								<th>问卷名称</th>
								<th>答题人账号</th>
								<th>答题人姓名</th>
								<th>答题渠道</th>
								<th>起始时间</th>
								<th>结束时间</th>
								<th>获得分值</th>
								<th>更新时间</th>
								<th>备注信息</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody>
						<c:forEach items="${page.list}" var="respondents">
							<tr>
								<td>
									${respondents.questionnaire.name}
								</td>
								<td>
									${respondents.member.usercode}
								</td>
								<td>
									${respondents.member.name}
								</td>
								<td>
									${fns:getDictLabel(respondents.answerChannel, 'crm_mi_member_registerPlatform', '')}
								</td>
								<td>
									<fmt:formatDate value="${respondents.startTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
								</td>
								<td>
									<fmt:formatDate value="${respondents.endTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
								</td>
								<td>
									${respondents.point}
								</td>
								<td>
									<fmt:formatDate value="${respondents.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
								</td>
								<td title="${respondents.remarks}">
									${fns:abbr(respondents.remarks,15)}
								</td>
								<td>
									<div class="btn-group zf-tableButton">
				                  		<button type="button" class="btn btn-xs btn-info" onclick="window.location.href='${ctx}/spm/qa/respondents/info?id=${respondents.id}'">详情</button>
				                  		<button type="button" class="btn btn-sm btn-info dropdown-toggle" data-toggle="dropdown">
                                          <span class="caret"></span>
                                        </button>
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
			"ordering" : true,
			"order": [[ 4, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
			"columnDefs":[
				{"orderable":false,targets:0},
				{"orderable":false,targets:1},          
				{"orderable":false,targets:2},          
				{"orderable":false,targets:3}, 
				{"orderable":false,targets:6},
				{"orderable":false,targets:9},  
				{"orderable":false,targets:8}
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