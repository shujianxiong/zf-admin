<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>资金账户条目管理</title>
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
                                <b>会员账号</b> 
                                <a class="pull-right">${fns:getMemberById(bankbookTemp.bankbookBalance.member.id).usercode }</a>
                            </li>
                            <li class="list-group-item">
                                <b>创建类型</b> 
                                <a class="pull-right"><span class="label label-primary">${fns:getDictLabel(bankbookTemp.createType, 'crm_bb_bankbook_createType', '')}</span></a>
                            </li>
                            
                            <li class="list-group-item">
                                <b>变动类型</b> 
                                <a class="pull-right"><span class="label label-primary">${fns:getDictLabel(bankbookTemp.changeType, 'crm_bb_bankbook_changeType', '')}</span></a>
                            </li>
                            <li class="list-group-item">
                                <b>资金类型</b> 
                                <a class="pull-right"><span class="label label-primary">${fns:getDictLabel(bankbookTemp.moneyType, 'crm_bb_bankbook_moneyType', '')}</span></a>
                            </li>
                            
                            <li class="list-group-item">
                                <b>变动金额</b> 
                                <a class="pull-right"><span class="text-red">${bankbookTemp.money}</span></a>
                            </li>
                            <li class="list-group-item">
                                <b>条目状态</b> 
                                <a class="pull-right"><span class="label label-primary">${fns:getDictLabel(bankbookTemp.status, 'crm_bb_bankbook_temp_status', '')}</span></a>
                            </li>
                            
                            <li class="list-group-item">
                                <b>审核人</b> 
                                <a class="pull-right">${fns:getUserById(bankbookTemp.checkBy).name }</a>
                            </li>
                            <li class="list-group-item">
                                <b>审核时间</b> 
                                <a class="pull-right"><fmt:formatDate value="${bankbookTemp.checkTime}" pattern="yyyy-MM-dd HH:mm:ss"/></a>
                            </li>
                           
                            
                            <li class="list-group-item">
                                <b>创建人</b> 
                                <a class="pull-right">${fns:getUserById(bankbookTemp.createBy.id).name }</a>
                            </li>
                            <li class="list-group-item">
                                <b>创建时间</b> 
                                <a class="pull-right"><fmt:formatDate value="${bankbookTemp.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></a>
                            </li>
                            
                            <li class="list-group-item">
                                <b>更新人</b> 
                                <a class="pull-right">${fns:getUserById(bankbookTemp.updateBy.id).name }</a>
                            </li>
                            <li class="list-group-item">
                                <b>更新时间</b> 
                                <a class="pull-right"><fmt:formatDate value="${bankbookTemp.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/></a>
                            </li>
                            
                            <li class="list-group-item">
                                <b>备注</b> 
                                <a class="pull-right">${bankbookTemp.remarks}</a>
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