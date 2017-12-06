<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>奖品领取列表管理</title>
	<meta name="decorator" content="adminLte"/>
	<script type="text/javascript">
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
		<section  class="content-header content-header-menu">
			<h1>
				<small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/spm/pr/prizeRecord/list">奖品领取记录列表</a></small>
				
				<shiro:hasPermission name="spm:pr:prizeRecord:edit"><small>|</small><small><i class="fa-form-edit"></i><a href="${ctx}/spm/pr/prizeRecord/form">奖品领取记录${not empty prizeRecord.id?'修改':'添加'}</a></small></shiro:hasPermission>
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
	
				<form:form id="searchForm" modelAttribute="prizeRecord" action="${ctx}/spm/pr/prizeRecord/list" method="post" class="form-horizontal">
					<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
					<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
					<input id="id" name="id" type="hidden"/>
					<input id="prizeId" name="prize.id" type="hidden"/>
					<div class="box-body">
						<div class="row">
							<div class="col-md-4">
								<div  class="form-group">
									<label for="name" class="col-sm-3 control-label">领取原因</label>
									<div class="col-sm-7">
										<sys:selectverify name="reasonType" tip="请选择领取原因" verifyType="0" dictName="SPM_PR_PRIZE_RECORD_REASON_TYPE" id="reasonType" isMandatory="false"></sys:selectverify>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div  class="form-group">
									<label for="name" class="col-sm-3 control-label">领取状态</label>
									<div class="col-sm-7">
										<sys:selectverify name="receiveStatus" tip="请选择领取状态" verifyType="0" dictName="SPM_PR_PRIZE_RECORD_RECEIVE_STATUS" id="receiveStatus" isMandatory="false"></sys:selectverify>
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
									<th>会员</th>
									<th>奖品</th>
									<th>领取原因</th>
									<th>领取时间</th>
									<th>领取状态</th>
									<th style="display:none;">创建者</th>
									<th style="display:none;">创建时间</th>
									<th style="display:none;">更新者</th>
									<th style="display:none;">更新时间</th>
									<th style="display:none;">备注信息</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${page.list}" var="prizeRecord" varStatus="status">
									<tr data-index="${status.index }">
										<td class="details-control text-center">
											<i class="fa fa-plus-square-o text-success"></i>
										</td>
										<td>
											${prizeRecord.member.usercode }
										</td>
										<td>
											${prizeRecord.prize.name}
										</td>
										<td>
											${fns:getDictLabel(prizeRecord.reasonType, 'SPM_PR_PRIZE_RECORD_REASON_TYPE', '') }
										</td>
										<td>
											<fmt:formatDate value="${prizeRecord.receiveTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
										</td>
										<td>
											<c:choose>
												<c:when test="${prizeRecord.receiveStatus eq '1'}">
													<span class="label label-success">${fns:getDictLabel(prizeRecord.receiveStatus, 'SPM_PR_PRIZE_RECORD_RECEIVE_STATUS', '')  }</span>
												</c:when>
												<c:when test="${prizeRecord.receiveStatus eq '0'}">
													<span class="label label-primary">${fns:getDictLabel(prizeRecord.receiveStatus, 'SPM_PR_PRIZE_RECORD_RECEIVE_STATUS', '')  }</span>
												</c:when>
											</c:choose>
											
										</td>
										<td data-hide="true">
											${fns:getUserById(prizeRecord.createBy.id).name}
										</td>
										<td data-hide="true">
											<fmt:formatDate value="${prizeRecord.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
										</td>
										<td data-hide="true">
											${fns:getUserById(prizeRecord.updateBy.id).name}
										</td>
										<td data-hide="true">
											<fmt:formatDate value="${prizeRecord.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
										</td>
										<td  data-hide="true">
											${prizeRecord.remarks }
										</td>
										<td>
											 <shiro:hasPermission name="spm:pr:prizeRecord:edit">
												<div class="btn-group zf-tableButton">
								                  	<button type="button" class="btn btn-sm btn-info" onclick="window.location.href='${ctx}/spm/pr/prizeRecord/info?id=${prizeRecord.id}'">详情</button>
								                  	<button type="button" class="btn btn-sm btn-info dropdown-toggle" data-toggle="dropdown">
								                    	<span class="caret"></span>
									                </button>
								                  	<c:if test="${prizeRecord.receiveStatus eq '0' }">
									                  	<ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
									                  		<li><a href="#this" data-href="${ctx}/spm/pr/prizeRecord/form" data-message="" data-json="{'id':'${prizeRecord.id}'}" onclick="return ZF.xconfirm(this);">修改</a></li>
									                  		<li><a href="#this" data-href="${ctx}/spm/pr/prizeRecord/changeFlag" data-message="确定领取该奖品?" data-json="{'id':'${prizeRecord.id}','prize.id':'${prizeRecord.prize.id }'}" onclick="return ZF.xconfirm(this);">领取</a></li>
										                <%-- <li><a href="${ctx}/spm/pr/prizeRecord/delete?id=${prizeRecord.id}" style="color:#fff" onclick="return ZF.delRow('确定要删除该奖品领取记录吗？',this.href)">删除</a></li> --%>
									                  	<%-- <li><a href="${ctx}/spm/pr/prizeRecord/info?id=${prizeRecord.id}">详情</a></li> --%>
													  	</ul>
								                  	</c:if>
												</div>
								            </shiro:hasPermission>
								            <shiro:lacksPermission name="spm:pr:prizeRecord:edit">
								            	<div class="btn-group zf-tableButton">
								                  	<button type="button" class="btn btn-sm btn-info" onclick="window.location.href='${ctx}/spm/pr/prizeRecord/info?id=${prizeRecord.id}'">详情</button>
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
		//表格初始化
	 	var t=ZF.parseTable("#contentTable",{
			"paging" : false,
			"lengthChange" : false,
			"searching" : false,//关闭搜索
			"order": [[ 4, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
			"columnDefs":[
				{"orderable":false,targets:0},
				{"orderable":false,targets:1},
				{"orderable":false,targets:2},
				{"orderable":false,targets:3},
				{"orderable":false,targets:5},
				{"orderable":false,targets:6},
				{"orderable":false,targets:7},
				{"orderable":false,targets:8},
				{"orderable":false,targets:9},
				{"orderable":false,targets:10},
				{"orderable":false,targets:11}
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
	});
	</script>
</body>
</html>