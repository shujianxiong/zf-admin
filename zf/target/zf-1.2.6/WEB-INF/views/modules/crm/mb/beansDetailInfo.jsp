<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>会员魅力豆流水管理</title>
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
        <p class="lead">会员魅力豆流水信息</p>
        <div class="table-responsive">
            <table class="table">
                <tr>
                    <th width="10%">会员账号</th>
                    <td colspan="3">${fns:getMemberById(beansDetail.beans.member.id).usercode}</td>

                </tr>
                <tr>
                    <th width="10%">变动类型（增/减）</th>
                    <td>
                        <a class="pull-left"><span class="label label-primary">${fns:getDictLabel(beansDetail.changeType, 'add_decrease', '')}</span></a>
                    </td>
                    <th width="10%">变动数量</th>
                    <td width="40%">${beansDetail.num}</td>

                </tr>
                <tr>
                    <th width="10%">变动后历史魅力豆</th>
                    <td>
                        ${beansDetail.historyBeans}
                    </td>
                    <th width="10%">变动后当前魅力豆</th>
                    <td width="40%">
                        ${beansDetail.currentBeans}
                    </td>

                </tr>
                <tr>
                    <th width="10%">变动原因</th>
                    <td>
                        <a class="pull-left"><span class="label label-primary">${fns:getDictLabel(beansDetail.changeReasonType, 'crm_mb_beans_detail_changeReasonType', '')}</span></a>
                    </td>
                    <th>来源业务编号</th>
                    <td width="40%">${beansDetail.operateSourceNo}</td>
                </tr>
                <tr>
                    <th width="10%">备注</th>
                    <td colspan="3"><p class="text-muted well well-sm no-shadow">${beansDetail.remarks}</p></td>
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