<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>答案管理</title>
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
				<small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/spm/qa/respondentsAns/list">用户答题记录列表</a></small>
		      </h1>
		</section>
		<section class="content">
			<form:form id="searchForm" modelAttribute="respondentsAns" action="${ctx}/spm/qa/respondentsAns/" method="post" class="breadcrumb form-search">
				<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
				<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
				<div class="">
					
				</div>
				
				<ul class="ul-form">
					<li><label title="问卷名称/问题名称">名称：</label>
						<form:input path="questionnaireQue.questionnaire.name" htmlEscape="false" maxlength="64" class="input-medium"/>
					</li>
					<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
					<li class="clearfix"></li>
				</ul>
			</form:form>
		</section>
		
	</div>

	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/spm/qa/respondentsAns/">答案列表</a></li>
		<%-- <shiro:hasPermission name="spm:qa:respondentsAns:edit"><li><a href="${ctx}/spm/qa/respondentsAns/form">答案添加</a></li></shiro:hasPermission> --%>
	</ul>
	<form:form id="searchForm" modelAttribute="respondentsAns" action="${ctx}/spm/qa/respondentsAns/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label title="问卷名称/问题名称">名称：</label>
				<form:input path="questionnaireQue.questionnaire.name" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-hover table-bordered table-condensed">
		<thead>
			<tr>
				<th>问卷名称</th>
				<th>问题名称</th>
				<th>选择答案</th>
				<th>填写答案</th>
				<th>更新时间</th>
				<th>备注信息</th>
				<%-- <shiro:hasPermission name="spm:qa:respondentsAns:edit"><th>操作</th></shiro:hasPermission> --%>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="respondentsAns">
			<tr>
				<td><a href="${ctx}/spm/qa/respondentsAns/form?id=${respondentsAns.id}">
					${respondentsAns.questionnaireQue.questionnaire.name}
				</a></td>
				<th>
					${respondentsAns.questionnaireQue.baseQuestion.name}
				</th>
				<td>
					${respondentsAns.baseAnswer.name}
				</td>
				<td>
					${respondentsAns.answerText}
				</td>
				<td>
					<fmt:formatDate value="${respondentsAns.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td title="${respondentsAns.remarks}">
					${fns:abbr(respondentsAns.remarks,15)}
				</td>
				<%-- <shiro:hasPermission name="spm:qa:respondentsAns:edit"><td>
    				<a href="${ctx}/spm/qa/respondentsAns/form?id=${respondentsAns.id}">修改</a>
					<a href="${ctx}/spm/qa/respondentsAns/delete?id=${respondentsAns.id}" onclick="return confirmx('确认要删除该答案吗？', this.href)">删除</a>
				</td></shiro:hasPermission> --%>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>