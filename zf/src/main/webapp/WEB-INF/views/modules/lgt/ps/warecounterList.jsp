<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>货屉列表管理</title>
	<meta name="decorator" content="adminLte"/>
	<%@include file="/WEB-INF/views/include/treetable.jsp" %>
	<script type="text/javascript">
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
	<style type="text/css">
		tr{ 
		    cursor: pointer;    /*手形*/   
		} 
	</style>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
		<section class="content-header content-header-menu">
		 <h1>
			<small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/lgt/ps/warecounter/list">货屉列表</a></small>
	        <small>|</small>
			<small><i class="fa-form-edit"></i><a href="${ctx}/lgt/ps/warecounter/form">货屉新增</a></small>
	      </h1>
		</section>
		<sys:tip content="${message}"/>
		<section class="content">
			<form:form id="searchForm" modelAttribute="warecounter" action="${ctx}/lgt/ps/warecounter/list" method="post" class="form-horizontal">
				<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
				<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
				<div class="box box-info">
					<div class="box-header with-border zf-query">
						<h5>查询条件</h5>
						<div class="box-tools pull-right">
				            <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
				            <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-remove"></i></button>
				          </div>
					</div>
					<div class="box-body">
						<div class="row">
							<div class="col-md-4">
							<input id="id" name="id" type="hidden" value="${warehouseId}"/>
								<sys:inputtree name="warearea.warehouse.id" url="${ctx}/lgt/ps/warehouse/warehouseListData" id="warehouse" label="所属仓库" labelValue="${warehouseCode}" labelWidth="3" inputWidth="7"
									 labelName="warearea.warehouse.code" value="${warehouseId}" tip="请选择仓库" onchange="changeWarehouse"></sys:inputtree>
							</div>
							<div class="col-md-4">
								<sys:inputtree name="warearea.id" url="${ctx}/lgt/ps/warearea/wareareaListData" id="warearea" label="所属货架" labelValue="" labelWidth="3" inputWidth="7" 
									labelName="warearea.code" value="" tip="请选择货架" postParam="{postName:[\"warehouse.id\"],inputId:[\"warehouseId\"]}" isQuery="true" ></sys:inputtree>
							</div>
						</div>
					</div>
					<div class="box-footer">
						<div class="pull-right box-tools">
			        		<button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
		               		<button type="submit" class="btn btn-info btn-sm"><i class="fa fa-search"></i>查询</button>
			        	</div>
					</div>
				</div>
			</form:form>
			<div class="box box-soild">
				<div class="box-body">
					<div class="table-reponsive">
						<table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
							<thead>
								<tr>
									<th class="zf-dataTables-multiline"></th>
									<th>所属区域</th>
									<th>货屉编号</th>
									<th>归属供应商</th>
									<th>归属分类</th>
									<th>启用状态</th>
									<th style="display: none;">创建者</th>
									<th style="display: none;">更新时间</th>
									<th style="display: none;">更新者</th>
									<th style="display: none;">备注信息</th>
									<shiro:hasPermission name="lgt:ps:warecounter:edit"><th>操作</th></shiro:hasPermission>
								</tr>
							</thead>
							<tbody id="tBody">
								<c:forEach items="${page.list}" var="warecounter" varStatus="status">
									<tr data-index="${status.index }">
										<td class="details-control text-center">
                                            <i class="fa fa-plus-square-o text-success"></i>
                                        </td>
										<td>
											${warecounter.warearea.warehouse.code }-${warecounter.warearea.code }
										</td>
										<td>
											${fns:abbr(warecounter.code, 20)}
										</td>
										<td>
										    ${warecounter.supplier.name }
										</td>
										<td>
										    ${warecounter.category.categoryName }
										</td>
										<td>
                                              <c:choose>
                                                      <c:when test="${warecounter.usableFlag == 1 }">
                                                          <span class="label label-success">${fns:getDictLabel(warecounter.usableFlag, 'yes_no', '') }</span>
                                                      </c:when>
                                                      <c:otherwise>
                                                          <span class="label label-primary">${fns:getDictLabel(warecounter.usableFlag, 'yes_no', '') }</span>
                                                      </c:otherwise>
                                                  </c:choose>
										</td>
										<td data-hide="true">
											${fns:getUserById(warecounter.createBy.id).name}
										</td>
										<td data-hide="true">
											<fmt:formatDate value="${warecounter.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
										</td>
										<td data-hide="true">
											${fns:getUserById(warecounter.updateBy.id).name}
										</td>
										<td data-hide="true">
											${fns:abbr(warecounter.remarks, 30)}
										</td>
										<shiro:hasPermission name="lgt:ps:warecounter:edit"><td>
											<div class="btn-group zf-tableButton">
				                  				<button type="button" class="btn btn-xs btn-info" onclick="window.location.href='${ctx}/lgt/ps/warecounter/form?id=${warecounter.id}'">修改</button>
				                  				<button type="button" class="btn btn-xs btn-info dropdown-toggle" data-toggle="dropdown">
								                   <span class="caret"></span>
								                </button>
								                <ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
								                	<li><a href="${ctx}/lgt/ps/warecounter/delete?id=${warecounter.id}" onclick="return ZF.delRow('确认要删除该记录吗？', this.href)">删除</a></li>
								                </ul>
							                </div>
										</td></shiro:hasPermission>
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
		//点击仓库选择时，需清空货架、货屉、货位
		function changeWarehouse(){
			$("#wareareaName").val("");
			$("#wareareaId").val("");
		}
		

	    $(function() {
	         //表格初始化
	        ZF.parseTable("#contentTable",{
	            "paging" : false,
	            "lengthChange" : false,
	            "searching" : false,
	            "order": [[ 7, "asc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
	            "columnDefs":[
	                {"orderable":false,targets:0},
	                {"orderable":false,targets:1},  
	                {"orderable":false,targets:2},
	                {"orderable":false,targets:3},
	                {"orderable":false,targets:4},
	                {"orderable":false,targets:5},
	                {"orderable":false,targets:6},
	                {"orderable":false,targets:7},
	                {"orderable":false,targets:8},
	                {"orderable":false,targets:9},
	                {"orderable":false,targets:10}
	            ],
	            "ordering" : true,
	            "info" : false,
	            "autoWidth" : false,
	            "multiline":true,//是否开启多行表格
	            "isRowSelect":true,//是否开启行选中
	            "rowSelect":function(tr){productId = tr.attr("data-value");},
	            "rowSelectCancel":function(tr){productId = null;}
	        })
	    });
		
	</script>
</body>
</html>