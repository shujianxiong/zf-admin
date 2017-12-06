<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>设计师管理</title>
	<meta name="decorator" content="adminLte"/>
	<style type="text/css">
		tr{ 
		    cursor: pointer;    /*手形*/   
		} 
	</style>
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
		<section class="content-header">
			<h1>
		        <small class="menu-active">
		        	<i class="fa fa-repeat"></i><a href="${ctx}/lgt/bs/designer/select">设计师列表</a>
		        </small>
	      	</h1>
		</section>
		<sys:tip content="${message}"/>
		<section class="content">
			<form:form id="searchForm" modelAttribute="designer" action="${ctx}/lgt/bs/designer/select" method="post" class="form-horizontal">
				<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
				<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
				<div class="box box-info">
					<div class="box-header">
						<div class="box-header with-border zf-query">
							<h5>查询条件</h5>
							<div class="box-tools pull-right">
								<button type="button" class="btn btn-box-tool"data-widget="collapse"><i class="fa fa-minus"></i></button>
								<button type="button" class="btn btn-box-tool"data-widget="remove"><i class="fa fa-remove"></i></button>
							</div>
						</div>
					</div>
					<div class="box-body">
						<div class="row">
							<div class="col-md-4">
								<div class="form-group">
									<label for="name" class="col-sm-3 control-label">名称</label>
									<div class="col-sm-7">
										<form:input path="name" htmlEscape="false" maxlength="50" class="form-control"  placeholder="请输入设计师名称" />
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
					<div class="table-responsive">
						<table id="contentTable" class="table table-hover table-bordered table-condensed zf-tbody-font-size">
							<thead>
								<tr>
									<th></th>
									<th>名称</th>
									<th>性别</th>
									<th>年龄</th>
									<th>国籍</th>
									<th>设计风格</th>
									<th>标签</th>
									<th>头像</th>
									<th>简介</th>
									<th>是否启用</th>
									<th>是否推荐</th>
									<th>备注信息</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach items="${page.list}" var="designer">
								<tr>
								    <td>
										<div class="zf-check-wrapper-padding">
											<input type="radio" name="selectName"  data-value="${designer.id }=${designer.name}" value="${designer.id}" />
										</div>
									</td>
									<td>
										<input type="hidden" id="designerId${designer.id }"  value="${designer.id}" />
										<input type="hidden" id="designerName${designer.id }"  value="${designer.name}" />
										${designer.name}
									</td>
									<td>
										${fns:getDictLabel(designer.sex, 'sex', '')}
									</td>
									<td>
										${designer.age}
									</td>
									<td>
										${fns:getDictLabel(designer.country, 'country', '')}
									</td>
									<td>
										${fns:getDictLabel(designer.designStyle, 'lgt_bs_designer_designStyle', '')}
									</td>
									<td>
										${designer.tags}
									</td>
									<td>
										<img onerror="imgOnerror(this);"  src="${imgHost }${fn:replace(designer.gravatar, '|', '')}" data-big data-src="${imgHost }${designer.gravatar}" width="20px" height="20px" />
									</td>
									<td title="${designer.summary }">
										${fns:abbr(designer.summary,40)}
									</td>
									<td>
										<c:choose>
											<c:when test="${designer.usableFlag eq '1'}">
												<span class="label label-success">${fns:getDictLabel(designer.usableFlag, 'yes_no', '')}</span>
											</c:when>
											<c:when test="${designer.usableFlag eq '0'}">
												<span class="label label-primary">${fns:getDictLabel(designer.usableFlag, 'yes_no', '')}</span>
											</c:when>
										</c:choose>
									</td>
									<td>
										<c:choose>
											<c:when test="${designer.recommendFlag eq '1'}">
												<span class="label label-success">${fns:getDictLabel(designer.recommendFlag, 'yes_no', '')}</span>
											</c:when>
											<c:when test="${designer.recommendFlag eq '0'}">
												<span class="label label-primary">${fns:getDictLabel(designer.recommendFlag, 'yes_no', '')}</span>
											</c:when>
										</c:choose>
									</td>
									<td title="${designer.remarks }">
										${fns:abbr(designer.remarks,15)}
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
	$(function(){
		ZF.bigImg();
		 //表格初始化
		ZF.parseTable("#contentTable", {
			"paging" : false,
			"lengthChange" : false,
			"searching" : false,
			"ordering" : true,
			"info" : false,
			"order": [[ 3, "asc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
			"columnDefs":[
                {"orderable":false,targets:0},
                {"orderable":false,targets:1},
				{"orderable":false,targets:2},
				{"orderable":false,targets:4},
				{"orderable":false,targets:5},
				{"orderable":false,targets:6},
				{"orderable":false,targets:7},
				{"orderable":false,targets:8},
				{"orderable":false,targets:11}
            ],
			"autoWidth" : false,
			"multiline" : true,//是否开启多行表格
			"isRowSelect" : false//是否开启行选中
		})
		
		$(":radio").iCheck({
			checkboxClass : 'icheckbox_minimal-blue',
			radioClass : 'iradio_minimal-blue'
		});
		 
		$(":radio").on("ifClicked",function(){
			$("input[name=selectName]").iCheck('uncheck');
		})
		
		
	});
</script>
</body>
</html>