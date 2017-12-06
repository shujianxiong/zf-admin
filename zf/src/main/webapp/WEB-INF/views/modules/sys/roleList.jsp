<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>角色管理</title>
	<meta name="decorator" content="adminLte"/>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
		<section class="content-header content-header-menu">
	      <h1>
	        <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/sys/role/">角色列表</a></small>
	        <shiro:hasPermission name="sys:role:edit"><small>|</small>
			<small><i class="fa-form-edit"></i><a href="${ctx}/sys/role/form">角色新增</a></small></shiro:hasPermission>
	      </h1>
	    </section>
	    <sys:tip content="${message}"/>
	    <section class="content">
	    	<div class="box box-soild">
	    		<div class="box-body">
	    			<table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
						<thead>
							<tr>
								<th>角色名称</th>
								<th>英文名称</th>
								<th>归属机构</th>
								<th>是否可用</th>
								<shiro:hasPermission name="sys:role:edit">
								<th>操作</th>
								</shiro:hasPermission>
							</tr>
						</thead>
						<tbody>
						<c:forEach items="${list}" var="role">
							<tr>
								<td>${role.name}</td>
								<td>${role.enname}</td>
								<td>${role.office.id}</td>
								<td>
								    <c:choose>
								        <c:when test="${role.useable eq '0' }">
								            <span class="label label-primary">${fns:getDictLabel(role.useable, 'yes_no', '') }</span>
								        </c:when>
								        <c:when test="${role.useable eq '1' }">
                                            <span class="label label-success">${fns:getDictLabel(role.useable, 'yes_no', '') }</span>
                                        </c:when>
								    </c:choose>
								</td>
								<td>
					                <shiro:hasPermission name="sys:role:edit">	
					              	<div class="btn-group zf-tableButton">
				                  		<%-- <button type="button" class="btn btn-xs btn-info" onclick="window.location.href='${ctx}/sys/role/assign?id=${role.id}'">分配</button> --%>
				                  		<button type="button" class="btn btn-xs btn-info" onclick="window.location.href='${ctx}/sys/role/info?id=${role.id}'">详情</button>
					                  	<button type="button" class="btn btn-xs btn-info dropdown-toggle" data-toggle="dropdown">
					                    	<span class="caret"></span>
					                  	</button>
					                  	<ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
					                  		<c:if test="${(role.sysData eq fns:getDictValue('是', 'yes_no', '1') && fns:getUser().admin)||!(role.sysData eq fns:getDictValue('是', 'yes_no', '1'))}">
												<li><a href="${ctx}/sys/role/form?id=${role.id}">修改</a></li>
											</c:if>
											<li><a href="${ctx }/sys/role/updateUseable?id=${role.id}">${role.useable eq '0' ? '启用':'禁用' }</a></li>
											<li><a  href="${ctx}/sys/role/delete?id=${role.id}" onclick="return ZF.delRow('确认要删除该角色吗？', this.href)">删除</a></li>
											<%-- <li><a href="${ctx}/sys/role/info?id=${role.id}">详情</a></li> --%>
					                  	</ul>
					                </div>
					              	</shiro:hasPermission>
								</td>
							</tr>
						</c:forEach>
						</tbody>
					</table>
	    		</div>
	    	</div>
	    </section>
	</div>
	<script>
	  $(function () {
		 //表格初始化
		ZF.parseTable("#contentTable", {
			"paging" : false,
			"lengthChange" : false,
			"searching" : false,
			"ordering" : false,
			"info" : false,
			"autoWidth" : false,
			"multiline" : true,//是否开启多行表格
			"isRowSelect" : false//是否开启行选中
		})
	  	
	  });
</script>
</body>
</html>