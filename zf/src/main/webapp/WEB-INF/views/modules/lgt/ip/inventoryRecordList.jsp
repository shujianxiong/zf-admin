<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>时尚导师表管理</title>
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
		<li class="active"><a href="${ctx}/idx/mt/mentor/">时尚导师表列表</a></li>
		<shiro:hasPermission name="idx:mt:mentor:edit"><li><a href="${ctx}/idx/mt/mentor/form">时尚导师表添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="mentor" action="${ctx}/idx/mt/mentor/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>姓名：</label>
				<form:input path="name" htmlEscape="false" maxlength="50" class="input-medium"/>
			</li>
			<li><label>性别：</label>
				<form:radiobuttons path="sex" items="${fns:getDictList('sex')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
			</li>
			<li><label>国籍：</label>
				<form:input path="country" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>标签（|分割）：</label>
				<form:input path="tags" htmlEscape="false" maxlength="50" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-hover table-bordered table-condensed">
		<thead>
			<tr>
				<th>姓名</th>
				<th>性别</th>
				<th>国籍</th>
				<th>首页展示图</th>
				<th>头像</th>
				<th>标签（|分割）</th>
				<th>列表简介</th>
				<th>更新者</th>
				<th>更新时间</th>
				<th>备注信息</th>
				<shiro:hasPermission name="idx:mt:mentor:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="mentor">
			<tr>
				<td><a href="${ctx}/idx/mt/mentor/form?id=${mentor.id}">
					${mentor.name}
				</a></td>
				<td>
					${fns:getDictLabel(mentor.sex, 'sex', '')}
				</td>
				<td>
					${mentor.country}
				</td>
				<td>
					${mentor.indexPhoto}
				</td>
				<td>
					${mentor.gravatar}
				</td>
				<td>
					${mentor.tags}
				</td>
				<td>
					${mentor.listSummary}
				</td>
				<td>
					${mentor.updateBy.id}
				</td>
				<td>
					<fmt:formatDate value="${mentor.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${mentor.remarks}
				</td>
				<shiro:hasPermission name="idx:mt:mentor:edit"><td>
    				<a href="${ctx}/idx/mt/mentor/form?id=${mentor.id}">修改</a>
					<a href="${ctx}/idx/mt/mentor/delete?id=${mentor.id}" onclick="return ZF.delRow('确认要删除该盘点记录吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>