<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>周范秀场管理</title>
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
        <p class="lead">周范秀场信息</p>
        <div class="table-responsive">
            <table class="table">
                <tr>
                    <th width="10%">会员账号</th>
                    <td colspan="3">${fns:getMemberById(showArea.member.id).usercode}</td>
                </tr>
                <tr>
                    <th width="10%">标题</th>
                    <td >${showArea.title}</td>
                    <th width="10%">展示时间</th>
                    <td ><fmt:formatDate value="${showArea.displayTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                </tr>
                <tr>
                    <th width="10%">播放次数</th>
                    <td >${showArea.playNum}
                    </td>
                    <th width="10%">是否启用</th>
                    <td><span class="label label-primary">${fns:getDictLabel(showArea.usableFlag,'yes_no','') }</span></td>
                </tr>
                <tr>
                    <th width="10%">备注</th>
                    <td colspan="3"><p class="text-muted well well-sm no-shadow">${showArea.remarks}</p></td>
                </tr>
            </table>
        </div>
    </section>
    <section class="invoice">
        <p class="lead">视频设置信息</p>
        <div class="table-responsive">
            <table class="table">
                <tr>
                    <th width="10%"><span data-toggle='tooltip' data-placement='top' data-original-title='用于周范秀场'>视频</span></th>
                    <td><video width="320" height="240" controls="controls" style="object-fit:fill;">
                        <source src="http://img.chinazhoufan.com/${showArea.video}" type="video/mp4">
                    </video>
                    </td>
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