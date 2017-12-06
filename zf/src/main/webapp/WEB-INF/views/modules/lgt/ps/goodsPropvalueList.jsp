<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>商品属性值管理</title>
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
<  /head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/lgt/ps/goodsPropvalue/">商品属性值列表</a></li>
		<shiro:hasPermission name="lgt:ps:lgtPsGoodsPropvalue:edit"><li><a href="${ctx}/lgt/ps/goodsPropvalue/form">商品属性值添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="goodsPropvalue" action="${ctx}/lgt/ps/goodsPropvalue/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-hover table-bordered table-condensed">
		<thead>
			<tr>
				<th>更新时间</th>
				<th>备注信息</th>
				<shiro:hasPermission name="lgt:ps:lgtPsGoodsPropvalue:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="goodsPropvalue">
			<tr>
				<td><a href="${ctx}/lgt/ps/goodsPropvalue/form?id=${goodsPropvalue.id}">
					<fmt:formatDate value="${goodsPropvalue.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</a></td>
				<td title="${goodsPropvalue.remarks}">
					${fns:abbr(goodsPropvalue.remarks,15)}
				</td>
				<shiro:hasPermission name="lgt:ps:lgtPsGoodsPropvalue:edit"><td>
    				<a href="${ctx}/lgt/ps/goodsPropvalue/form?id=${goodsPropvalue.id}">修改</a>
					<a href="${ctx}/lgt/ps/goodsPropvalue/delete?id=${goodsPropvalue.id}" onclick="return confirmx('确认要删除该商品属性值吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>