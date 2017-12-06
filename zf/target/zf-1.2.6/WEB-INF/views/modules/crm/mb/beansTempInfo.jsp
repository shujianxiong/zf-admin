<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>会员魅力豆临时条目管理</title>
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
        <p class="lead">会员魅力豆临时条目信息</p>
        <div class="table-responsive">
            <table class="table">
                <tr>
                    <th width="10%">会员账号</th>
                    <td colspan="3">${fns:getMemberById(beansTemp.beans.member.id).usercode}</td>

                </tr>
                <tr>
                    <th width="10%">账户条目序列号</th>
                    <td>
                        ${beansTemp.tempSerialNo}
                    </td>
                </tr>
                <tr>
                    <th width="10%">创建类型</th>
                    <td>
                        <a class="pull-left"><span class="label label-primary">${fns:getDictLabel(beansTemp.createType, 'crm_bb_bankbook_createType', '')}</span></a>
                    </td>
                    <th width="10%">变动类型</th>
                    <td width="40%">
                        <a class="pull-left"><span class="label label-primary">${fns:getDictLabel(beansTemp.changeType, 'add_decrease', '')}</span></a>
                    </td>

                </tr>
                <tr>
                    <th width="10%">变动原因</th>
                    <td>
                        <a class="pull-left"><span class="label label-primary">${fns:getDictLabel(beansTemp.changeReasonType, 'crm_mb_beans_detail_changeReasonType', '')}</span></a>
                    </td>
                    <th width="10%">变动数量</th>
                    <td width="40%"> ${beansTemp.num}</td>
                </tr>
                <tr>
                    <th width="10%">审核状态</th>
                    <td>
                        <a class="pull-left"><span class="label label-primary">${fns:getDictLabel(beansTemp.checkStatus, 'crm_bb_bankbook_temp_status', '')}</span></a>
                    </td>
                    <th width="10%">审核者</th>
                    <td width="40%">${fns:getUserById(beansTemp.checkBy).name }</td>
                </tr>
                <tr>
                    <th width="10%">审核时间</th>
                    <td>
                        <fmt:formatDate value="${beansTemp.checkTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                    </td>
                </tr>
                <tr>
                    <th width="10%">备注</th>
                    <td colspan="3"><p class="text-muted well well-sm no-shadow">${beansTemp.remarks}</p></td>
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