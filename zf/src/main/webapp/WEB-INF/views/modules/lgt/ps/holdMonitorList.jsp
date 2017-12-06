<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>货品持有监控管理</title>
	<meta name="decorator" content="adminLte"/>
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
				<small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/lgt/ps/holdMonitor/">货品持有监控列表</a></small>
		      </h1>	
		</section>
		<sys:tip content="${message}"/>
		<section class="content">
			<form:form id="searchForm" modelAttribute="holdMonitor" action="${ctx}/lgt/ps/holdMonitor/" method="post" class="form-horizontal">
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
									<label for="responsibleByBtn" class="col-sm-3 control-label">责任员工</label>
									<div class="col-sm-7">
										<input type="hidden" id="responsibleById" name="responsibleBy.id">
										<input id="responsibleByBtn" type="text" data-value="" value="" placeholder="按责任人查询" class="form-control zf-input-readonly" readonly="readonly"/>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-group">
									<label for="resourceType" class="col-sm-3 control-label">来源类型</label>
									<div class="col-sm-7">
										<form:select path="resourceType" class="input-medium">
											<form:option value="" label="所有"/>
											<form:options items="${fns:getDictList('lgt_ps_hold_monitor_resourceType')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
										</form:select>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-group">
									<label for="holdStatus" class="col-sm-3 control-label">持有状态</label>
									<div class="col-sm-7">
										<form:select path="holdStatus" class="input-medium">
											<form:option value="" label="所有"/>
											<form:options items="${fns:getDictList('lgt_ps_hold_monitor_holdStatus')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
										</form:select>
									</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-4">
								<div class="form-group">
									<label for="beginRegisterTime" class="col-sm-3 control-label">接收开始时间</label>
			        				<div class="col-sm-7">
			        					<sys:datetime id="beginReceiveTimeDiv" inputName="beginReceiveTime" tip="请选择接收开始时间" value="${holdMonitor.beginReceiveTime }" inputId="beginReceiveTime"></sys:datetime>
			        				</div>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-group">
									<label for="beginRegisterTime" class="col-sm-3 control-label">接收结束时间</label>
			        				<div class="col-sm-7">
			        					<sys:datetime id="endReceiveTimeDiv" inputName="endReceiveTime" tip="请选择收结束时间" value="${holdMonitor.endReceiveTime }" inputId="endReceiveTime"></sys:datetime>
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
					<div class="table-reponsive">
						<table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
							<thead>
								<tr>
									<th class="zf-dataTables-multiline"></th>
									<th>责任员工</th>
									<th>来源类型</th>
									<th>来源编号</th>
									<th>货品接收时间</th>
									<th>要求移交时间</th>
									<th>实际移交时间</th>
									<th>持货状态</th>
									<th>已持有时间</th>
									<th style="display: none;">创建者</th>
									<th style="display: none;">创建时间</th>
									<th style="display: none;">更新者</th>
									<th style="display: none;">更新时间</th>
									<th style="display: none;">备注</th>
									<shiro:hasPermission name="lgt:ps:lgtPsHoldMonitor:edit"><th>操作</th></shiro:hasPermission>
								</tr>
							</thead>
							<tbody>
							<c:forEach items="${page.list}" var="holdMonitor" varStatus="status">
								<tr data-index="${status.index }">
									<td class="details-control text-center">
										<i class="fa fa-plus-square-o text-success"></i>
									</td>
									<td>
										${fns:getUserById(holdMonitor.responsibleBy.id).name} 
									</td>
									<td>
										${fns:getDictLabel(holdMonitor.resourceType, 'lgt_ps_hold_monitor_resourceType', '')}
									</td>
									<td>
										${holdMonitor.resourceIdStr}
									</td>
									<td>
										<fmt:formatDate value="${holdMonitor.receiveTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>
									<td>
										<fmt:formatDate value="${holdMonitor.limitTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>
									<td>
										<fmt:formatDate value="${holdMonitor.devolveTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>
									<td>
										<c:choose>
											<c:when test="${ holdMonitor.holdStatus eq '1' }">
												<span class="label label-primary">${fns:getDictLabel(holdMonitor.holdStatus, 'lgt_ps_hold_monitor_holdStatus', '')}</span>
											</c:when>
											<c:when test="${ holdMonitor.holdStatus eq '2' }">
												<span class="label label-success">${fns:getDictLabel(holdMonitor.holdStatus, 'lgt_ps_hold_monitor_holdStatus', '')}</span>
											</c:when>
										</c:choose>
									</td>
									<td>
										<jsp:useBean id="nowTime" class="java.util.Date" />
					                    <c:set var="receiveTime" value="${holdMonitor.receiveTime}"/>
										<c:set var="holdTime" value="${nowTime.time-receiveTime.time}"/>
										
										<c:choose>
											<c:when test="${holdMonitor.holdStatus == '1'}">
												<fmt:formatNumber value="${holdTime/1000/60/60/24}" pattern="#0.0"/>天
											</c:when>
											<c:otherwise>
												0天
											</c:otherwise>
										</c:choose>
									</td>
									<td data-hide="true">
										${fns:getUserById(holdMonitor.createBy.id).name }
									</td>
									<td data-hide="true">
										<fmt:formatDate value="${holdMonitor.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>
									<td data-hide="true">
										${fns:getUserById(holdMonitor.updateBy.id).name }
									</td>
									<td data-hide="true">
										<fmt:formatDate value="${holdMonitor.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>
									<td data-hide="true">
										${holdMonitor.remarks}
									</td>
									<shiro:hasPermission name="lgt:ps:lgtPsHoldMonitor:edit">
										<td>
											<div class="btn-group zf-tableButton">
						                  		<button type="button" class="btn btn-xs btn-info" onclick="window.location.href='${ctx}/lgt/ps/holdMonitor/info?id=${holdMonitor.id}'">详情</button>
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
		
	 <sys:userselect id="responsibleBy" url="${ctx}/sys/office/userTreeData" isMulti="false" title="人员选择" height="550" width="550"></sys:userselect>
	</div>

<script>
	  $(function () {
		  //表格初始化
	 	var t=ZF.parseTable("#contentTable",{
			"paging" : false,
			"lengthChange" : false,
			"searching" : false,//关闭搜索
			"order": [[ 8, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
			"columnDefs":[
				{"orderable":false,targets:0},
				{"orderable":false,targets:1},
				{"orderable":false,targets:2},
				{"orderable":false,targets:3},
				{"orderable":false,targets:7},
				{"orderable":false,targets:14}
          ],
			"ordering" : true,//开启排序
			"info" : false,
			"autoWidth" : false,
			"multiline":true,//是否开启多行表格
			"isRowSelect":true,//是否开启行选中
			"rowSelect":function(tr){},//行选中回调
			"rowSelectCancel":function(tr){}//行取消选中回调
		});
	  	
	  	$("#responsibleByBtn").on("click",function(){
	  		responsibleByinit({
		   		"selectCallBack":function(list){
   					if(list.length>0){
   						$("#responsibleById").val(list[0].id);
   						$("#responsibleByBtn").val(list[0].text);
			   		}
				}
			});
	  	})
	  	
	  });
</script>

</body>
</html>