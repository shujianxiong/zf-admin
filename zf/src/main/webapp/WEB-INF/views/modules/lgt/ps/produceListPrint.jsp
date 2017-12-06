<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>产品打印</title>
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
        
        <section class="content-header content-header-menu">
        </section>
        
        <section class="invoice">
            <p class="lead" style="text-align: center;">产品打印</p>
            <div class="row">
                <div class="pull-right">
                    <button type="button" class="btn btn-sm btn-dropbox" onclick="toPrint()"><i class="fa fa-print">打印</i></button>&nbsp;&nbsp;&nbsp;&nbsp;
                </div>
            </div>
            <div class="table-responsive">
                <table class="table table-striped">
                    <thead>
                        <tr>
	                        <th width="25px;">商品图片</th>
	                        <th width="10px;">商品分类</th>
	                        <th width="20px;">商品名称(编码)</th>
	                        <th width="20px;">产品名称(编码)</th>
	                        <th width="20px;">属性</th>
	                        <th width="10px;">采购价</th>
                            <th width="10px;">销售价</th>
                            <th width="20px;">可用</th>
                            <th width="20px;">冻结</th>
                        </tr>
                    </thead>
                    <tbody>
	                    <c:forEach items="${list}" var="p" varStatus="status">
	                        <tr>
	                            <td><img data-big data-src="${imgHost}${p.goods.icon }"  src="${imgHost}${p.goods.icon }" width="40px" height="40px"/></td>
	                            <td>${p.goods.category.categoryName }</td>
	                            <td>${p.goods.name }<br/>${p.goods.code }</td>
	                            <td>${p.name }<br/>${p.code }</td>
	                            <td>
	                               <c:forEach items="${p.producePropValues }" var="ppv">
	                                   ${ppv.property.propName }: ${ppv.propvalue.pvalueName }<br/>
	                               </c:forEach>
	                            
	                            </td>
	                            <td>${p.pricePurchase }</td>
	                            <td>${p.priceSrc }</td>
	                            <td>${p.stockNormal }</td>
	                            <td>${p.stockLock }</td>
	                        </tr>
	                    </c:forEach>
	                 </tbody>
                </table>
            </div>
        </section>
    </div>
    <script type="text/javascript">
        $(function() {
        	ZF.bigImg();
        });
        
        function toPrint() {
            $(".row").hide();
            print();
            $(".row").show();
        }
    </script>
</body>
</html>