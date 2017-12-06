<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>问题答案管理</title>
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
		<li class="active"><a href="${ctx}/spm/qa/baseAnswer/">问题答案列表</a></li>
		<shiro:hasPermission name="spm:qa:baseAnswer:edit"><li><a href="${ctx}/spm/qa/baseAnswer/form">问题答案添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="baseAnswer" action="${ctx}/spm/qa/baseAnswer/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>答案名称：</label>
				<form:input path="name" htmlEscape="false" maxlength="200" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-hover table-bordered table-condensed">
		<thead>
			<tr>
				<th>答案名称</th>
				<th>更新时间</th>
				<th>备注信息</th>
				<shiro:hasPermission name="spm:qa:baseAnswer:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="baseAnswer">
			<tr>
				<td><a href="${ctx}/spm/qa/baseAnswer/form?id=${baseAnswer.id}">
					${baseAnswer.name}
				</a></td>
				<td>
					<fmt:formatDate value="${baseAnswer.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td title="${baseAnswer.remarks}">
					${fns:abbr(baseAnswer.remarks,15)}
				</td>
				<shiro:hasPermission name="spm:qa:baseAnswer:edit"><td>
    				<a href="${ctx}/spm/qa/baseAnswer/form?id=${baseAnswer.id}">修改</a>
					<a href="${ctx}/spm/qa/baseAnswer/delete?id=${baseAnswer.id}" onclick="return confirmx('确认要删除该问题答案吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>