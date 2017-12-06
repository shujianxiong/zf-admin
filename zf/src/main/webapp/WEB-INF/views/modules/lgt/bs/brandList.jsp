<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>品牌管理</title>
	<meta name="decorator" content="adminLte"/>
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
			$("#name").val("");
			$("#s2id_brandStatus").select2("val","");
			$("#s2id_displayFlag").select2("val","");
			$("#s2id_recommendFlag").select2("val","");
		}
		//清空查询条件
		function clearQueryParam(){
			$("#name").val("");
			$("#s2id_brandStatus").select2("val","");
			$("#s2id_displayFlag").select2("val","");
			$("#s2id_recommendFlag").select2("val","");
		}
	</script>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
		<section  class="content-header content-header-menu">
			<h1>
				<small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/lgt/bs/brand/list">品牌列表</a></small>
				<shiro:hasPermission name="lgt:bs:brand:edit"><small>|</small><small><i class="fa-form-edit"></i><a href="${ctx}/lgt/bs/brand/form">品牌${not empty brand.id?'修改':'添加'}</a></small></shiro:hasPermission>
			</h1>
		</section>
		<sys:tip content="${message}"/>
		
		<section  class="content">
			<div class="box box-info">
				<div class="box-header with-border zf-query">
					<h5>查询条件</h5>
					<div class="box-tools pull-right">
						<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
						<button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-remove"></i></button>
					</div>
				</div>
	
				<form:form id="searchForm" modelAttribute="brand" action="${ctx}/lgt/bs/brand/list" method="post" class="form-horizontal">
					<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
					<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
					<div class="box-body">
						<div class="row">
							<div class="col-md-4">
								<div  class="form-group">
									<label for="name" class="col-sm-3 control-label">品牌名称</label>
									<div class="col-sm-7">
										<sys:inputverify name="name" id="name" verifyType="0" tip="请输入查询的品牌名称" isMandatory="false" isSpring="true"></sys:inputverify>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div  class="form-group">
									<label for="brandStatusId" class="col-sm-3 control-label">品牌状态</label>
									<div class="col-sm-7">
										<form:select path="brandStatus" class="input-medium" id="brandStatusId">
											<form:option value="" label="所有"/>
											<form:options items="${fns:getDictList('brand_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
										</form:select>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="box-footer">
						<div class="pull-right box-tools">
			        		<button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
		               		<button type="submit" class="btn btn-info btn-sm"><i class="fa fa-search"></i>查询</button>
			        	</div>
					</div>
	            </form:form>
				</div>
				<div class="box box-soild">
				<div class="box-body">
					<div class="table-responsive">
						<table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
							<thead>
								<tr>
								    <th class="zf-dataTables-multiline"></th>
									<th>品牌LOGO</th>
									<th>品牌头部图</th>
									<th>品牌名称</th>
									<th>品牌公司名称</th>
									<th>品牌简介</th>
									<th>品牌类型</th>
									<th>品牌状态</th>
									<th style="display:none">创建人</th>
                                    <th style="display:none">创建时间</th>
                                    <th style="display:none">更新人</th>
                                    <th style="display:none">更新时间</th>
									<th style="display:none">备注信息</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${page.list}" var="brand" varStatus="status">
									<tr data-index="${status.index }">
	                                    <td class="details-control text-center">
	                                        <i class="fa fa-plus-square-o text-success"></i>
	                                    </td>
										<td>
                                            <img onerror="imgOnerror(this);"  src="${imgHost }${brand.logo}" data-big data-src="${imgHost }${brand.logo}" style="width:20px;height:20px;">
                                        </td>
                                        <td>
                                            <img onerror="imgOnerror(this);"  src="${imgHost }${brand.topPhoto}" data-big data-src="${imgHost }${brand.topPhoto}" style="width: 20px; height: 20px;">
                                        </td>
										<td title="${brand.name}">
											<%-- <a href="${ctx}/lgt/bs/brand/info?id=${brand.id}"> --%>
												${fns:abbr(brand.name, 30)}
											<!-- </a> -->
										</td>
										<td title="${brand.companyName}">
											${fns:abbr(brand.companyName, 30)}
										</td>
										<td title="${brand.introduction}">
											${fns:abbr(brand.introduction, 30)}
										</td>
										<td>
											<c:choose>
												<c:when test="${brand.type eq '1'}">
													<span class="label label-success">${fns:getDictLabel(brand.type, 'lgt_bs_brand_type', '')}</span>
												</c:when>
												<c:when test="${brand.type eq '2'}">
													<span class="label label-primary">${fns:getDictLabel(brand.type, 'lgt_bs_brand_type', '')}</span>
												</c:when>
											</c:choose>
										</td>
										<td>
											<c:choose>
												<c:when test="${brand.brandStatus eq '1'}">
													<span class="label label-success">${fns:getDictLabel(brand.brandStatus, 'brand_status', '')}</span>
												</c:when>
												<c:when test="${brand.brandStatus eq '0'}">
													<span class="label label-primary">${fns:getDictLabel(brand.brandStatus, 'brand_status', '')}</span>
												</c:when>
											</c:choose>
										</td>
										<td data-hide="true">
                                            ${fns:getUserById(brand.createBy.id).name}
	                                    </td>
	                                    <td data-hide="true">
	                                        <fmt:formatDate value="${brand.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
	                                    </td>
	                                    <td data-hide="true">
	                                        ${fns:getUserById(brand.updateBy.id).name}
	                                    </td>
	                                    <td data-hide="true"> 
	                                        <fmt:formatDate value="${brand.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
	                                    </td>
										<td data-hide="true">
											${fns:abbr(brand.remarks,30)}
										</td>
										<td>
											 <shiro:hasPermission name="lgt:bs:brand:edit">
												<div class="btn-group zf-tableButton">
								                  	<button type="button" class="btn btn-sm btn-info" onclick="window.location.href='${ctx}/lgt/bs/brand/form?id=${brand.id}'">修改</button>
								                  	<button type="button" class="btn btn-sm btn-info dropdown-toggle" data-toggle="dropdown">
								                    	<span class="caret"></span>
									                </button>
								                  	<ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
								                  	<li><a onclick="return changeFlag('确定要执行该操作吗？', '${ctx}/lgt/bs/brand/updateStatus?id=${brand.id}')" href="#this">${brand.brandStatus eq '0'?"启用":"停用"}</a></li>
									                <li><a href="${ctx}/lgt/bs/brand/delete?id=${brand.id}" style="color:#fff" onclick="return ZF.delRow('确定要删除该品牌吗？',this.href)">删除</a></li>
								                  	<li><a href="${ctx}/lgt/bs/brand/info?id=${brand.id}">详情</a></li>
												  	</ul>
												</div>
								            </shiro:hasPermission>
								            <shiro:lacksPermission name="lgt:bs:brand:edit">
								            	<div class="btn-group zf-tableButton">
								                  	<button type="button" class="btn btn-sm btn-info" onclick="window.location.href='${ctx}/lgt/bs/brand/info?id=${brand.id}'">详情</button>
								                  	<button type="button" class="btn btn-sm btn-info dropdown-toggle" data-toggle="dropdown">
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
	
	$(function() {
		ZF.bigImg();
		//表格初始化
	 	var t=ZF.parseTable("#contentTable",{
			"paging" : false,
			"lengthChange" : false,
			"searching" : false,//关闭搜索
			"ordering" : false,//开启排序
			"info" : false,
			"autoWidth" : false,
			"multiline":true,//是否开启多行表格
			"isRowSelect":true,//是否开启行选中
			"rowSelect":function(tr){},//行选中回调
			"rowSelectCancel":function(tr){},//行取消选中回调
			"addRow":{
				"eventId":"#addRow",
				"getData":function(){
					return ["<td class=\"details-control text-center\"><i class=\"fa fa-plus-square-o text-success\"></i></td>",
					        "<td>2</td>",
					        "<td>3</td>",
					        "<td>4</td>",
					        "<td>5</td>",
					        "<td>6</td>",
					        "<td>7</td>",
					        "<td data-hide=\"true\">8</td>",
					        "<td data-hide=\"true\">9</td>",
					        "<td data-hide=\"true\">10</td>",
					        "<td data-hide=\"true\">11</td>",
					        "<td title=\"测试\">12</td>",
					        "<td>13</td>"
					       ];
				},
				"callBack":function(){
					console.log("行添加结束")
				}
				
			}
		});
	});
	</script>
</body>
</html>