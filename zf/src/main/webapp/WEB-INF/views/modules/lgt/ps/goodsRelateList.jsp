<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>商品列表管理</title>
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
		<sys:tip content="${message}"/>
		<section class="content">
			<form:form id="searchForm" modelAttribute="goods" action="${ctx}/lgt/ps/goods/relateselect?goodsId=${goodsId }" method="post" class="form-horizontal">
				<input type="hidden" id="goodsId" value="${goodsId }" />
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
									<label for="searchParameterKeyWord" class="col-sm-3 control-label">关键字</label>
									<div class="col-sm-7">
										<form:input id="searchParameterKeyWord" path="searchParameter.keyWord" htmlEscape="false" maxlength="50" class="form-control" placeholder="请输入商品名称查询"/>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<sys:inputtree url="${ctx}/lgt/ps/category/categoryData" label="分类查询" tip="请选择分类" id="category" labelName="category.categoryName" name="category.id" labelWidth="3" inputWidth="7"></sys:inputtree>
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
									<th></th>
									<th>商品编码</th>
									<th>商品名称</th>
									<th>样图</th>
									<th>商品状态</th>
									<th>商品销量</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach items="${page.list}" var="goods" varStatus="status">
								<tr>
									<td>
										<input id="${goods.id }" data-value="${goods.id }" data-name="${goods.name }"  type="checkBox" />
									</td>
									<td>
										${goods.code}
									</td>
                                    <td title="${goods.name }">
                                        ${fns:abbr(goods.name, 15)}
                                    </td>
									<td>
										<img onerror="imgOnerror(this);"  src="${imgHost }${fn:replace(goods.samplePhoto, '|', '')}" data-big data-src="${imgHost }${goods.samplePhoto}" width="21px" height="21px" />
									</td>
									<td>
										<c:choose>
                                           <c:when test="${goods.status=='1'}">
                                                <span class="label label-default">${fns:getDictLabel(goods.status, 'lgt_ps_goods_status', '')}</span>
                                           </c:when>
                                           <c:when test="${goods.status=='2' }">
                                                <span class="label label-success">${fns:getDictLabel(goods.status, 'lgt_ps_goods_status', '')}</span>
                                           </c:when>
                                           <c:when test="${goods.status=='3' }">
                                                <span class="label label-primary">${fns:getDictLabel(goods.status, 'lgt_ps_goods_status', '')}</span>
                                           </c:when>
                                       </c:choose>
									</td>
									<td>
                                        ${goods.sellNum}
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
	
<script>
	  $(function () {
		 //表格初始化
		ZF.parseTable("#contentTable", {
			"paging" : false,
			"lengthChange" : false,
			"searching" : false,
			"ordering" : true,
			"order": [[ 5, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
			"columnDefs":[
				{"orderable":false,targets:0},
				{"orderable":false,targets:1},
				{"orderable":false,targets:2},
				{"orderable":false,targets:3},
				{"orderable":false,targets:4}
            ],
			"info" : false,
			"autoWidth" : false,
			"multiline" : true,//是否开启多行表格
			"isRowSelect" : false//是否开启行选中
		});
		 
		$('input').iCheck({
			checkboxClass : 'icheckbox_minimal-blue',
		});
		
		ZF.bigImg();
		
	  });
</script>
	
</body>
</html>