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
				<small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/spm/ac/activityResearch/list">活动列表</a></small>
				
				<shiro:hasPermission name="spm:ac:activityResearch:edit"><small>|</small><small><i class="fa-form-edit"></i><a href="${ctx}/spm/ac/activityResearch/form">活动${not empty acActivity.id?'修改':'添加'}</a></small></shiro:hasPermission>
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
	
				<form:form id="searchForm" modelAttribute="activityResearch" action="${ctx}/spm/ac/activityResearch/list" method="post" class="form-horizontal">
					<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
					<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
					<input id="id" name="id" type="hidden" value="${activityResearch.id }"/>
					<input type="hidden" name="activity.id" value="${activityResearch.activity.id }"/>
					<%-- <input type="hidden" name="activity.activeFlag" value="${activityResearch.activity.activeFlag }"/> --%>
					<div class="box-body">
						<div class="row">
							<div class="col-md-4">
								<div  class="form-group">
									<label for="keyWordId" class="col-sm-3 control-label">关键字</label>
									<div class="col-sm-7">
										<sys:inputverify name="searchParameter.keyWord" tip="请输入活动名称或者标题进行检索" verifyType="0" isMandatory="false" isSpring="true" id="keyWordId"></sys:inputverify>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div  class="form-group">
									<label for="activityTypeID" class="col-sm-3 control-label">活动类型</label>
									<div class="col-sm-7">
										<sys:selectverify name="activity.activityType" tip="请选择活动类型" verifyType="0" isMandatory="false" dictName="SPM_AC_ACTIVITY_TYPE" id="activityTypeID"></sys:selectverify>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div  class="form-group">
									<label for="activeFlagId" class="col-sm-3 control-label">启用状态</label>
									<div class="col-sm-7">
										<sys:selectverify name="activity.activeFlag" tip="请选择启用状态" verifyType="0" isMandatory="false" dictName="yes_no" id="activeFlagId"></sys:selectverify>
									</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-4">
								<div class="form-group">
									<label for="beginRequiredTimeId" class="col-sm-3 control-label">开始时间</label>
									<div class="col-sm-7">
										<sys:datetime id="beginRequiredTimeId" inputName="activity.beginRequiredTime" tip="请选择开始时间" value="${activityResearch.activity.beginRequiredTime }" inputId="beginRequiredTime"></sys:datetime>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div  class="form-group">
									<label for="endRequiredTimeId" class="col-sm-3 control-label">结束时间</label>
									<div class="col-sm-7">
										<sys:datetime id="endRequiredTimeId" inputName="activity.endRequiredTime" tip="请选择结束时间" value="${activityResearch.activity.endRequiredTime }" inputId="endRequiredTime"></sys:datetime>
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
									<th>活动名称</th>
									<th>活动标题</th>
									<th>活动类型</th>
									<th>活动模板</th>
									<!-- <th>活动副标题</th> -->
									<th>分享小图</th>
<!-- 									<th>分享中图</th> -->
									<!-- <th style="display:none;">简介</th>
									<th style="display:none;">介绍</th>
									<th style="display:none;">规则详情</th> -->
									<th>奖励积分</th>
									<th>开始时间</th>
									<th>结束时间</th>
									<th>启用状态</th>
									<th>奖品</th>
									<th style="display:none;">创建者</th>
									<th style="display:none;">创建时间</th>
									<th style="display:none;">更新者</th>
									<th style="display:none;">更新时间</th>
									<!-- <th style="display:none;">备注信息</th> -->
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${page.list}" var="activityResearch" varStatus="status">
									<tr data-index="${status.index }">
										<td class="details-control text-center">
											<i class="fa fa-plus-square-o text-success"></i>
										</td>
										<td title="${activityResearch.activity.name}">
												${fns:abbr(activityResearch.activity.name, 30)}
										</td>
										 <td title="${acActivity.title }">${fns:abbr(activityResearch.activity.title, 30) }</td>
										<td>
											${fns:getDictLabel(activityResearch.activity.activityType,'SPM_AC_ACTIVITY_TYPE','')}
										</td>
										<td title="${activityResearch.activity.acActivityTemplate.name }">${fns:abbr(activityResearch.activity.acActivityTemplate.name, 30) }</td>
										
										<%--<td title="${acActivity.subtitle }">${fns:abbr(acActivity.subtitle, 30) }</td> --%>
										<td>
											<img onerror="imgOnerror(this);"  src="${imgHost }${fn:replace(activityResearch.activity.shareSPhoto, '|', '')}" data-big data-src="${imgHost }${fn:replace(activityResearch.activity.shareSPhoto, '|', '')}" style="width:20px;height:20px;">
										</td>
