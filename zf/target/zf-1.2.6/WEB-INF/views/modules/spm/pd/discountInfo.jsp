<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>产品促销记录管理</title>
    <meta name="decorator" content="adminLte"/>
    <style type="text/css">
        tr{ 
            cursor: pointer;    /*手形*/   
        } 
    </style>
</head>
<body>
<div class="content-wrapper sub-content-wrapper">
    
	<section class="content-header content-header-menu">
    </section>        

	<section class="invoice">
		<p class="lead">基本信息</p>
        <div class="table-responsive">
            <table class="table">
                <tr>
                    <th width="10%">促销折扣</th>
                    <td colspan="3"><span class="text-red">${discount.discountFilterScale }</span></td>
                </tr>
                <tr>
                    <th width="10%">体验押金比例</th>
                    <td colspan="3"><span class="text-red">${discount.scaleExperienceDeposit }</span></td>
                </tr>
                <tr>
                    <th width="10%">积分可低金额</th>
                    <td colspan="3"><span class="text-red">${discount.priceDecPoint }</span></td>
                </tr>
                <tr>
                    <th width="10%">促销生效时间</th>
                    <td colspan="3"><span class="text-red"><fmt:formatDate value="${discount.discountFilterStart}" pattern="yyyy-MM-dd HH:mm:ss"/></span></td>
                </tr>
                <tr>
                    <th width="10%">促销失效时间</th>
                    <td colspan="3"><span class="text-red"><fmt:formatDate value="${discount.discountFilterEnd}" pattern="yyyy-MM-dd HH:mm:ss"/></span></td>
                </tr>
                <tr>
                    <th width="10%">操作人</th>
                    <td colspan="3">${fns:getUserById(discount.createBy.id).name }</td>
                </tr>
                <tr>
                    <th width="10%">操作时间</th>
                    <td colspan="3"><fmt:formatDate value="${discount.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                </tr>
                <tr>
                    <th width="10%">备注</th>
                    <td colspan="3"><p class="text-muted well well-sm no-shadow">${discount.remarks}</p></td>
                </tr>
            </table>
        </div>
    </section>
    
    <section class="invoice">
        <p class="lead">筛选条件</p>
        <div class="table-responsive">
            <table class="table table-striped">
                <c:forEach items="${discount.propertyList }" var="p" varStatus="stats">
                    <tr>
                        <th width="10%">${p.propName }</th>
                        <td width="40%">
                            <c:forEach items="${p.propvalueList }" var="pv">
                                ${pv.pvalueName }&nbsp;&nbsp;
                            </c:forEach>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </section>
    
    <section class="invoice">
        <p class="lead">关联产品</p>
        <div class="table-responsive">
            <table class="table table-bordered table-hover table-striped zf-tbody-font-size">
                <tr>
                	<th>样图</th>
                    <th>产品编码</th>
                    <th>名称</th>
                    <th>标准克重</th>
                    <th>采购价</th>
                    <th>运算成本价</th>
                    <th>运算加价系数</th>
                    <th>销售价</th>
                    <th>体验费比例</th>
                    <th>体验押金比例</th>
                    <th>积分可抵金额</th>
                    <th>促销特价</th>
                    <th>促销折扣</th>
                    <th>促销筛选折扣</th>
                    <th>促销生效时间</th>
                    <th>促销失效时间</th>
                </tr>
                <c:forEach items="${discount.produceItemList }" var="pi" >
                    <tr>
                        <td><img onerror="imgOnerror(this);" src="${imgHost }${pi.produce.goods.samplePhoto}" data-big data-src="${imgHost }${pi.produce.goods.samplePhoto}" width="60px;" height="60px;"/></td>
                        <td>${pi.produce.code }</td>
                        <c:set var="fullName" value="${pi.produce.goods.name } ${pi.produce.name }"></c:set>
                        <td title="${fullName }">${fns:abbr(fullName, 15)}</td>
                        <td>${pi.preItem.standardWeight } <i class="fa fa-arrow-right" style="color: #CDC9C9;"></i> ${pi.standardWeight }</td>
                        <td>
                            <c:if test="${pi.preItem.pricePurchase ne pi.pricePurchase }"><span class='text-red'></c:if>
                            ${pi.preItem.pricePurchase }  <i class="fa fa-arrow-right" style="color: #CDC9C9;"></i>  ${pi.pricePurchase }
                            <c:if test="${pi.preItem.pricePurchase ne pi.pricePurchase }"></span></c:if>
                            
                        </td>
                        <td>
                            <c:if test="${pi.preItem.priceOperation ne pi.priceOperation }"><span class='text-red'></c:if>
                            ${pi.preItem.priceOperation }  <i class="fa fa-arrow-right" style="color: #CDC9C9;"></i>  ${pi.priceOperation }
                            <c:if test="${pi.preItem.priceOperation ne pi.priceOperation }"></span></c:if>
                        </td>
                        <td>
                            <c:if test="${pi.preItem.ratioOperation ne pi.ratioOperation }"><span class='text-red'></c:if>
                            ${pi.preItem.ratioOperation }  <i class="fa fa-arrow-right" style="color: #CDC9C9;"></i>  ${pi.ratioOperation }
                            <c:if test="${pi.preItem.ratioOperation ne pi.ratioOperation }"></span></c:if>
                        </td>
                        <td>
                            <c:if test="${pi.preItem.priceSrc ne pi.priceSrc }"><span class='text-red'></c:if>
                            ${pi.preItem.priceSrc }  <i class="fa fa-arrow-right" style="color: #CDC9C9;"></i>  ${pi.priceSrc }
                            <c:if test="${pi.preItem.priceSrc ne pi.priceSrc }"></span></c:if>
                        </td>
                        <td>
                            <c:if test="${pi.preItem.scaleExperienceFee ne pi.scaleExperienceFee }"><span class='text-red'></c:if>
                            ${pi.preItem.scaleExperienceFee }  <i class="fa fa-arrow-right" style="color: #CDC9C9;"></i>  ${pi.scaleExperienceFee }
                            <c:if test="${pi.preItem.scaleExperienceFee ne pi.scaleExperienceFee }"></span></c:if>
                        </td>
                        <td>
                            <c:if test="${pi.preItem.scaleExperienceDeposit ne pi.scaleExperienceDeposit }"><span class='text-red'></c:if>
                            ${pi.preItem.scaleExperienceDeposit }  <i class="fa fa-arrow-right" style="color: #CDC9C9;"></i>  ${pi.scaleExperienceDeposit }
                            <c:if test="${pi.preItem.scaleExperienceDeposit ne pi.scaleExperienceDeposit }"></span></c:if>
                        </td>
                        <td>
                            <c:if test="${pi.preItem.priceDecPoint ne pi.priceDecPoint }"><span class='text-red'></c:if>
                            ${pi.preItem.priceDecPoint }  <i class="fa fa-arrow-right" style="color: #CDC9C9;"></i>  ${pi.priceDecPoint }
                            <c:if test="${pi.preItem.priceDecPoint ne pi.priceDecPoint }"></span></c:if>
                        </td>
                        <td>
                            <c:if test="${pi.preItem.discountPrice ne pi.discountPrice }"><span class='text-red'></c:if>
                            ${pi.preItem.discountPrice }  <i class="fa fa-arrow-right" style="color: #CDC9C9;"></i>  ${pi.discountPrice }
                            <c:if test="${pi.preItem.discountPrice ne pi.discountPrice }"></span></c:if>
                        </td>
                        <td>
                            <c:if test="${pi.preItem.discountScale ne pi.discountScale }"><span class='text-red'></c:if>
                            ${pi.preItem.discountScale }  <i class="fa fa-arrow-right" style="color: #CDC9C9;"></i>  ${pi.discountScale }
                            <c:if test="${pi.preItem.discountScale ne pi.discountScale }"></span></c:if>
                        </td>
                        <td>
                            <c:if test="${pi.preItem.discountFilterScale ne pi.discountFilterScale }"><span class='text-red'></c:if>
                            ${pi.preItem.discountFilterScale }  <i class="fa fa-arrow-right" style="color: #CDC9C9;"></i>  ${pi.discountFilterScale }
                            <c:if test="${pi.preItem.discountFilterScale ne pi.discountFilterScale }"></span></c:if>
                        </td>
                        <td>
                            <c:if test="${pi.preItem.discountFilterStart ne pi.discountFilterStart }"><span class='text-red'></c:if>
                            <fmt:formatDate value="${pi.preItem.discountFilterStart}" pattern="yyyy-MM-dd HH:mm:ss"/></span> <br/> <i class="fa fa-arrow-down" style="color: #CDC9C9;"></i> <br/><span class='text-red'><fmt:formatDate value="${pi.discountFilterStart}" pattern="yyyy-MM-dd HH:mm:ss"/>
                            <c:if test="${pi.preItem.discountFilterStart ne pi.discountFilterStart }"></span></c:if>
                        </td>
                        <td>
                            <c:if test="${pi.preItem.discountFilterEnd ne pi.discountFilterEnd }"><span class='text-red'></c:if>
                            <fmt:formatDate value="${pi.preItem.discountFilterEnd}" pattern="yyyy-MM-dd HH:mm:ss"/></span><br/>  <i class="fa fa-arrow-down" style="color: #CDC9C9;"></i> <br/><span class='text-red'><fmt:formatDate value="${pi.discountFilterEnd}" pattern="yyyy-MM-dd HH:mm:ss"/>
                            <c:if test="${pi.preItem.discountFilterEnd ne pi.discountFilterEnd }"></span></c:if>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </section>
        
    <section class="invoice">
        <div class="box-footer">
            <button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)">
            	<i class="fa fa-mail-reply"></i>返回
        	</button>
		</div>
	</section>
	     
	<script type="text/javascript">
		$(function() {
			ZF.bigImg();
		});
	</script>
</div>
</body>
</html>