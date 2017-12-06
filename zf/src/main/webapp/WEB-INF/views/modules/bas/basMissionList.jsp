<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>我的所有审核列表</title>
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
	    <section class="content">
	    	<div class="box box-info">
	    		<div class="box-header with-border zf-query">
		          <h5>查询条件</h5>
		          <div class="box-tools pull-right">
		            <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
		            <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-remove"></i></button>
		          </div>
		        </div>
		        <sys:tip content="${message}"/>
			    <form:form id="searchForm" modelAttribute="basMission" action="${ctx}/bas/basMission/" method="post" class="form-horizontal">
			    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
				<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		        <div class="box-body">
		        	<div class="row">
		        		<div class="col-md-4">
		        			<div class="form-group">
			                  <label for="businessType" class="col-sm-3 control-label">任务类型</label>
			                  <div class="col-sm-7">
			                    <form:select path="businessType" class="form-control select2">
									<form:option value="" label="所有"/>
									<form:options items="${fns:getDictList('bas_mission_businessType')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
								</form:select>
			                  </div>
			                </div>
		        		</div>
		        		<div class="col-md-4">
		        			<div class="form-group">
			                  <label for="approveStatus" class="col-sm-3 control-label">审核状态</label>
			                  <div class="col-sm-7">
			                    <form:select path="approveStatus" class="form-control select2">
									<form:option value="" label="所有"/>
									<form:options items="${fns:getDictList('bas_mission_approveStatus')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
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
								<th>任务编号</th>
								<th>发起人</th>
								<th>任务类型</th>
								<th>审核状态</th>
								<th>发起时间</th>
								<th>要求完成时间</th>
								<th>延期次数</th>
								<th>完成时间</th>
								<th style="display: none">创建者</th>
								<th style="display: none">创建时间</th>
								<th style="display: none">更新者</th>
								<th style="display: none">更新时间</th>
								<th style="display: none">备注</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody>
						<c:forEach items="${page.list}" var="basMission" varStatus="status">
							<tr data-index="${status.index }">
								<td class="details-control text-center">
									<i class="fa fa-plus-square-o text-success"></i>
								</td>
								<td>${basMission.missionCode}</td>
								<td>
									${fns:getUserById(basMission.startBy.id).name} 
								</td>
								<td>
									<c:choose>
										<c:when test="${basMission.businessType eq '1'}">
											<span class="label label-info">${fns:getDictLabel(basMission.businessType, 'bas_mission_businessType', '')}</span>
										</c:when>
										<c:when test="${basMission.businessType eq '2'}">
											<span class="label label-danger">${fns:getDictLabel(basMission.businessType, 'bas_mission_businessType', '')}</span>
										</c:when>
									</c:choose>
								</td>
								<td>
									<c:choose>
										<c:when test="${basMission.approveStatus eq '1' }">
											<span class="label label-info">${fns:getDictLabel(basMission.approveStatus, 'bas_mission_approveStatus', '')}</span>
										</c:when>
										<c:when test="${basMission.approveStatus eq '2'}">
											<span class="label label-success">${fns:getDictLabel(basMission.approveStatus, 'bas_mission_approveStatus', '')}</span>
										</c:when>
										<c:when test="${basMission.approveStatus eq '3'}">
											<span class="label label-danger">${fns:getDictLabel(basMission.approveStatus, 'bas_mission_approveStatus', '')}</span>
										</c:when>
										<c:otherwise>
											<span class="label label-info">待审核</span>
										</c:otherwise>
									</c:choose>
								</td>
								<td>
									<fmt:formatDate value="${basMission.startTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
								</td>
								<td>
									<fmt:formatDate value="${basMission.limitTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
								</td>
								<td>
									${ basMission.delayCount}
								</td>
								<td>
									<fmt:formatDate value="${basMission.endTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
								</td>
								<td data-hide="true">
									${fns:getUserById(basMission.createBy.id).name }
								</td>
								<td data-hide="true">
									<fmt:formatDate value="${basMission.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
								</td>
								<td data-hide="true">
									${fns:getUserById(basMission.updateBy.id).name }
								</td>
								<td data-hide="true">
									<fmt:formatDate value="${basMission.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
								</td>
								<td data-hide="true">
									${basMission.remarks }
								</td>
								<td>
									<div class="btn-group zf-tableButton">
				                  		<button type="button" class="btn btn-xs btn-info" onclick="info('${basMission.id}',${basMission.businessType})">详情</button>
					                  	<button type="button" class="btn btn-xs btn-info dropdown-toggle" data-toggle="dropdown">
					                    	<span class="caret"></span>
					                  	</button>
					                    <shiro:hasPermission name="bas:basMission:edit">
					                    	<c:if test="${basMission.approveStatus eq '1' || basMission.approveStatus eq null}">
							                  	<ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
													<li><a href="#this" onclick="onSubmit('${basMission.id}','1')">通过</a></li>
													<li><a href="#this" onclick="onSubmit('${basMission.id}','2')">拒绝</a></li>
							                  	</ul>
						                  	</c:if>
					                    </shiro:hasPermission>
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
	<form:form name="infoForm" action="" modelAttribute="basMission" method="get" >
	<form:hidden id="infoId" path="id"/>
	</form:form>
<script type="text/javascript">
	 function info(id,type){
		 $("#infoId").val(id);
		 switch(type){
		 	case 1:
		 		infoForm.action="${ctx}/lgt/dp/dispatchMission/detailedAll";
		 		break;
		 	case 2:
		 		infoForm.action="";
		 		break;
		 	default:
		 		infoForm.action="";
		 }
		 infoForm.submit();
	 }
	
	 function onSubmit(id,type){
		 confirm("确定要提交该信息吗？", "info", function(){
			 	var dataList={"id":id,"type":type};
				var url="${ctx}/bas/basMission/check";
				ZF.ajaxQuery(true,url,dataList,function(data){
					if(data == "true"){
						$("#loading").hide();
						history.go(0);
						ZF.showTip("操作成功！", "info");
					}else{
						ZF.showTip("程序出错啦0_0！", "warning");
					}
					
				});
		 }, null);
	 }
	  $(function () {
		//表格初始化
		 	var t=ZF.parseTable("#contentTable",{
				"paging" : false,
				"lengthChange" : false,
				"searching" : false,//关闭搜索
				"order": [[ 5, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
				"columnDefs":[
                    {"orderable":false,targets:0},
                    {"orderable":false,targets:1},
					{"orderable":false,targets:2},
					{"orderable":false,targets:3},
					{"orderable":false,targets:4},
					{"orderable":false,targets:14}
	            ],
				"ordering" : true,//开启排序
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
	    
	  	//表格单选功能
	    $('#contentTable tbody').on( 'click', 'tr', function (){
	        if ($(this).hasClass('selected')) {
	            $(this).removeClass('selected');
	        }else{
	        	$('#contentTable tr.selected').removeClass('selected');
	            $(this).addClass('selected');
	        }
	    });
	  	
	  });
</script>
</body>
</html>