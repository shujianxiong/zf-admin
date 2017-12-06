<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>公司资产变更记录管理</title>
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
                                <b>变动类型</b> 
                                <a class="pull-right"><span class="label label-primary">${fns:getDictLabel(capitalChange.changeType, 'cap_cc_capital_change_type', '')}</span></a>
                            </li>
                            
                            <li class="list-group-item">
                                <b>变动原因类型</b> 
                                <a class="pull-right"><span class="label label-primary">${fns:getDictLabel(capitalChange.changeReasonType, 'cap_cc_capital_change_reason_type', '')}</span></a>
                            </li>
                            
                            <li class="list-group-item">
                                <b>新固定资产编号</b> 
                                <a class="pull-right">${capitalChange.newCapitalNo}</a>
                            </li>
                            
                            <li class="list-group-item">
                                <b>新数量</b> 
                                <a class="pull-right">${capitalChange.newNum}</a>
                            </li>
                            
                            <li class="list-group-item">
                                <b>新使用部门</b> 
                                <a class="pull-right">${capitalChange.newUseOffice.name}</a>
                            </li>
                            
                            <li class="list-group-item">
                                <b>新使用地点</b> 
                                <a class="pull-right">${capitalChange.newUsePlace}</a>
                            </li>
                            
                            <li class="list-group-item">
                                <b>新使用员工</b> 
                                <a class="pull-right">${capitalChange.newUseUser.name}</a>
                            </li>
                            
                            <li class="list-group-item">
                                <b>新资产状态</b> 
                                <a class="pull-right"><span class="label label-primary">${fns:getDictLabel(capitalChange.newCapitalStatus, 'cap_cc_capital_capital_status', '')}</span></a>
                            </li>
                            
                            <li class="list-group-item">
                                <b>新使用状态</b> 
                                <a class="pull-right"><span class="label label-primary">${fns:getDictLabel(capitalChange.newUseStatus, 'cap_cc_capital_use_status', '')}</span></a>
                            </li>
                            
                            <li class="list-group-item">
                                <b>创建人</b> 
                                <a class="pull-right">${fns:getUserById(capitalChange.updateBy.id).name}</a>
                            </li>
                            
                             <li class="list-group-item">
                                <b>创建时间</b> 
                                <a class="pull-right"><fmt:formatDate value="${capitalChange.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></a>
                            </li>
                            
                            <li class="list-group-item">
                                <b>更新人</b> 
                                <a class="pull-right">${fns:getUserById(capitalChange.updateBy.id).name}</a>
                            </li>
                            
                             <li class="list-group-item">
                                <b>更新时间</b> 
                                <a class="pull-right"><fmt:formatDate value="${capitalChange.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/></a>
                            </li>
                            
                            <li class="list-group-item">
                                <b>备注</b> 
                                <a class="pull-right">${capitalChange.remarks}</a>
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