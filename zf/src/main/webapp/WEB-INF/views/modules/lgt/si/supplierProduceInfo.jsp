<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>供应商产品管理</title>
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
                        <th width="10%">商品名称</th>
                        <td>${goods.name }</td>
                        <th width="10%">状态</th>
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
                    </tr>
                    <tr>
                        <th width="10%">英文名称</th>
                        <td>${property.propName }</td>
                        <th width="10%">商品分类</th>
                        <td width="40%">${goods.category.categoryName}</td>
                    </tr>
                    <tr>
                        <th width="10%">商品编码</th>
                        <td>${goods.code }</td>
                        <th width="10%">原厂编码</th>
                        <td width="40%">${goods.factoryCode }</td>
                    </tr>
                    <tr>
                        <th width="10%">设计师</th>
                        <td>${goods.designer.name }</td>
                        <th width="10%">品牌</th>
                        <td width="40%">${goods.brand.name }</td>
                    </tr>
                    <tr>
                        <th width="10%">标签</th>
                        <td colspan="3">
                            <c:forEach items="${tagsList}" var="tag">
                                <span class="label label-primary">${tag.name }</span>
                            </c:forEach>
                        </td>
                    </tr>
                    <tr>
                        <th width="10%">备注</th>
                        <td colspan="3"><p class="text-muted well well-sm no-shadow">${goods.remarks}</p></td>
                    </tr>
                </table>
            </div>
        </section>
        
        <section class="invoice">
            <p class="lead">商品配置</p>
            <div class="table-responsive">
                <table class="table">
                    <tr>
                        <th width="10%">业务设置</th>
                        <td>
                                <c:choose>
                                    <c:when test="${goods.isCouponUsable eq '1' }">
                                        <span class="label label-success">可使用优惠券</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="label label-primary">禁止使用优惠券</span>
                                    </c:otherwise>
                                </c:choose>
                                <c:choose>
                                    <c:when test="${goods.isRecommend eq '1' }">
                                        <span class="label label-success">推荐商品</span>
                                    </c:when>
                                </c:choose>
                        
                        </td>
                    </tr>
                </table>
            </div>
        </section>
        
        <section class="invoice">
            <p class="lead">商品属性</p>
            <div class="table-responsive">
                <table class="table table-striped">
                    <c:forEach items="${goods.goodsProp }" var="goodsProp" varStatus="stats">
                        <c:if test="${stats.index%2 == 0 }"><tr></c:if>
                            <th width="10%">${goodsProp.property.propName }</th>
                            <c:forEach items="${goodsProp.goodsPropvalue }" var="goodsPropvalue">
                                <td width="40%">${goodsPropvalue.pvalue }</td>
                            </c:forEach>
                        <c:if test="${stats.index%2 != 0 }"></tr></c:if>
                    </c:forEach>
                </table>
            </div>
        </section>
        
        <section class="invoice">
            <p class="lead">商品关联商品</p>
            <div class="table-responsive">
                <table class="table table-striped">
                    <tr>
                        <th>名称</th>
                        <th>商品编码</th>
                        <th>展示价格</th>
                        <th>展示图(小)</th>
                        <th>状态</th>
                    </tr>
                    <c:forEach items="${relateGoodsList }" var="goods" >
                        <tr>
                            <td>${goods.name }</td>
                            <td>${goods.code }</td>
                            <td><span class="text-red">${goods.price }</span></td>
                            <td><img onerror="imgOnerror(this);"  src="${imgHost }${fn:replace(goods.photo, '|', '')}" width="25px" height="25px" class="img-responsive" /></td>
                            <td><span class="label label-primary">${fns:getDictLabel(goods.status, 'lgt_ps_goods_status', '')}</span></td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </section>
        
        <section class="invoice">
            <p class="lead">产品基本信息</p>
            <div class="table-responsive">
                <table class="table">
                    <tr>
                        <th width="10%">产品编码</th>
                        <td>${produce.code }</td>
                        <th width="10%">产品原厂编码</th>
                        <td width="40%">${produce.factoryCode }</td>
                    </tr>
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
                        <th width="10%">克重</th>
                        <td>${produce.standardWeight }</td>
                        <th width="10%">备注</th>
                        <td width="40%"><p class="text-muted well well-sm no-shadow">${produce.remarks }</p></td>
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
                </table>
            </div>
        </section>
        
        <section class="invoice">
            <p class="lead">产品价格</p>
            <div class="table-responsive">
                <table class="table">
                    <tr>
                        <th width="10%">产品采购价</th>
                        <td><span class="text-red">${produce.pricePurchase }</span></td>
                        <th width="10%">运算采购价</th>
                        <td><span class="text-red">${produce.priceOperation }</span></td>
                    </tr>
                    <tr>
                        <th width="10%">产品销售价</th>
                        <td colspan="3"><span class="text-red">${produce.priceSrc }</span></td>
                    </tr>
                </table>
            </div>
        </section>
        
        <section class="invoice">
            <p class="lead">商品金工石费用</p>
            <div class="table-responsive">
                <table class="table table-striped">
                    <tr>
                        <th>商品名称</th>
                        <th>工费</th>
                        <th>起板费</th>
                        <th>电金工艺</th>
                        <th>电金颜色</th>
                        <th>电金厚度</th>
                        <th>电金价格</th>
                    </tr>
                    <c:forEach items="${spList }" var="supplierProduce" >
                        <tr>
                            <td>${supplierProduce.goods.name }</td>
                            <td>${supplierProduce.workFee }</td>
                            <td>${supplierProduce.templetFee }</td>
                            <td><span class="label label-primary">${fns:getDictLabel(supplierProduce.electrolyticGoldCrafts, 'lgt_si_supplier_produce_egCrafts', '' )}</span></td>
                            <td><span class="label label-primary">${fns:getDictLabel(supplierProduce.electrolyticGoldColour, 'lgt_si_supplier_produce_egColour', '') }</span></td>
                            <td>${supplierProduce.electrolyticGoldThickness }</td>
                            <td>${supplierProduce.electrolyticGoldPrice }</td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </section>
        
        <section class="invoice">
            <p class="lead">商品对应的供应商产品价格</p>
            <div class="table-responsive">
                <table class="table table-striped">
                    <tr>
                        <th>产品名称</th>
                        <th>镶口费</th>
                        <th>镶口数</th>
                        <th>金价</th>
                        <th>损耗</th>
                        <th>金重上限</th>
                        <th>金重下限</th>
                        <th>主石重量</th>
                        <th>主石价格</th>
                        <th>辅石重量</th>
                        <th>辅石价格</th>
                        <th>采购价上限</th>
                        <th>采购价下限</th>
                    </tr>
                    <c:forEach items="${spList }" var="supplierProduce" >
                        <tr>
                            <td>${supplierProduce.produce.name }</td>
                            <td>${supplierProduce.inlayFee }</td>
                            <td>${supplierProduce.inlayNum }</td>
                            <td>${supplierProduce.goldPrice }</td>
                            <td>${supplierProduce.lossFee }</td>
                            <td>${supplierProduce.goldWeightMax }</td>
                            <td>${supplierProduce.goldWeightMin }</td>
                            <td>${supplierProduce.mainStoneWeight }</td>
                            <td>${supplierProduce.mainStonePrice }</td>
                            <td>${supplierProduce.subsidiaryStoneWeight }</td>
                            <td>${supplierProduce.subsidiaryStonePrice }</td>
                            <td>${supplierProduce.pricePurchaseMax }</td>
                            <td>${supplierProduce.pricePurchaseMin }</td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </section>
        
        <section class="invoice">
            <div class="row no-print">
                <div class="col-xs-12">
                    <button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
                </div>
            </div>
        </section>
        
    </div>
</body>
</html>