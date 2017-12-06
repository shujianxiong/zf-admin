<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>会员魅力豆管理</title>
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

    </section>
    <section class="invoice">
        <p class="lead">会员魅力豆信息</p>
        <div class="table-responsive">
            <table class="table">
                <tr>
                    <th width="10%">会员账号</th>
                    <td colspan="3">${fns:getMemberById(beans.member.id).usercode}</td>

                </tr>
                <tr>
                    <th width="10%">历史魅力豆</th>
                    <td>
                        ${beans.historyBeans}
                    </td>
                    <th width="10%">当前魅力豆</th>
                    <td>
                        ${beans.currentBeans}
                    </td>
                </tr>
                <tr>
                    <th width="10%">更新者</th>
                    <td>${fns:getUserById(beans.updateBy.id).name }</td>
                    <th width="10%">更新时间</th>
                    <td><fmt:formatDate value="${beans.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                </tr>
                <tr>
                    <th width="10%">备注</th>
                    <td colspan="3"><p class="text-muted well well-sm no-shadow">${beans.remarks}</p></td>
                </tr>
            </table>
        </div>
    </section>
    <section class="invoice">
        <div class="row no-print">
            <div class="col-xs-12">
                <button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
            </div>
        </div>
    </section>
</div>
</body>
</html>