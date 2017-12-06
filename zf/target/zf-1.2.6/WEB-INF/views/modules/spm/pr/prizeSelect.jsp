<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>奖品列表管理</title>
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
				<small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/spm/pr/prize/select">奖品列表</a></small>
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
	
				<form:form id="searchForm" modelAttribute="prize" action="${ctx}/spm/pr/prize/select" method="post" class="form-horizontal">
					<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
					<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
					<div class="box-body">
						<div class="row">
							<div class="col-md-4">
								<div  class="form-group">
									<label for="name" class="col-sm-3 control-label">奖品名称</label>
									<div class="col-sm-7">
										<sys:inputverify name="name" id="name" verifyType="0" tip="请输入查询的奖品名称" isMandatory="false" isSpring="true"></sys:inputverify>
									</div>
								</div>
							</div>
							
							<div class="col-md-4">
								<div  class="form-group">
									<label for="brandStatusId" class="col-sm-3 control-label">奖品类型</label>
									<div class="col-sm-7">
										<sys:selectverify name="type" tip="请选择奖品类型" verifyType="0" dictName="SPM_PR_PRIZE_TYPE" id="typeId" isMandatory="false"></sys:selectverify>
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
									<th>奖品编号</th>
									<th>奖品名称</th>
									<th>奖品类型</th>
									<!-- <th>奖品状态</th> -->
									<th>展示金额</th>
<!-- 									<th>奖品介绍</th> -->
									<th>预览图</th>
									<!-- <th>展示图片</th> -->
									<th>所需积分</th>
									<!-- <th>库存数量</th> -->
									<th>可用库存数量</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${page.list}" var="prize">
									<tr>
										<td>
											<div class="zf-check-wrapper-padding">
												<input type="radio" name="chkItem" value="${prize.id}" data-name="${prize.name}"/>
											</div>
										</td>
										<td>
											${prize.code }
										</td>
										<td>
											${prize.name}
										</td>
										<td>
											${fns:getDictLabel(prize.type,'SPM_PR_PRIZE_TYPE','') }
										</td>
										<%-- <td>
											${fns:getDictLabel(prize.status,'SPM_PR_PRIZE_STATUS','') }
										</td> --%>
										<td>
											${prize.displayPrice}
										</td>
<!-- 										<td> -->
<%-- 											${prize.introduce } --%>
<!-- 										</td> -->
										<td>
											<img onerror="imgOnerror(this);"  src="${imgHost }${prize.mainPhoto}" data-big data-src="${imgHost }${prize.mainPhoto}"  width="20" height="20">
										</td>
										<%-- <td>
											<img src="${imgHost }${prize.displayPhotos}" data-big data-src="${imgHost }${prize.displayPhotos}"  width="20" height="20">
										</td> --%>
										<td>${prize.costPoint }</td>
										<%-- <td>${prize.stockNum }</td> --%>
										<td>${prize.usableNum }</td>
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
				{"orderable":false,targets:5}
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