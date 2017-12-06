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
					<i class="fa fa-repeat"></i><a href="${ctx}/spm/qa/questionnaire/select">问卷列表</a>
				</small>
			</h1>
		</section>
		<section class="content">
			<form:form id="searchForm" modelAttribute="questionnaire" action="${ctx}/spm/qa/questionnaire/select" method="post" class="form-horizontal">
				<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
				<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
				<input id="pageKey" name="pageKey" type="hidden" value="${pageKey }"/>
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
									<label for="code" class="col-sm-3 control-label">问卷名称</label>
									<div class="col-sm-7">
										<form:input path="name" htmlEscape="false" maxlength="64" class="form-control" placeholder="请输入问卷名称进行查询"/>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-group">
									<label for="code" class="col-sm-3 control-label">问卷类别</label>
									<div class="col-sm-7">
										<form:select path="type" htmlEscape="false" maxlength="50" class="form-control select2">
											<form:option label="所有" value="" />
											<form:options items="${fns:getDictList('spm_qa_questionnaire_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
										</form:select>
									</div>
								</div>
							</div>
							<%-- <div class="col-md-4">
								<div class="form-group">
									<label for="code" class="col-sm-3 control-label">展现类型</label>
									<div class="col-sm-7">
										<form:select path="displayType" htmlEscape="false" maxlength="50" class="form-control select2">
											<form:option label="所有" value="" />
											<form:options items="${fns:getDictList('spm_qa_questionnaire_displayType')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
										</form:select>
									</div>
								</div>
							</div> --%>
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
									<th></th>
									<th>问卷名称</th>
									<th>问卷类别</th>
									<th>问卷标题</th>
									<th>问卷说明</th>
									<th>是否奖励积分</th>
									<th>奖励积分数量</th>
								</tr>
							</thead>
							<tbody id="tBodyId">
							<c:forEach items="${page.list}" var="questionnaire" varStatus="qstatus">
								<tr id="${questionnaire.id }" data-type="item">
									<td data-type="checkbox">
										<div class="zf-check-wrapper-padding">
											<input type="radio" name="chkItem" value="${questionnaire.id }" data-name="${questionnaire.name }"/>
										</div>	
									</td>
									<td>
										${questionnaire.name}
									</td>
									<td>
										${fns:getDictLabel(questionnaire.type, 'spm_qa_questionnaire_type', '')}
									</td>
									<td>
										${questionnaire.title}
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
			
			$('input').iCheck({
				checkboxClass : 'icheckbox_minimal-blue',
				radioClass : 'iradio_minimal-blue'
			});
			
			// 表格初始化
		 	ZF.parseTable("#contentTable",{
				"paging" : false,
				"lengthChange" : false,
				"searching" : false,
				"order": [[ 6, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
				"columnDefs":[
					{"orderable":false,targets:0},
					{"orderable":false,targets:2},
					{"orderable":false,targets:3},
					{"orderable":false,targets:4},
					{"orderable":false,targets:5},
					{"orderable":false,targets:1}
	            ],
				"ordering" : true,
				"info" : false,
				"autoWidth" : false,
				"multiline":true,//是否开启多行表格
				"isRowSelect":true,//是否开启行选中
				"rowSelect":function(tr){productId = tr.attr("data-value");},
				"rowSelectCancel":function(tr){productId = null;}
			})
			
			var checkTable=new ZF.CheckTable("${pageKey}");
		});
		
	</script>			
</body>
</html>