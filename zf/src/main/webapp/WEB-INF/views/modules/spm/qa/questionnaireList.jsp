<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>问卷管理</title>
	<meta name="decorator" content="adminLte"/>
	<style type="text/css">
		tr{ 
		    cursor: pointer;    /*手形*/   
		} 
	</style>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
		<section class="content-header content-header-menu">
			<h1>
				<small class="menu-active">
					<i class="fa fa-repeat"></i><a href="${ctx}/spm/qa/questionnaire/">问卷列表</a>
				</small>
				<shiro:hasPermission name="spm:qa:questionnaire:edit">
					<small>|</small>
					<small>
						<i class="fa-form-edit"></i><a href="${ctx}/spm/qa/questionnaire/form">问卷添加</a>
					</small>
				</shiro:hasPermission>
			</h1>
		</section>
		
		<sys:tip content="${message}" />
		
		<section class="content">
			<form:form id="searchForm" modelAttribute="questionnaire" action="${ctx}/spm/qa/questionnaire/" method="post" class="form-horizontal">
				<input type="hidden" name="id" >
				<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
				<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
				<div class="box box-info">
					<div class="box-header with-border zf-query">
						<h5>查询条件</h5>
						<div class="box-tools pull-right">
							<button type="button" class="btn btn-box-tool" data-widget="collapse">
								<i class="fa fa-minus"></i>
							</button>
							<button type="button" class="btn btn-box-tool" data-widget="remove">
								<i class="fa fa-remove"></i>
							</button>
						</div>
					</div>
					<div class="box-body">
						<div class="row">
							<div class="col-md-4">
								<div class="form-group">
									<label for="name" class="col-sm-3 control-label">问卷名称</label>
									<div class="col-sm-7">
										<form:input path="name" htmlEscape="false" maxlength="64" class="form-control" placeholder="请输入问卷名称进行查询"/>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-group">
									<label for="type" class="col-sm-3 control-label">问卷类别</label>
									<div class="col-sm-7">
										<form:select path="type" htmlEscape="false" maxlength="50" class="form-control select2">
											<form:option label="所有" value="" />
											<form:options items="${fns:getDictList('spm_qa_questionnaire_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
										</form:select>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-group">
									<label for="status" class="col-sm-3 control-label">问卷状态</label>
									<div class="col-sm-7">
										<form:select path="status" htmlEscape="false" maxlength="50" class="form-control select2">
											<form:option label="所有" value="" />
											<form:options items="${fns:getDictList('spm_qa_questionnaire_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
										</form:select>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="box-footer">
						<div class="pull-right box-tools">
							<button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()">
								<i class="fa fa-refresh"></i>重置
							</button>
							<button type="submit" class="btn btn-info btn-sm">
								<i class="fa fa-search"></i>查询
							</button>
						</div>
					</div>
				</div>
			</form:form>
			
			<div class="box box-soild">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-12 pull-right"></div>
					</div>
					<div class="table-responsive">
						<table id="contentTable" class="table table-hover table-bordered table-striped zf-tbody-font-size">
							<thead>
								<tr>
									<th class="zf-dataTables-multiline"></th>
									<th>问卷名称</th>
									<th>问卷类别</th>
									<th>问卷状态</th>
									<th>问卷标题</th>
									<th>问卷说明</th>
									<th>是否奖励积分</th>
									<th>奖励积分数量</th>
									<th style="display:none">创建者</th>
									<th style="display:none">创建时间</th>
									<th style="display:none">更新者</th>
									<th style="display:none">更新时间</th>
									<th style="display:none">备注信息</th>
									<th><shiro:hasPermission name="spm:qa:questionnaire:edit">操作</shiro:hasPermission></th>
								</tr>
							</thead>
							<tbody>
							<c:forEach items="${page.list}" var="questionnaire" varStatus="qstatus">
								<tr data-index="${qstatus.index}${status.index}">
									<td class="details-control text-center"><i class="fa fa-plus-square-o text-success"></i></td>
									<td  title="${ questionnaire.name}">
										${fns:abbr(questionnaire.name,16)}
									</td>
									<td>
										${fns:getDictLabel(questionnaire.type, 'spm_qa_questionnaire_type', '')}
									</td>
									<td>
										<c:choose>
											<c:when test="${ questionnaire.status eq '1'}">
												<span class="label label-primary">${fns:getDictLabel(questionnaire.status, 'spm_qa_questionnaire_status', '')}</span>
											</c:when>
											<c:when test="${ questionnaire.status eq '2'}">
												<span class="label label-success">${fns:getDictLabel(questionnaire.status, 'spm_qa_questionnaire_status', '')}</span>
											</c:when>
										</c:choose>
									</td>
									<td title="${ questionnaire.title}">
										${fns:abbr(questionnaire.title,16)}
									</td>
									<td title="${questionnaire.description }">
										${fns:abbr(questionnaire.description,32)}
									</td>
									<td>
										<c:choose>
											<c:when test="${ questionnaire.rewardPointFlag eq '0'}">
												<span class="label label-primary">${fns:getDictLabel(questionnaire.rewardPointFlag, 'yes_no', '')}</span>
											</c:when>
											<c:when test="${ questionnaire.rewardPointFlag eq '1'}">
												<span class="label label-success">${fns:getDictLabel(questionnaire.rewardPointFlag, 'yes_no', '')}</span>
											</c:when>
										</c:choose>
									</td>
									<td>
										${questionnaire.rewardPointNum}
									</td>
									<td data-hide="true">
										${fns:getUserById(questionnaire.createBy.id).name}
									</td>
									<td data-hide="true">
										<fmt:formatDate value="${questionnaire.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>
									<td data-hide="true">
										${fns:getUserById(questionnaire.updateBy.id).name}
									</td>
									<td data-hide="true">
										<fmt:formatDate value="${questionnaire.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>
									<td data-hide="true">
										${questionnaire.remarks}
									</td>
									<td>
										<div class="btn-group zf-tableButton">
											<button type="button" class="btn btn-sm btn-info" onclick="window.location.href='${ctx}/spm/qa/questionnaire/info?id=${questionnaire.id}'">详情</button>
											<shiro:hasPermission name="spm:qa:questionnaire:edit">
												<button type="button" class="btn btn-sm btn-info dropdown-toggle" data-toggle="dropdown">
													<span class="caret"></span>
												</button>
												<ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
													<c:if test="${questionnaire.status eq '1' }">
														<li><a href="#this" data-href="${ctx}/spm/qa/questionnaire/addQueform" data-json="{'id':'${questionnaire.id }'}" onclick="ZF.xconfirm(this)">关联问题</a></li>
														<li><a href="#this" data-href="${ctx}/spm/qa/questionnaire/updateStatus" data-json="{'id':'${questionnaire.id }'}" onclick="ZF.xconfirm(this)">发布</a></li>
														<li><a href="${ctx}/spm/qa/questionnaire/form?id=${questionnaire.id}">修改</a></li>
													</c:if>
													<li><a href="#this" onclick="ZF.delRow('确认要删除该问卷吗？','${ctx}/spm/qa/questionnaire/delete?id=${questionnaire.id}')">删除</a></li>
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
      		<sys:selectmutil id="baseQuestionSelect" title="问卷问题选择" url="${ctx}/spm/qa/baseQuestion/questionSelect?questionnaireId=${ questionnaire.id}" isDisableCommitBtn="true" width="1200" height="700" isRefresh="false"></sys:selectmutil>
		</section>
	</div>
	<script type="text/javascript">
		$(function () {
			ZF.bigImg();
			
			// 表格初始化
		 	ZF.parseTable("#contentTable",{
				"paging" : false,
				"lengthChange" : false,
				"searching" : false,
				"order": [[ 7, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
				"columnDefs":[
					{"orderable":false,targets:0},
					{"orderable":false,targets:1},
					{"orderable":false,targets:2},
					{"orderable":false,targets:3},
					{"orderable":false,targets:4},
					{"orderable":false,targets:5},
					{"orderable":false,targets:6},
					{"orderable":false,targets:8},
					{"orderable":false,targets:9},
					{"orderable":false,targets:10},
					{"orderable":false,targets:11},
					{"orderable":false,targets:12},
					{"orderable":false,targets:13}
	            ],
				"ordering" : true,
				"info" : false,
				"autoWidth" : false,
				"multiline":true,//是否开启多行表格
				"isRowSelect":true,//是否开启行选中
				"rowSelect":function(tr){productId = tr.attr("data-value");},
				"rowSelectCancel":function(tr){productId = null;}
			})
		});
		
		function addQuestion(questionnaireId,name){
			$("#baseQuestionSelectModal").modal('toggle');//显示模态框
		}
	</script>			
</body>
</html>