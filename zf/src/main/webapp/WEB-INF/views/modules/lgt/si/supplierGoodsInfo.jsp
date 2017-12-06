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
            <p class="lead" style="text-align: center;">供应商产品明细</p>
            <div class="table-responsive">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>商品样图</th>
                            <th>商品名称</th>
                            <th>工费</th>
                            <th>起板费</th>
                            <th>电金工艺</th>
	                        <th>电金颜色</th>
	                        <th>电金厚度</th>
	                        <th>电金价格</th>
                            <th>创建时间</th>
                            <th>更新时间</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${list}" var="supplierProduce" varStatus="status">
                            <tr style="background-color: #00c0ef;">
                                <td><img src="${imgHost }${supplierProduce.goods.samplePhoto}" data-big data-src="${imgHost }${supplierProduce.goods.samplePhoto}" width="20px" height="20px"/></td>
                                <td>${supplierProduce.goods.name }</td>
                                <td>${supplierProduce.workFee }</td>
                                <td>${supplierProduce.templetFee }</td>
                                <td><span class="label label-primary">${fns:getDictLabel(supplierProduce.electrolyticGoldCrafts, 'lgt_si_supplier_produce_egCrafts', '' )}</span></td>
                                <td><span class="label label-primary">${fns:getDictLabel(supplierProduce.electrolyticGoldColour, 'lgt_si_supplier_produce_egColour', '') }</span></td>
                                <td>${supplierProduce.electrolyticGoldThickness }</td>
                                <td>${supplierProduce.electrolyticGoldPrice }</td>
                                
                                <td><fmt:formatDate value="${supplierProduce.createDate}"
                                        pattern="yyyy-MM-dd" /></td>
                                <td><fmt:formatDate value="${supplierProduce.updateDate}"
                                        pattern="yyyy-MM-dd" /></td>
                            </tr>
                            <c:if test="${not empty supplierProduce.spList }">
                               <tr>
                                   <td colspan="10">
                                        <table class="table table-condensed">
                                            <thead>
                                                <tr>
                                                    <th></th>
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
                                            </thead>
                                            <tbody>
                                                <c:forEach items="${supplierProduce.spList }" var="sp">
                                                   <tr>
                                                        <td>&nbsp;</td>
                                                        <td>${sp.produce.name }</td>
                                                        <td>${supplierProduce.inlayFee }</td>
                                                        <td>${supplierProduce.inlayNum }</td>
                                                        <td>${sp.goldPrice }</td>
                                                        <td>${sp.lossFee }</td>
                                                        <td>${supplierProduce.goldWeightMax }</td>
                                                        <td>${supplierProduce.goldWeightMin }</td>
                                                        <td>${sp.mainStoneWeight }</td>
                                                        <td>${sp.mainStonePrice }</td>
                                                        <td>${sp.subsidiaryStoneWeight }</td>
                                                        <td>${sp.subsidiaryStonePrice }</td>
                                                        <td>${sp.pricePurchaseMax }</td>
                                                        <td>${sp.pricePurchaseMin }</td>
                                                  </tr>             
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                   </td>
                               </tr>
                            </c:if>
                        </c:forEach>
                     </tbody>
                </table>
            </div>
            
            <div class="row no-print">
                <div class="col-xs-12">
                    <button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
                </div>
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