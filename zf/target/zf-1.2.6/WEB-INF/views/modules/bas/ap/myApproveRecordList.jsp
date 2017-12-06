<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>审核记录管理</title>
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
		<section class="content-header">
			
		</section>
		<sys:tip content="${message}"/>
		<section class="content">
			<form:form id="searchForm" modelAttribute="approveRecord" action="${ctx}/bas/ap/approveRecord" method="post" class="form-horizontal">
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
								<div class="form-group">
									<label for="searchParameter.keyWord" class="col-sm-3 control-label">关键字</label>
									<div class="col-sm-7">
										<form:input path="searchParameter.keyWord" placeholder="可输入任务编号查询" class="form-control"/>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-group">
									<label for="stockCategory" class="col-sm-3 control-label" >任务类型</label>
									<div class="col-sm-7">
										<form:select path="businessType" class="form-control select2">
											<form:option value="" label="所有"/>
											<form:options items="${fns:getDictList('bas_mission_businessType')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
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
				</div>
			</form:form>
			
			<div class="box box-soild">
				<div class="box-body">
					<div class="table-responsive">
						<table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
							<thead>
								<tr>
									<th class="zf-dataTables-multiline"></th>
									<th>任务编号</th>
									<th>任务类型</th>
									<th>审批前业务状态</th>
									<th>审批后业务状态</th>
									<th>审批前审批状态</th>
									<th>审批后审批状态</th>
									<th>审批备注</th>
									<th>审批时间</th>
									<th style="display: none">创建者</th>
									<th style="display: none">创建时间</th>
									<th style="display: none">更新者</th>
									<th style="display: none">备注</th>
									<shiro:hasPermission name="bas:ap:approveRecord:edit"><th>操作</th></shiro:hasPermission>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${page.list }" var="approveRecord" varStatus="status">
									<tr data-index="${status.index }">
										<td class="details-control text-center">
											<i class="fa fa-plus-square-o text-success"></i>
										</td>
										<td>
											${approveRecord.missionCode }
										</td>
										<td>
											${fns:getDictLabel(approveRecord.businessType,'bas_mission_businessType','') }
										</td>
										<td>
											${approveRecord.preBusinessStatus }
										</td>
										<td>
											${approveRecord.postBusinessStatus }
										</td>
										<td>
											${fns:getDictLabel(approveRecord.preApproveStatus, 'bas_mission_approveStatus', '')}
										</td>
										<td>
											${fns:getDictLabel(approveRecord.postApproveStatus, 'bas_mission_approveStatus', '')}
										</td>
										<td>
											${approveRecord.approveRemarks }
										</td>
										<td>
											<fmt:formatDate value="${approveRecord.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
										</td>
										<td data-hide="true">
											${fns:getUserById(approveRecord.createBy.id).name}
										</td>
										<td data-hide="true">
											<fmt:formatDate value="${approveRecord.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
										</td>
										<td data-hide="true">
											${fns:getUserById(approveRecord.updateBy.id).name}
										</td>
										<td data-hide="true">
											${fns:abbr(approveRecord.remarks, 15)}
										</td>
									  	<shiro:hasPermission name="bas:ap:approveRecord:edit">
											<td>
												<div class="btn-group zf-tableButton">
						                  				<button type="button" class="btn btn-xs btn-info" onclick="return ZF.delRow('确定要删除该记录吗','${ctx}/bas/ap/approveRecord/delete?id=${approveRecord.id }')">删除</button>
								                </div>
											</td>
					                  	</shiro:hasPermission>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			
		</section>
	</div>
	<script type="text/javascript">
		$(function(){
			 //表格初始化
		 	ZF.parseTable("#contentTable",{
				"paging" : false,
				"lengthChange" : false,
				"searching" : false,
				"order": [[ 8, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
				"columnDefs":[
					{"orderable":false,targets:0},
					{"orderable":false,targets:1},
					{"orderable":false,targets:2},
					{"orderable":false,targets:3},
					{"orderable":false,targets:4},
					{"orderable":false,targets:5},
					{"orderable":false,targets:6},
					{"orderable":false,targets:7},
					{"orderable":false,targets:13}
	            ],
				"ordering" : true,
				"info" : false,
				"autoWidth" : false,
				"multiline":true//是否开启多行表格
// 				"isRowSelect":true,//是否开启行选中
// 				"rowSelect":function(tr){productId = tr.attr("data-value");},
// 				"rowSelectCancel":function(tr){productId = null;}
			})
		});
	</script>
	
</body>
</html>