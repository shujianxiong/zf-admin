<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>员工消息中心管理</title>
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
		<li class="active"><a href="${ctx}/msg/um/umMessage/">员工消息中心列表</a></li>
		<shiro:hasPermission name="msg:um:umMessage:edit"><li><a href="${ctx}/msg/um/umMessage/form">员工消息中心添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="umMessage" action="${ctx}/msg/um/umMessage/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>标题：</label>
				<form:input path="title" htmlEscape="false" maxlength="50" class="input-medium" title="支持标题和内容查询"/>
			</li>
			<li><label>消息状态：</label>
				<form:select path="status" class="input-medium">
					<form:option value="" label="所有"/>
					<form:options items="${fns:getDictList('msg_um_message_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-hover table-bordered table-condensed">
		<thead>
			<tr>
				<th>消息类别</th>
				<th>消息类型</th>
				<th>发送用户</th>
				<th>标题</th>
				<th>内容</th>
				<th>接收用户</th>
				<th>消息状态</th>
				<th>推送时间</th>
				<th>查看时间</th>
				<th>备注信息</th>
				<shiro:hasPermission name="msg:um:umMessage:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="umMessage">
			<tr>
				<td><a href="${ctx}/msg/um/umMessage/form?id=${umMessage.id}">
					${fns:getDictLabel(umMessage.category, 'msg_um_message_category', '')}
				</a></td>
				<td>
					${fns:getDictLabel(umMessage.type, 'msg_um_message_type', '')}
				</td>
				<td>
					${fns:getUserById(umMessage.sendUser.id).name}
				</td>
				<td>
					${umMessage.title}
				</td>
				<td title="${umMessage.content}">
					${fns:abbr(umMessage.content,32)}
				</td>
				<td>
					${fns:getUserById(umMessage.receiveUser.id).name}
				</td>
				<td>
					${fns:getDictLabel(umMessage.status, 'msg_um_message_status', '')}
				</td>
				<td>
					<fmt:formatDate value="${umMessage.pushTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					<fmt:formatDate value="${umMessage.viewTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td title="${umMessage.remarks}">
					${fns:abbr(umMessage.remarks,15)}
				</td>
				<shiro:hasPermission name="msg:um:umMessage:edit"><td>
    				<a href="${ctx}/msg/um/umMessage/form?id=${umMessage.id}">查看</a>
					<a href="${ctx}/msg/um/umMessage/delete?id=${umMessage.id}" onclick="return confirmx('确认要删除该员工消息中心吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>