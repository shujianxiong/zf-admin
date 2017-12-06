<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>我的盘点任务</title>
	<meta name="decorator" content="adminLte"/>
	<style type="text/css">
		tr{ 
		    cursor: pointer;    /*手形*/   
		} 
	</style>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>

	<div class="content-wrapper sub-content-wrapper">
		<section class="content-header content-header-menu">
			<h1>
		        <small class="menu-active">
		        	<i class="fa fa-repeat"></i><a href="${ctx}/lgt/ip/inventoryMissionExe">我的盘点任务</a>
		        </small>
	      	</h1>
		</section>
		
		<sys:tip content="${message}"/>
		
		<section class="content">
			<form:form id="searchForm" modelAttribute="inventoryMission" action="${ctx}/lgt/ip/inventoryMissionExe/" method="post" class="form-horizontal">
			<input id="inventoryMissionId" name="inventoryMissionId" type="hidden"/>
			<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
			<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
			<div class="box box-info">
				<div class="box-header with-border zf-query">
					<h5>查询条件</h5>
					<div class="box-tools pull-right">
						<button type="button" class="btn btn-box-tool"data-widget="collapse"><i class="fa fa-minus"></i></button>
						<button type="button" class="btn btn-box-tool"data-widget="remove"><i class="fa fa-remove"></i></button>
					</div>
				</div>
				<div class="box-body">
					<div class="row">
						<div class="col-md-4">
							<div class="form-group">
								<label for="code" class="col-sm-3 control-label" >批次编号</label>
								<div class="col-sm-7">
									<form:input id="batchNo" path="batchNo" htmlEscape="false" maxlength="64" class="form-control"  placeholder="批次编号"/>
								</div>
							</div>
						</div>
						<div class="col-md-4">
							<div class="form-group">
								<label for="code" class="col-sm-3 control-label" >盘点类型</label>
								<div class="col-sm-7">
									<form:select path="type" htmlEscape="false" maxlength="50" class="form-control select2">
									<form:option label="所有" value="" />
									<form:options items="${fns:getDictList('lgt_ip_inventory_mission_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
								</form:select>
								</div>
							</div>
						</div>
						<!-- 
						<div class="col-md-4">
							<div class="form-group">
								<label for="code" class="col-sm-3 control-label" >盘点方式</label>
								<div class="col-sm-7">
									<form:select path="style" htmlEscape="false" maxlength="50" class="form-control select2">
										<form:option label="所有" value="" />
										<form:options items="${fns:getDictList('lgt_ip_inventory_mission_style')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
									</form:select>
								</div>
							</div>
						</div> -->
						<div class="col-md-4">
							<div class="form-group">
								<label for="code" class="col-sm-3 control-label" >盘点状态</label>
								<div class="col-sm-7">
									<form:select path="status" htmlEscape="false" maxlength="50" class="form-control select2">
										<form:option label="所有" value="" />
										<form:options items="${fns:getDictList('lgt_ip_inventory_mission_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
									</form:select>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="box-footer">
					<div class="pull-right box-tools">
		        		<button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh">重置</i></button>
	               		<button type="submit" class="btn btn-info btn-sm"><i class="fa fa-search">查询</i></button>
		        	</div>
				</div>
			</div>
			</form:form>
			<div class="box box-soild">
				<div class="box-body">
