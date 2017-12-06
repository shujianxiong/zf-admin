<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>自动回复列表管理</title>
	<meta name="decorator" content="adminLte"/>
</head>
<body>
<div class="content-wrapper sub-content-wrapper">
		<section  class="content-header content-header-menu">
			<h1>
				<small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/wcp/ar/autoReply/list">自动回复列表</a></small>
				
				<shiro:hasPermission name="wcp:ar:autoReply:edit"><small>|</small><small><i class="fa-form-edit"></i><a href="${ctx}/wcp/ar/autoReply/form">自动回复${not empty autoReply.id?'修改':'添加'}</a></small></shiro:hasPermission>
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
	
				<form:form id="searchForm" modelAttribute="autoReply" action="${ctx}/wcp/ar/autoReply/list" method="post" class="form-horizontal">
					<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
					<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
					<input id="id" name="id" type="hidden"/>
					<div class="box-body">
						<div class="row">
							<div class="col-md-4">
								<div  class="form-group">
									<label for="keyWordId" class="col-sm-3 control-label">关键字</label>
									<div class="col-sm-7">
										<sys:inputverify name="keywords" tip="请输入关键字进行检索" verifyType="0" isMandatory="false" isSpring="true" id="keywords"></sys:inputverify>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div  class="form-group">
									<label for="activeFlagId" class="col-sm-3 control-label">启用状态</label>
									<div class="col-sm-7">
										<sys:selectverify name="activeFlag" tip="请选择启用状态" verifyType="0" isMandatory="false" dictName="yes_no" id="activeFlagId"></sys:selectverify>
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
									<th>规则名称</th>
									<th>规则代码</th>
									<th>关键字</th>
									<th>类型</th>
									<th>内容</th>
									<!-- <th>文字</th>
									<th>图片</th>
									<th>音频</th>
									<th>视频</th> -->
									<th>所属公众号</th>
									<th>启用状态</th>
									<th>排列序号</th>
									<th style="display:none;">创建者</th>
									<th style="display:none;">创建时间</th>
									<th style="display:none;">更新者</th>
									<th style="display:none;">更新时间</th>
									<th style="display:none;">备注信息</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${page.list}" var="autoReply" varStatus="status">
									<tr data-index="${status.index }">
										<td class="details-control text-center">
											<i class="fa fa-plus-square-o text-success"></i>
										</td>
										<td title="${autoReply.name}">
											${fns:abbr(autoReply.name, 30)}
										</td>
										<td title="${autoReply.code}">
											${fns:abbr(autoReply.code, 30)}
										</td>
										<td  title="${autoReply.keywords}">
											${fns:abbr(autoReply.keywords, 30) }
										</td>
										<td>
											${fns:getDictLabel(autoReply.contentType, 'wcp_ar_auto_reply_contentType', '') }
										</td>
										<c:choose>
											<c:when test="${autoReply.contentType eq 'text' }">
												<td title="${autoReply.text}">	
													${fns:abbr(autoReply.text, 30)}
												</td>
											</c:when>
											<c:when test="${autoReply.contentType eq 'img' }">
												<td>
													${autoReply.image }
												</td>
											</c:when>
											<c:when test="${autoReply.contentType eq 'voice' }">
												<td>
													${autoReply.voice }
												</td>
											</c:when>
											<c:when test="${autoReply.contentType eq 'video' }">
												<td>
													${autoReply.video }  
												</td>
											</c:when>
											<c:when test="${autoReply.contentType eq 'news' }">
												<td>
													<c:forEach items="${autoReply.replyArticleList }" var="ra">
														${ra.articleMsg.name }
														<%-- <a herf="${ra.articleMsg.linkUrl }">${ra.articleMsg.name }</a><br/> --%>
													</c:forEach>
												</td>
											</c:when>
											<c:when test="${autoReply.contentType eq 'undefined' }">
													<td>无</td>
											</c:when>
										</c:choose>
										<%-- <td>
											${autoReply.textMsg }
										</td>
										<td>
											<img src="${imgHost }${fn:replace(autoReply.imageMsg, '|', '')}" data-big data-src="${imgHost }${fn:replace(autoReply.imageMsg, '|', '')}" style="width:20px;height:20px;">
										</td>
										<td>
											<img src="${imgHost }${fn:replace(autoReply.voice, '|', '')}" data-big data-src="${imgHost }${fn:replace(autoReply.voice, '|', '')}" style="width:20px;height:20px;">
										</td>
										<td>
											<img src="${imgHost }${fn:replace(autoReply.video, '|', '')}" data-big data-src="${imgHost }${fn:replace(autoReply.video, '|', '')}" style="width:20px;height:20px;">
										</td> --%>
										<td>
												${fns:getDictLabel(autoReply.mp, 'mp_type', '') }
										</td>
										<td>
											<c:choose>
												<c:when test="${autoReply.activeFlag eq '0'}">
													<span class="label label-primary">${fns:getDictLabel(autoReply.activeFlag, 'yes_no', '')}</span>
												</c:when>
												<c:when test="${autoReply.activeFlag eq '1'}">
													<span class="label label-success">${fns:getDictLabel(autoReply.activeFlag, 'yes_no', '')}</span>
												</c:when>
											</c:choose>
										</td>
										<td>${autoReply.orderNo }</td>
										<td data-hide="true">
											${fns:getUserById(autoReply.createBy.id).name}
										</td>
										<td data-hide="true">
											<fmt:formatDate value="${autoReply.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
										</td>
										<td data-hide="true">
											${fns:getUserById(autoReply.updateBy.id).name}
										</td>
										<td data-hide="true">
											<fmt:formatDate value="${autoReply.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
										</td>
										<td  data-hide="true">
											${autoReply.remarks }
										</td>
										<td>
											 <shiro:hasPermission name="wcp:ar:autoReply:edit">
												<div class="btn-group zf-tableButton">
								                  	<button type="button" class="btn btn-sm btn-info" onclick="window.location.href='${ctx}/wcp/ar/autoReply/form?id=${autoReply.id}'">修改</button>
								                  	<button type="button" class="btn btn-sm btn-info dropdown-toggle" data-toggle="dropdown">
								                    	<span class="caret"></span>
									                </button>
								                  	<ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
								                  	<c:choose>
								                  		<c:when test="${autoReply.activeFlag eq '1' }">
										                  	<li><a href="#this" data-href="${ctx}/wcp/ar/autoReply/updateStatus" data-message="确定要停用吗？" data-json="{'id':'${autoReply.id }','activeFlag':'0'}" onclick="return ZF.xconfirm(this);">停用</a></li>
								                  		</c:when>
								                  		<c:when test="${autoReply.activeFlag eq '0' }">
								                  			<li><a href="#this" data-href="${ctx}/wcp/ar/autoReply/updateStatus" data-message="确定要启用吗？" data-json="{'id':'${autoReply.id }','activeFlag':'1'}" onclick="return ZF.xconfirm(this);">启用</a></li>
								                  		</c:when>
								                  	</c:choose>
									                <li><a href="#this" data-href="${ctx}/wcp/ar/autoReply/delete" data-message="确定要删除该回复消息吗？" data-json="{'id':'${autoReply.id }'}" onclick="return ZF.xconfirm(this);">删除</a></li>
								                  	<li><a href="${ctx}/wcp/ar/autoReply/info?id=${autoReply.id}">详情</a></li>
												  	</ul>
												</div>
								            </shiro:hasPermission>
								            <shiro:lacksPermission name="wcp:ar:autoReply:edit">
								            	<div class="btn-group zf-tableButton">
								                  	<button type="button" class="btn btn-sm btn-info" onclick="window.location.href='${ctx}/wcp/ar/autoReply/info?id=${autoReply.id}'">详情</button>
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
			"order": [[ 7, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
			"columnDefs":[
				{"orderable":false,targets:0},
				{"orderable":false,targets:1},
				{"orderable":false,targets:2},
				{"orderable":false,targets:3},
				{"orderable":false,targets:4},
				{"orderable":false,targets:5},
				{"orderable":false,targets:6},
				{"orderable":false,targets:8},
				{"orderable":false,targets:9},
				{"orderable":false,targets:10},
				{"orderable":false,targets:11},
				{"orderable":false,targets:12},
				{"orderable":false,targets:13}
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
					        "<td>1</td>",
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
	
	
	function changeFlag(message,href){
		confirm(message,"info",function(){
			window.location.href=href;
		});
		return false;
	}
	</script>
	<script type="text/javascript">
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</body>
</html>