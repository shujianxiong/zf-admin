<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>体验单管理</title>
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
        <div class="box box-primary">
            <div class="box-header with-border zf-query">
                <h5>体验单基本信息</h5>
                <div class="box-tools">
                    <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                </div>
                <div class="box-body">
                    <div class="table-responsive">
                         <table class="table">
                            <tr>
                                <th width="10%">订单编号</th>
                                <td>${experienceOrder.orderNo}</td>
                            </tr>
                            <tr>
                                <th width="10%">订单类型</th>
                                <td><span class="label label-primary">${fns:getDictLabel(experienceOrder.type,'bus_oe_experience_order_type','')}</span></td>
                                <th width="10%">支付状态</th>
                                <td><span class="label label-primary">${fns:getDictLabel(experienceOrder.statusPay,'bus_order_statusPay','')}</span></td>
                            </tr>
                            <tr>
                                <th width="10%">系统订单状态</th>
                                <td><span class="label label-primary">${fns:getDictLabel(experienceOrder.statusSystem,'bus_oe_experience_order_statusSystem','')}</span></td>
                                <th width="10%">会员订单状态</th>
                                <td><span class="label label-primary">${fns:getDictLabel(experienceOrder.statusMember,'bus_oe_experience_order_statusMember','')}</span></td>
                            </tr>
                            <tr>
                               <th width="10%">会员账号</th>
                                <td>${fns:getMemberById(experienceOrder.member.id).usercode}</td>
                                <th width="10%">下单会员权限</th>
                                <td><span class="label label-primary">${experiencePack.name}</span></td>
                            </tr>
                            <tr>
                                <th width="10%">订单备注</th>
                                <td colspan="3">${experienceOrder.memberRemarks}</td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <div class="box box-primary">
            <div class="box-header with-border zf-query">
                <h5>收货地址信息</h5>
                <div class="box-tools">
                    <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                </div>
            </div>
            <div class="box-body">
                <div class="table-responsive">
                    <table class="table table-bordered table-hover table-striped zf-tbody-font-size">
                        <thead>
                        <tr>
                            <th>姓名</th>
                            <th>联系电话</th>
                            <th>收货地址</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>
                                ${experienceOrder.receiveName}
                            </td>
                            <td>
                                ${experienceOrder.receiveTel}
                            </td>
                            <td>
                                ${experienceOrder.receiveAreaStr}&nbsp;&nbsp;${experienceOrder.receiveAreaDetail }
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="box box-primary">
            <div class="box-header with-border zf-query">
                <h5>商品信息</h5>
                <div class="box-tools">
                    <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                </div>
            </div>
            <div class="box-body">
                <div class="table-responsive">
                    <table class="table table-bordered table-hover table-striped zf-tbody-font-size">
                        <thead>
                        <tr>
                            <th>名称</th>
                            <th>产品编码</th>
                            <th>展示图</th>
                            <th>数量</th>
                            <th>保证金</th>
                            <th>体验费</th>
                            <th>体验状态</th>
                            <th>质检类型</th>
                            <th>赔偿金额</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${experienceOrder.epList }" var="ep" >
                            <c:choose>
                                <c:when test="${ep.returnProduce != null }">
                                    <c:forEach items="${ep.returnProduce.returnProductList}" var="returnProduct">
                                        <tr>
                                            <td>${ep.goodsTitle }&nbsp;&nbsp;${ep.produceName }</td>
                                            <td>${ep.produce.code}</td>
                                            <td><img src="${imgHost }${ep.produce.goods.icon}" data-big data-src="${imgHost }${ep.produce.goods.icon}" width="20px;" height="20px;"/></td>
                                            <td><span class="text-red">1</span></td>
                                            <td><span class="text-red">${ep.produce.priceSrc}</span></td>
                                            <td><span class="text-red">${ep.produce.experienceFee}</span></td>
                                            <td>${fns:getDictLabel(ep.status, 'bus_oe_experience_produce_status', '')}</td>
                                            <td>${fns:getDictLabel(returnProduct.damageType, 'bus_or_repair_order_breakdownType', '')}</td>
                                            <td>${returnProduct.decMoney}</td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td>${ep.goodsTitle }&nbsp;&nbsp;${ep.produceName }</td>
                                        <td>${ep.produce.code}</td>
                                        <td><img src="${imgHost }${ep.produce.goods.icon}" data-big data-src="${imgHost }${ep.produce.goods.icon}" width="20px;" height="20px;"/></td>
                                        <td><span class="text-red">${ep.num }</span></td>
                                        <td><span class="text-red">${ep.produce.priceSrc}</span></td>
                                        <td><span class="text-red">${ep.produce.experienceFee}</span></td>
                                        <td>${fns:getDictLabel(ep.status, 'bus_oe_experience_produce_status', '')}</td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

      <div class="box box-primary">
            <div class="box-header with-border zf-query">
                <h5>订单配送信息</h5>
                <div class="box-tools">
                    <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                </div>
                <div class="box-body">
                    <div class="table-responsive">
                        <table class="table">
                            <tr>
                                <th width="10%">订单发货时间</th>
                                <td><fmt:formatDate value="${sendOrder.sendDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                            </tr>
                            <tr>
                                <th width="10%">预计收货时间</th>
                                <td><%-- <fmt:formatDate value="${experienceOrder.expressTime}" pattern="yyyy-MM-dd HH:mm:ss"/> --%></td>
                                <th width="10%">预计退货时间</th>
                                <td></td>
                            </tr>
                            <tr>
                                <th width="10%">实际签收时间</th>
                                <td></td>
                                <th width="10%">收货确认时间</th>
                                <td></td>
                            </tr>
                            <tr>
                                <th width="10%">实际预约归还时间</th>
                                <td></td>
                                <th width="10%">快递揽件时间</th>
                                <td></td>
                            </tr>
                            <tr>
                                <th width="10%">预计到仓时间</th>
                                <td></td>
                                 <th width="10%">实际到仓时间</th>
                                <td></td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="box box-primary">
            <div class="box-header with-border zf-query">
                <h5>物流信息</h5>
                <div class="box-tools">
                    <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                </div>
                <div class="box-body">
                    <div class="table-responsive">
                        <table class="table">
                            <tr>
                                <th id="sendRouteInfo" width="10%"><a>去程物流信息</a></th>
                                <td><span class="label label-primary"></span></td>
                                <th id="returnRouteInfo" width="10%"><a>回程物流信息</a></th>
                                <td><span class="label label-primary"></span></td>
                            </tr>
                            <tr>
                                <th width="10%">是否拒收退货</th>
                                <td><span class="label label-primary"></span></td>
                                <th width="10%">原因是否合理</th>
                                <td><span class="label label-primary"></span></td>
                            </tr>
                            <tr>
                                <th width="10%">退货邮寄时间</th>
                                <td><span class="text-red"></span></td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="box box-primary">
            <div class="box-header with-border zf-query">
                <h5>订单费用信息</h5>
                <div class="box-tools">
                    <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                </div>
                <div class="box-body">
                    <div class="table-responsive">
                        <table class="table">
                            <tr>
                                <th width="10%">订单总额</th>
                                <td><span class="text-red">${experienceOrder.moneyTotal}</span></td>
                            </tr>
                            <tr>
                                <th width="10%">保证金</th>
                               <td><span class="text-red">${experienceOrder.moneyProduce}</span></td>
                                <th width="10%">体验费</th>
                                <td><span class="text-red">${experienceOrder.moneyExperience}</span></td>
                            </tr>
                            <tr>
                                <th width="10%">去程运费</th>
                                <td><span class="text-red">${experienceOrder.moneyLgt}</span></td>
                                <th width="10%">回程运费</th>
                                <td><span class="text-red">${experienceOrder.moneyBackLgt}</span></td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>

       <div class="box box-primary">
            <div class="box-header with-border zf-query">
                <h5>订单结算信息</h5>
                <div class="box-tools">
                    <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                </div>
                <div class="box-body">
                    <div class="table-responsive">
                        <table class="table">
                            <tr>
                                <th width="10%">应退保证金</th>
                                <td><span class="label label-primary">${experienceOrder.moneySettSrcReturn}</span></td>
                            </tr>
                            <tr>
                                <th width="10%">损坏赔偿(金额)</th>
                               <td><span class="text-red">${experienceOrder.moneySettDec}</span></td>
                                <th width="10%">超期滞纳金</th>
                                <td><span class="text-red">${experienceOrder.moneySettOverdue}</span></td>
                            </tr>
                            <tr>
                                <th width="10%">购买抵扣</th>
                                <td><span class="text-red">${experienceOrder.moneySettDec }</span></td>
                            </tr>
                            <tr>
                                <th width="10%">实际退款</th>
                                <td><span class="text-red">${experienceOrder.moneySettReturn}</span></td>
                            </tr>
                            <tr>
                                <th width="10%">是否超期</th>
                               <td><span class="text-red"></span></td>
                                <th width="10%">超期时间</th>
                                <td><span class="label label-primary"></span></td>
                            </tr>
                            <tr>
                                <th width="10%">是否已自动转购买</th>
                                <td><span class="text-red"></span></td>
                            </tr>
                            <tr>
                                <th width="10%">是否欠款</th>
                                <td><span>
                                <c:choose>
                                    <c:when test="${experienceOrder.statusSystem eq '100' }">
                                        <span class="text-red">是</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-red">否</span>
                                    </c:otherwise>
                                </c:choose>
                                </span></td>
                            </tr>
                            <tr>
                                <th width="10%">欠款金额</th>
                               <td><span class="text-red">${experienceOrder.arrearageAmount}</span></td>
                                <th width="10%">支付时间</th>
                                <td><fmt:formatDate value="${experienceOrder.payTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="box box-primary">
            <div class="box-header with-border zf-query">
                <h5>售后信息</h5>
                <div class="box-tools">
                    <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                </div>
                <div class="box-body">
                    <div class="table-responsive">
                         <table class="table table-bordered table-hover table-striped zf-tbody-font-size">
                        <thead>
                        <tr>
                            <th>申请售后订单状态</th>
                            <th>申请类型</th>
                            <th>处理结果</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${serviceApply}" var="sa" >
                            <tr>
                                <td><span class="label label-primary">${fns:getDictLabel(sa.applyTimeType, 'ser_sa_service_apply_applyTimeType', '')}</span></td>
                                <td><span class="label label-primary">${fns:getDictLabel(sa.applyDealType, 'ser_sa_service_apply_applyDealType', '')}</span></td>
                                <td><span class="label label-primary">${fns:getDictLabel(sa.dealResultType, 'ser_sa_service_apply_dealResultType', '')}</span></td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    </div>
                </div>
            </div>
        </div>
        <div class="row no-print">
	        <div class="col-xs-12">
	       		<button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
	       	</div>
		</div>
    </section>
    <div id="infoModal" class="modal fade" data-backdrop="false" data-keyboard="false" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog" style="width: 1500px; height: 700px;">
            <div class="modal-content" style="width: 100%; height: 100%;">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"
                            aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title"></h4>
                </div>
                <div class="modal-body" style="width: 100%; height: 80%;">
                    <%--<iframe id="infoIframe" src="" width="100%" height="100%" frameborder="0"></iframe>--%>
                    <ul  id="infoBody" class="timeline"></ul>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal -->
    </div>
    
