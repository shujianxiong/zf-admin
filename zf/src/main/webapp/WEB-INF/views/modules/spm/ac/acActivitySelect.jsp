<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>调研活动列表管理</title>
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
				<small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/spm/ac/acActivity/select">活动列表</a></small>
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
	
				<form:form id="searchForm" modelAttribute="acActivity" action="${ctx}/spm/ac/acActivity/select" method="post" class="form-horizontal">
					<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
					<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
					<div class="box-body">
						<div class="row">
							<div class="col-md-4">
								<div  class="form-group">
									<label for="keyWordId" class="col-sm-3 control-label">关键字</label>
									<div class="col-sm-7">
										<sys:inputverify name="searchParameter.keyWord" tip="请输入活动名称进行检索" verifyType="0" isMandatory="false" isSpring="true" id="keyWordId"></sys:inputverify>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div  class="form-group">
									<label for="activityTypeID" class="col-sm-3 control-label">活动类型</label>
									<div class="col-sm-7">
										<sys:selectverify name="activityType" tip="请选择活动类型" verifyType="0" isMandatory="false" dictName="SPM_AC_ACTIVITY_TYPE" id="activityTypeID"></sys:selectverify>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-group">
									<label for="beginRequiredTimeId" class="col-sm-3 control-label">开始起始时间</label>
									<div class="col-sm-7">
										<sys:datetime id="beginRequiredTimeId" inputName="beginRequiredTime" tip="请选择开始时间" inputId="beginRequiredTime" value="${acActivity.beginRequiredTime }"></sys:datetime>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div  class="form-group">
									<label for="endRequiredTimeId" class="col-sm-3 control-label">开始结束时间</label>
									<div class="col-sm-7">
										<sys:datetime id="endRequiredTimeId" inputName="endRequiredTime" tip="请选择结束时间" inputId="endRequiredTime"  value="${acActivity.endRequiredTime }"></sys:datetime>
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
									<th></th>
									<th>活动名称</th>
									<th>活动类型</th>
									<!-- <th>活动标题</th> -->
									<!-- <th>活动副标题</th> -->
									<th>分享小图</th>
<!-- 									<th>分享中图</th> -->
<!-- 									<th>简介</th> -->
<!-- 									<th>介绍</th> -->
									<!-- <th>规则详情</th> -->
									<th>奖励积分</th>
									<th>开始时间</th>
									<th>结束时间</th>
<!-- 									<th>启用状态</th> -->
									<th>奖品</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${page.list}" var="acActivity">
									<tr>
										<td>
											<div class="zf-check-wrapper-padding">
												<input type="radio" name="chkItem" value="${acActivity.id }" data-name="${acActivity.name }"/>
											</div>
										</td>
										<td title="${acActivity.name}">
												${fns:abbr(acActivity.name, 30)}
										</td>
										<td>
											${fns:getDictLabel(acActivity.activityType,'SPM_AC_ACTIVITY_TYPE','')}
										</td>
										<%-- <td title="${acActivity.title}">${fns:abbr(acActivity.title, 30) }</td> --%>
										<%-- <td title="${acActivity.subtitle}">${fns:abbr(acActivity.subtitle, 30) }</td> --%>
										<td>
											<img onerror="imgOnerror(this);"  src="${imgHost }${acActivity.shareSPhoto}" data-big data-src="${imgHost }${acActivity.shareSPhoto}" style="width:20px;height:20px;">
										</td>
										<%-- <td>
											<img src="${imgHost }${acActivity.shareMPhoto}" data-big data-src="${imgHost }${acActivity.shareMPhoto}" style="width:20px;height:20px;">
										</td>
										<td title="${acActivity.summary}">
											${fns:abbr(acActivity.summary, 30) }
										</td>
										<td title="${acActivity.introduce}">
											${fns:abbr(acActivity.introduce, 30)}
										</td> --%>
										<%-- <td title="${acActivity.ruleDetail}">
											${fns:abbr(acActivity.ruleDetail, 30) }
										</td> --%>
										<td title="${acActivity.rewardPoint}">
											${fns:abbr(acActivity.rewardPoint, 30) }
										</td>
										<td>
											<fmt:formatDate value="${acActivity.startTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
										</td>
										<td>
											<fmt:formatDate value="${acActivity.endTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
										</td>
										<%-- <td>
											<c:choose>
												<c:when test="${acActivity.activeFlag eq '0'}">
													<span class="label label-primary">${fns:getDictLabel(acActivity.activeFlag, 'yes_no', '')}</span>
												</c:when>
												<c:when test="${acActivity.activeFlag eq '1'}">
													<span class="label label-success">${fns:getDictLabel(acActivity.activeFlag, 'yes_no', '')}</span>
												</c:when>
											</c:choose>
										</td> --%>
										<td>
											${acActivity.rewardPrize.name }
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
		
		$('input').iCheck({
			checkboxClass : 'icheckbox_minimal-blue',
			radioClass : 'iradio_minimal-blue'
		});
		
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
				{"orderable":false,targets:7}
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