<!-- 										<td> -->
<%-- 											<img src="${imgHost }${acActivity.shareMPhoto}" data-big data-src="${imgHost }${acActivity.shareMPhoto}" style="width:20px;height:20px;"> --%>
<!-- 										</td> -->
										<%-- <td title="${acActivity.summary }" data-hide="true">
											${fns:abbr(acActivity.summary, 30) }
										</td>
										<td title="${acActivity.introduce}" data-hide="true">
											${fns:abbr(acActivity.introduce, 30)}
										</td>
										<td title="${acActivity.ruleDetail }" data-hide="true">
											${fns:abbr(acActivity.ruleDetail, 30) }
										</td> --%>
										<td>
											${activityResearch.activity.rewardPoint }
										</td>
										<td>
											<fmt:formatDate value="${activityResearch.activity.startTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
										</td>
										<td>
											<fmt:formatDate value="${activityResearch.activity.endTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
										</td>
										<td>
											<c:choose>
												<c:when test="${activityResearch.activity.activeFlag eq '0'}">
													<span class="label label-primary">${fns:getDictLabel(activityResearch.activity.activeFlag, 'yes_no', '')}</span>
												</c:when>
												<c:when test="${activityResearch.activity.activeFlag eq '1'}">
													<span class="label label-success">${fns:getDictLabel(activityResearch.activity.activeFlag, 'yes_no', '')}</span>
												</c:when>
											</c:choose>
										</td>
										<td>
											${activityResearch.activity.rewardPrize.name }
										</td>
										<td data-hide="true">
											${fns:getUserById(activityResearch.activity.createBy.id).name}
										</td>
										<td data-hide="true">
											<fmt:formatDate value="${activityResearch.activity.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
										</td>
										<td data-hide="true">
											${fns:getUserById(activityResearch.activity.updateBy.id).name}
										</td>
										<td data-hide="true">
											<fmt:formatDate value="${activityResearch.activity.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
										</td>
										<%-- <td  data-hide="true">
											${acActivity.remarks }
										</td> --%>
										<td>
											 <shiro:hasPermission name="spm:ac:activityResearch:edit">
												<div class="btn-group zf-tableButton">
								                  	<button type="button" class="btn btn-sm btn-info" onclick="window.location.href='${ctx}/spm/ac/activityResearch/form?id=${activityResearch.id}'">修改</button>
								                  	<button type="button" class="btn btn-sm btn-info dropdown-toggle" data-toggle="dropdown">
								                    	<span class="caret"></span>
									                </button>
								                  	<ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
								                  	<c:choose>
								                  		<c:when test="${activityResearch.activity.activeFlag eq '1' }">
										                  	<li><a href="#this" data-href="${ctx}/spm/ac/activityResearch/updateStatus" data-message="确定要停用吗？" data-json="{'activity.id':'${activityResearch.activity.id }','activity.activeFlag':'0'}" onclick="return ZF.xconfirm(this);">停用</a></li>
								                  		</c:when>
								                  		<c:when test="${activityResearch.activity.activeFlag eq '0' }">
								                  			<li><a href="#this" data-href="${ctx}/spm/ac/activityResearch/updateStatus" data-message="确定要启用吗？" data-json="{'activity.id':'${activityResearch.activity.id }','activity.activeFlag':'1'}"  onclick="return ZF.xconfirm(this);">启用</a></li>
								                  		</c:when>
								                  	</c:choose>
									                <li><a href="#this" data-href="${ctx}/spm/ac/activityResearch/delete" data-message="确定要删除该活动吗？" data-json="{'id':'${activityResearch.id }'}" onclick="return ZF.xconfirm(this);">删除</a></li>
								                  	<li><a href="${ctx}/spm/ac/activityResearch/info?id=${activityResearch.id}" >详情</a></li>
												  	</ul>
												</div>
								            </shiro:hasPermission>
								            <shiro:lacksPermission name="spm:ac:activityResearch:edit">
								            	<div class="btn-group zf-tableButton">
								                  	<button type="button" class="btn btn-sm btn-info" onclick="window.location.href='${ctx}/spm/ac/activityResearch/info?id=${activityResearch.id}'">详情</button>
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
			"order": [[ 6, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
			"columnDefs":[
				{"orderable":false,targets:0},
				{"orderable":false,targets:1},
				{"orderable":false,targets:2},
				{"orderable":false,targets:3},
				{"orderable":false,targets:4},
				{"orderable":false,targets:5},
				{"orderable":false,targets:9},
				{"orderable":false,targets:10},
				{"orderable":false,targets:14},
				{"orderable":false,targets:15}
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