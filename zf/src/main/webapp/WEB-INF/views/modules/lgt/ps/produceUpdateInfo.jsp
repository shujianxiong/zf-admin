<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>产品更新审批管理</title>
    <meta name="decorator" content="adminLte"/>
    <style type="text/css">
        tr{ 
            cursor: pointer;    /*手形*/   
        } 
    </style>
</head>
<body>
<div class="content-wrapper sub-content-wrapper">
   <section class="content">
            <div class="row">
                <div class="col-md-4">
                    <div class="box box-primary">
                        <div class="box-body box-profile">
                            <ul class="list-group list-group-unbordered">
                                <li class="list-group-item">
                                    <b>产品编码</b> 
                                    <a class="pull-right">${produceUpdate.produce.code }</a>
                                </li>
                                <li class="list-group-item">
                                    <b>产品名称</b> 
                                    <a class="pull-right">${produceUpdate.produce.name }</a>
                                </li>
                                <li class="list-group-item">
                                    <b>采购价</b> 
                                    <a class="pull-right"><span class="text-red">${produceUpdate.srcPricePurchase }</span>→<span class="text-red">${produceUpdate.desPricePurchase }</span></a>
                                </li>
                                <li class="list-group-item">
                                    <b>运算成本价</b> 
                                    <a class="pull-right"><span class="text-red">${produceUpdate.srcPriceOperation }</span>→<span class="text-red">${produceUpdate.desPriceOperation }</span></a>
                                </li>
                                
                                <li class="list-group-item">
                                    <b>是否可购买</b> 
                                    <a class="pull-right"><span class="label label-primary">${fns:getDictLabel(produceUpdate.srcIsBuy,'yes_no','' ) }</span>→<span class="label label-success">${fns:getDictLabel(produceUpdate.desIsBuy,'yes_no','' ) }</span></a>
                                </li>
                                <li class="list-group-item">
                                    <b>购买价格</b> 
                                    <a class="pull-right"><span class="text-red">${produceUpdate.srcPriceBuy }</span>→<span class="text-red">${produceUpdate.desPriceBuy }</span></a>
                                </li>
                                
                                <li class="list-group-item">
                                    <b>购买打折比例</b> 
                                    <a class="pull-right">${produceUpdate.srcScaleDiscount }→${produceUpdate.desScaleDiscount }</a>
                                </li>
                                
                                <li class="list-group-item">
                                    <b>是否可体验</b> 
                                    <a class="pull-right"><span class="label label-primary">${fns:getDictLabel(produceUpdate.srcIsExperience,'yes_no','' ) }</span>→<span class="label label-success">${fns:getDictLabel(produceUpdate.desIsExperience,'yes_no','' ) }</span></a>
                                </li>
                                <li class="list-group-item">
                                    <b>是否可预购</b> 
                                    <a class="pull-right"><span class="label label-primary">${fns:getDictLabel(produceUpdate.srcIsForebuy,'yes_no','' ) }</span>→<span class="label label-success">${fns:getDictLabel(produceUpdate.desIsForebuy,'yes_no','' ) }</span></a>
                                </li>
                                <li class="list-group-item">
                                    <b>是否可预约</b> 
                                    <a class="pull-right"><span class="label label-primary">${fns:getDictLabel(produceUpdate.srcIsForeexperience,'yes_no','' ) }</span>→<span class="label label-success">${fns:getDictLabel(produceUpdate.desIsForeexperience,'yes_no','' ) }</span></a>
                                </li>
                                <li class="list-group-item">
                                    <b>体验费收取比例</b> 
                                    <a class="pull-right">${produceUpdate.srcScaleExperience }→${produceUpdate.desScaleExperience }</a>
                                </li>
                                <li class="list-group-item">
                                    <b>创建人</b> 
                                    <a class="pull-right">${fns:getUserById(produceUpdate.createBy.id).name }</a>
                                </li>
                                <li class="list-group-item">
                                    <b>创建时间</b> 
                                    <a class="pull-right"><fmt:formatDate value="${produceUpdate.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></a>
                                </li>
                                <li class="list-group-item">
                                    <b>更新人</b> 
                                    <a class="pull-right">${fns:getUserById(produceUpdate.updateBy.id).name }</a>
                                </li>
                                <li class="list-group-item">
                                    <b>更新时间</b> 
                                    <a class="pull-right"><fmt:formatDate value="${produceUpdate.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/></a>
                                </li>
                                <li class="list-group-item">
                                    <b>备注</b>
                                    <br/> 
                                    <a>${produceUpdate.remarks}</a>
                                </li>
                                
                                <li class="list-group-item">
                                    <b>审批状态</b> 
                                    <a class="pull-right"><span class="label label-primary">${fns:getDictLabel(produceUpdate.checkStatus,'lgt_ps_produce_update_checkStatus','' )}</span></a>
                                </li>
                                <li class="list-group-item">
                                    <b>审批人</b> 
                                    <a class="pull-right">${fns:getUserById(produceUpdate.checkBy.id).name }</a>
                                </li>
                                <li class="list-group-item">
                                    <b>审批时间</b> 
                                    <a class="pull-right"><fmt:formatDate value="${produceUpdate.checkTime}" pattern="yyyy-MM-dd HH:mm:ss"/></a>
                                </li>
                                <li class="list-group-item">
                                    <b>审批备注</b> 
                                    <br/>
                                    <a>${produceUpdate.checkRemarks}</a>
                                </li>
                                
                            </ul>
                        </div>
                        
                        <div class="box-footer">
                                <button type="button" class="btn btn-default btn-sm"
                                    onclick="javascript:history.go(-1)">
                                    <i class="fa fa-mail-reply"></i>返回
                                </button>
                            </div>
                        
                    </div>
                </div>
            </div>
        </section>
</div>
</body>
</html>