<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>问题管理</title>
	<meta name="decorator" content="adminLte"/>
	<style type="text/css">
		tr{ 
		    cursor: pointer;    /*手形*/   
		} 
	</style>
	<script type="text/javascript">
		$(document).ready(function() {
			$('#hint1').tooltip();
			$('#hint2').tooltip();
			$('#hint3').tooltip();
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
		//清空查询条件
		function clearQueryParam(){
			$("#name").val("");
			$("#s2id_type").select2("val","");
			$("#s2id_answerType").select2("val","");
		}
	</script>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
		<section class="content-header content-header-menu">
			<h1>
				<small class="menu-active">
					<i class="fa fa-repeat"></i><a href="${ctx}/spm/qa/baseQuestion/list">问题列表</a>
				</small>
				<shiro:hasPermission name="spm:qa:baseQuestion:edit">
					<small>|</small>
					<small>
						<i class="fa-form-edit"></i><a href="${ctx}/spm/qa/baseQuestion/form">问题添加</a>
					</small>
				</shiro:hasPermission>
			</h1>
		</section>
		
		<sys:tip content="${message}" />
		
		<section class="content">
			<form:form id="searchForm" modelAttribute="baseQuestion" action="${ctx}/spm/qa/baseQuestion/" method="post" class="form-horizontal">
				<input type="hidden" name="id" />
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
									<label for="code" class="col-sm-3 control-label">问题名称</label>
									<div class="col-sm-7">
										<form:input path="name" htmlEscape="false" maxlength="64" class="form-control" placeholder="请输入问题名称进行查询"/>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-group">
									<label for="code" class="col-sm-3 control-label">问题类型</label>
									<div class="col-sm-7">
										<form:select path="type" htmlEscape="false" maxlength="50" class="form-control select2">
											<form:option label="所有" value="" />
											<form:options items="${fns:getDictList('spm_qa_base_question_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
										</form:select>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-group">
									<label for="code" class="col-sm-3 control-label">答案类型</label>
									<div class="col-sm-7">
										<form:select path="answerType" htmlEscape="false" maxlength="50" class="form-control select2">
											<form:option label="所有" value="" />
											<form:options items="${fns:getDictList('spm_qa_base_question_answerType')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
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
									<th>问题名称</th>
									<th>问题类型</th>
									<th>问题描述</th>
									<!-- <th>问题图片介绍</th> -->
									<th>答案类型</th>
									<th>启用状态</th>
									<th style="display:none">创建者</th>
									<th style="display:none">创建时间</th>
									<th style="display:none">更新者</th>
									<th style="display:none">更新时间</th>
									<th>备注信息</th>
									<th><shiro:hasPermission name="spm:qa:baseQuestion:edit">操作</shiro:hasPermission></th>
								</tr>
							</thead>
							<tbody>
							<c:forEach items="${page.list}" var="baseQuestion" varStatus="qstatus">
								<tr data-index="${qstatus.index}${status.index}">
									<td class="details-control text-center"><i class="fa fa-plus-square-o text-success"></i></td>
									<td>
										${baseQuestion.name}
									</td>
									<td>
										${fns:getDictLabel(baseQuestion.type, 'spm_qa_base_question_type', '')}
									</td>
									<td>
										${baseQuestion.description}
									</td>
									<!-- <td>
										<img src="${baseQuestion.photo}" data-src="${baseQuestion.photo}" data-big style="width:20px;height:20px;">
									</td> -->
									<td>
										${fns:getDictLabel(baseQuestion.answerType, 'spm_qa_base_question_answerType', '')}
									</td>
									<td>
										<c:if test="${baseQuestion.activeFlag=='0' }">
											<span class="label label-primary">${fns:getDictLabel(baseQuestion.activeFlag, 'yes_no', '')}</span>
										</c:if>
										<c:if test="${baseQuestion.activeFlag=='1' }">
											<span class="label label-success">${fns:getDictLabel(baseQuestion.activeFlag, 'yes_no', '')}</span>
										</c:if>
									</td>
									<td data-hide="true">
										${fns:getUserById(baseQuestion.createBy.id).name}
									</td>
									<td data-hide="true">
										<fmt:formatDate value="${baseQuestion.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>
									<td data-hide="true">
										${fns:getUserById(baseQuestion.updateBy.id).name}
									</td>
									<td data-hide="true">
										<fmt:formatDate value="${baseQuestion.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>
									<td title="${baseQuestion.remarks}">
										${fns:abbr(baseQuestion.remarks,15)}
									</td>
									<td>
										<div class="btn-group zf-tableButton">
											<button type="button" class="btn btn-sm btn-info" onclick="window.location.href='${ctx}/spm/qa/baseQuestion/info?id=${baseQuestion.id}'">详情</button>
											<shiro:hasPermission name="spm:qa:baseQuestion:edit">
												<button type="button" class="btn btn-sm btn-info dropdown-toggle" data-toggle="dropdown">
													<span class="caret"></span>
												</button>
												<ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
													<c:choose>
														<c:when test="${baseQuestion.activeFlag eq 1 }">
															<!-- <li><a href="#this" onclick="update('${baseQuestion.id}')">停用</a></li> -->
															<li><a href="#this" data-href="${ctx}/spm/qa/baseQuestion/isstop" data-message="" data-json="{'id':'${baseQuestion.id }'}" onclick="ZF.xconfirm(this)">停用</a></li>
														</c:when>
														<c:otherwise>
															<li><a href="#this" data-href="${ctx}/spm/qa/baseQuestion/isstop" data-message="" data-json="{'id':'${baseQuestion.id }'}" onclick="ZF.xconfirm(this)">启用</a></li>
														</c:otherwise>
													</c:choose>
													<li><a href="#this" data-href="${ctx}/spm/qa/baseQuestion/delete" data-message="您确定要删除该记录么？" data-json="{'id':'${baseQuestion.id }'}" onclick="ZF.xconfirm(this)">删除</a></li>
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
	<script type="text/javascript">
		$(function () {
			ZF.bigImg();
			
			// 表格初始化
		 	ZF.parseTable("#contentTable",{
				"paging" : false,
				"lengthChange" : false,
				"searching" : false,
				"ordering" : false,
				"info" : false,
				"autoWidth" : false,
				"multiline":true,//是否开启多行表格
				"isRowSelect":true,//是否开启行选中
				"rowSelect":function(tr){productId = tr.attr("data-value");},
				"rowSelectCancel":function(tr){productId = null;}
			})
		});
	</script>
</body>
</html>