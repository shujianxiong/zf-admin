<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>宣传推广文章管理</title>
	<meta name="decorator" content="adminLte"/>
	<style type="text/css">
		tr{ 
		    cursor: pointer;    /*手形*/   
		} 
		
	</style>
	<script type="text/javascript" src="${ctxStatic}/adminLte/plugins/zclip/jquery.zclip.js""></script>
	<script type="text/javascript">
		$(document).ready(function() {
			$('#hint1').tooltip();
			$('#hint2').tooltip();
			$('#hint3').tooltip();
			$('#hint4').tooltip();
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
		//清空查询条件
		function clearQueryParam(){
			$("#title").val("");
			$("#subtitle").val("");
			$("#content").val("");
			$("#s2id_category").select2("val","");
		}
	</script>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
		<section class="content-header content-header-menu">
			<h1>
				<small class="menu-active">
					<i class="fa fa-repeat"></i><a href="${ctx}/spm/ar/arArticle/">宣传文章列表</a>
				</small>
				<shiro:hasPermission name="spm:ar:arArticle:edit">
					<small>|</small>
					<small>
						<i class="fa-form-edit"></i><a href="${ctx}/spm/ar/arArticle/form">宣传文章添加</a>
					</small>
				</shiro:hasPermission>
			</h1>
		</section>
		
		<sys:tip content="${message}" />
		
		<section class="content">
			<form:form id="searchForm" modelAttribute="arArticle" action="${ctx}/spm/ar/arArticle/" method="post" class="form-horizontal">
				<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
				<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
				<div class="box box-info">
					<div class="box-header with-border zf-query">
						<h5>查询条件</h5>
						<div class="box-tools pull-right">
							<button type="button" class="btn btn-box-tool" data-widget="collapse">
								<i class="fa fa-minus"></i>
							</button>
							<button type="button" class="btn btn-box-tool" data-widget="remove">
								<i class="fa fa-remove"></i>
							</button>
						</div>
					</div>
					<div class="box-body">
						<div class="row">
							<div class="col-md-4">
								<div class="form-group">
									<label for="code" class="col-sm-3 control-label">文章名称</label>
									<div class="col-sm-7">
										<form:input path="name" htmlEscape="false" maxlength="64" class="form-control" placeholder="请输入文章名称进行查询"/>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-group">
									<label for="code" class="col-sm-3 control-label">文章编码</label>
									<div class="col-sm-7">
										<form:input path="code" htmlEscape="false" maxlength="64" class="form-control" placeholder="请输入文章编码进行查询"/>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-group">
									<label for="code" class="col-sm-3 control-label">文章类别</label>
									<div class="col-sm-7">
										<form:select path="category" htmlEscape="false" maxlength="50" class="form-control select2">
											<form:option label="所有" value="" />
											<form:options items="${fns:getDictList('spm_ar_article_category')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
										</form:select>
									</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-4">
								<div class="form-group">
									<label for="code" class="col-sm-3 control-label">标签</label>
									<div class="col-sm-7">
										<form:input path="tags" htmlEscape="false" maxlength="64" class="form-control" placeholder="请输入标签进行查询"/>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-group">
									<label for="code" class="col-sm-3 control-label">标题</label>
									<div class="col-sm-7">
										<form:input path="title" htmlEscape="false" maxlength="64" class="form-control" placeholder="请输入标题进行查询"/>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-group">
									<label for="code" class="col-sm-3 control-label">启用状态</label>
									<div class="col-sm-7">
										<form:select path="activeFlag" htmlEscape="false" maxlength="50" class="form-control select2">
											<form:option label="所有" value="" />
											<form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
										</form:select>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="box-footer">
						<div class="pull-right box-tools">
							<button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()">
								<i class="fa fa-refresh"></i>重置
							</button>
							<button type="submit" class="btn btn-info btn-sm">
								<i class="fa fa-search"></i>查询
							</button>
						</div>
					</div>
				</div>
			</form:form>
			
			<div class="box box-soild">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-12 pull-right"></div>
					</div>
					<div class="table-responsive">
						<table id="contentTable" class="table table-hover table-bordered table-striped zf-tbody-font-size">
							<thead>
								<tr>
									<th class="zf-dataTables-multiline"></th>
									<th>文章名称</th>
									<th>文章编码</th>
									<th>文章类别</th>
									<th>标签</th>
									<th>标题</th>
									<th>副标题</th>
									<th>列表展示图</th>
									<th>发布时间</th>
									<th>启用状态</th>
									<th style="display:none">创建者</th>
									<th style="display:none">创建时间</th>
									<th style="display:none">更新者</th>
									<th style="display:none">更新时间</th>
									<th>备注信息</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${page.list}" var="arArticle" varStatus="astatus">
									<tr data-index="${astatus.index}${status.index}">
										<td class="details-control text-center"><i class="fa fa-plus-square-o text-success"></i></td>
										<td title="${arArticle.name}">
											${fns:abbr(arArticle.name,30)}
										</td>
										<td title="${arArticle.code}">
											${fns:abbr(arArticle.code,30)}
										</td>
										<td>
											${fns:getDictLabel(arArticle.category,'spm_ar_article_category','')}
										</td>
										<td>
											${arArticle.tags}
										</td>
										<td title="${arArticle.title}">
											${fns:abbr(arArticle.title,30)}
										</td>
										<td title="${arArticle.subtitle}">
											${fns:abbr(arArticle.subtitle,30)}
										</td>
										<td>
											<img onerror="imgOnerror(this);"  src="${imgHost }${arArticle.shareSPhoto}" data-big data-src="${imgHost }${arArticle.shareSPhoto}" width="20px" height="20px" />
										</td>
										<td>
											<fmt:formatDate value="${arArticle.publishTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
										</td>
										<td>
											<c:if test="${arArticle.activeFlag=='0' }">
												<span class="label label-primary">${fns:getDictLabel(arArticle.activeFlag,'yes_no','')}</span>
											</c:if>
											<c:if test="${arArticle.activeFlag=='1' }">
												<span class="label label-success">${fns:getDictLabel(arArticle.activeFlag,'yes_no','')}</span>
											</c:if>
										</td>
										<td data-hide="true">
											${fns:getUserById(arArticle.createBy.id).name}
										</td>
										<td data-hide="true">
											<fmt:formatDate value="${arArticle.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
										</td>
										<td data-hide="true">
											${fns:getUserById(arArticle.updateBy.id).name}
										</td>
										<td data-hide="true">
											<fmt:formatDate value="${arArticle.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
										</td>
										<td title="${arArticle.remarks}">
											${fns:abbr(arArticle.remarks,15)}
										</td>
										<td>
											<div class="btn-group zf-tableButton">
												<button type="button" class="btn btn-sm btn-info" onclick="window.location.href='${ctx}/spm/ar/arArticle/info?id=${arArticle.id}'">预览</button>
												<button type="button" class="btn btn-sm btn-info dropdown-toggle" data-toggle="dropdown">
													<span class="caret"></span>
												</button>
												<shiro:hasPermission name="spm:ar:arArticle:edit">
													<ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
														<li><a href="#this" data-href="${host}${ctxWeb}/ar/arArticle/info?articleId=${arArticle.id}" onclick="copyUrl(this)">复制地址</a></li>
														<li><a href="${ctx}/spm/ar/arArticle/form?id=${arArticle.id}">修改</a></li>
														<li><a href="${ctx}/spm/ar/arArticle/delete?id=${arArticle.id}"  style="color: #fff" onclick="return ZF.delRow('确认要删除该宣传文章吗？', this.href);">删除</a></li>
													</ul>
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
	<script type="text/javascript">
		var productId = null;
		$(function () {
			ZF.bigImg();
			// 表格初始化
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
					{"orderable":false,targets:9},
					{"orderable":false,targets:10},
					{"orderable":false,targets:11},
					{"orderable":false,targets:12},
					{"orderable":false,targets:13},
					{"orderable":false,targets:14},
					{"orderable":false,targets:15}
	            ],
				"ordering" : true,
				"info" : false,
				"autoWidth" : false,
				"multiline":true,//是否开启多行表格
				"isRowSelect":true,//是否开启行选中
				"rowSelect":function(tr){productId = tr.attr("data-value");},
				"rowSelectCancel":function(tr){productId = null;}
			})
			
		});
		
		function copyUrl(obj) {
             $(obj).zclip({  
                 path:"${ctxStatic}/adminLte/plugins/zclip/ZeroClipboard.swf",  
                 copy:function(){
                	 return $(this).attr("data-href");
               	 },  
                 afterCopy:function(){
                	 alert("复制成功！");
                 }  
             });
	    }
		
	</script>
</body>
</html>