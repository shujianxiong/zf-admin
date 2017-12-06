<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>货位存货详情</title>
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
            <p class="lead" style="text-align: center;">货位存货详情</p>
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
	                            <td><img src="${imgHost}${t.goods.icon }" width="40px;" height="40px;"/></td>
	                            <td>${t.goods.category.categoryName }</td>
	                            <td>${t.produce.name }</td>
	                            <td>${t.code }</td>
	                            <td>${t.wareplace.warecounter.warearea.warehouse.name }&nbsp;&nbsp;${t.wareplace.warecounter.warearea.name }&nbsp;&nbsp;${t.wareplace.warecounter.code}&nbsp;&nbsp;${t.wareplace.code}</td>
	                            <td>${t.weight }</td>
	                        </tr>
	                    </c:forEach>
	                 </tbody>
                </table>
            </div>
            <div class="box-footer">
               <button type="button" class="btn btn-default btn-sm"
                   onclick="javascript:history.go(-1)">
                   <i class="fa fa-mail-reply"></i>返回
               </button>
           </div>
        </section>
    </div>
    
</body>
</html>