<!-- 					<div class="row"> -->
<!-- 						<div class="col-sm-12 pull-right"> -->
<!-- 				          	<button type="button" class="btn btn-sm btn-default" onclick="view()"><i class="fa fa-eye">详情</i></button> -->
<!-- 						</div> -->
<!-- 					</div> -->
					<table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
						<thead>
							<tr>
								<th class="zf-dataTables-multiline"></th>
								<th>盘点批次编号</th>
								<th>盘点仓库</th>
								<th>盘点类型</th>
								<th>盘点方式</th>
								<th>盘点状态</th>
								<th>盘点起始时间</th>
								<th>盘点结束时间</th>
								<th>盘点结果</th>
								<th style="display:none">创建者</th>
								<th style="display:none">创建时间</th>
								<th style="display:none">更新者</th>
								<th style="display:none">更新时间</th>
								<th>备注信息</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${page.list}" var="inventoryMission" varStatus="status">
							<tr data-index="${status.index }">
								<td class="details-control text-center">
									<i class="fa fa-plus-square-o text-success"></i>
								</td>
								<td>
									${inventoryMission.batchNo }
								</td>
								<td>
									${inventoryMission.warehouse.name}
								</td>
								<td>
									<c:choose>
										<c:when test="${inventoryMission.type == 1 }">
											<span class="label label-primary"> ${fns:getDictLabel(inventoryMission.type,'lgt_ip_inventory_mission_type','') }</span>
										</c:when>
										<c:otherwise>
											<span class="label label-info"> ${fns:getDictLabel(inventoryMission.type,'lgt_ip_inventory_mission_type','') }</span>
										</c:otherwise>
									</c:choose>
								</td>
								<td>
									${fns:getDictLabel(inventoryMission.style,'lgt_ip_inventory_mission_style','') }
								</td>
								<td>
									<c:choose>
										<c:when test="${inventoryMission.status == 1 }">
											<span class="label label-default"> ${fns:getDictLabel(inventoryMission.status,'lgt_ip_inventory_mission_status','') }</span>
										</c:when>
										<c:when test="${inventoryMission.status == 2 }">
											<span class="label label-success"> ${fns:getDictLabel(inventoryMission.status,'lgt_ip_inventory_mission_status','') }</span>
										</c:when>
										<c:when test="${inventoryMission.status == 3 }">
											<span class="label label-primary"> ${fns:getDictLabel(inventoryMission.status,'lgt_ip_inventory_mission_status','') }</span>
										</c:when>
										<c:otherwise>
											<span class="label label-info"> ${fns:getDictLabel(inventoryMission.status,'lgt_ip_inventory_mission_status','') }</span>
										</c:otherwise>
									</c:choose>
								</td>
								<td>
									<fmt:formatDate value="${inventoryMission.startTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
								</td>
								<td>
									<fmt:formatDate value="${inventoryMission.endTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
								</td>
								<td>
								    <c:choose>
                                        <c:when test="${inventoryMission.resultType == 1 }">
                                            <span class="label label-success">${fns:getDictLabel(inventoryMission.resultType,'lgt_ip_inventory_mission_resultType','') }</span>
                                        </c:when>
                                        <c:when test="${inventoryMission.resultType == 2 }">
                                            <span class="label label-danger">${fns:getDictLabel(inventoryMission.resultType,'lgt_ip_inventory_mission_resultType','') }</span>
                                        </c:when>
                                    </c:choose>
									
								</td>
								<td data-hide="true">
									${fns:getUserById(inventoryMission.createBy.id).name}
								</td>
								<td data-hide="true">
									<fmt:formatDate value="${inventoryMission.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
								</td>
								<td data-hide="true">
									${fns:getUserById(inventoryMission.updateBy.id).name}
								</td>
								<td data-hide="true"> 
									<fmt:formatDate value="${inventoryMission.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
								</td>
								<td title="${inventoryMission.remarks}">
									${fns:abbr(inventoryMission.remarks,15)}
								</td>
								<td>
									<div class="btn-group zf-tableButton">
										<button type="button" class="btn btn-sm btn-info" onclick="infoMission('${inventoryMission.id}')">详情</button>
										<button type="button" class="btn btn-sm btn-info dropdown-toggle" data-toggle="dropdown">
						                   <span class="caret"></span>
						                </button>
										<c:if test="${inventoryMission.status==2 }">
											<shiro:hasPermission name="lgt:ip:inventoryMissionExe:edit">
							                <ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
							                    <li><a href="#this" onclick="exeMission('${inventoryMission.id}')" style="color:#fff">盘点</a></li>
							                </ul>
							                </shiro:hasPermission>
										</c:if>
									</div>
								</td>
							</tr>
							</c:forEach>
						</tbody>
					</table>
					<div class="box-footer">
			        	<div class="dataTables_paginate paging_simple_numbers">${page}</div>
		            </div>
				</div>
			</div>
		</section>
	</div>
	
	<script>
		$(function () {
			 //表格初始化
			ZF.parseTable("#contentTable",{
				"paging" : false,
				"lengthChange" : false,
				"searching" : false,				// 关闭搜索
				"order": [[ 6, "desc" ]],			// 指定默认初始化按第几列排序，默认排序升序，降序
				"columnDefs":[
					{"orderable":false,targets:0},	//第0列和第12列不排序
					{"orderable":false,targets:1},
					{"orderable":false,targets:2},
					{"orderable":false,targets:3},
					{"orderable":false,targets:4},
					{"orderable":false,targets:5},
					{"orderable":false,targets:8},
					{"orderable":false,targets:9},
					{"orderable":false,targets:10},
					{"orderable":false,targets:11},
					{"orderable":false,targets:12},
					{"orderable":false,targets:13},
					{"orderable":false,targets:14}
		       ],
				"ordering" : true,					// 开启排序
				"info" : false,
				"autoWidth" : false,
				"multiline":true,					// 是否开启多行表格
				"isRowSelect":true,					// 是否开启行选中
				"rowSelect":function(tr){},			// 行选中回调
				"rowSelectCancel":function(tr){}	//行取消选中回调
			});
		});
	  
		// 预览
		function infoMission(id){
			window.location.href="${ctx}/lgt/ip/inventoryMissionExe/info?id="+id;
		}
		// 盘点
		function exeMission(id){
			window.location.href = "${ctx}/lgt/ip/inventoryMissionExe/form?id="+id;
		}
	</script>
</body>
</html>