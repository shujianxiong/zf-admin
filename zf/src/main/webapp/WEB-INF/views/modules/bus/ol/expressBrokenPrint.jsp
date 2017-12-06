<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>责任确认清单打印</title>
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
            <p class="lead" style="text-align: center;">物流公司责任确认清单</p>
            <div class="row">
                <div class="pull-right">
                    <button type="button" class="btn btn-sm btn-dropbox" onclick="toPrint()"><i class="fa fa-print">打印</i></button>&nbsp;&nbsp;&nbsp;&nbsp;
                </div>
            </div>
            <div class="table-responsive">
                <table class="table">
                    <tr>
                        <th style="text-align: center;" >包裹损坏信息</th>
                        <td colspan="3"></td>
                        <th style="text-align: center;">内包装损坏信息</th>
                        <td >
                        </td>
                    </tr>
                    <tr>
                        <th width="10%">包裹损坏类型</th>
                        <td colspan="3"><span class="label label-primary">${fns:getDictLabel(expressBroken.outsideBrokenType,'bus_ol_express_broken_outsideBrokenType','') }</span></td>
                        <th width="396px">内包装损坏类型</th>
                        <td ><span class="label label-primary">${fns:getDictLabel(expressBroken.insideBrokenType,'bus_ol_express_broken_insideBrokenType','') }</span></td>
                    </tr>
                    <tr>
                        <th width="10%"></th>
                        <td colspan="3"></td>
                        <th width="10%">损失赔偿</th>
                        <td>${expressBroken.insideBrokenPrice}</td>
                    </tr>
                </table>
            </div>
            <div class="table-responsive">
                <c:forEach items="${returnOrder.returnProductList}" var="product" varStatus="status">
                <table class="table">
                    <tr>
                        <th  style="text-align: center;">商品损坏信息</th>
                        <td colspan="3"></td>
                    </tr>
                    <tr>
                        <th width="10%">商品名称</th>
                        <td width="396px"><span class="label label-primary">${product.product.goods.name}</span></td>
                    </tr>
                    <tr>
                        <th width="10%">商品破损类型</th>
                        <td width="396px"><span class="label label-primary">${fns:getDictLabel(product.damageType,'bus_or_repair_order_breakdownType','') }</span></td>
                    </tr>
                    <tr>
                        <th width="10%">维修费用</th>
                        <td>${expressBroken.insideBrokenPrice}</td>
                    </tr>
                </table>
                </c:forEach>
            </div>
            <div class="table-responsive">
                    <table class="table">
                        <tr>
                            <th  style="text-align: center;">物流公司信息</th>
                        </tr>
                        <tr>
                            <th width="10%">公司名称</th>
                            <td colspan="3"><span class="label label-primary">${fns:getDictLabel(returnOrder.expressCompany, 'express_company', '')}</span></td>
                        </tr>
                        <tr>
                            <th width="10%">快递员确认签字</th>
                            <td></td>
                        </tr>
                        <tr>
                            <th width="10%">时间</th>
                            <td></td>
                        </tr>
                    </table>
            </div>
        </section>
        <section>
            <div class="box-footer">
                <div class="pull-left box-tools">
                    <button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
                </div>
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