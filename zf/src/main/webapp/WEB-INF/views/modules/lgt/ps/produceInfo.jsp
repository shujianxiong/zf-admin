<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>产品列表管理-产品修改</title>
	<meta name="decorator" content="adminLte"/>
</head>

<body>
	<div class="content-wrapper sub-content-wrapper">
		
		<section class="content-header content-header-menu">
			
	    </section>
	    
	    <section class="invoice">
	    	<p class="lead">商品基本信息</p>
	    	<div class="table-responsive">
	    		<table class="table">
	    			<tr>
		                <th width="10%">商品编码</th>
		                <td>${produce.goods.code }</td>
		                <th width="10%">商品原厂编码</th>
		                <td>${produce.goods.factoryCode }</td>
	              	</tr>
	              	<tr>
		                <th width="10%">商品名称</th>
		                <td >${produce.goods.name }</td>
		                <th width="10%">商品分类</th>
		                <td width="40%">${produce.goods.category.categoryName }</td>
	              	</tr>
	              	<tr>
		                <th width="10%">商品状态</th>
		                <td colspan="3">
		                	<c:choose>
						        <c:when test="${produce.goods.status=='1'}">
						             <span class="label label-default">${fns:getDictLabel(produce.goods.status, 'lgt_ps_goods_status', '')}</span>
						        </c:when>
						        <c:when test="${produce.goods.status=='2' }">
	                                    <span class="label label-success">${fns:getDictLabel(produce.goods.status, 'lgt_ps_goods_status', '')}</span>
	                               </c:when>
	                               <c:when test="${produce.goods.status=='3' }">
	                                    <span class="label label-primary">${fns:getDictLabel(produce.goods.status, 'lgt_ps_goods_status', '')}</span>
	                               </c:when>
						    </c:choose>
		                </td>
	              	</tr>
	              	<tr>
	              		<th width="10%">展示图</th>
	              		<td colspan="3">
	              			<img onerror="imgOnerror(this);"  class="img-responsive" src="${imgHost }${produce.goods.samplePhoto}" >
	              		</td>
	              	</tr>
	    		</table>
	    	</div>
		</section>
	    
	    <section class="invoice">
	    	<p class="lead">产品基本信息</p>
	    	<div class="table-responsive">
	    		<table class="table">
	              	<tr>
		                <th width="10%">产品名称</th>
		                <td >${produce.name }</td>
		                <th width="10%">产品状态</th>
		                <td >
		                	<c:choose>
								<c:when test="${produce.status == 1 }"><span class="label label-primary">${fns:getDictLabel(produce.status,'lgt_ps_produce_status','') }</span></c:when>
								<c:when test="${produce.status == 2 }"><span class="label label-primary">${fns:getDictLabel(produce.status,'lgt_ps_produce_status','') }</span></c:when>
								<c:when test="${produce.status == 3 }"><span class="label label-primary">${fns:getDictLabel(produce.status,'lgt_ps_produce_status','') }</span></c:when>
								<c:when test="${produce.status == 4 }"><span class="label label-default">${fns:getDictLabel(produce.status,'lgt_ps_produce_status','') }</span></c:when>
								<c:otherwise><span class="label label-danger">${fns:getDictLabel(produce.status,'lgt_ps_produce_status','') }</span></c:otherwise>
							</c:choose>
		                </td>
	              	</tr>
	              	<tr>
		                <th width="10%">产品编码</th>
		                <td>${produce.code }</td>
		                <th width="10%">产品原厂编码</th>
		                <td width="40%">${produce.factoryCode }</td>
	              	</tr>
	              	<tr>
		                <th width="10%">风格类型</th>
		                <td><span class="label label-primary">${fns:getDictLabel(produce.styleType , 'lgt_ps_produce_styleType', '')}</span></td>
		                <th width="10%">销量</th>
                        <td width="40%">${produce.sellNum}</td>
	              	</tr>
	              	<tr>
                        <th width="10%">是否可购买</th>
                        <td><span class="label label-primary">${fns:getDictLabel(produce.isBuy, 'yes_no', '')}</span></td>
                        <th width="10%">是否可体验</th>
                        <td width="40%"><span class="label label-primary">${fns:getDictLabel(produce.isExperience , 'yes_no', '')}</span></td>
                    </tr>
                    <tr>
                        <th width="10%">是否可预购</th>
                        <td><span class="label label-primary">${fns:getDictLabel(produce.isForeBuy , 'yes_no', '')}</span></td>
                        <th width="10%">是否可预约体验</th>
                        <td width="40%"><span class="label label-primary">${fns:getDictLabel(produce.isForeExperience , 'yes_no', '')}</span></td>
                    </tr>
                    <tr>
                        <th width="10%">克重</th>
                        <td colspan="3">${produce.standardWeight }</td>
                    </tr>
	              	<tr>
		                <th width="10%">属性</th>
		                <td colspan="3">
		                	<table id="contentTable" class="table table-striped">
								<c:forEach items="${produce.producePropValues }" var="ppv">
								<tr>
								    <td>${ppv.property.propName }</td>
								    <td>${ppv.propvalue.pvalueName }</td>
								    <td>${ppv.pvalue }</td>
							    </tr>
								</c:forEach>
							</table>
		                </td>
	              	</tr>
	              	<tr>
                        <th width="10%">备注</th>
                        <td colspan="3"><p class="text-muted well well-sm no-shadow">${produce.remarks }</p></td>
                    </tr>
	    		</table>
	    	</div>
	    </section>
	    
	    <section class="invoice">
	    	<p class="lead">产品价格</p>
	    	<div class="table-responsive">
	    		<table class="table">
	    			<tr>
		                <th width="10%">采购价</th>
		                <td><span class="text-red">${produce.pricePurchase }</span></td>
		                <th width="10%">运算成本价</th>
		                <td width="40%"><span class="text-red">${produce.priceOperation }</span></td>
	              	</tr>
	              	<tr>
		                <th width="10%">购买价</th>
		                <td><span class="text-red">${produce.priceSrc }</span></td>
		                <th width="10%">体验费收取比例</th>
		                <td width="40%">${produce.scaleExperienceFee }</td>
	              	</tr>
	              	
	              	
	              	<tr>
                        <th width="10%">体验押金比例</th>
                        <td><span class="text-red">${produce.scaleExperienceDeposit }</span></td>
                        <th width="10%">积分可抵金额</th>
                        <td width="40%"><span class="text-red">${produce.priceDecPoint }</span></td>
                    </tr>
                    <tr>
                        <th width="10%">促销详情</th>
                        <td colspan="3">
                            <c:choose>
                                <c:when test="${not empty produce.discountPrice }">
                                                                        特&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;价：<span class="text-red">${produce.discountPrice }</span></c:when>
                                <c:when test="${not empty produce.discountScale }">
                                                                        折&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;扣：<span class="text-red">${produce.discountScale }</span></c:when>
                                <c:when test="${not empty produce.discountFilterScale }">
                                <span title="起止日期：<fmt:formatDate value='${produce.discountFilterStart}' pattern='yyyy-MM-dd HH:mm:ss'/> - <fmt:formatDate value='${produce.discountFilterEnd}' pattern='yyyy-MM-dd HH:mm:ss'/>">
                                                                         筛选折扣：<span class="text-red">${produce.discountFilterScale }</span>
                                </span>
                                </c:when>
                                <c:otherwise>
                                                                        平台折扣：<span class="text-red">${dspValue }</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
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