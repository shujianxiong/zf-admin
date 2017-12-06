<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>运费模板管理</title>
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
                                    <b>发货仓库</b> 
                                    <a class="pull-right">${transportFee.warehouse.name}</a>
                                </li>
                                
                                <li class="list-group-item">
                                    <b>收货地区</b> 
                                    <a class="pull-right">${transportFee.receiveArea.name}</a>
                                </li>
                                
                                <li class="list-group-item">
                                    <b>快递公司价格</b> 
                                    <a class="pull-right">${transportFee.costMoney}</a>
                                </li>
                            
                                <li class="list-group-item">
                                    <b>运费</b> 
                                    <a class="pull-right"><span class="text-red">${transportFee.money}</span></a>
                                </li>
                                
                                <li class="list-group-item">
                                    <b>寄送耗时</b> 
                                    <a class="pull-right">${transportFee.days}</a>
                                </li>
                                
                                <li class="list-group-item">
                                    <b>启用状态</b> 
                                    <a class="pull-right"><span class="label label-primary">${fns:getDictLabel(transportFee.usableFlag, 'yes_no','')}</span></a>
                                </li>
                                
                                <li class="list-group-item">
                                    <b>更新时间</b> 
                                    <a class="pull-right"><fmt:formatDate value="${transportFee.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/></a>
                                </li>
                                
                                <li class="list-group-item">
                                    <b>备注信息</b> 
                                    <a class="pull-right">${transportFee.remarks}</a>
                                </li>
                                
                            </ul>
                            
                        </div>
                        
                        <div class="box-footer">
                            <button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)">
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