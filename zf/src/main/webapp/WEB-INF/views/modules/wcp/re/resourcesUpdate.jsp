<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>图文素材修改</title>
    <meta name="decorator" content="adminLte"/>
    <script type="text/javascript" src="${ctxStatic}/ckeditor/ckeditor.js"></script>
    <script type="text/javascript">
        $(document).ready(function() {
            editor = CKEDITOR.replace( 'content', {
                on: {
                    instanceReady: function( ev ) {
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
        function page(n, s) {
            $("#pageNo").val(n);
            $("#pageSize").val(s);
            $("#searchForm").submit();
            return false;
        };
    </script>
</head>
<body>
<div class="content-wrapper sub-content-wrapper">
    <section class="content-header content-header-menu">
        <h1>
            <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/re/mp/resources">素材列表</a></small>
            <small>|</small>
            <small><i class="fa-form-edit"></i><a href="${ctx}/re/mp/resources/toUpdateArticle">修改图文</a></small>
        </h1>
    </section>
    <sys:tip content="${message}"/>
    <section class="content">
        <div class="row">
            <div class="col-md-6">
                <form:form id="inputForm" modelAttribute="mediaTemp" action="${ctx}/re/mp/resources/updateArticle"
                           method="post" onsubmit="" class="form-horizontal">
                    <div class="box box-success">
                        <div class="box-header with-border zf-query">
                            <h5>新增图文素材</h5>
                            <div class="box-tools">
                                <div class="pull-left">
                                    <button type="button" class="btn btn-box-tool" data-widget="collapse"><i
                                            class="fa fa-minus"></i></button>
                                </div>
                            </div>
                        </div>
                        <div class="box-body">
                            <div class="form-group    ">
                                <label class="col-sm-2 control-label">图文id</label>
                                <div class="col-sm-9">
                                    <sys:inputverify id="mediaId" name="mediaId" tip="" verifyType="0" isSpring="true"
                                                     forbidInput="true"></sys:inputverify>
                                </div>
                            </div>
                            <div class="form-group    ">
                                <label class="col-sm-2 control-label">文章在图文的位置</label>
                                <div class="col-sm-9">
                                    <sys:inputverify id="index" name="index" tip="请输入文章在图文的位置，整数必填" verifyType="4"
                                                     isSpring="true"></sys:inputverify>
                                </div>
                            </div>
                            <div class="form-group    ">
                                <label class="col-sm-2 control-label">标题</label>
                                <div class="col-sm-9">
                                    <sys:inputverify id="title" name="title" tip="请输入标题" verifyType="0"
                                                     isSpring="true"></sys:inputverify>
                                </div>
                            </div>
                            <div class="form-group    ">
                                <label class="col-sm-2 control-label">封面图片素材id</label>
                                <div class="col-sm-9">
                                    <sys:inputverify id="thumb_media_id" name="thumb_media_id" tip="请输入封面图片素材id，必填"
                                                     verifyType="0" isSpring="true"></sys:inputverify>
                                </div>
                            </div>
                            <div class="form-group    ">
                                <label class="col-sm-2 control-label">作者</label>
                                <div class="col-sm-9">
                                    <sys:inputverify id="author" name="author" tip="请输入作者，必填" verifyType="0"
                                                     isSpring="true"></sys:inputverify>
                                </div>
                            </div>
                            <div class="form-group    ">
                                <label class="col-sm-2 control-label">摘要</label>
                                <div class="col-sm-9">
                                    <sys:inputverify id="digest" name="digest" tip="请输入摘要，必填" verifyType="0"
                                                     isSpring="true"></sys:inputverify>
                                </div>
                            </div>
                            <div class="form-group    ">
                                <label class="col-sm-2 control-label">是否显示封面</label>
                                <div class="col-sm-9">
                                    <sys:selectverify name="show_cover_pic" tip="请选择是否显示封面" verifyType="99"
                                                      dictName="yes_no" id="show_cover_pic"></sys:selectverify>
                                </div>
                            </div>
                            <div class="form-group    ">
                                <label class="col-sm-2 control-label">图文内容</label>
                                <div class="col-sm-9">
                                    <textarea name="content">${mediaTemp.content}</textarea>
                                    <sys:preview id="preview"  title="内容预览" content="" width="1200" height="700"></sys:preview>
                                </div>
                            </div>
                            <div class="form-group    ">
                                <label class="col-sm-2 control-label">原文地址</label>
                                <div class="col-sm-9">
                                    <sys:inputverify id="content_source_url" name="content_source_url" tip="请输入原文地址，必填"
                                                     verifyType="0" isSpring="true"></sys:inputverify>
                                </div>
                            </div>
                        </div>
                        <div class="box-footer">
                            <div class="pull-left box-tools">
                                <button type="button" class="btn btn-default btn-sm"
                                        onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回
                                </button>
                            </div>
                            <div class="pull-right box-tools">
                                <button type="button" class="btn btn-info btn-sm" onclick="return submitForm();"><i
                                        class="fa fa-save">保存</i></button>
                            </div>
                        </div>
                    </div>
                </form:form>
            </div>
        </div>
    </section>
</div>
<script type="text/javascript">
    //全局变量
    var editors = new Array();
    var rowspanNum = 0;

    // 添加货品
    function addProduct(obj) {
        var tr = $(obj).parent().parent();
        var ppid = tr.prop("id");
        rowspanNum++
        // 插入tr
        var subTrHtmlTmpl = "<tr data-name='" + ppid + "_newTr'>"
            + "<td><input type=\"text\" data-name=\"" + ppid + "_title\" name = \"mediaTempList[" + (rowspanNum - 1) + "].title\" value=\"\" title=\"标题\" placeholder=\"请输入标题，必填项\" class=\"form-control zf-input-readonly\" style=\"font-size:12px;\" maxlength=\"10\"/></td>"
            + "<td><input type=\"text\" data-name=\"" + ppid + "_media_id\" name = \"mediaTempList[" + (rowspanNum - 1) + "].thumb_media_id\" value=\"\" title=\"图片素材id\" placeholder=\"请输入图片素材id，必填项\" class=\"form-control zf-input-readonly\" style=\"font-size:12px;\" maxlength=\"50\"/></td>"
            + "<td><select data-name=\"" + ppid + "_rf\" name = \"mediaTempList[" + (rowspanNum - 1) + "].show_cover_pic\" class='form-control select2'><c:forEach items='${fns:getDictList("yes_no")}' var='d'><option value='${d.value}' ${d.value eq 1 ?'selected':''}>${d.label}</option></c:forEach></select></td>"
            + "<td><textarea  data-name=\"" + ppid + "_content\" value=\"\" name = \"mediaTempList[" + (rowspanNum - 1) + "].content\"></textarea></td>"
            + "<td><input type=\"text\" data-name=\"" + ppid + "_source_url\" name = \"mediaTempList[" + (rowspanNum - 1) + "].content_source_url\" value=\"\" title=\"content\" placeholder=\"请输入原文地址\" class=\"form-control zf-input-readonly\" style=\"font-size:12px;\" maxlength=\"50\"/></td>"
            + "<td><span data-type=\"hideBtn\" class=\"close pull-right\" title=\"删除\" style=\"display:block;float: left;\" onclick=\"delProduct(this,'" + ppid + "','" + (rowspanNum - 1) + "');\"><i class=\"fa fa-minus\"></i></span></td>"
            + "</tr>";

        $("#whiteTr").before(subTrHtmlTmpl);
        // 重置行记录name值

        //resetTrNameIndex(ppid, parseInt(rowspanNum));
        if (!CKEDITOR.instances["mediaTempList[" + (rowspanNum - 1) + "].content"]) {
            editors[(rowspanNum - 1)] = CKEDITOR.replace("mediaTempList[" + (rowspanNum - 1) + "].content", {
                on: {
                    instanceReady: function (ev) {
                        this.dataProcessor.writer.setRules('p', {
                            indent: false,
                            breakBeforeOpen: false,   //<p>之前不加换行
                            breakAfterOpen: false,    //<p>之后不加换行
                            breakBeforeClose: false,  //</p>之前不加换行
                            breakAfterClose: false    //</p>之后不加换行7
                        });
                    }
                }
            });
        }

    }

    // 删除货品
    function delProduct(obj, ppid, mediaTempListIndex) {
        // 更新页面显示

        //var rowspanNum = $("#"+ppid).attr("data-num");
        // rowspanNum-- ;
        //$("#"+ppid).attr("data-num", parseInt(rowspanNum));	// 设置rowspan
        // 重置行记录name值
        //resetTrNameIndex(ppid, parseInt(rowspanNum));
        CKEDITOR.instances["mediaTempList[" + mediaTempListIndex + "].content"].destroy(true);
        $(obj).parent().parent().remove();

    }

    // 重置页面某行货品记录的各隐藏域的name的序号(新增、删除记录时调用)
    function resetTrNameIndex(ppid, trNum) {
        for (var i = 0; i < trNum; i++) {
            $($("input[data-name=" + ppid + "_title]")[i]).prop("name", "mediaTempList[" + i + "].title");
            $($("input[data-name=" + ppid + "_media_id]")[i]).prop("name", "mediaTempList[" + i + "].thumb_media_id");
            $($("select[data-name=" + ppid + "_rf]")[i]).prop("name", "mediaTempList[" + i + "].show_cover_pic");
            $($("input[data-name=" + ppid + "_source_url]")[i]).prop("name", "mediaTempList[" + i + "].content_source_url");
        }

    }

    function submitForm() {
        $("#inputForm").submit();
    }
</script>
</body>
</html>