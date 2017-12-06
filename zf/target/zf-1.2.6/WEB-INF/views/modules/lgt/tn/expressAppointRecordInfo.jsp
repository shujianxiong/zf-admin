<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>快递预约记录管理</title>
    <meta name="decorator" content="adminLte"/>
    <style type="text/css">
        tr{ 
            cursor: pointer;    /*手形*/   
        } 
    </style>
</head>
<body>
<div class="content-wrapper sub-content-wrapper">
    <div class="content-wrapper sub-content-wrapper">
        <section class="content">
            <div class="row">
                <div class="col-md-4">
                    <div class="box box-primary">
                        <div class="box-body box-profile">
                            <ul class="list-group list-group-unbordered">
                                <li class="list-group-item">
                                    <b>会员账号</b> 
                                    <a class="pull-right">${fns:getMemberById(expressAppointRecord.member.id).name}</a>
                                </li>
                                <li class="list-group-item">
                                    <b>订单类型</b> 
                                    <a class="pull-right"><span class="label label-primary">${fns:getDictLabel(expressAppointRecord.orderType, 'bus_order_type', '无')}</span></a>
                                </li>
                                
                                <li class="list-group-item">
                                    <b>预约状态</b> 
                                    <a class="pull-right"><span class="label label-primary">${fns:getDictLabel(expressAppointRecord.status, 'lgt_tn_express_appoint_record_status', '无')}</span></a>
                                </li>
                                <li class="list-group-item">
                                    <b>预约开始时间</b> 
                                    <a class="pull-right"><fmt:formatDate value="${expressAppointRecord.appointStartTime}" pattern="yyyy-MM-dd HH:mm:ss"/></a>
                                </li>
                                <li class="list-group-item">
                                    <b>预约截止时间</b> 
                                    <a class="pull-right"><fmt:formatDate value="${expressAppointRecord.appointEndTime}" pattern="yyyy-MM-dd HH:mm:ss"/></a>
                                </li>
                                <li class="list-group-item">
                                    <b>取件区域</b> 
                                    <a class="pull-right">${expressAppointRecord.area.name}</a>
                                </li>
                                <li class="list-group-item">
                                    <b>取件地址</b> 
                                    <a class="pull-right">${expressAppointRecord.areaDetail}</a>
                                </li>
                                
                                <li class="list-group-item">
                                    <b>更新时间</b> 
                                    <a class="pull-right"><fmt:formatDate value="${expressAppointRecord.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/></a>
                                </li>
                                
                                <li class="list-group-item">
                                    <b>备注</b> 
                                    <a class="pull-right">${expressAppointRecord.remarks}</a>
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
</div>
</body>
</html>