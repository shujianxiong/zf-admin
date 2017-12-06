<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>货品打印</title>
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
            <p class="lead" style="text-align: center;">货品打印</p>
            <div class="row">
                <div class="pull-right">
                    <button type="button" class="btn btn-sm btn-dropbox" onclick="toPrint()"><i class="fa fa-print">打印</i></button>&nbsp;&nbsp;&nbsp;&nbsp;
                </div>
            </div>
            <div class="table-responsive">
                <table class="table table-striped">
                    <thead>
                        <tr>
	                        <th width="10%">商品图片</th>
	                        <th width="10%">商品分类</th>
	                        <th width="10%">规格</th>
	                        <th width="10%">货品编码</th>
	                        <th width="10%">货位</th>
	                        <th width="10%">克重</th>
                        </tr>
                    </thead>
                    <tbody>
	                    <c:forEach items="${list}" var="t" varStatus="status">
	                        <tr>
	                            <td><img  onerror="imgOnerror(this);" data-big data-src="${imgHost}${t.goods.samplePhoto }" src="${imgHost}${t.goods.samplePhoto }" width="40px;" height="40px;"/></td>
	                            <td>${t.goods.category.categoryName }</td>
	                            <td>${t.produce.name }</td>
	                            <td>${t.code }</td>
	                            <td>${t.wareplace.warecounter.warearea.warehouse.code }-${t.wareplace.warecounter.warearea.code }-${t.wareplace.warecounter.code}-${t.wareplace.code}</td>
	                            <td>${t.weight }</td>
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