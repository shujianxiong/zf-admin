<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>商品分类管理</title>
	<meta name="decorator" content="adminLte"/>
	<%@include file="/WEB-INF/views/include/treetable.jsp" %>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#contentTable").treeTable({expandLevel : 3});
			ZF.bigImg();
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false; 
        }
		
		function removeCategory(url,id){
			confirm("如果该分类下存在子分类,将都会删除。<br/>确认要删除该商品分类吗？","warning",function(){
				window.location.href=url+"?id="+id;
			});
		}
	</script>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
		<section class="content-header content-header-menu">
	      <h1>
	        <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/lgt/ps/category/list">分类列表</a></small>
	        
	        <shiro:hasPermission name="lgt:ps:lgtPsCategory:edit"><small>|</small><small><i class="fa-form-edit"></i><a href="${ctx}/lgt/ps/category/form">分类${not empty category.id?'修改':'添加'}</a></small></shiro:hasPermission>
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
									<th>分类名称</th>
									<th>分类标记</th>
									<th>分类图标</th>
									<th>使用范围</th>
									<th class="sort-column orderNo" style="text-align:center;">排序序号</th>
									<th>创建人</th>
									<th>创建时间</th>
									<th>更新人</th>
									<th>更新时间</th>
									<th>备注信息</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach items="${list}" var="category">
								<tr id="${category.id}" pId="${not empty category.parent.id ?category.parent.id:'0'}">
									
									<td nowrap>
										<%-- <a href="${ctx}/lgt/ps/category/view?id=${category.id}"> --%>
										${category.categoryName}
										<!-- </a> -->
									</td>
									<td style="text-align:center;">
										${category.categoryTag}
									</td>
									<td>
										<img onerror="imgOnerror(this);" src="${imgHost }${category.categoryIcon}" data-big data-src="${imgHost }${category.categoryIcon}" width="20px" height="20px" />
									</td>
									<td><span class="label label-primary">${fns:getDictLabel(category.useRange,'useRange', '') }</span></td>
									<td class="zf-table-money">
										${category.orderNo}
									</td>
									<td>
										${fns:getUserById(category.createBy.id).name}
									</td>
									<td>
										<fmt:formatDate value="${category.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>
									<td>
										${fns:getUserById(category.updateBy.id).name}
									</td>
									<td>
										<fmt:formatDate value="${category.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>
									<td nowrap title="${category.remarks}">
										${fns:abbr(category.remarks,15)}
									</td>
									<td>
										<shiro:hasPermission name="lgt:ps:lgtPsCategory:edit">
											<div class="btn-group zf-tableButton">
												<button type="button" class="btn btn-xs btn-info" onclick="window.location.href='${ctx}/lgt/ps/category/form?id=${category.id}'">修改</button>
							                  	<button type="button" class="btn btn-xs btn-info dropdown-toggle" data-toggle="dropdown">
							                    	<span class="caret"></span>
							                  	</button>
							                  	<ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
							                    	<li><a href="#this" onclick="removeCategory('${ctx}/lgt/ps/category/delete','${category.id}')" style="color:#fff">删除</a></li>
							                    	<li><a href="${ctx}/lgt/ps/category/view?id=${category.id}">详情</a></li>
							                  	</ul>
							                </div>
										</shiro:hasPermission>
										<shiro:lacksPermission name="lgt:ps:lgtPsCategory:edit">
											<div class="btn-group zf-tableButton">
												<button type="button" class="btn btn-xs btn-info" onclick="window.location.href='${ctx}/lgt/ps/category/view?id=${category.id}'">详情</button>
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
	    	</div>
	    </section>
	</div>
</body>
</html>