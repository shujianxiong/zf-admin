<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>货位打印</title>
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
            <p class="lead" style="text-align: center;">货位打印</p>
            <div class="row">
                <div class="pull-right">
                    <button type="button" class="btn btn-sm btn-dropbox" onclick="toPrint()"><i class="fa fa-print">打印</i></button>&nbsp;&nbsp;&nbsp;&nbsp;
                </div>
            </div>
            <div class="table-responsive">
                <table class="table table-striped">
                    <thead>
                        <tr>
	                        <th width="10%">货仓</th>
	                        <th width="10%">货区</th>
	                        <th width="10%">货架</th>
	                        <th width="10%">货位编码</th>
	                        <th width="10%">存货量</th>
                        </tr>
                    </thead>
                    <tbody>
	                    <c:forEach items="${list}" var="wp" varStatus="status">
	                        <tr>
	                            <td>${wp.warecounter.warearea.warehouse.name }</td>
	                            <td>${wp.warecounter.warearea.name }</td>
	                            <td>${wp.warecounter.code }</td>
	                            <td>${wp.code }</td>
	                            <td>${wp.stock }</td>
	                        </tr>
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