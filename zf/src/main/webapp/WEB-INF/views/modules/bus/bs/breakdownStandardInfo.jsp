<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>货品定损标准管理</title>
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
                                <b>问题类型</b> 
                                <a class="pull-right"><span class="label label-primary">${fns:getDictLabel(breakdownStandard.breakdownType, 'bus_or_repair_order_breakdownType', '')}</span></a>
                            </li>
                            <li class="list-group-item">
                                <b>魅力豆是否可抵</b>
                                <a class="pull-right"><span class="label label-primary">${fns:getDictLabel(breakdownStandard.beansDecFlag, 'yes_no', '')}</span></a>
                            </li>
                            <li class="list-group-item">
                                <b>定损百分比</b> 
                                <a class="pull-right">${breakdownStandard.moneyLossPercent}</a>
                            </li>
                            
                            <li class="list-group-item">
                                <b>创建者</b> 
                                <a class="pull-right">${fns:getUserById(breakdownStandard.createBy.id).name}</a>
                            </li>
                            <li class="list-group-item">
                                <b>创建时间</b> 
                                <a class="pull-right"><fmt:formatDate value="${breakdownStandard.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></a>
                            </li>
                            
                            <li class="list-group-item">
                                <b>更新者</b> 
                                <a class="pull-right">${fns:getUserById(breakdownStandard.updateBy.id).name}</a>
                            </li>
                            <li class="list-group-item">
                                <b>更新时间</b> 
                                <a class="pull-right"><fmt:formatDate value="${breakdownStandard.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/></a>
                            </li>
                            
                            <li class="list-group-item">
                                <b>备注</b> 
                                <a class="pull-right">${breakdownStandard.remarks }</a>
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