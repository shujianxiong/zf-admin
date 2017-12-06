<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>报警发送设置管理</title>
	<meta name="decorator" content="adminLte"/>
</head>
<body>
<div class="content-wrapper sub-content-wrapper">

    <section class="content-header content-header-menu">
            
        </section>
        
        <section class="invoice">
            <div class="table-responsive">
                <table class="table">
                    <tr>
                        <th width="10%">警报类别</th>
                        <td>
                            <span class="label label-primary">${fns:getDictLabel(warningConfig.category,'msg_uw_warning_category','')}</span>
                        </td>
                    </tr>
                    <tr>
                        <th width="10%">警报类型</th>
                        <td><span class="label label-primary">${fns:getDictLabel(warningConfig.type,'msg_uw_warning_type','')}</span></td>
                    </tr>
                    <tr>
                        <th width="10%">标题</th>
                        <td>${warningConfig.title }</td>
                    </tr>
                    <tr>
                        <th width="10%">内容文本模型类型</th>
                        <td><span class="label label-primary">${fns:getDictLabel(warningConfig.receiveType,'msg_uw_warning_config_receiveType','')}</span></td>
                    </tr>
                    <tr>
                        <th width="10%">内容文本模型</th>
                        <td>${warningConfig.contentModel }</td>
                    </tr>
                    <tr>
                        <th width="10%">接收人</th>
                        <td>${ fns:getUserById(warningConfig.receiveUser.id).name}</td>
                    </tr>
                    <tr>
                        <th width="10%">启用标记</th>
                        <td><span class="label label-primary">${fns:getDictLabel(warningConfig.usableFlag,'yes_no','')}</span></td>
                    </tr>
                    <tr>
                        <th width="10%">监控标记</th>
                        <td><span class="label label-primary">${fns:getDictLabel(warningConfig.monitorFlag,'yes_no','')}</span></td>
                    </tr>
                    <tr>
                        <th width="10%">备注</th>
                        <td colspan="4"><p class="text-muted well well-sm no-shadow">${warningConfig.remarks }</p></td>
                    </tr>
                </table>
            </div>
            <div class="box-footer">
                <button type="button" class="btn btn-default btn-sm"
                    onclick="javascript:history.go(-1)">
                    <i class="fa fa-mail-reply"></i>返回
                </button>
            </div>
        </section>
</div>
</body>
</html>