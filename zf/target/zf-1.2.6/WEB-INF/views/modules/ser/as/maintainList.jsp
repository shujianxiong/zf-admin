<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>售后维修工单管理</title>
	<meta name="decorator" content="default"/>
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
			$('#hint4').tooltip();
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
		//清空查询条件
		function clearQueryParam(){
			$("#workorderNo").val("");
			$("#maintainUserIdName").val("");
			$("#s2id_maintainStatus").select2("val","");
			$("#s2id_maintainType").select2("val","");
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/ser/as/maintain/">售后维修工单列表</a></li>
		<shiro:hasPermission name="ser:as:maintain:edit"><li><a href="${ctx}/ser/as/maintain/form">售后维修工单添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="maintain" action="${ctx}/ser/as/maintain/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>工单编号：</label>
				<form:input id="workorderNo" path="workorder.workorderNo" htmlEscape="false" maxlength="64" class="input-medium"/>
				<a id="hint1" href="#" rel="tooltip" title="请输入工单编号进行查询"><span class="icon-info-sign"><font color="green"></font></span></a>
			</li>
			<li><label>维护状态：</label>
				<form:select path="maintainStatus" class="input-xlarge ">
					<form:option value="" label="所有"/>
					<form:options items="${fns:getDictList('ser_as_maintain_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
				<a id="hint2" href="#" rel="tooltip" title="请选择维护状态进行查询"><span class="icon-info-sign"><font color="green"></font></span></a>
			</li>
			<li><label>维护人：</label>
				<sys:treeselect id="maintainUserId" name="maintainUser.id" value="${maintain.maintainUser.id}" labelName="maintainUser.name" labelValue="${maintain.maintainUser.name}"
					title="用户" url="/sys/office/treeData?type=3" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
					<a id="hint3" href="#" rel="tooltip" title="请选择维护人进行查询"><span class="icon-info-sign"><font color="green"></font></span></a>
			</li>
			<li><label>维护类型：</label>
				<form:select path="maintainType" class="input-xlarge">
					<form:option value="" label="所有"/>
					<form:options items="${fns:getDictList('ser_as_maintain_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
				<a id="hint4" href="#" rel="tooltip" title="请选择维护类型进行查询"><span class="icon-info-sign"><font color="green"></font></span></a>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="btns"><input id="btnRest" class="btn btn-primary" type="button" value="清除"  onclick="clearQueryParam()"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-hover table-bordered table-condensed">
		<thead>
			<tr>
				<th>工单编号</th>
				<th>维护状态</th>
				<th>维护人</th>
				<th>派单时间</th>
				<th>完成时间</th>
				<th>维护类型</th>
				<th>维护结果</th>
				<th>更新时间</th>
				<th>备注信息</th>
				<shiro:hasPermission name="ser:as:maintain:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="maintain">
			<tr>
				<td><a href="${ctx}/ser/as/maintain/form?id=${maintain.id}">
					${maintain.workorder.workorderNo}
				</a></td>
				<td>
					${fns:getDictLabel(maintain.maintainStatus, 'ser_as_maintain_status', '')}
				</td>
				<td>
					${maintain.maintainUser.name}
				</td>
				<td>
					<fmt:formatDate value="${maintain.startTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					<fmt:formatDate value="${maintain.finishTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${fns:getDictLabel(maintain.maintainType, 'ser_as_maintain_type', '')}
				</td>
				<td>
					${fns:getDictLabel(maintain.result, 'ser_as_maintain_result', '')}
				</td>
				<td>
					<fmt:formatDate value="${maintain.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td title="${maintain.remarks}">
					${fns:abbr(maintain.remarks,15)}
				</td>
				<shiro:hasPermission name="ser:as:maintain:edit"><td>
    				<a href="${ctx}/ser/as/maintain/form?id=${maintain.id}">修改</a>
					<a href="${ctx}/ser/as/maintain/delete?id=${maintain.id}" onclick="return confirmx('确认要删除该售后维修工单吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>