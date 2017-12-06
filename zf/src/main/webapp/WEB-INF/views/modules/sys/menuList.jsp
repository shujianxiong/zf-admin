<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>菜单管理</title>
	<meta name="decorator" content="adminLte"/>
	<%@include file="/WEB-INF/views/include/treetable.jsp" %>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#treeTable").treeTable({expandLevel : 3}).show();
		});
    	function updateSort() {
// 			loading('正在提交，请稍等...');
	    	$("#listForm").attr("action", "${ctx}/sys/menu/updateSort");
	    	$("#listForm").submit();
    	}
	</script>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
		<section class="content-header content-header-menu">
			<h1>
				<small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/sys/menu/">菜单列表</a></small>
				<small>|</small>
				<small><i class="fa-form-edit"></i><a href="${ctx}/sys/menu/form">菜单新增</a></small>
			</h1>
		</section>
		<sys:tip content="${message}"/>
		<section class="content">
			<form id="listForm" method="post">
				<div class="box box-soild">
					<div class="box-body">
						<div class="table-responsive">
							<table id="treeTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
								<thead><tr><th>名称</th><th>链接</th><th style="text-align:center;">排序</th><th>可见</th><th>权限标识</th><shiro:hasPermission name="sys:menu:edit"><th>操作</th></shiro:hasPermission></tr></thead>
								<tbody><c:forEach items="${list}" var="menu">
									<tr id="${menu.id}" pId="${menu.parent.id ne '1'?menu.parent.id:'0'}">
										<td nowrap>
											<i class="icon-${not empty menu.icon?menu.icon:' hide'}"></i>
											<span data-click data-toggle='tooltip' data-placement='top' data-original-title='点击修改'>${menu.name}</span>
											<input data-name="menuName" data-blur type="text" value="${menu.name}" style="height:20px;margin:0;padding:0;text-align:center;display:none;" class="form-control"/>
										</td>
										<td title="${menu.href}">
											<span data-click data-toggle='tooltip' data-placement='top' data-original-title='点击修改'>${fns:abbr(menu.href,30)}</span>
											<input data-name="menuHref" data-blur type="text" value="${menu.href}" style="height:20px;margin:0;padding:0;text-align:center;display:none;" class="form-control"/>
										</td>
										<td style="text-align:center;">
											<shiro:hasPermission name="sys:menu:edit">
												<input type="hidden" name="ids" value="${menu.id}"/>
												<span data-click data-toggle='tooltip' data-placement='top' data-original-title='点击修改'>${menu.sort}</span>
												<input data-name="menuSorts" data-blur name="sorts" type="text" value="${menu.sort}" class="form-control" style="width:50px;height:20px;margin:0;padding:0;text-align:center;display:none;">
											</shiro:hasPermission><shiro:lacksPermission name="sys:menu:edit">
												${menu.sort}
											</shiro:lacksPermission>
										</td>
										<td>${menu.isShow eq '1'?'显示':'隐藏'}</td>
										<td title="${menu.permission}">${fns:abbr(menu.permission,30)}</td>
										<shiro:hasPermission name="sys:menu:edit"><td nowrap>
											<a href="${ctx}/sys/menu/form?id=${menu.id}">修改</a>
											<a href="${ctx}/sys/menu/delete?id=${menu.id}" onclick="return ZF.delRow('要删除该菜单及所有子菜单项吗？', this.href)">删除</a>
											<a href="${ctx}/sys/menu/form?parent.id=${menu.id}">添加下级菜单</a> 
										</td></shiro:hasPermission>
									</tr>
								</c:forEach></tbody>
							</table>
						</div>
					</div>
				</div>
				
			 </form>
		</section>
	</div>
	<script type="text/javascript">
		$(function(){
			//表格初始化
			ZF.parseTable("#treeTable", {
				"paging" : false,
				"lengthChange" : false,
				"searching" : false,
				"ordering" : false,
				"info" : false,
				"autoWidth" : false,
				"multiline" : true,//是否开启多行表格
				"isRowSelect" : false//是否开启行选中
			})
			
			$("[data-click]").on("click",function(){
				$(this).hide();
				$(this).next().next().show();
				$(this).next().next().focus();
			})
			
			$("[data-blur]").on("blur",function(){
				$(this).hide();
				$(this).prev().show();
			})
			
			$("[data-name=menuName]").on("change",function(){
				console.log($(this).parent().parent().attr("id"))
				var menuName=$(this).val();
				var obj=$(this);
				var id=$(this).parent().parent().attr("id");
				var data="{\"menuName\":\""+menuName+"\"}";
				ZF.ajaxQuery(true,"${ctx}/sys/menu/update/menuId/"+id,$.parseJSON(data),function(data){
					if(data.status=="0"){
						ZF.showTip(data.message,"warning")
					}else{
						obj.prev().text(menuName)
						ZF.showTip(data.message,"info")
					}
				})
			})
			
			$("[data-name=menuHref]").on("change",function(){
				var menuHref=$(this).val();
				var obj=$(this);
				var id=$(this).parent().parent().attr("id");
				var data="{\"menuHref\":\""+menuHref+"\"}";
				ZF.ajaxQuery(true,"${ctx}/sys/menu/update/menuId/"+id,$.parseJSON(data),function(data){
					if(data.status=="0"){
						ZF.showTip(data.message,"warning")
					}else{
						obj.prev().text(menuHref)
						ZF.showTip(data.message,"info")
					}
				})
			})
			
			$("[data-name=menuSorts]").on("change",function(){
				var menuSorts=$(this).val();
				var obj=$(this);
				var id=$(this).parent().parent().attr("id");
				var data="{\"menuSorts\":\""+menuSorts+"\"}";
				ZF.ajaxQuery(true,"${ctx}/sys/menu/update/menuId/"+id,$.parseJSON(data),function(data){
					if(data.status=="0"){
						ZF.showTip(data.message,"warning")
					}else{
						obj.prev().text(menuSorts)
						ZF.showTip(data.message,"info")
					}
				})
			})
		})
	</script>
</body>
</html>