<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>问卷问题管理</title>
	<meta name="decorator" content="default"/>
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
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/spm/qa/questionnaireQue/">问卷问题列表</a></li>
		<shiro:hasPermission name="spm:qa:questionnaireQue:edit"><li><a href="${ctx}/spm/qa/questionnaireQue/form">问卷问题添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="questionnaireQue" action="${ctx}/spm/qa/questionnaireQue/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>问卷ID：</label>
				<form:input path="questionnaireId" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>问题项ID：</label>
				<form:input path="baseQuestionId" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-hover table-bordered table-condensed">
		<thead>
			<tr>
				<th>问卷ID</th>
				<th>问题项ID</th>
				<th>更新时间</th>
				<th>备注信息</th>
				<shiro:hasPermission name="spm:qa:questionnaireQue:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="questionnaireQue">
			<tr>
				<td><a href="${ctx}/spm/qa/questionnaireQue/form?id=${questionnaireQue.id}">
					${questionnaireQue.questionnaireId}
				</a></td>
				<td>
					${questionnaireQue.baseQuestionId}
				</td>
				<td>
					<fmt:formatDate value="${questionnaireQue.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td title="${questionnaireQue.remarks}">
					${fns:abbr(questionnaireQue.remarks,15)}
				</td>
				<shiro:hasPermission name="spm:qa:questionnaireQue:edit"><td>
    				<a href="${ctx}/spm/qa/questionnaireQue/form?id=${questionnaireQue.id}">修改</a>
					<a href="${ctx}/spm/qa/questionnaireQue/delete?id=${questionnaireQue.id}" onclick="return confirmx('确认要删除该问卷问题吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>