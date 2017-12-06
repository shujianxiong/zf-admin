<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>货位列表管理</title>
	<meta name="decorator" content="adminLte"/>
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
			<small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/lgt/ps/wareplace/wareplaceList">货位列表</a></small>
			<small>|</small>
			<small><i class="fa-form-edit"></i><a href="${ctx}/lgt/ps/wareplace/form">货位添加</a></small>
		</h1>
	</section>
	<sys:tip content="${message}"/>
	<section class="content">
		<form:form id="searchForm" modelAttribute="wareplace" action="${ctx}/lgt/ps/wareplace/wareplaceList" method="post" class="form-horizontal">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<input id="wareplaceId" name="id" type="hidden"/>
		<input id="lockFlag" name="lockFlag" type="hidden"/>
		<input id="usableFlag" name="usableFlag" type="hidden"/>
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
						<sys:inputtree name="warecounter.warearea.warehouse.id" url="${ctx}/lgt/ps/warehouse/warehouseListData" id="warehouse" label="所属仓库" labelValue="${warehouseCode}" labelWidth="3" inputWidth="7"
							 labelName="warecounter.warearea.warehouse.code" value="${warehouseId}" tip="请选择仓库" onchange="changeWarehouse"></sys:inputtree>
					</div>
					<div class="col-md-4">
						<sys:inputtree name="warecounter.warearea.id" url="${ctx}/lgt/ps/warearea/wareareaListData" id="warearea" label="所属货架" labelValue="" labelWidth="3" inputWidth="7" 
							labelName="warecounter.warearea.code" value="" tip="请选择货架" postParam="{postName:[\"warehouse.id\"],inputId:[\"warehouseId\"]}" isQuery="true" onchange="changeWarearea"></sys:inputtree>
					</div>
					<div class="col-md-4">
						<sys:inputtree name="warecounter.id" url="${ctx}/lgt/ps/warecounter/warecounterListData" id="warecounter" label="所属货屉" labelValue="" labelWidth="3" inputWidth="7"
							labelName="warecounter.code" value="" tip="请选择货屉" postParam="{postName:[\"warearea.id\"],inputId:[\"wareareaId\"]}" isQuery="true"></sys:inputtree>
					</div>
				</div>
				<div class="row">
					<div class="col-md-4">
						<div class="form-group">
							<label for="searchParameter.keyWord" class="col-sm-3 control-label">关键字</label>
							<div class="col-sm-7">
								<form:input path="searchParameter.keyWord" placeholder="可输入货位编码或货品编码或名称查询" class="form-control"/>
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
		</div>
		</form:form>
		<div class="box box-soild">
			<div class="box-body">
				<div class="table-responsive">
					<table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
						<thead>
							<tr>
								<th class="zf-dataTables-multiline"></th>
								<th>所属区域</th>
								<th>货位编号</th>
								<th>货位电子码</th>
								<th>存货产品</th>
								<th>产品图</th>
								<th>存货量</th>
								<th>锁定状态</th>
								<th>启用状态</th>
								<th style="display:none">创建者</th>
								<th style="display:none">创建时间</th>
								<th style="display:none">更新者</th>
								<th style="display:none">更新时间</th>
								<th>备注信息</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${page.list }" var="wareplace" varStatus="status">
								<tr data-index="${status.index }">
									<td class="details-control text-center">
										<i class="fa fa-plus-square-o text-success"></i>
									</td>
									<td>
										${wareplace.warecounter.warearea.warehouse.code }-${wareplace.warecounter.warearea.code }-${wareplace.warecounter.code}
									</td>
									<td>
										${fns:abbr(wareplace.code, 15)}
									</td>
									<td title="${wareplace.scanCode }">
										${fns:abbr(wareplace.scanCode, 32)}
									</td>
									<td title="${wareplace.produce.goods.name} ${wareplace.produce.name}">
										${wareplace.produce.code}
									</td>
									<td>
										<img onerror="imgOnerror(this);" src="${imgHost }${wareplace.produce.goods.samplePhoto}" data-big data-src="${imgHost }${wareplace.produce.goods.samplePhoto}" width="20px" height="20px" />
									</td>
									<td>
										${wareplace.stock}
									</td>
									<td>
										<c:choose>
											<c:when test="${wareplace.lockFlag == 1 }">
												<span class="label label-success">${fns:getDictLabel(wareplace.lockFlag,'yes_no','')}</span>
											</c:when>
											<c:otherwise>
												<span class="label label-primary">${fns:getDictLabel(wareplace.lockFlag,'yes_no','')}</span>
											</c:otherwise>
										</c:choose>
									</td>
									<td>
                                       <c:choose>
                                            <c:when test="${wareplace.usableFlag == 1 }">
                                                <span class="label label-success">${fns:getDictLabel(wareplace.usableFlag, 'yes_no', '') }</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="label label-primary">${fns:getDictLabel(wareplace.usableFlag, 'yes_no', '') }</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
									<td data-hide="true">
										${fns:getUserById(wareplace.createBy.id).name}
									</td>
									<td data-hide="true">
										<fmt:formatDate value="${wareplace.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>
									<td data-hide="true">
										${fns:getUserById(wareplace.updateBy.id).name}
									</td>
									<td data-hide="true">
										<fmt:formatDate value="${wareplace.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>
									<td title="${wareplace.remarks }">
										${fns:abbr(wareplace.remarks, 15)}
									</td>
									<td>
										<div class="btn-group zf-tableButton">
											<button type="button" class="btn btn-sm btn-info" onclick="window.location.href='${ctx}/lgt/ps/wareplace/form?id=${wareplace.id }'">修改</button>
											<button type="button" class="btn btn-sm btn-info dropdown-toggle" data-toggle="dropdown">
							                   <span class="caret"></span>
							                </button>
							                <ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
							                    <c:choose>
										  			<c:when test="${wareplace.lockFlag == 1 }">
										  				<li><a href="#this" onclick="updateLockFlag('${ctx}/lgt/ps/wareplace/updateLockFlag','${wareplace.id}','0','确定要解锁该货位吗？')" style="color:#fff">解锁</a></li>
										  			</c:when>
										  			<c:when test="${wareplace.lockFlag == 0}" >
										  				<li><a href="#this" onclick="updateLockFlag('${ctx}/lgt/ps/wareplace/updateLockFlag','${wareplace.id}','1','确定要锁定该货位吗？')" style="color:#fff">锁定</a></li>
										  			</c:when>
										  		</c:choose>
										  		<c:choose>
										  		    <c:when test="${wareplace.usableFlag == 0}">
                                                        <li><a href="#this" onclick="updateUsableFlag('${ctx}/lgt/ps/wareplace/updateUsableFlag','${wareplace.id}','1','确定要启用该货位吗？')" style="color:#fff">启用</a></li>
                                                    </c:when>
                                                    <c:when test="${wareplace.usableFlag == 1}" >
                                                        <li><a href="#this" onclick="updateUsableFlag('${ctx}/lgt/ps/wareplace/updateUsableFlag','${wareplace.id}','0','确定要禁用该货位吗？')" style="color:#fff">禁用</a></li>
                                                    </c:when>
										  		</c:choose>
							                </ul>
										</div>
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

	var wareplaceId = null;
	var warecounterId = null;
	$(function() {
		
		ZF.bigImg();
		
		 //表格初始化
	 	ZF.parseTable("#contentTable",{
			"paging" : false,
			"lengthChange" : false,
			"searching" : false,
			"order": [[ 12, "asc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
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
				{"orderable":false,targets:10},
				{"orderable":false,targets:11},
				{"orderable":false,targets:12},
				{"orderable":false,targets:13},
				{"orderable":false,targets:14}
            ],
			"ordering" : false,
			"info" : false,
			"autoWidth" : false,
			"multiline":true,//是否开启多行表格
			"isRowSelect":true,//是否开启行选中
			"rowSelect":function(tr){productId = tr.attr("data-value");},
			"rowSelectCancel":function(tr){productId = null;}
		})
	});
	//点击仓库选择时，需清空区域、货架、货位
	function changeWarehouse(){
		$("#wareareaName").val("");
		$("#wareareaId").val("");
		$("#warecounterName").val("");
		$("#warecounterId").val("");
		$("#wareplaceName").val("");
		$("#wareplaceId").val("");
	}
	//点击区域选择时，需清空货架、货位
	function changeWarearea(){
		$("#warecounterName").val("");
		$("#warecounterId").val("");
		$("#wareplaceName").val("");
		$("#wareplaceId").val("");
	}
	
	//锁定或解锁货位
	function updateLockFlag(url,id,lockFlag,message){
		confirm(message,"warning",function(){
			$("#wareplaceId").val(id);
			$("#lockFlag").val(lockFlag),
			$("#searchForm").attr("action",url);
			$("#searchForm").submit();
		})
	}
	
	
	//启用或禁用货位
    function updateUsableFlag(url,id,usableFlag,message){
        confirm(message,"warning",function(){
            $("#wareplaceId").val(id);
            $("#usableFlag").val(usableFlag),
            $("#searchForm").attr("action",url);
            $("#searchForm").submit();
        })
    }
</script>	
</body>
</html>