</div>
<script type="text/javascript">
$(function() {
	ZF.bigImg();
    $("#sendRouteInfo").on('click',function() {
        $('.modal-title').text("查看去程物流信息");
        $("#infoBody").html('');
        const sendRouteInfo = ${fns:toJson(sendRouteInfo)};
        if(sendRouteInfo){
            let html = ""
            const routeList = sendRouteInfo.routeList;
            for(let i=0;i<routeList.length;i++){
                html+="<li class='time-label' style='margin-bottom: 0px;'><span style='padding: 0px' class='bg-blue'>"+routeList[i].acceptTime+"</span></li>";
                html+="<li style='margin-bottom: 0px;'> <div class='timeline-item'><div style='padding: 0px; font-weight: bolder' class='timeline-body'>"+routeList[i].remark+"</div></div> </li>";
            }
            $("#infoBody").html(html);
        }else {
            $("#infoBody").html('暂无信息');
        }
        $("#infoModal").modal('toggle');//显示模态框
    });
    $("#returnRouteInfo").on('click',function() {
        $('.modal-title').text("查看回程物流信息");
        $("#infoBody").html('');
        const returnRouteInfo = ${fns:toJson(returnRouteInfo)};
        console.info(returnRouteInfo);
        if(returnRouteInfo){
            let html = ""
            const routeList = returnRouteInfo.routeList;
            for(let i=0;i<routeList.length;i++){
                html+="<li class='time-label' style='margin-bottom: 0px;'><span style='padding: 0px' class='bg-blue'>"+routeList[i].acceptTime+"</span></li>";
                html+="<li style='margin-bottom: 0px;'> <div class='timeline-item'><div style='padding: 0px; font-weight: bolder' class='timeline-body'>"+routeList[i].remark+"</div></div> </li>";
            }
            $("#infoBody").html(html);
        }else {
            $("#infoBody").html('暂无信息');
        }
        $("#infoModal").modal('toggle');//显示模态框
    });
});
</script>
</body>
</html>