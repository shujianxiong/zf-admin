<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>注册邀请码管理</title>
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
    
    <form:form id="inputForm" modelAttribute="rgInviteCode" action="${ctx}/idx/rg/rgInviteCode/info" method="post" class="form-horizontal">
        <section class="content">
            <div class="row">
                <div class="col-md-3">
                    <div class="box box-primary">
                        <div class="box-body box-profile">
                           <ul class="list-group list-group-unbordered">
                                <li class="list-group-item">
                                  <b>邀请码</b> <a class="pull-right">${rgInviteCode.inviteCode}</a>
                                </li>
                                <li class="list-group-item">
                                  <b>创建时间</b> <a class="pull-right"><fmt:formatDate value="${rgInviteCode.createDate}"
                                            pattern="yyyy-MM-dd HH:mm:ss" /></a>
                                </li>
                                <li class="list-group-item">
                                  <b>使用标记</b> <a class="pull-right"><span class="label label-primary">${rgInviteCode.useFlag eq '0'?'未使用':'已使用'}</span></a>
                                </li>
                                <li class="list-group-item">
                                  <b>使用会员</b> <a class="pull-right">${fns:getMemberById(rgInviteCode.useMember.id).usercode}</a>
                                </li>
                                <li class="list-group-item">
                                  <b>使用时间</b> <a class="pull-right"><fmt:formatDate value="${rgInviteCode.useTime}"
                                            pattern="yyyy-MM-dd HH:mm:ss" /></a>
                                </li>
                                <li class="list-group-item">
                                    <b>备注</b> 
                                    <a class="pull-right">${rgInviteCode.remarks}</a>
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