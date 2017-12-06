<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>帮助中心建议管理</title>
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
        <p class="lead">帮助中心建议信息</p>
        <div class="table-responsive">
            <table class="table">
                <tr>
                    <th width="10%">会员账号</th>
                    <td colspan="3"> ${fns:getMemberById(suggestion.member.id).usercode}</td>
                </tr>
                <tr>
                    <th width="10%">内容</th>
                    <td colspan="3">
                        ${suggestion.content}
                    </td>
                </tr>
                <tr>
                    <th width="10%">联系电话</th>
                    <td>${suggestion.tel}</td>
                    <th width="10%">处理状态</th>
                    <td>
                        <span class="label label-primary">${fns:getDictLabel(suggestion.dealStatus, 'ser_hc_suggestion_dealStatus', '')}</span>
                    </td>
                </tr>
                <tr>
                    <th width="10%">更新时间</th>
                    <td colspan="3">
                        <fmt:formatDate value="${suggestion.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                    </td>
                </tr>
                <tr>
                    <th width="10%">备注</th>
                    <td colspan="3"><p class="text-muted well well-sm no-shadow">${suggestion.remarks}</p></td>
                </tr>
            </table>
        </div>
    </section>
    <section class="invoice">
        <p class="lead">图片设置信息</p>
        <div class="table-responsive">
            <table class="table">
                <c:forEach items="${suggestion.imgs }" var="img" varStatus="status">
                    <tr>
                        <th width="10%"><span data-toggle='tooltip' data-placement='top' data-original-title='用于帮助中心'>图片${(status.index)+1}</span></th>
                        <td><img onerror="imgOnerror(this);"  class="img-responsive" src="${imgHost }${img}" alt="icon"></td>
                    </tr>
                </c:forEach>
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