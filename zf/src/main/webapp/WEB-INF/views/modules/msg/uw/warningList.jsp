<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>员工报警中心管理</title>
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
		<li class="active"><a href="${ctx}/msg/uw/warning/">员工报警中心列表</a></li>
		<shiro:hasPermission name="msg:uw:warning:edit"><li><a href="${ctx}/msg/uw/warning/form">员工报警中心添加</a></li></shiro:hasPermission> 
	</ul>
	<form:form id="searchForm" modelAttribute="warning" action="${ctx}/msg/uw/warning/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>警报类型：</label>
				<form:select path="type" class="input-medium">
					<form:option value="" label="所有"/>
					<form:options items="${fns:getDictList('msg_uw_warning_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>发送用户：</label>
				<sys:treeselect id="sendUser" name="sendUser.id" value="${warning.sendUser.id}" labelName="" labelValue="${fns:getUserById(warning.sendUser.id).name}"
					title="用户" url="/sys/office/treeData?type=3" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
			</li>
			<li><label>标题：</label>
				<form:input path="title" htmlEscape="false" maxlength="50" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-hover table-bordered table-condensed">
		<thead>
			<tr>
				<th>警报类别</th>
				<th>警报类型</th>
				<th>发送用户</th>
				<th>标题</th>
				<th>内容</th>
				<th>接收用户</th>
				<th>处理用户</th>
				<th>警报状态</th>
				<th>推送时间</th>
				<th>查看时间</th>
				<th>处理开始时间</th>
				<th>处理完成时间</th>
				<th>处理结果类型</th>
				<th>处理结果备注</th>
				<th>更新时间</th>
				<th>备注信息</th>
<%-- 				<shiro:hasPermission name="msg:uw:warning:edit"><th>操作</th></shiro:hasPermission> --%>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="warning">
			<tr>
				<td><a href="${ctx}/msg/uw/warning/info?id=${warning.id}">
					${fns:getDictLabel(warning.category, 'msg_uw_warning_category', '')}
				</a></td>
				<td>
					${fns:getDictLabel(warning.type, 'msg_uw_warning_type', '')}
				</td>
				<td>
					${fns:getUserById(warning.sendUser.id).name}
				</td>
				<td>
					${warning.title}
				</td>
				<td title="${warning.content} ">
					${fns:abbr(warning.content,16)}
				</td>
				<td>
					${fns:getUserById(warning.receiveUser.id).name}
				</td>
				<td>
					${fns:getUserById(warning.dealUser.id).name}
				</td>
				<td>
					${fns:getDictLabel(warning.status, 'msg_uw_warning_status', '')}
				</td>
				<td>
					<fmt:formatDate value="${warning.pushTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					<fmt:formatDate value="${warning.viewTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					<fmt:formatDate value="${warning.dealStartTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					<fmt:formatDate value="${warning.dealEndTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${fns:getDictLabel(warning.dealResultType, 'msg_uw_warning_deal_result_type', '')}
				</td>
				<td>
					${warning.dealResultRemarks}
				</td>
				<td>
					<fmt:formatDate value="${warning.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td title="${warning.remarks}">
					${fns:abbr(warning.remarks,15)}
				</td>
<%-- 				<shiro:hasPermission name="msg:uw:warning:edit"><td> --%>
<%--     				<a href="${ctx}/msg/uw/warning/info?id=${warning.id}">查看</a> --%>
    				
<%--     				<c:if test="${warning.dealResultType != '1' }"> --%>
<%--     					<a href="${ctx}/msg/uw/warning/form?id=${warning.id}">处理</a> --%>
<%--     				</c:if> --%>
<%-- 				</td></shiro:hasPermission> --%>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>