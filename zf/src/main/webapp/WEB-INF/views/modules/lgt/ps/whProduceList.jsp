<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>产品库存列表</title>
	<meta name="decorator" content="adminLte"/>
	<script type="text/javascript">
		$(document).ready(function() {
// 			$("#contentTable").treeTable({expandLevel : 3});
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
		
		//启用或停用监控
		function updateMotinorStatus(url,id,stockStatus,num,motinorStatus,message){
			console.log(num);
			if(num>0){
	 			confirm(message,'info',function(){
					$("#whProduceId").val(id);
					$("#motinorStatus").val(motinorStatus),
					$("#searchForm").attr("action",url);
					$("#searchForm").submit();
					return false;
				})
			}else{
				ZF.showTip("请先设置好库存监控数据!","warning");
				return false;
			}
		}
	</script>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
		<section class="content-header content-header-menu">
			<h1>
				<small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/lgt/ps/whProduce/list">产品库存列表</a></small>
<!-- 				<small>|</small> -->
<%-- 	        	<shiro:hasPermission name="lgt:ps:product:edit"><small><i class="fa-form-edit"></i><a href="${ctx}/lgt/ps/whProduce/form">修改设置</a></small></shiro:hasPermission> --%>
			</h1>
		</section>
		<sys:tip content="${message}"/>
		<section class="content">
			<form:form id="searchForm" modelAttribute="whProduce" action="${ctx}/lgt/ps/whProduce/list" method="post" class="form-horizontal">
				<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
				<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
				<input id="whProduceId" name="id" type="hidden"/>
				<input id="motinorStatus" name="status" type="hidden"/>
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
								<sys:inputtree name="warehouse.id" url="${ctx}/lgt/ps/warehouse/warehouseListData" id="warehouse" label="监控仓库" labelWidth="3" inputWidth="7" labelName="warehouse.name" labelValue="${code}" value="${warehouse.id }" tip="请选择仓库" title="仓库"></sys:inputtree>
							</div>
							<div class="col-md-4">
								<div class="form-group">
									<label for="motinorStatus" class="col-sm-3 control-label">是否生效</label>
									<div class="col-sm-7">
										<form:select path="motinorStatus" class="form-control select2">
											<form:option value="" label="所有"/>
											<form:options items="${fns:getDictList('lgt_ps_wh_produce_motinorStatus') }" itemLabel="label" itemValue="value" htmlEscape="false"/>
										</form:select>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-group">
									<label for="stockStatus" class="col-sm-3 control-label">库存状态</label>
									<div class="col-sm-7">
										<select name="stockStatus" class="form-control select2" >
											<option value="">所有</option>
											<option value="1" <c:if test="${stockStatus == 1}">selected = "true"</c:if>>正常</option>
											<option value="2" <c:if test="${stockStatus == 2}">selected = "true"</c:if>>预警</option>
											<option value="3" <c:if test="${stockStatus == 3}">selected = "true"</c:if>>报警</option>
										</select>
									</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-4">
								<div class="form-group">
									<label for="searchParameter.keyWord" class="col-sm-3 control-label">产品名称</label>
									<div class="col-sm-7">
										<form:input path="searchParameter.keyWord" class="form-control" placeholder="输入商品或产品名称查询"/>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-group">
									<label for="produce.code" class="col-sm-3 control-label">产品编码</label>
									<div class="col-sm-7">
										<form:input path="produce.code" class="form-control" placeholder="输入产品编码查询"/>
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
<!-- 					<div class="box-header with-border"> -->
						
<!-- 					</div> -->
					<div class="box-body">
						<div class="row">
							<div class="col-sm-12 pull-right">
					          	<shiro:hasPermission name="lgt:ps:product:edit">
						            <button type="button" class="btn btn-sm btn-success" onclick="window.location.href='${ctx}/lgt/ps/whProduce/form'" ><i class="fa fa-pencil">批量修改</i></button>
						            <sys:selectmutil id="updateByWarehouse" height="800" url="${ctx}/lgt/ps/whProduce/updateByWarehouse" width="1200" isDisableCommitBtn="true" title="按仓库修改"></sys:selectmutil>
					            </shiro:hasPermission>
							</div>
						</div>
						<div class="table-responsive">
							<table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
								<thead>
									<tr>	
										<th class="zf-dataTables-multiline"></th>
										<th>所属仓库</th>
										<th>样图</th>
										<th>产品编码</th>
										<th>产品全称</th>
										<th class="zf-table-money">正常库存<span data-toggle="tooltip" class="badge bg-light-blue" data-original-title="当前仓库中存在的、可下体验单或销售单的库存">?</span></th>
										<th class="zf-table-money">锁定库存<span data-toggle="tooltip" class="badge bg-light-blue" data-original-title="体验或销售过程锁定的库存（不包含销售完成的产品库存）、产品维修锁定的库存等，不可再下体验单或销售单">?</span></th>
										<th class="zf-table-money">负债库存<span data-toggle="tooltip" class="badge bg-light-blue" data-original-title="预约体验或预约销售过程中，仓库库存不足导致的负债库存；采购回货后预约单变为可支付，则同时减少负债库存">?</span></th>
										<th style="display: none">监控状态</th>
										<th style="display: none">标准库存</th>
										<th style="display: none">安全库存</th>
										<th style="display: none">警戒库存</th>
										<th style="display: none">库存状态</th>
										<th style="display: none">创建者</th>
										<th style="display: none">创建时间</th>
										<th style="display: none">更新者</th>
										<th style="display: none">更新时间</th>
										<th style="display: none">备注信息</th>
										<shiro:hasPermission name="lgt:ps:whProduce:edit"><th>操作</th></shiro:hasPermission>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${page.list }" var="whProduce" varStatus="status">
										<tr data-index="${status.index }">
											<td class="details-control text-center">
												<i class="fa fa-plus-square-o text-success"></i>
											</td>
											<td>
												${whProduce.warehouse.name }
											</td>
											<td><img onerror="imgOnerror(this);"  src="${imgHost }${whProduce.produce.goods.samplePhoto}" data-big data-src="${imgHost }${whProduce.produce.goods.samplePhoto}" width="21" height="21" /></td>
											<td>
												${whProduce.produce.code }
											</td>
											<c:set value="${whProduce.produce.goods.name  }${whProduce.produce.name }" var="name" />
											<td title="${name }">
												${fns:abbr(name, 20) }
											</td>
											<td class="zf-table-money">
												${whProduce.stockNormal }
											</td>
											<td class="zf-table-money">
												${whProduce.stockLock }
											</td>
											<td class="zf-table-money">
												${whProduce.stockDebt }
											</td>
											<td data-hide="true">
											   <c:choose>
											       <c:when test="${whProduce.motinorStatus eq '0' }">
											          <span class="label label-primary">${fns:getDictLabel(whProduce.motinorStatus,'lgt_ps_wh_produce_motinorStatus','') }</span>
											       </c:when>
											       <c:when test="${whProduce.motinorStatus eq '1' }">
											          <span class="label label-success">${fns:getDictLabel(whProduce.motinorStatus,'lgt_ps_wh_produce_motinorStatus','') }</span>
											       </c:when>
											       <c:when test="${whProduce.motinorStatus eq '2' }">
											          <span class="label label-default">${fns:getDictLabel(whProduce.motinorStatus,'lgt_ps_wh_produce_motinorStatus','') }</span>
											       </c:when>
											   </c:choose>
											</td>
											<td data-hide="true">
												${whProduce.stockStandard }
											</td>
											<td data-hide="true">
												${whProduce.stockSafe }
											</td>
											<td data-hide="true">
												${whProduce.stockWarning }
											</td>
											<td data-hide="true">
												<c:choose>
													<c:when test="${whProduce.stockNormal < whProduce.stockWarning}">
														<span class="label label-danger">报警</span>
													</c:when>
													<c:when test="${whProduce.stockNormal< whProduce.stockSafe}">
														<span class="label label-warning">预警</span>
													</c:when>
													<c:otherwise>
														<span class="label label-primary">正常</span>
													</c:otherwise>
												</c:choose>
											</td>
											<td data-hide="true">
												${fns:getUserById(whProduce.createBy.id).name }
											</td>
											<td data-hide="true">
												<fmt:formatDate value="${whProduce.createDate }" pattern="yyyy-MM-dd HH:mm:ss"/>
											</td>
											<td data-hide="true">
												${fns:getUserById(whProduce.updateBy.id).name }
											</td>
											<td data-hide="true">
												<fmt:formatDate value="${whProduce.updateDate }" pattern="yyyy-MM-dd HH:mm:ss"/>
											</td>
											<td data-hide="true">
												${whProduce.remarks}
											</td>
										  	<shiro:hasPermission name="lgt:ps:whProduce:edit">
												<td>
													<div class="btn-group zf-tableButton">
									                  	<button type="button" class="btn btn-xs btn-info" onclick="window.location.href='${ctx}/lgt/ps/whProduce/form?id=${whProduce.id}&produce.id=${whProduce.produce.id }'">修改</button>
									                  	<button type="button" class="btn btn-xs btn-info dropdown-toggle" data-toggle="dropdown">
									                    	<span class="caret"></span>
									                  	</button>
									                  	<ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
									                    	<c:choose>
										                  		<c:when test="${whProduce.motinorStatus == '1'}">
			    													<li><a href="#this" onclick="updateMotinorStatus('${ctx}/lgt/ps/whProduce/updateMotinorStatus','${whProduce.id}','${stockStatus }',${whProduce.stockStandard+whProduce.stockSafe+whProduce.stockWarning },'2','确定要停用监控吗？')">关闭</a></li>
										                  		</c:when>
										                  		<c:otherwise>
			    													<li><a href="#this" onclick="updateMotinorStatus('${ctx}/lgt/ps/whProduce/updateMotinorStatus','${whProduce.id}','${stockStatus }',${whProduce.stockStandard+whProduce.stockSafe+whProduce.stockWarning },'1','确定要启用监控吗？')">开启</a></li>
										                  		</c:otherwise>
										                  	</c:choose>
									                  	</ul>
									                </div>
												</td>
						                    </shiro:hasPermission>
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
<script>
  $(function () {
		// 缩略图展示
		ZF.bigImg();
		
		 //表格初始化
		ZF.parseTable("#contentTable", {
			"paging" : false,
			"lengthChange" : false,
			"searching" : false,
			"ordering" : false,
			"order": [[ 6, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
			"columnDefs":[
				{"orderable":false,targets:0},
				{"orderable":false,targets:1},
				{"orderable":false,targets:2},
				{"orderable":false,targets:3},
				{"orderable":false,targets:4},
				{"orderable":false,targets:5},
				{"orderable":false,targets:9},
				{"orderable":false,targets:16}
            ],
			"info" : false,
			"autoWidth" : false,
			"multiline" : true,//是否开启多行表格
			"isRowSelect" : false//是否开启行选中
		})


	});
</script>	
</body>
</html>