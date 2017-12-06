<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>个人微店店主管理</title>
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
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
		
		function updateStatus(url,id,messsage,keeperStatus){
			if(confirm(messsage)){
				$("#mystoreKeeperId").val(id);
				$("#keeperStatus").val(keeperStatus);
				$("#searchForm").attr("action",url);
				$("#searchForm").submit();
			}
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/msm/mk/mystoreKeeper/">个人微店店主列表</a></li>
<%-- 		<shiro:hasPermission name="msm:mk:mystoreKeeper:edit"><li><a href="${ctx}/msm/mk/mystoreKeeper/form">个人微店店主添加</a></li></shiro:hasPermission> --%>
	</ul>
	<form:form id="searchForm" modelAttribute="mystoreKeeper" action="${ctx}/msm/mk/mystoreKeeper/" method="post" class="breadcrumb form-search">
		<input type="hidden" id="mystoreKeeperId" name="id"/>
		<input type="hidden" id="keeperStatus" name="keeperStatus"/>
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">

			<li><label>微店店主：</label>
				<form:input path="name" htmlEscape="false" maxlength="50" class="input-medium"/>
				<a id="hint1" href="#" rel="tooltip" title="请输入店主编号或姓名或联系电话进行查询"><span class="icon-info-sign"><font color="green"></font></span></a>
			</li>
			
			<li><label>店主状态：</label>
				<form:select path="status" class="input-medium">
					<form:option value="" label="所有"/>
					<form:options items="${fns:getDictList('msm_mk_mystore_keeper_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
				<a id="hint2" href="#" rel="tooltip" title="请选择店主状态进行查询"><span class="icon-info-sign"><font color="green"></font></span></a>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-hover table-bordered table-condensed">
		<thead>
			<tr>
				<th>店主编号</th>
				<th>店主状态</th>
				<th>对应会员</th>
				<th>微店访问</th>
				<th>真实姓名</th>
				<th>性别</th>
				<th>年龄</th>
				<th>身份证号</th>
				<th>联系电话</th>
				<th>备用联系电话</th>
				<th>家庭住址编号</th>
				<th>家庭住址详情</th>
				<shiro:hasPermission name="msm:mk:mystoreKeeper:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="mystoreKeeper">
			<tr>
				<td><a href="${ctx}/msm/mk/mystoreKeeper/form?id=${mystoreKeeper.id}">
					${mystoreKeeper.keeperNo}
				</a></td>
				<td>
					${fns:getDictLabel(mystoreKeeper.status, 'msm_mk_mystore_keeper_status', '')}
				</td>
				<td>
					${mystoreKeeper.member.id}
				</td>
				<td>
					${mystoreKeeper.mystoreUrl}
				</td>
				<td>
					${mystoreKeeper.name}
				</td>
				<td>
					${fns:getDictLabel(mystoreKeeper.sex, 'sex', '')}
				</td>
				<td>
					${mystoreKeeper.age}
				</td>
				<td>
					${mystoreKeeper.idCard}
				</td>
				<td>
					${mystoreKeeper.tel}
				</td>
				<td>
					${mystoreKeeper.reserveTel}
				</td>
				<td>
					${fns:getAreaById(mystoreKeeper.addressArea.id).name}
				</td>
				<td>
					${mystoreKeeper.addressAreaDetail}
				</td>
				<shiro:hasPermission name="msm:mk:mystoreKeeper:edit"><td>
					<c:choose>
						<c:when test="${mystoreKeeper.status == 2}">
							<a href="#this" onclick="updateStatus('${ctx}/msm/mk/mystoreKeeper/updateStatus','${mystoreKeeper.id}','确定要修改为冻结吗？','3')">冻结</a>
    						<a href="#this" onclick="updateStatus('${ctx}/msm/mk/mystoreKeeper/updateStatus','${mystoreKeeper.id}','确定要修改为停用吗？','4')">停用</a>
						</c:when>
						<c:when test="${mystoreKeeper.status == 3}">
    						<a href="#this" onclick="updateStatus('${ctx}/msm/mk/mystoreKeeper/updateStatus','${mystoreKeeper.id}','确定要修改为正常吗？','2')">正常</a>
    						<a href="#this" onclick="updateStatus('${ctx}/msm/mk/mystoreKeeper/updateStatus','${mystoreKeeper.id}','确定要修改为停用吗？','4')">停用</a>
						</c:when>
						<c:when test="${mystoreKeeper.status == 4}">
    						<a href="#this" onclick="updateStatus('${ctx}/msm/mk/mystoreKeeper/updateStatus','${mystoreKeeper.id}','确定要修改为正常吗？','2')">正常</a>
    						<a href="#this" onclick="updateStatus('${ctx}/msm/mk/mystoreKeeper/updateStatus','${mystoreKeeper.id}','确定要修改为冻结吗？','3')">冻结</a>
						</c:when>
						<c:otherwise>
							<b>待审核</b>
						</c:otherwise>
					</c:choose>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>