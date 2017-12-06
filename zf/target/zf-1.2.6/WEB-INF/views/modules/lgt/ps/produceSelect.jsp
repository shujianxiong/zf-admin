<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>产品列表管理</title>
	<meta name="decorator" content="adminLte"/>
	<%@include file="/WEB-INF/views/include/treetable.jsp" %>
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
		
		function rowCheck(obj){
			//var goodsName=$(obj).attr("type-name");
			//if($(obj).attr("checked")=="checked"){
				//$("input[name='selectName']").removeAttr("checked");
				//$(obj).attr("checked","checked")
				//临时测试
// 				window.parent.builderTable("<tr data-val='1' id="+$(obj).val()+" class='proudceId' type-id="+$(obj).val()+"><td>"+goodsName+"</td>");
// 			}else{
				//临时测试 
// 				window.parent.removeTable($(obj).val());
				//window.parent.builderTable("<tr id="+$(obj).val()+"><td>Trident</td><td>InternetExplorer 4.0</td><td>Win 95+</td><td> 4</td><td>X</td></tr>");
				//window.parent.iframeSelected($(obj).val());
			//}
		}
		
		function clearQueryParam(){
			$("#categoryName").val("");
			$("#s2id_goodsStatus").select2("val","");
			$("#searchParameterKeyWord").val("");
		}
		
		
		
	</script>
</head>
<body>

<div class="content-wrapper sub-content-wrapper">
	<section class="content-header">
		<h1>
	        <small class="menu-active">
	        	<i class="fa fa-repeat"></i><a href="${ctx}/lgt/ps/produce/select?warehouseId=${warehouseId }">仓库产品列表</a>
	        </small>
      	</h1>
	</section>
	
	<sys:tip content="${message}"/>
	
	<section class="content">
		<form:form id="searchForm" modelAttribute="produce" action="${ctx}/lgt/ps/produce/select" method="post" class="form-horizontal">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<input id="pageKey" name="pageKey" type="hidden" value="${pageKey }"/>
		<div class="box box-info">
			<div class="box-header with-border zf-query">
				<h5>查询条件</h5>
				<div class="box-tools pull-right">
					<button type="button" class="btn btn-box-tool"data-widget="collapse"><i class="fa fa-minus"></i></button>
					<button type="button" class="btn btn-box-tool"data-widget="remove"><i class="fa fa-remove"></i></button>
				</div>
			</div>
			<div class="box-body">
				<div class="row">
					<div class="col-md-4">
						<div class="form-group">
							<label for="code" class="col-sm-3 control-label" >关键字</label>
							<div class="col-sm-7">
								<form:input id="searchParameterKeyWord" path="searchParameter.keyWord" htmlEscape="false" maxlength="50" class="form-control" placeholder="请输入名称或编码查询"/>
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="form-group">
							<label for="status" class="col-sm-3 control-label" >产品状态</label>
							<div class="col-sm-7">
								<form:select path="status" htmlEscape="false" maxlength="50" class="form-control select2">
									<form:option value="" label="所有"/>
									<form:options items="${fns:getDictList('lgt_ps_produce_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
								</form:select>
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<sys:inputtree name="warehouse.id" url="${ctx}/lgt/ps/warehouse/warehouseListData" id="warehouse" label="所属仓库" labelValue="" labelWidth="3" inputWidth="7"
									 labelName="warehouse.name" value="" tip="请选择仓库"></sys:inputtree>
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
					<table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
						<thead>
							<tr>
								<th>&nbsp;</th>
								<th>样图</th>
								<th>产品编码</th>
								<th>产品全称</th>
								<th>产品状态</th>
								<th>正常库存</th>
								<th>锁定库存</th>
								<th>负债库存</th>
								<th>标准库存</th>
								<th>安全库存</th>
								<th>警戒库存</th>
							</tr>
						</thead>
						<tbody id="tBodyId">
							<c:forEach items="${page.list}" var="produce">
								<tr id="${produce.id }" data-type="item">
									<td  data-type="checkbox">
										<input type="checkbox" name="selectName" value="${produce.id }" data-code="${produce.code}" data-name="${produce.name}" data-fullname="${produce.goods.name} ${produce.name}"/>
									</td>
									<td>
										<img onerror="imgOnerror(this);" src="${imgHost }${produce.goods.samplePhoto}" data-big data-src="${imgHost }${produce.goods.samplePhoto}" width="20px" height="20px" />
									</td>
									<td>
										${produce.code}
									</td>
									<td title="${produce.goods.name}(${produce.name })">
										${produce.goods.name}（${fns:abbr(produce.name, 16)}）
									</td>
									<td>
									    <c:choose>
                                            <c:when test="${produce.status == 1 }"><span class="label label-default">${fns:getDictLabel(produce.status,'lgt_ps_produce_status','') }</span></c:when>
                                            <c:when test="${produce.status == 2 }"><span class="label label-success">${fns:getDictLabel(produce.status,'lgt_ps_produce_status','') }</span></c:when>
                                            <c:when test="${produce.status == 3 }"><span class="label label-primary">${fns:getDictLabel(produce.status,'lgt_ps_produce_status','') }</span></c:when>
                                            <c:when test="${produce.status == 4 }"><span class="label label-danger">${fns:getDictLabel(produce.status,'lgt_ps_produce_status','') }</span></c:when>
                                            <c:otherwise><span class="label label-danger">${fns:getDictLabel(produce.status,'lgt_ps_produce_status','') }</span></c:otherwise>
                                        </c:choose>
									</td>
									<td>
										${produce.stockNormal}
									</td>
									<td>
										${produce.stockLock}
									</td>
									<td>
											${produce.stockLock}
									</td>
									<td>
										${produce.stockStandard}
									</td>
									<td>
										${produce.stockSafe}
									</td>
									<td>
										${produce.stockWarning}
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<div class="box-footer">
		        	<div class="dataTables_paginate paging_simple_numbers">${page}</div>
	            </div>
			</div>
		</div>
	</section>
</div>
	<script>
	  $(function () {
		ZF.bigImg();
		 //表格初始化
		ZF.parseTable("#contentTable", {
			"paging" : false,
			"lengthChange" : false,
			"searching" : false,
			"ordering" : true,
			"order": [[ 4, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
			"columnDefs":[
				{"orderable":false,targets:0},
				{"orderable":false,targets:1},
				{"orderable":false,targets:2},
				{"orderable":false,targets:3}
            ],
			"info" : false,
			"autoWidth" : false,
			"multiline" : true,//是否开启多行表格
			"isRowSelect" : false//是否开启行选中
		})
		
	   $('input').iCheck({
		   checkboxClass : 'icheckbox_minimal-blue',
           radioClass : 'iradio_minimal-blue'
	   });
		 
		var checkTable=new ZF.CheckTable("${pageKey}");
	  });
</script>
</body>
</html>