<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>货位列表管理</title>
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
			<small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/lgt/ps/wareplace/wareplaceSelect?produce.id=${wareplace.produce.id }&warecounter.warearea.warehouse.id=${wareplace.warecounter.warearea.warehouse.id}&modalWhDisplayFlag=${wareplace.modalWhDisplayFlag}">货位列表</a></small>
		</h1>
	</section>
	<sys:tip content="${message}"/>
	<section class="content">
		<form:form id="searchForm" modelAttribute="wareplace" action="${ctx}/lgt/ps/wareplace/wareplaceSelect" method="post" class="form-horizontal">
		<input id="pageNo" data-unclear="true" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize"  data-unclear="true" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<input id="wareplaceId"  data-unclear="true" name="id" type="hidden"/>
		<input id="lockFlag"  data-unclear="true" name="lockFlag" type="hidden"/>
		<input id="produceId"  data-unclear="true" name="produce.id" value="${wareplace.produce.id }" type="hidden"/>
		<input id="modalWhDisplayFlag" data-unclear="true"  name="modalWhDisplayFlag" value="${wareplace.modalWhDisplayFlag }" type="hidden"/>
		
		<div class="box box-info">
			<div class="box-header with-border zf-query">
				<h5>查询条件</h5>
				<div class="box-tools pull-right">
		          	<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
		            <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-remove"></i></button>
		        </div>
			</div>
			<div class="box-body">
				<c:choose>
					<c:when test="${wareplace.modalWhDisplayFlag eq true }">
						<div class="row">
							<div class="col-md-4">
								<sys:inputtree name="warecounter.warearea.warehouse.id" url="${ctx}/lgt/ps/warehouse/warehouseListData" id="warehouse" label="所属仓库" labelValue="" labelWidth="3" inputWidth="7"
									 labelName="warecounter.warearea.warehouse.name" value="" tip="请选择仓库" onchange="changeWarehouse"></sys:inputtree>
							</div>
							<div class="col-md-4">
								<sys:inputtree name="warecounter.warearea.id" url="${ctx}/lgt/ps/warearea/wareareaListData" id="warearea" label="仓库区域" labelValue="" labelWidth="3" inputWidth="7" 
									labelName="warecounter.warearea.name" value="" tip="请选择区域" postParam="{postName:[\"warehouse.id\"],inputId:[\"warehouseId\"]}" isQuery="true" onchange="changeWarearea"></sys:inputtree>
							</div>
							<div class="col-md-4">
								<sys:inputtree name="warecounter.id" url="${ctx}/lgt/ps/warecounter/warecounterListData" id="warecounter" label="所属货架" labelValue="" labelName="warecounter.code" labelWidth="3" inputWidth="7" value="" tip="请选择货架"
									postParam="{postName:[\"warearea.id\"],inputId:[\"wareareaId\"]}" isQuery="true"></sys:inputtree>
							</div>
						</div>
					</c:when>
					<c:otherwise>
						<input id="warehouseId"  data-unclear="true" name="warecounter.warearea.warehouse.id" value="${wareplace.warecounter.warearea.warehouse.id }" type="hidden"/>
					</c:otherwise>
				</c:choose>
				<div class="row">
					<div class="col-md-4">
						<div class="form-group">
							<label for="searchParameter.keyWord" class="col-sm-3 control-label">关键字</label>
							<div class="col-sm-7">
								<form:input path="searchParameter.keyWord" placeholder="可输入货位编码或产品编码或产品名称" class="form-control"/>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="box-footer">
				<div class="pull-right box-tools">
	        		<button type="button" class="btn btn-default btn-sm" onclick="resetForm()"><i class="fa fa-refresh"></i>重置</button>
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
								<th></th>
								<th>货位编号</th>
								<th>仓库名称</th>
								<th>仓库区域名称</th>
								<th>货架编号</th>
								<th>存货量</th>
								<th>存货产品编码</th>
								<th>存货产品名称</th>
								<!-- <th>锁定状态</th> -->
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${page.list }" var="wareplace" varStatus="status">
								<tr data-index="${status.index }">
									<td>
										<div class="zf-check-wrapper-padding">
										     <input type="radio" name="wareplaceChk" data-name="${wareplace.warecounter.warearea.warehouse.name } ${wareplace.warecounter.warearea.name} ${wareplace.warecounter.code} ${wareplace.code}" value="${wareplace.id }"/>
										</div>
									</td>
									<td>
										${fns:abbr(wareplace.code, 15)}
									</td>
									<td>
										${wareplace.warecounter.warearea.warehouse.name }
									</td>
									<td>
										${wareplace.warecounter.warearea.name }
									</td>
									<td>
										${wareplace.warecounter.code }
									</td>
									<td>
										${wareplace.stock}
									</td>
									<td>
										${wareplace.produce.code}
									</td>
									<td>
										${wareplace.produce.goods.name} ${wareplace.produce.name}
									</td>
									<%-- <td>
										<c:choose>
											<c:when test="${wareplace.lockFlag == 1 }">
												<span class="label label-primary">${fns:getDictLabel(wareplace.lockFlag,'yes_no','')}</span>
											</c:when>
											<c:otherwise>
												<span class="label label-info">${fns:getDictLabel(wareplace.lockFlag,'yes_no','')}</span>
											</c:otherwise>
										</c:choose>
									</td> --%>
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
		
		$('input').iCheck({
			checkboxClass : 'icheckbox_minimal-blue',
			radioClass : 'iradio_minimal-blue'
		});
		
		 //表格初始化
	 	ZF.parseTable("#contentTable",{
			"paging" : false,
			"lengthChange" : false,
			"searching" : false,
			"order": [[ 5, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
			"columnDefs":[
				{"orderable":false,targets:0},
				{"orderable":false,targets:1},
				{"orderable":false,targets:2},
				{"orderable":false,targets:3},
				{"orderable":false,targets:4},
				{"orderable":false,targets:6},
				{"orderable":false,targets:7}
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
	
	function resetForm() {
		var form = $("#searchForm");
		$("input[type=text]", form).val("");
		$("input[type=hidden]", form).each(function() {
			var c = $(this).attr("data-unclear");
			if(c == null || c == undefined || c.length <= 0 || c != "true") {
				$(this).val("");
			}
		});
		$("select", form).val("");
		$("select", form).each(function(){
			$(this).select2("val","");
		});
	}
</script>	
</body>
</html>