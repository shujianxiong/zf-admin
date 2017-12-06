<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>微信公众号菜单管理</title>
	<meta name="decorator" content="adminLte"/>
	<style type="text/css">
		tr{ 
		    cursor: pointer;    /*手形*/   
		} 
	</style>
	<script type="text/javascript">
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
		//清空查询条件
		function clearQueryParam(){
			$("#title").val("");
			$("#subtitle").val("");
			$("#content").val("");
			$("#s2id_category").select2("val","");
		}
	</script>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
		<section class="content-header content-header-menu">
			<h1>
				<small class="menu-active">
					<i class="fa fa-repeat"></i><a href="${ctx}/wcp/mn/menu/list?mpType=${mpType}">公众号菜单列表</a>
				</small>
				<shiro:hasPermission name="wcp:mn:menu:edit">
					<small>|</small>
					<small>
						<i class="fa-form-edit"></i><a href="${ctx}/wcp/mn/menu/form?mpType=${mpType}">公众号菜单编辑</a>
					</small>
				</shiro:hasPermission>
			</h1>
		</section>
		
		<sys:tip content="${message}" />
		
		<section class="content">
			<div class="box box-info">
				<div class="box-header with-border zf-query">
					<h5>查询条件</h5>
					<div class="box-tools pull-right">
						<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
						<button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-remove"></i></button>
					</div>
				</div>
					<input id="id" name="id" type="hidden"/>
					<div class="box-body" style="height: 100px">
						<div class="row">
							<div class="col-md-4">
								<div  class="form-group">
									<label for="mp" class="col-sm-3 control-label">微信公众号</label>
									<div class="col-sm-7">
										<select id="mp" name="mp" onchange="selectChange(this.options[this.options.selectedIndex].value)">
											<c:if test="${mpType eq 'D_A'}">
												<option value="D_A" id="D_A">周范儿</option>
												<option value="D_S" id="D_S">周范珠宝</option>
											</c:if>
											<c:if test="${mpType eq 'D_S'}">
												<option value="D_S" id="D_S">周范珠宝</option>
												<option value="D_A" id="D_A">周范儿</option>
											</c:if>
										</select>
									</div>
								</div>
							</div>
						</div>
					</div>
			</div>
			<div class="box box-info">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-12 pull-right"></div>
					</div>
					<div class="table-responsive">
						<table id="contentTable" class="table table-hover table-bordered table-striped zf-tbody-font-size">
							<thead>
								<tr>
									<th>菜单标题</th>
									<th>响应动作类型</th>
									<th>菜单KEY值</th>
									<th>网页链接</th>
									<th>图文mediaId</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${menuVo.menus}" var="menu" varStatus="astatus">
									<c:set var="menuId" value="${astatus.index }" ></c:set>
									<tr id="${menuId}">
										<td>
											${menu.name}
										</td>
										<td>
										       <c:choose>
										            <c:when test="${empty menu.type }"></c:when>
										            <c:when test="${menu.type eq 'click' }">点击推事件</c:when>
		                                            <c:when test="${menu.type eq 'view' }">跳转URL</c:when>
		                                            <c:when test="${menu.type eq 'scancode_push' }">扫码推事件</c:when>
		                                            <c:when test="${menu.type eq 'scancode_waitmsg' }">扫码推事件2</c:when>
		                                            <c:when test="${menu.type eq 'pic_sysphoto' }">弹出系统拍照发图</c:when>
		                                            <c:when test="${menu.type eq 'pic_photo_or_album' }">弹出拍照或者相册发</c:when>
		                                            <c:when test="${menu.type eq 'pic_weixin' }">弹出微信相册发图器</c:when>
		                                            <c:when test="${menu.type eq 'location_select' }">弹出地理位置选择器</c:when>
		                                            <c:when test="${menu.type eq 'media_id' }">下发消息(除文本消息)</c:when>
		                                            <c:when test="${menu.type eq 'view_limited' }">跳转图文消息URL</c:when>
		                                            <c:otherwise>
		                                              
		                                            </c:otherwise>
										       </c:choose>
										</td>
										<td>
											${menu.key}
										</td>
										<td title="${menu.url}">
											${fns:abbr(menu.url,30)}
										</td>
									</tr>
									<c:forEach items="${menu.subButtons}" var="submenu" varStatus="sstatus">
										<tr pid="${menuId }">
											<td>
												&nbsp;&nbsp;&nbsp;&nbsp;${submenu.name}
											</td>
											<td>
												<c:choose>
													<c:when test="${empty submenu.type }"></c:when>
                                                    <c:when test="${submenu.type eq 'click' }">点击推事件</c:when>
                                                    <c:when test="${submenu.type eq 'view' }">跳转URL</c:when>
                                                    <c:when test="${submenu.type eq 'scancode_push' }">扫码推事件</c:when>
                                                    <c:when test="${submenu.type eq 'scancode_waitmsg' }">扫码推事件2</c:when>
                                                    <c:when test="${submenu.type eq 'pic_sysphoto' }">弹出系统拍照发图</c:when>
                                                    <c:when test="${submenu.type eq 'pic_photo_or_album' }">弹出拍照或者相册发</c:when>
                                                    <c:when test="${submenu.type eq 'pic_weixin' }">弹出微信相册发图器</c:when>
                                                    <c:when test="${submenu.type eq 'location_select' }">弹出地理位置选择器</c:when>
                                                    <c:when test="${submenu.type eq 'media_id' }">下发消息(除文本消息)</c:when>
                                                    <c:when test="${submenu.type eq 'view_limited' }">跳转图文消息URL</c:when>
                                                    <c:otherwise>
                                                      
                                                    </c:otherwise>
                                               </c:choose>
											</td>
											<td>
												${submenu.key}
											</td>
											<td title="${submenu.url}">
												${fns:abbr(submenu.url, 30) }
											</td>
											<td>
													${submenu.mediaId}
											</td>
										</tr>
									</c:forEach>
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
    function selectChange(mpType) {
        window.location.href="${ctx}/wcp/mn/menu/list?mpType="+mpType;

    }
</script>
</body>
</html>