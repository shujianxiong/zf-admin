<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>个人微店申请管理</title>
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
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
		
		function audit(url,id){
			$("#mystoreApplyId").val(id);
			$("#searchForm").attr("action",url);
			$("#searchForm").submit();
		}
		//清空查询条件
		function clearQueryParam(){
			$("#beginApplyTime").val("");
			$("#endApplyTime").val("");
			$("#beginCheckTime").val("");
			$("#endCheckTime").val("");
			$("#s2id_status").select2("val","");
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/msm/mk/mystoreApply/">个人微店申请列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="mystoreApply" action="${ctx}/msm/mk/mystoreApply/" method="post" class="breadcrumb form-search">
		<input type="hidden" id="mystoreApplyId" name="id" />
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>申请状态：</label>
				<form:select path="status" class="input-medium">
					<form:option value="" label="所有"/>
					<form:options items="${fns:getDictList('msm_mk_mystore_apply_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
				<a id="hint1" href="#" rel="tooltip" title="请选择申请状态进行查询"><span class="icon-info-sign"><font color="green"></font></span></a>
			</li>
			<li><label>申请时间：</label>
				<input id="beginApplyTime" name="beginApplyTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${mystoreApply.beginApplyTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/> - 
				<input id="endApplyTime" name="endApplyTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${mystoreApply.endApplyTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
				<a id="hint2" href="#" rel="tooltip" title="请选择申请开始时间和结束时间进行查询"><span class="icon-info-sign"><font color="green"></font></span></a>
			</li>
			<li><label>审批时间：</label>
				<input id="beginCheckTime" name="beginCheckTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${mystoreApply.beginCheckTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/> - 
				<input id="endCheckTime" name="endCheckTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${mystoreApply.endCheckTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
				<a id="hint3" href="#" rel="tooltip" title="请选择审批开始时间和结束时间进行查询"><span class="icon-info-sign"><font color="green"></font></span></a>
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
				<th>申请会员账号</th>
				<th>申请状态</th>
				<th>申请时间</th>
				<th>相关图片</th>
				<th>审批员工</th>
				<th>审批时间</th>
				<th>审批备注</th>
				<shiro:hasPermission name="msm:mk:mystoreApply:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="mystoreApply">
			<tr>
				<td><a href="${ctx}/msm/mk/mystoreApply/info?id=${mystoreApply.id}">
					${mystoreApply.applyMember.usercode}
				</a></td>
				<td>
					${fns:getDictLabel(mystoreApply.status, 'msm_mk_mystore_apply_status', '')}
				</td>
				<td>
					<fmt:formatDate value="${mystoreApply.applyTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					<img onerror="imgOnerror(this);"  src="${fn:replace(mystoreApply.photoUrl, '|', '')}" data-src="${mystoreApply.photoUrl}" width="50px" height="50px" />
				</td>
				<td>
					${fns:getUserById(mystoreApply.checkUser.id).name} 
				</td>
				<td>
					<fmt:formatDate value="${mystoreApply.checkTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${mystoreApply.checkRemarks}
				</td>
				<shiro:hasPermission name="msm:mk:mystoreApply:edit"><td>
    				<c:choose>
    					<c:when test="${mystoreApply.status == 1 }">
    						<a href="#this" onclick="audit('${ctx}/msm/mk/mystoreApply/form','${mystoreApply.id}')">审核</a>
    					</c:when>
    					<c:otherwise>
    						已审核
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