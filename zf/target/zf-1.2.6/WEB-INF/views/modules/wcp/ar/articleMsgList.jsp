<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>图文消息列表管理</title>
	<meta name="decorator" content="adminLte"/>
</head>
<body>
<div class="content-wrapper sub-content-wrapper">
		<section  class="content-header content-header-menu">
			<h1>
				<small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/wcp/ar/articleMsg/list">图文消息列表</a></small>
				
				<shiro:hasPermission name="wcp:ar:articleMsg:edit"><small>|</small><small><i class="fa-form-edit"></i><a href="${ctx}/wcp/ar/articleMsg/form">图文消息${not empty articleMsg.id?'修改':'添加'}</a></small></shiro:hasPermission>
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
	
				<form:form id="searchForm" modelAttribute="articleMsg" action="${ctx}/wcp/ar/articleMsg/list" method="post" class="form-horizontal">
					<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
					<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
					<input id="id" name="id" type="hidden"/>
					<div class="box-body">
						<div class="row">
							<div class="col-md-4">
								<div  class="form-group">
									<label for="keyWordId" class="col-sm-3 control-label">名称</label>
									<div class="col-sm-7">
										<sys:inputverify name="searchParameter.keyWord" tip="请输入名称或者标题进行检索" verifyType="0" isMandatory="false" isSpring="true" id="keywordId"></sys:inputverify>
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
									<th>名称</th>
									<th>标题</th>
									<th>图片素材ID</th>
									<th>跳转链接</th>
									<th>排序权重</th>
									<th style="display:none;">创建者</th>
									<th style="display:none;">创建时间</th>
									<th style="display:none;">更新者</th>
									<th style="display:none;">更新时间</th>
									<th style="display:none;">备注信息</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${page.list}" var="articleMsg" varStatus="status">
									<tr data-index="${status.index }">
										<td class="details-control text-center">
											<i class="fa fa-plus-square-o text-success"></i>
										</td>
										<td title="${articleMsg.name}">
												${fns:abbr(articleMsg.name, 30)}
										</td>
										<td  title="${articleMsg.title}">${fns:abbr(articleMsg.title, 30) }</td>
										<td>
												${fns:abbr(articleMsg.pic, 50) }
										</td>
										<td title="${articleMsg.linkUrl }">${fns:abbr(articleMsg.linkUrl, 30) }</td>
										<td>${articleMsg.orderWeight }</td>
										<td data-hide="true">
											${fns:getUserById(articleMsg.createBy.id).name}
										</td>
										<td data-hide="true">
											<fmt:formatDate value="${articleMsg.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
										</td>
										<td data-hide="true">
											${fns:getUserById(articleMsg.updateBy.id).name}
										</td>
										<td data-hide="true">
											<fmt:formatDate value="${articleMsg.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
										</td>
										<td  data-hide="true">
											${articleMsg.remarks }
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
				{"orderable":false,targets:7},
				{"orderable":false,targets:8},
				{"orderable":false,targets:9},
				{"orderable":false,targets:10}
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
					        "<td data-hide=\"true\">11</td>"
					       ];
				},
				"callBack":function(){
					console.log("行添加结束")
				}
				
			}
		});
	});
	
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