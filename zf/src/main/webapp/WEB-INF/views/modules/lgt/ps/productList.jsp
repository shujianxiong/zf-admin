<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>货品管理</title>
	<meta name="decorator" content="adminLte"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
		
		function copyToClipboard(copyName, copyText){
			if (window.clipboardData){
				window.clipboardData.setData("Text", copyText)
			}else {
				var flashcopier = 'flashcopier';
				if(!document.getElementById(flashcopier)){
					var divholder = document.createElement('div');
					divholder.id = flashcopier;
					document.body.appendChild(divholder);
				}
				document.getElementById(flashcopier).innerHTML = '';
				var divinfo = '<embed src="../js/_clipboard.swf" FlashVars="clipboard='+encodeURIComponent(copyText)+'" width="0" height="0" type="application/x-shockwave-flash"></embed>';
		        document.getElementById(flashcopier).innerHTML = divinfo;
		    }
			top.$.jBox.tip(copyName+"已复制到剪贴板！", 'message');
	    }
		
		//查看详情
		function view(){}
		
		//修改
		function edit(){}
		
		//删除
		function del(){
			if(productId==''||productId == null || productId==undefined){
				alert("请先选中需要操作的记录！")
				return false;
			}else{
				if(confirm("确定要删除吗？")){
					$.ajax({
						type:'POST',
						data:'{id:'+productId+'}',
						url:'${ctx}/lgt/ps/product/delete',
						success:function(data){
							productId = null;
							return false;
						},
						error:function(data){
							alert("操作失败！")
							return false;
						}
					})
				}
			}
		}
	</script>
</head>
<body>

	<div class="content-wrapper sub-content-wrapper">
		<section class="content-header content-header-menu">
			<h1>
				<small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/lgt/ps/product/list">货品列表</a></small>
