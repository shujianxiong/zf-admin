<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>货品出入库记录管理</title>
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
			$("#searchPurchaseForm").submit();
        	return false;
        }
		
		//清空查询条件
		function clearQueryParam(){
			$(":text").val("");
			$("input:hidden").val("");
// 			$("#product.code").val("");
// 			$("#ioWareplaceIdId").val("");
// 			$("#ioWareplaceIdName").val("");
// 			$("#ioUseridId").val("");
// 			$("#ioUseridName").val("");
// 			$("#ioBusinessorderId").val("");
			$("#s2id_ioType").select2("val","");
			$("#s2id_ioReasonType").select2("val","");
		}
	</script>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
		<section class="content-header content-header-menu">
			<h1>
				<small class="menu-active">
					<i class="fa fa-repeat"></i><a href="${ctx}/lgt/ps/productWpIo/list">货品出入库记录列表</a>
				</small>
				<shiro:hasPermission name="lgt:ps:productWpIo:edit">
					<small>|</small>
					<small>
						<i class="fa-in-house"></i><a href="${ctx}/lgt/ps/productWpIo/inForm">货品入库</a>
					</small>
					<small>|</small>
					<small>
						<i class="fa-out-house"></i><a href="${ctx}/lgt/ps/productWpIo/outForm">货品出库</a>
					</small>
				</shiro:hasPermission>
			</h1>
		</section>
		
		<sys:tip content="${message}" />

		<section class="content">
			<form:form id="searchPurchaseForm" name="searchPurchaseForm" modelAttribute="productWpIo"	action="" method="post" class="form-horizontal">
				<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
				<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
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
									<label for="code" class="col-sm-3 control-label" >货品编码</label>
									<div class="col-sm-7">
										<form:input id="product.code" path="product.code" htmlEscape="false" maxlength="64" class="form-control"  placeholder="货品编码"/>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-group">
									<label for="code" class="col-sm-3 control-label" >操作类型</label>
									<div class="col-sm-7">
										<form:select path="ioType" htmlEscape="false" maxlength="50" class="form-control select2">
											<form:option label="所有" value="" />
											<form:options items="${fns:getDictList('lgt_ps_product_wp_io_ioType')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
										</form:select>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-group">
									<label for="code" class="col-sm-3 control-label" >操作原因</label>
									<div class="col-sm-7">
										<form:select path="ioReasonType" htmlEscape="false" maxlength="50" class="form-control select2">
											<form:option label="所有" value="" />
											<form:options items="${fns:getDictList('lgt_ps_product_wp_io_ioReasonType')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
										</form:select>
									</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-4">
								<div class="form-group">
									<label for="code" class="col-sm-3 control-label" >入库类型</label>
									<div class="col-sm-7">
										<form:select path="inType" htmlEscape="false" maxlength="50" class="form-control select2">
											<form:option label="所有" value="" />
											<form:options items="${fns:getDictList('lgt_ps_product_wp_io_inType')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
										</form:select>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-group">
									<label for="code" class="col-sm-3 control-label" >操作人</label>
									<div class="col-sm-7">
										<form:hidden id="ioUserId" path="ioUser.id" />
										<form:input id="ioUserName" path="ioUser.name" htmlEscape="false" maxlength="100" class="form-control zf-input-readonly"
											placeholder="请选择操作人" readonly="true"/>
										<sys:userselect id="selectUser" url="${ctx}/sys/office/userTreeData" height="550" width="550" isOffice="false" isMulti="false" title="人员选择"/>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-group">
									<label for="code" class="col-sm-3 control-label" >业务单号</label>
									<div class="col-sm-7">
										<form:input id="ioBusinessorderId" path="ioBusinessorderId" htmlEscape="false" maxlength="64" class="form-control"  placeholder="来源业务单号"/>
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
							<button type="button" onclick="submit1()" class="btn btn-info btn-sm">
								<i class="fa fa-search"></i>查询
							</button>
						</div>
					</div>
				</div>
			</form:form>

			<div class="box box-soild">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-12 pull-right">
							<button type="button" class="btn btn-sm btn-success" onclick="showImportModal();" ><i class="fa fa-pencil">批量入库</i></button>
							<button type="button" class="btn btn-sm btn-success" onclick="showExportModal();" ><i class="fa fa-pencil">批量出库</i></button>
							<button type="button" class="btn btn-sm btn-primary" onclick="exportFile();" ><i class="fa fa-file">导出Excel</i></button>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 pull-right"></div>
					</div>
					<div class="table-responsive">
						<table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
							<thead>
								<tr>
									<th class="zf-dataTables-multiline"></th>
									<th>货品编码</th>
									<th>产品全称</th>
									<th>操作类型</th>
									<th>操作原因</th>
									<th>出入库货位</th>
									<th>入库类型</th>
									<th>入库后状态</th>
									<th>操作人</th>
									<th>操作时间</th>
									<th>来源业务单号</th>
									<th>所属供应商</th>
									<th style="display:none">创建者</th>
									<th style="display:none">创建时间</th>
									<th style="display:none">更新者</th>
									<th style="display:none">更新时间</th>
									<th>备注信息</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${page.list}" var="productWpIo" varStatus="pstatus">
									<tr id="${purchaseMission.id}" data-index="${pstatus.index}${status.index}">
										<td class="details-control text-center"><i class="fa fa-plus-square-o text-success"></i></td>
										<td>${productWpIo.product.code}</td>
										<c:set var="fullName" value="${productWpIo.product.produce.goods.name } ${productWpIo.product.produce.name }"></c:set>
										<td title="${fullName }">${fns:abbr(fullName, 20) }</td>
										<td>
										    <c:choose>
										        <c:when test="${productWpIo.ioType eq '1' }">
										            <span class="label label-primary">${fns:getDictLabel(productWpIo.ioType, 'lgt_ps_product_wp_io_ioType', '')}</span>
										        </c:when>
										        <c:when test="${productWpIo.ioType eq '2' }">
                                                      <span class="label label-info">${fns:getDictLabel(productWpIo.ioType, 'lgt_ps_product_wp_io_ioType', '')}</span>
                                                </c:when>
										    </c:choose>
										</td>
										<td>
										   <span class="label label-primary">${fns:getDictLabel(productWpIo.ioReasonType, 'lgt_ps_product_wp_io_ioReasonType', '')}</span>
										   <%-- <c:choose>
										      <c:when test="${productWpIo.ioReasonType eq '11' }">
										          <span class="label label-primary">${fns:getDictLabel(productWpIo.ioReasonType, 'lgt_ps_product_wp_io_ioReasonType', '')}</span>
										      </c:when>
										      <c:when test="${productWpIo.ioReasonType eq '12' }">
                                                  <span class="label label-default">${fns:getDictLabel(productWpIo.ioReasonType, 'lgt_ps_product_wp_io_ioReasonType', '')}</span>
                                              </c:when>
                                              <c:when test="${productWpIo.ioReasonType eq '21' }">
                                                  <span class="label label-primary">${fns:getDictLabel(productWpIo.ioReasonType, 'lgt_ps_product_wp_io_ioReasonType', '')}</span>
                                              </c:when>
                                              <c:when test="${productWpIo.ioReasonType eq '22' }">
                                                  <span class="label label-default">${fns:getDictLabel(productWpIo.ioReasonType, 'lgt_ps_product_wp_io_ioReasonType', '')}</span>
                                              </c:when>
										   </c:choose> --%>
										</td>
										<td>${productWpIo.ioWareplace.warecounter.warearea.warehouse.code}-${productWpIo.ioWareplace.warecounter.warearea.code}-${productWpIo.ioWareplace.warecounter.code}-${productWpIo.ioWareplace.code}</td>
										<td>${fns:getDictLabel(productWpIo.inType, 'lgt_ps_product_wp_io_inType', '')}</td>
										<td>${fns:getDictLabel(productWpIo.inStatus, 'lgt_ps_product_status', '')}</td>
										<td>${fns:getUserById(productWpIo.ioUser.id).name}</td>
										<td><fmt:formatDate value="${productWpIo.ioTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
										<td title="${productWpIo.ioBusinessorderId }">${fns:abbr(productWpIo.ioBusinessorderId,22)}</td>
										
										<td>${productWpIo.supplier.name }</td>
										
										<td data-hide="true">${fns:getUserById(productWpIo.createBy.id).name}</td>
										<td data-hide="true"><fmt:formatDate value="${productWpIo.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
										<td data-hide="true">${fns:getUserById(productWpIo.updateBy.id).name}</td>
										<td data-hide="true"><fmt:formatDate value="${productWpIo.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
										<td title="${productWpIo.remarks }">${fns:abbr(productWpIo.remarks,15)}</td>
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
		<div id="geneteModal1" class="modal fade" data-backdrop="false" data-keyboard="false" tabindex="-1" role="dialog" aria-labelledby="批量导入入库" aria-hidden="true">
			<form id="inputForm1" action="${ctx}/lgt/ps/ProductWpIoImport/importFile"  enctype="multipart/form-data"  method="post" class="form-horizontal" onsubmit="return importFile();">
				<div class="modal-dialog" style="width:60%;height:45%;" >
					<div class="modal-content" style="width:100%;height:100%;">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal" aria-label="Close">
								<span aria-hidden="true">&times;</span></button>
							<h4 class="modal-title">批量导入模板信息</h4>
						</div>
						<div class="box-body">
							<div class="form-group">
								<label class="col-sm-2 control-label">上传文件</label>
								<div class="col-sm-9">
									<input type="file" id="inputFile" name="file" accept="application/vnd.ms-excel">
									<p class="help-block text-red">
										文件只限Excel文本文件,后缀为.xlsx<br/>
									</p>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">内容格式</label>
								<div class="col-sm-9">
									<p class="help-block text-red">
										第一列：产品编码，第二列：操作原因类型（11：采购入库 12：退货入库 13:盘点入库 14：调货入库），
										第三列：入库货品类型（1：正常 2：采购坏货 3：库存坏货），第四列：货品入库后的状态（1:正常 2:锁定 4: 已售出 5：已移除），第五列：货品克重，
										第六列：供应商名称（必填），第七列：货品采购价，第八列：货品原厂编码（非必填），第九列：货品证书编码（非必填）
										第十列：来源业务单号（非必填），第十一列：备注
									</p>
									<table class="table table-bordered table-hover table-striped zf-tbody-font-size">
										<!--  <thead>
                                             <tr>
                                                 <th>第一列：国家</th>
                                                 <th>第二列：省</th>
                                                 <th>第三列：市</th>
                                                 <th>第四列：区</th>
                                             </tr>
                                         </thead> -->
										<tbody>
										<tr>
											<td>1080501</td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td>11</td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
											<td>1</td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
											<td></td>
											<td>1</td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td>2.89</td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td>宝云号</td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td>5000.00</td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td>88888888</td>
											<td></td>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td>6464646464</td>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td>18698570436</td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td>货品入库</td>
										</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
						<div class="box-footer">
							<div class="pull-right box-tools">
								<button type="submit"  class="btn btn-info btn-sm"><i class="fa fa-save"></i>导入</button>
							</div>
						</div>
					</div>
				</div>
			</form>
		</div>
		<div id="geneteModal2" class="modal fade" data-backdrop="false" data-keyboard="false" tabindex="-1" role="dialog" aria-labelledby="批量导入出库" aria-hidden="true">
			<form id="inputForm2" action="${ctx}/lgt/ps/ProductWpIoImport/outImportFile"  enctype="multipart/form-data"  method="post" class="form-horizontal" onsubmit="return outImportFile();">
				<div class="modal-dialog" style="width:60%;height:45%;" >
					<div class="modal-content" style="width:100%;height:100%;">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal" aria-label="Close">
								<span aria-hidden="true">&times;</span></button>
							<h4 class="modal-title">批量导入模板信息</h4>
						</div>
						<div class="box-body">
							<div class="form-group">
								<label class="col-sm-2 control-label">上传文件</label>
								<div class="col-sm-9">
									<input type="file" id="inputFile2" name="file" accept="application/vnd.ms-excel">
									<p class="help-block text-red">
										文件只限Excel文本文件,后缀为.xlsx<br/>
									</p>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">内容格式</label>
								<div class="col-sm-9">
									<p class="help-block text-red">
										第一列：操作原因类型（21：销售出库 22：盘点出库 23：调货出库 24：维修出库 25：翻新出库 ），
										第二列：货品编码，第三列：来源业务单号，非必填，第四列：备注
									</p>
									<table class="table table-bordered table-hover table-striped zf-tbody-font-size">
										<!--  <thead>
                                             <tr>
                                                 <th>第一列：国家</th>
                                                 <th>第二列：省</th>
                                                 <th>第三列：市</th>
                                                 <th>第四列：区</th>
                                             </tr>
                                         </thead> -->
										<tbody>
										<tr>
											<td>21</td>
											<td></td>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td>101230112</td>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
											<td>18698570436</td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
											<td></td>
											<td>批量出库</td>
										</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
						<div class="box-footer">
							<div class="pull-right box-tools">
								<button type="submit"  class="btn btn-info btn-sm"><i class="fa fa-save"></i>导入</button>
							</div>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
	<script type="text/javascript">
		var productId = null;
		$(function () {
			$("#ioUserName").on("click", function() {
				selectUserinit({
					"selectCallBack" : function(list) {
						$("#ioUserId").val(list[0].id);
						$("#ioUserName").val(list[0].text);
					}
				})
			});
			
			 //表格初始化
		 	ZF.parseTable("#contentTable",{
				"paging" : false,
				"lengthChange" : false,
				"searching" : false,
				"order": [[ 15, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
				"columnDefs":[
					{"orderable":false,targets:0},
					{"orderable":false,targets:1},
					{"orderable":false,targets:2},
					{"orderable":false,targets:3},
					{"orderable":false,targets:4},
					{"orderable":false,targets:5},
					{"orderable":false,targets:6},
					{"orderable":false,targets:7},
					{"orderable":false,targets:8},
					{"orderable":false,targets:9},
					{"orderable":false,targets:10},
					{"orderable":false,targets:11},
					{"orderable":false,targets:12},
					{"orderable":false,targets:13},
					{"orderable":false,targets:14},
					{"orderable":false,targets:15},
					{"orderable":false,targets:16}
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

        function showImportModal(){
            $("#geneteModal1").modal('toggle');
        };
        function showExportModal(){
            $("#geneteModal2").modal('toggle');
        };
        function importFile() {
            var file = $("#inputFile").val();
            if(file == null || file == "") {
                ZF.showTip("请先上传模板Excel表!", "info");
                return false;
            }
            $("#inputForm1").submit();
        };
        function outImportFile() {
            var file = $("#inputFile2").val();
            if(file == null || file == "") {
                ZF.showTip("请先上传模板Excel表!", "info");
                return false;
            }
            $("#inputForm2").submit();
        };
        function exportFile() {
			document.searchPurchaseForm.action="${ctx}/lgt/ps/ProductWpIoExport/export";
			document.searchPurchaseForm.submit();
        }
        function submit1() {
			document.searchPurchaseForm.action="${ctx}/lgt/ps/productWpIo/list";
			document.searchPurchaseForm.submit();
        }
	</script>
</body>
</html>

