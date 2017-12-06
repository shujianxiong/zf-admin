<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>货品管理</title>
	<meta name="decorator" content="adminLte"/>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
	
		<section class="content-header content-header-menu">
				
		</section>
		
		<section class="invoice">
			<p class="lead">所属商品信息</p>
			<div class="table-responsive">
				<table class="table">
					<tr>
		                <th width="10%">商品名称</th>
		                <td width="40%">${product.goods.name}</td>
		                <th width="10%">商品编码</th>
		                <td width="40%">${product.goods.code}</td>
	              	</tr>
	              	<tr>
		                <th width="10%">展示图</th>
		                <td colspan="3">
		                	<img onerror="imgOnerror(this);"  class="img-responsive" src="${imgHost }${product.goods.samplePhoto}" style="max-height:300px;max-width:300px;">
		                </td>
	              	</tr>
				</table>
			</div>
		</section>
		
		<section class="invoice">
			<p class="lead">所属产品信息</p>
			<div class="table-responsive">
				<table class="table">
					<tr>
		                <th width="10%">产品名称</th>
		                <td width="40%">${product.produce.name}</td>
		                <th width="10%">产品编码</th>
		                <td width="40%">${product.produce.code}</td>
	              	</tr>
				</table>
			</div>
		</section>
		
		<section class="invoice">
			<p class="lead">货品信息</p>
			<div class="table-responsive">
				<table class="table">
					<tr>
		                <th width="10%">货品编码</th>
		                <td width="40%">${product.code}</td>
		                <th width="10%">货品电子码</th>
		                <td width="40%">${product.scanCode}</td>
	              	</tr>
	              	<tr>
                        <th width="10%">采购价</th>
                        <td width="10%"><span class="text-red">${product.pricePurchase}</span></td>
                        <th width="10%">所属供应商</th>
                        <td width="10%">${product.supplier.name }</td>
                    </tr>
	              	<tr>
		                <th width="10%">原厂编码</th>
		                <td width="40%">${product.factoryCode }</td>
		                <th width="10%">证书编号</th>
		                <td width="40%">${product.certificateNo }</td>
	              	</tr>
	              	<tr>
		                <th width="10%">状态</th>
		                <td width="40%">
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
	              		<th width="10%">持有人</th>
		                <td colspan="3">${fns:getUserById(product.holdUser.id).name }</td>
	              	</tr>
	              	<tr>
		                <th width="10%">货位编号</th>
		                <td width="40%">${product.wareplace.warecounter.warearea.warehouse.code}-${product.wareplace.warecounter.warearea.code}-${product.wareplace.warecounter.code}-${product.wareplace.code}</td>
		                <th width="10%">货品克重</th>
		                <td width="40%">${product.weight}</td>
	              	</tr>
	              	<tr>
                        <th width="10%">备注</th>
                        <td colspan="3"><p class="text-muted well well-sm no-shadow">${product.remarks}</p></td>
                    </tr>
				</table>
			</div>
			<div class="row no-print">
	       		<div class="col-xs-12">
	       			<button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
	       		</div>
			</div>
		</section>
	</div>
</body>
</html>