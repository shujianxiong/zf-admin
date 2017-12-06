<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>调货产品货品明细列表</title>
	<meta name="decorator" content="adminLte"/>
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
	</script>
</head>
<body>
	<!-- Content Wrapper. Contains page content -->
	<div class="content-wrapper sub-content-wrapper">
	    <sys:tip content="${message}"/>
		<section class="content">
	    	<div class="box box-soild">
				<div class="box-header">
					
				</div>
				<div class="box-body">
				<div class="table-responsive">
	    			<table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
						<thead>
							<tr>
							<th>货品编号</th>
							<th>调货状态</th>
							<th>调出货位编号</th>
							<th>调入货位编号</th>
							</tr>
						</thead>
						<tbody>
						<c:forEach items="${page.list}" var="dispatchproduct">
							<tr>
								<td>${dispatchproduct.outWareplace.produce.goods.name}--${dispatchproduct.outWareplace.produce.name}--${dispatchproduct.product.code}</td>
								<td>
									<c:if test="${dispatchproduct.status eq '1'}">
										<span class="label label-info">调货中</span>
									</c:if>
									<c:if test="${dispatchproduct.status eq '2'}">
										<span class="label label-danger">调货完成</span>
									</c:if>
								</td>
								<td>
									${dispatchproduct.outWareplace.warecounter.warearea.warehouse.name}
					   				-${dispatchproduct.outWareplace.warecounter.warearea.name}
					   				-${dispatchproduct.outWareplace.warecounter.code}
					   				-${dispatchproduct.outWareplace.code}
								</td>
								<td>
									${dispatchproduct.inWareplace.warecounter.warearea.warehouse.name}
					   				-${dispatchproduct.inWareplace.warecounter.warearea.name}
					   				-${dispatchproduct.inWareplace.warecounter.code}
					   				-${dispatchproduct.inWareplace.code}
								</td>
							</tr>
						</c:forEach>
						</tbody>
						</table>
					</div>
				</div>  
				<!-- <div class="box-footer">
		        	<div class="pull-right box-tools">
		        		<button type="button" class="btn btn-default" onclick="history.go(-1)">返回</button>
		        	</div>
	            </div>  -->
				<div class="box-footer">
		        	<div class="dataTables_paginate paging_simple_numbers">${page}</div>
		        </div>
			</div>
		</section>
	</div>
	
<script>
	  $(function () {
		//表格初始化
		 	var t=ZF.parseTable("#contentTable",{
				"paging" : false,
				"lengthChange" : false,
				"searching" : false,//关闭搜索
				"ordering" : false,//开启排序
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
	    
	  	//表格单选功能
	    $('#contentTable tbody').on( 'click', 'tr', function (){
	        if ($(this).hasClass('selected')) {
	            $(this).removeClass('selected');
	        }else{
	        	$('#contentTable tr.selected').removeClass('selected');
	            $(this).addClass('selected');
	        }
	    });
	  	
	  });
</script>
</body>
</html>