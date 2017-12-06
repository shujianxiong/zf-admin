<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>体验包管理</title>
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
        <p class="lead">体验包信息</p>
        <div class="table-responsive">
            <table class="table">
                <tr>
                    <th width="10%">名称</th>
                    <td>${experiencePack.name}</td>
                    <th width="10%">类型</th>
                    <td>
                        <span class="label label-primary">${fns:getDictLabel(experiencePack.type,'experience_pack_type','') }</span>
                    </td>
                </tr>
                <tr>
                    <th width="10%">标题</th>
                    <td colspan="3">${experiencePack.title}</td>
                </tr>
                <tr>
                    <th width="10%">简介</th>
                    <td colspan="3"><p class="text-muted well well-sm no-shadow">${experiencePack.summary}</p></td>
                </tr>
                <tr>
                    <th width="10%">价格</th>
                    <td>${experiencePack.price}</td>
                    <th width="10%">邀请人数</th>
                    <td>
                        ${experiencePack.persons}
                    </td>
                </tr>
                <tr>
                    <th width="10%">体验次数</th>
                    <td>${experiencePack.times}</td>
                    <th width="10%">押金折扣</th>
                    <td>${experiencePack.depositScale}</td>
                </tr>
                <tr>
                    <th width="10%">购买折扣</th>
                    <td>${experiencePack.discountScale}</td>
                    <th width="10%">免回程运费</th>
                    <td>
                        <span class="label label-primary">${fns:getDictLabel(experiencePack.type,'experience_pack_type','') }</span>
                    </td>
                </tr>
                <tr>
                    <th width="10%">购买上限</th>
                    <td>${experiencePack.buyLimit}</td>
                    <th width="10%">卡券ID</th>
                    <td>${experiencePack.cardId}</td>
                </tr>
                <tr>
                    <th width="10%">持续时间</th>
                    <td>${experiencePack.days}</td>
                    <th width="10%">启用状态</th>
                    <td>
                        <span class="label label-primary">${fns:getDictLabel(experiencePack.activeFlag,'yes_no','') }</span>
                    </td>
                </tr>
                <tr>
                    <th width="10%">备注</th>
                    <td colspan="3"><p class="text-muted well well-sm no-shadow">${experiencePack.remarks}</p></td>
                </tr>
            </table>
        </div>
    </section>
    <section class="invoice">
        <p class="lead">图片设置信息</p>
        <div class="table-responsive">
            <table class="table">
                <tr>
                    <th width="10%"><span data-toggle='tooltip' data-placement='top' data-original-title='用于体验包'>背景图</span></th>
                    <td><img onerror="imgOnerror(this);"  class="img-responsive" src="${imgHost }${experiencePack.photo }" alt="icon"></td>
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