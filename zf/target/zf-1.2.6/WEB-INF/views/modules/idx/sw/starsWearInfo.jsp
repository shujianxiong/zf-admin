<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>明星穿搭管理</title>
    <meta name="decorator" content="adminLte"/>
    <style type="text/css">
        tr{ 
            cursor: pointer;    /*手形*/   
        } 
    </style>
</head>
<body>
<script type="text/javascript" src="${ctxStatic}/ckeditor/ckeditor.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
        editor = CKEDITOR.replace( 'content', {
            on: {
                instanceReady: function( ev ) {
                    edit = ev.editor;
                    edit.setReadOnly(true);
                    this.dataProcessor.writer.setRules( 'p', {
                        indent: false,
                        breakBeforeOpen: false,   //<p>之前不加换行
                        breakAfterOpen: false,    //<p>之后不加换行
                        breakBeforeClose: false,  //</p>之前不加换行
                        breakAfterClose: false    //</p>之后不加换行7
                    });
                }
            }
        });

    });
</script>
<div class="content-wrapper sub-content-wrapper">
    <section class="content-header content-header-menu">

    </section>
    <section class="invoice">
        <p class="lead">基本信息</p>
        <div class="table-responsive">
            <table class="table">
                <tr>
                    <th width="10%">标题</th>
                    <td>${starsWear.title}</td>
                    <th width="10%">展示日期</th>
                    <td>
                        <fmt:formatDate value="${starsWear.displayDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                    </td>
                </tr>
                <tr>
                    <th width="10%">简介</th>
                    <td colspan="3">${starsWear.summary}</td>
                </tr>
                <tr>
                    <th width="10%">内容</th>
                    <td colspan="3">
                        <textarea name="content" >${starsWear.content}</textarea>
                    </td>
                </tr>
                <tr>
                    <th width="10%">是否启用</th>
                    <td><span class="label label-primary">${fns:getDictLabel(starsWear.usableFlag,'yes_no','') }</span></td>
                </tr>
                <tr>
                    <th width="10%">备注</th>
                    <td colspan="3"><p class="text-muted well well-sm no-shadow">${starsWear.remarks}</p></td>
                </tr>
            </table>
        </div>
    </section>
    <section class="invoice">
        <p class="lead">图片设置信息</p>
        <div class="table-responsive">
            <table class="table">
                <tr>
                    <th width="10%"><span data-toggle='tooltip' data-placement='top' data-original-title='用于搭配列表、搭配详情'>列表图</span></th>
                    <td><img onerror="imgOnerror(this);"  class="img-responsive" src="${imgHost }${starsWear.listPhoto }" alt="icon"></td>
                </tr>
                <tr>
                    <th width="10%"><span data-toggle='tooltip' data-placement='top' data-original-title='用于搭配列表、搭配详情'>详情图</span></th>
                    <td><img onerror="imgOnerror(this);"  class="img-responsive" src="${imgHost }${starsWear.detailPhoto }" alt="icon"></td>
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