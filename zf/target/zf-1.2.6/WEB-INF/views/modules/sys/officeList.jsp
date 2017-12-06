<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>机构管理</title>
	<meta name="decorator" content="adminLte"/>
	<%@include file="/WEB-INF/views/include/treetable.jsp" %>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#contentTable").treeTable({expandLevel : 3});
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false; 
        }
		
		function removeOffice(url,id){
			confirm("要删除该机构及所有子机构项吗？","warning",function(){
				window.location.href=url+"?id="+id;
			});
		}
	</script>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
		<section class="content-header content-header-menu">
	      <h1>
	        <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/sys/office/list">机构列表</a></small>
	        
	        <%-- <shiro:hasPermission name="sys:office:edit"><small>|</small><small><i class="fa-form-edit"></i><a href="${ctx}/sys/office/form?parent.id=${office.id}">机构${not empty office.id?'修改':'添加'}</a></small></shiro:hasPermission> --%>
	      </h1>
	    </section>
	    <sys:tip content="${message}"/>
	    <section class="content">
	    	<div class="box box-soild">
	    		<div class="box-body">
	    			<div class="table-responsive">
	    				<table id="contentTable" class="table table-hover table-bordered table-condensed zf-tbody-font-size">
							<thead>
								<tr>
									<th>机构名称</th>
									<th>归属区域</th>
									<th>机构编码</th>
									<th>机构类型</th>
									<th>是否启用</th>
									<th>备注</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach items="${list}" var="office">
								<tr id="${office.id}" pId="${office.parent.id}">
									<td nowrap>
										${office.name}
									</td>
									<td>
										${office.area.name}
									</td>
									<td>
										${office.code}
									</td>
									<td>
										${fns:getDictLabel(office.type, 'sys_office_type', '无')}
									</td>
									<td>
										<c:choose>
											<c:when test="${office.useable eq '1'}">
												<span class="label label-success">${fns:getDictLabel(office.useable, 'yes_no', '')}</span>
											</c:when>
											<c:when test="${office.useable eq '0'}">
												<span class="label label-primary">${fns:getDictLabel(office.useable, 'yes_no', '')}</span>
											</c:when>
										</c:choose>
									</td>
									<td>
										${office.remarks }
									</td>
									<td>
										<shiro:hasPermission name="sys:office:edit">
											<div class="btn-group zf-tableButton">
							                  <button type="button" class="btn btn-xs btn-info" onclick="window.location.href='${ctx}/sys/office/form?id=${office.id}'">修改</button>
							                  <button type="button" class="btn btn-xs btn-info dropdown-toggle" data-toggle="dropdown">
							                    <span class="caret"></span>
							                 </button>
							                  <ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
							                    <c:if test="${office.id ne '1' }"><!-- 顶级根目录不允许删除 -->
								                    <li><a href="#this" onclick="return removeOffice('${ctx}/sys/office/delete','${office.id}')" style="color:#fff">删除</a></li>
							                    </c:if>
							                    <li><a href="${ctx}/sys/office/form?parent.id=${office.id}">添加下级机构</a></li>
							                    <li><a href="${ctx}/sys/office/info?id=${office.id}">详情</a></li>
							                    <li>
							                    	<c:if test="${office.useable == 1}">
							                    		<a href="${ctx}/sys/office/changeFlag?id=${office.id}&useable=0" style="color:#fff" onclick="return changeFlag('确认要停用该机构吗？',this.href)">
							                    		停用
							                        	</a>
							                    	</c:if>
							                    	<c:if test="${office.useable == 0}">
							                    		<a href="${ctx}/sys/office/changeFlag?id=${office.id}&useable=1" style="color:#fff" onclick="return changeFlag('确认要启用该机构吗？',this.href)">
							                    		启用
							                        	</a>
							                    	</c:if>
							                    </li>
							                  </ul>
							                </div>
										</shiro:hasPermission>
										<shiro:lacksPermission name="sys:office:edit">
											<div class="btn-group zf-tableButton">
								                <button type="button" class="btn btn-xs btn-info" onclick="window.location.href='${ctx}/sys/office/info?id=${office.id}'">详情</button>
								                  	<button type="button" class="btn btn-xs btn-info dropdown-toggle" data-toggle="dropdown">
								                    	<span class="caret"></span>
								                </button>
							                </div>
										</shiro:lacksPermission>
									</td>
								</tr>
							</c:forEach>
							</tbody>
						</table>
	    			</div>
	    		</div>
	    		<div class="box-footer">
	        		<div class="dataTables_paginate paging_simple_numbers">${page}</div>
	        	</div>
	    	</div>
	    </section>
	</div>
	<script type="text/javascript">
	function changeFlag(message,href){
		confirm(message,"info",function(){
			window.location.href=href;
		});
		return false;
	}
	</script>
</body>
</html>