<!-- 				<small>|</small> -->
<%-- 	        	<shiro:hasPermission name="lgt:ps:product:edit"><small><i class="fa-form-edit"></i><a href="${ctx}/lgt/ps/product/form">新建货品</a></small></shiro:hasPermission> --%>
			</h1>
		</section>
		<sys:tip content="${message}"/>
		<section class="content">
			<div class="box box-info">
				<div class="box-header with-border zf-query">
					<h5>查询条件</h5>
					<div class="box-tools pull-right">
						<button type="button" class="btn btn-box-tool"data-widget="collapse"><i class="fa fa-minus"></i></button>
						<button type="button" class="btn btn-box-tool"data-widget="remove"><i class="fa fa-remove"></i></button>
					</div>
				</div>
				<form:form id="searchForm" modelAttribute="product" action="${ctx}/lgt/ps/product/list" method="post" class="form-horizontal">
					<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
					<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
					<div class="box-body">
						<div class="row">
							<div class="col-md-4">
								<div class="form-group">
									<label for="searchParameter.keyWord" class="col-sm-3 control-label" >关键字</label>
									<div class="col-sm-7">
										<form:input id="keyWords" path="searchParameter.keyWord" htmlEscape="false" maxlength="255" class="form-control"   placeholder="请输入货品编码或产品编码或产品名称查询"/>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-group">
									<label for="searchParam" class="col-sm-3 control-label" >当前状态</label>
									<div class="col-sm-7">
										<form:select id="status" path="status" class="form-control select2">
											<form:option value="" label="所有"/>
											<form:options items="${fns:getDictList('lgt_ps_product_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
										</form:select>
									</div>
								</div>
							</div>
							<div class="col-md-4">
							    <input id="id" name="id" type="hidden" value="${warehouseId}"/>
								<sys:inputtree name="wareplace.warecounter.warearea.warehouse.id" url="${ctx}/lgt/ps/warehouse/warehouseListData" id="warehouse" label="所属仓库" labelValue="${warehouseCode}" labelWidth="3" inputWidth="7"
									 labelName="wareplace.warecounter.warearea.warehouse.code" value="${warehouseId}" tip="请选择仓库" onchange="changeWarehouse"> ></sys:inputtree>
							</div>
						</div>
						<div class="row">
							<div class="col-md-4">
								<sys:inputtree name="wareplace.warecounter.warearea.id" url="${ctx}/lgt/ps/warearea/wareareaListData" id="warearea" label="仓库区域" labelValue="" labelWidth="3" inputWidth="7" 
									labelName="wareplace.warecounter.warearea.code" value="" tip="请选择区域" postParam="{postName:[\"warehouse.id\"],inputId:[\"warehouseId\"]}" isQuery="true" onchange="changeWarearea"></sys:inputtree>
							</div>
							<div class="col-md-4">
								<sys:inputtree name="wareplace.warecounter.id" url="${ctx}/lgt/ps/warecounter/warecounterListData" id="warecounter" label="所属货架" labelValue="" labelName="wareplace.warecounter.code" labelWidth="3" inputWidth="7" value="" tip="请选择货架"
									postParam="{postName:[\"warearea.id\"],inputId:[\"wareareaId\"]}" isQuery="true" onchange="changeWarecounter"></sys:inputtree>
							</div>
							<div class="col-md-4">
								<sys:inputtree name="wareplace.id" url="${ctx}/lgt/ps/wareplace/wareplaceListData" id="wareplace" label="所属货位" labelValue="" labelName="wareplace.code" labelWidth="3" inputWidth="7" value="" tip="请选择货位"
									postParam="{postName:[\"warecounter.id\"],inputId:[\"warecounterId\"]}" isQuery="true"></sys:inputtree>
							</div>
						</div>
					</div>
					<div class="box-footer">
						<div class="pull-right box-tools">
						    <button type="button" class="btn btn-sm btn-dropbox" onclick="printPreview()"><i class="fa fa-print">打印预览</i></button>
						    <button type="button" class="btn btn-sm btn-success" id="exportBtn"><i class="fa fa-file-excel-o">Excel导出</i></button>
			        		<button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
		               		<button type="submit" class="btn btn-info btn-sm"><i class="fa fa-search"></i>查询</button>
			        	</div>
					</div>
	            </form:form>
			</div>
			<div class="box box-soild">
				<div class="box-header">
					
				</div>
				<div class="box-body">
					<div class="table-responsive">
						<table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
							<thead>
								<tr>
									<th class="zf-dataTables-multiline"></th>
									<th>样图</th>
									<th>货品编码</th>
									<th>产品编码</th>
									<th>产品全称</th>
									<th>产品状态</th>
									<th>货品状态</th>
									<th>存放货位</th>
									<th>所属供应商</th>
									<th>坏货图片</th>
									<th>更新时间</th>
									<th>更新者</th>
									<th>备注</th>
									<th style="display:none">货品原厂编码</th>
									<th style="display:none">货品证书编号</th>
									<th style="display:none">创建者</th>
									<th style="display:none">创建时间</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach items="${page.list}" var="product" varStatus="status">
								<tr data-value="${product.id }" data-index="${status.index }">
									<td class="details-control text-center">
										<i class="fa fa-plus-square-o text-success"></i>
									</td>
									<td><img onerror="imgOnerror(this);"  src="${imgHost }${product.goods.samplePhoto}" data-big data-src="${imgHost }${product.goods.samplePhoto}" width="21" height="21" /></td>
									<td>
										${product.code}
									</td>
									<td>
										${product.produce.code}
									</td>
									<c:set var="fullName" value="${product.goods.name} ${product.produce.name}"></c:set>
                                    <td title="${fullName }">${fns:abbr(fullName, 15)}</td>
									<td>
                                        <c:choose>
                                            <c:when test="${product.produce.status == 1 }"><span class="label label-default">${fns:getDictLabel(product.produce.status,'lgt_ps_produce_status','') }</span></c:when>
                                            <c:when test="${product.produce.status == 2 }"><span class="label label-success">${fns:getDictLabel(product.produce.status,'lgt_ps_produce_status','') }</span></c:when>
                                            <c:when test="${product.produce.status == 3 }"><span class="label label-primary">${fns:getDictLabel(product.produce.status,'lgt_ps_produce_status','') }</span></c:when>
                                            <c:when test="${product.produce.status == 4 }"><span class="label label-danger">${fns:getDictLabel(product.produce.status,'lgt_ps_produce_status','') }</span></c:when>
                                            <c:otherwise><span class="label label-danger">${fns:getDictLabel(product.produce.status,'lgt_ps_produce_status','') }</span></c:otherwise>
                                        </c:choose>
                                    </td>
									<td>
										<c:choose>
											<c:when test="${ product.status eq '1'}">
												<span class="label label-primary">${fns:getDictLabel(product.status, 'lgt_ps_product_status', '')}</span>
											</c:when>
											<c:when test="${ product.status eq '2'}">
												<span class="label label-default">${fns:getDictLabel(product.status, 'lgt_ps_product_status', '')}</span>
											</c:when>
											<c:when test="${ product.status eq '3'}">
												<span class="label label-warning">${fns:getDictLabel(product.status, 'lgt_ps_product_status', '')}</span>
											</c:when>
											<c:when test="${ product.status eq '4'}">
												<span class="label label-warning">${fns:getDictLabel(product.status, 'lgt_ps_product_status', '')}</span>
											</c:when>
											<c:when test="${ product.status eq '5'}">
												<span class="label label-default">${fns:getDictLabel(product.status, 'lgt_ps_product_status', '')}</span>
											</c:when>
											<c:otherwise>
												<span class="label label-default">${fns:getDictLabel(product.status, 'lgt_ps_product_status', '')}</span>
											</c:otherwise>
										</c:choose>
									</td>
									<td>
										<c:if test="${product.wareplace!=null && product.wareplace.code!=null}">
											${product.wareplace.warecounter.warearea.warehouse.code}-${product.wareplace.warecounter.warearea.code}-${product.wareplace.warecounter.code}-${product.wareplace.code}
										</c:if>
									</td>
									<td>
									   ${product.supplier.name }
									</td>
									<td>
										<c:forEach items="${product.imgs}" var="img" varStatus="status">
											<img onerror="imgOnerror(this);" src="${imgHost }${img}" data-big data-src="${imgHost }${img}" width="20px" height="20px" />
										</c:forEach>
									</td>
									<td>
										<fmt:formatDate value="${product.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>
									<td>
											${fns:getUserById(product.updateBy.id).name}
									</td>
									<td title="${product.remarks}">
											${fns:abbr(product.remarks,10)}
									</td>
									<td data-hide="true">
										${product.factoryCode}
									</td>
									<td data-hide="true">
										${product.certificateNo}
									</td>
									<td data-hide="true">
										${fns:getUserById(product.createBy.id).name}
									</td>
									<td data-hide="true">
										<fmt:formatDate value="${product.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>
									<td>
										<div class="btn-group zf-tableButton">
						                  	<button type="button" class="btn btn-sm btn-info" onclick="window.location.href='${ctx}/lgt/ps/product/info?id=${product.id}'">详情</button>
						                  	<button type="button" class="btn btn-sm btn-info dropdown-toggle" data-toggle="dropdown">
						                    	<span class="caret"></span>
						                  	</button>
					                  	   <shiro:hasPermission name="lgt:ps:product:edit">
                                                       <ul class="dropdown-menu btn-info zf-dropdown-width" role=  "menu">
														   <li><a href="${ctx}/lgt/ps/product/form?id=${product.id}">修改</a></li>
                                                           <li><a href="${ctx}/lgt/ps/product/upload?id=${product.id}">图片上传</a></li>
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
			// 缩略图展示
			ZF.bigImg();
			
			 //表格初始化
		 	ZF.parseTable("#contentTable",{
				"paging" : false,
				"lengthChange" : false,
				"searching" : false,
				//"order": [[ 14, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
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
					{"orderable":false,targets:16},
					{"orderable":false,targets:17}
	            ],
				"ordering" : false,
				"info" : false,
				"autoWidth" : false,
				"multiline":true,//是否开启多行表格
				"isRowSelect":true,//是否开启行选中
				"rowSelect":function(tr){productId = tr.attr("data-value");},
				"rowSelectCancel":function(tr){productId = null;}
			})
		});
		
		//点击仓库选择时，需清空区域、货架、货位
		function changeWarehouse(){
			$("#wareareaName").val("");
			$("#wareareaId").val("");
			$("#warecounterName").val("");
			$("#warecounterId").val("");
			$("#wareplaceName").val("");
			$("#wareplaceId").val("");
		}
		//点击区域选择时，需清空货架、货位
		function changeWarearea(){
			$("#warecounterName").val("");
			$("#warecounterId").val("");
			$("#wareplaceName").val("");
			$("#wareplaceId").val("");
		}
		//点击货架选择时，需清空货位
		function changeWarecounter(){
			$("#wareplaceName").val("");
			$("#wareplaceId").val("");
		}
		
		
		 $("#exportBtn").on("click", function() {
	            $("#searchForm").attr("action", "${ctx}/lgt/ps/ProductExport/export");
	            $("#searchForm").submit();
	            $("#searchForm").attr("action", "${ctx}/lgt/ps/product/list");
	        });

		function printPreview() {
			var i = 0;
            $("#searchForm input[type!=hidden]").each(function() {
                if($(this).val() != null   && $(this).val() != ""  && $(this).val() != undefined) {
                    i++;
                }
            });
            $("#searchForm select").each(function() {
                if($(this).val() != null   && $(this).val() != ""  && $(this).val() != undefined) {
                    i++;
                }
            });
            if(i == 0) {
                ZF.showTip("请选择查询条件!", "info");
                return false;
            }
			
			var keyWords = $("#keyWords").val();
			var status = $("#status").val();
			var wpId = $("#wareplaceId").val();
			var wcId = $("#warecounterId").val();
			var waId = $("#wareareaId").val();
			var whId = $("#warehouseId").val();
			
            window.open("${ctx}/lgt/ps/product/printPreview?searchParameter.keyWord="+keyWords+"&status="+status+"&wareplace.warecounter.warearea.warehouse.id="+whId+"&wareplace.warecounter.warearea.id="+waId+"&wareplace.warecounter.id="+wcId+"&wareplace.id="+wpId);
        }
		
		
	</script>
</body>
</html>