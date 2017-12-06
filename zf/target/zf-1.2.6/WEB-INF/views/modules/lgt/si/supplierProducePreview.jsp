<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>供应商产品打印</title>
    <meta name="decorator" content="adminLte"/>
    <style type="text/css">
        .watermark {
            width: 90%;
		    height: 30%;
		    margin-top: 20%;
		    margin-left: 30%;
		    position: fixed;
		    z-index: 100;
		    top: 0px;
		    left: 0px;
		    background-color: #f6f6f6;
		    filter: alpha(opacity=4);
		    -moz-opacity: 0.05;
		    opacity: 0.05;
		    font-size: 100px;
		    color: White;
		    transform:rotate(10deg);
            -ms-transform:rotate(10deg);
            -webkit-transform:rotate(10deg);
        }
    </style>
</head>
<body>
<div class="content-wrapper sub-content-wrapper">
        <h1 class="watermark text-red">${supplier.name }</h1>
        
        <section class="content-header content-header-menu">
        </section>
        
        <section class="invoice">
            <p class="lead" style="text-align: center;">${supplier.name }</p>
            <div class="row">
                <div class="pull-right">
                    <button type="button" class="btn btn-sm btn-dropbox" onclick="toPrint()"><i class="fa fa-print">打印</i></button>&nbsp;&nbsp;&nbsp;&nbsp;
                </div>
            </div>
            <div class="table-responsive">
                <table class="table table-striped">
                    <thead>
                        <tr>
	                        <th width="10%">商品名称</th>
	                        <th width="10%">工费</th>
	                        <th width="10%">起板费</th>
	                        <th width="6%">电金工艺</th>
                            <th width="6%">电金颜色</th>
                            <th width="6%">电金厚度(mm)</th>
                            <th width="6%">电金价格</th>
	                        <th width="10%">创建时间</th>
	                        <th width="10%">更新时间</th>
                        </tr>
                    </thead>
                    <tbody>
	                    <c:forEach items="${list}" var="supplierProduce" varStatus="status">
	                        <tr>
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
	                               <td colspan="8">
		                                <table class="table table-condensed">
						                    <thead>
						                        <tr>
						                            <th width="5%"></th>
						                            <th width="6%">产品名称</th>
						                            <th width="5%">镶口费</th>
                                                    <th width="5%">镶口数</th>
							                        <th width="5%">金价</th>
							                        <th width="5%">损耗</th>
							                        <th width="5%">金重上限</th>
							                        <th width="5%">金重下限</th>
							                        <th width="5%">主石重量</th>
							                        <th width="5%">主石价格</th>
							                        <th width="5%">辅石重量</th>
							                        <th width="5%">辅石价格</th>
						                        </tr>
						                    </thead>
						                    <tbody>
						                        <c:forEach items="${supplierProduce.spList }" var="sp">
										           <tr>
										                <td>&nbsp;</td>
							                            <td>${sp.produce.name }</td>
							                            <td>${sp.inlayFee }</td>
                                                        <td>${sp.inlayNum }</td>
							                            <td>${sp.goldPrice }</td>
							                            <td>${sp.lossFee }</td>
							                            <td>${sp.goldWeightMax }</td>
							                            <td>${sp.goldWeightMin }</td>
							                            <td>${sp.mainStoneWeight }</td>
							                            <td>${sp.mainStonePrice }</td>
							                            <td>${sp.subsidiaryStoneWeight }</td>
							                            <td>${sp.subsidiaryStonePrice }</td>
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
        </section>
    </div>
    <script type="text/javascript">
        function toPrint() {
        	$(".row").hide();
        	print();
        	$(".row").show();
        }
    </script>
</body>
</html>