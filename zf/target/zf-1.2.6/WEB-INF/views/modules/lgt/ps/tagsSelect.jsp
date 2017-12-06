<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>商品标签管理</title>
	<meta name="decorator" content="adminLte"/>
	<style type="text/css">
		tr{ 
		    cursor: pointer;    /*手形*/   
		} 
	</style>
	<script type="text/javascript">
		$(document).ready(function() {
			//保存时必须要选择一个保存对象
			
			//单个点击事件获取checkbox的值
// 			$("input[type='checkbox").change(function(e){
// 				var addUrl = "${ctx}/lgt/ps/tags/saveGoodsTags";
// 				var dellUrl = "${ctx}/lgt/ps/tags/goodsTagsDelete";
// 				var ncid = $(this).attr("tags-id");
// 				var tagsId = $(this).val();
// 				if($(this).attr("checked")=='checked'){
// 					ajaxData(addUrl, ncid, tagsId);
// 				}else{
// 					ajaxData(dellUrl, ncid, tagsId);
// 				}
// 			});
		});
		

		function ajaxData(url, ncid, tags){
			$("#loading").show();
			var data={"id":ncid, "tagss[0].id":tags};
			ajaxRequest(url,"POST",data)
		}
		
		function ajaxRequest(url, type, data){
			$.ajax({
			   type: type,
			   url: url,
			   data: data,
			   success: successResult,
			   error:errorResult
			});
		}
		
		function successResult(data){ 
			$("#loading").hide();
			var result = eval("("+data+")");
			if(result.flag){
				$.jBox.tip('保存成功。', 'success',{
					timeout:1500
				});
			}else{
				$.jBox.tip('保存失败。', 'error');
			}
		}
		
		function errorResult(data){
			$("#loading").hide();
			$.jBox.tip('保存失败,刷新页面在进行操作 。', 'error');
		}
		
		
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
			<form:form id="searchForm" modelAttribute="tags" action="${ctx}/lgt/ps/tags/tagsSelect?goodsId=${goodsId}" method="post" class="form-horizontal">
				<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
				<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
				<input type="hidden" name="goods.id"  value="${goodsId}" id="goodsId"/><!-- 商品Id -->
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
									<label for="name" class="col-sm-3 control-label">标签名称</label>
									<div class="col-sm-7">
										<form:input path="name" htmlEscape="false" maxlength="50" class="form-control"/>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-group">
									<label for="hotFlag" class="col-sm-3 control-label">是否热门</label>
									<div class="col-sm-7">
										<form:select path="hotFlag" class="form-control select2">
											<form:option value="" label="所有"/>
											<form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
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
				</div>
			</form:form>
			<div class="box box-soild">
				<div class="box-body">
					<div class="table-responsive">
						<table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
							<thead>
								<tr>
									<th style="width: 20px;">&nbsp;</th>
									<th>标签名称</th>
									<th>是否热门</th>
									<th>排列序号</th>
									<th>更新时间</th>
									<th>备注信息</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach items="${page.list}" var="tags">
								<tr>
									<td>
										<c:set var="flag" value="0"/>
										<c:forEach items="${goodsTags.tagss}" var="b">
											<c:if test="${tags.id eq b.id}">
												<c:set var="flag" value="1"/>
											</c:if>
										</c:forEach>
										<input type="checkBox" <c:if test="${flag eq '1' }"> checked="checked"</c:if> tags-id="${goodsId}" value="${tags.id}" />
										<c:set var="flag" value="0"/>
									</td>
									<td>
										${tags.name}
									</td>
									<td>
										<c:choose>
											<c:when test="${ tags.hotFlag eq '0'}">
												<span class="label label-primary">${fns:getDictLabel(tags.hotFlag, 'yes_no', '')}</span>
											</c:when>
											<c:when test="${ tags.hotFlag eq '1'}">
												<span class="label label-success">${fns:getDictLabel(tags.hotFlag, 'yes_no', '')}</span>
											</c:when>
										</c:choose>
									</td>
									<td>
										${tags.orderNo}
									</td>
									<td>
										<fmt:formatDate value="${tags.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>
									<td title="${tags.remarks}">
										${fns:abbr(tags.remarks,15)}
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
			"order": [[ 3, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
			"columnDefs":[
				{"orderable":false,targets:0},
				{"orderable":false,targets:1},
				{"orderable":false,targets:2},
				{"orderable":false,targets:4},
				{"orderable":false,targets:5}
            ],
			"info" : false,
			"autoWidth" : false,
			"multiline" : true,//是否开启多行表格
			"isRowSelect" : false//是否开启行选中
		});
		 
		$('input').iCheck({
			checkboxClass : 'icheckbox_minimal-blue',
		});
		
		
		
	  });
</script>
	
</body>
</html>