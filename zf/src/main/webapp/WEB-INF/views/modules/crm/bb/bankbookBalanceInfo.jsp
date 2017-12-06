<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>资金账户余额管理</title>
    <meta name="decorator" content="adminLte"/>
    <style type="text/css">
        tr{ 
            cursor: pointer;    /*手形*/   
        } 
    </style>
</head>
<body>
<div class="content-wrapper sub-content-wrapper">
    <sys:tip content="${message}"/>
    
    <form:form id="inputForm" modelAttribute="bankbookBalance" action="${ctx}/crm/bb/bankbookBalance/info" method="post" class="form-horizontal">
        <section class="content">
            <div class="row">
                <div class="col-md-4">
                    <div class="box box-primary">
                        <div class="box-body box-profile">
                        
                            <ul class="list-group list-group-unbordered">
                                <li class="list-group-item">
                                    <b>会员账号</b> 
                                    <a class="pull-right">${fns:getMemberById(bankbookBalance.member.id).usercode}</a>
                                </li>
                                <li class="list-group-item">
                                    <b>可用余额</b> 
                                    <a class="pull-right">${bankbookBalance.usableBalance}</a>
                                </li>
                                <li class="list-group-item">
                                    <b>冻结余额</b> 
                                    <a class="pull-right">${bankbookBalance.frozenBalance}</a>
                                </li>
                                <li class="list-group-item">
                                    <b>最后更新时间</b> 
                                    <a class="pull-right"><fmt:formatDate value="${bankbookBalance.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/></a>
                                </li>
                                <li class="list-group-item">
                                    <b>备注</b> 
                                    <a class="pull-right">${bankbookBalance.remarks }</a>
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
    </form:form>
</div>
</body>
</html>