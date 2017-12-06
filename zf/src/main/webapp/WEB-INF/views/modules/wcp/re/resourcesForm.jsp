<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>图文素材新增</title>
	<meta name="decorator" content="adminLte"/>
	<script type="text/javascript" src="${ctxStatic}/ckeditor/ckeditor.js"></script>
	<script type="text/javascript">
        function page(n,s){
            $("#pageNo").val(n);
            $("#pageSize").val(s);
            $("#searchForm").submit();
            return false;
        }

	</script>
</head>
<body>
<div class="content-wrapper sub-content-wrapper">
	<section  class="content-header content-header-menu">
		<h1>
			<small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/re/mp/resources">素材列表</a></small>
			<small>|</small><small><i class="fa-form-edit"></i><a href="${ctx}/re/mp/resources/form">文件上传</a></small>
			<small>|</small><small><i class="fa-form-edit"></i><a href="${ctx}/re/mp/resources/toAddMedia">图文素材新增</a></small>
			<small>|</small><small><i class="fa-form-edit"></i><a href="${ctx}/re/mp/resources/toMesUp">图文消息内的图片上传</a></small>
		</h1>
	</section>
	<sys:tip content="${message}"/>
	<section class="content">
		<form:form id="inputForm" modelAttribute="media" action="${ctx}/re/mp/resources/addMedia" method="post" onsubmit="" class="form-horizontal">
		<div class="box box-soild">
			<div class="box-header with-border zf-query">
				<h5>新增图文素材</h5>
				<div class="box-tools">
					<div class="pull-left">
						<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
					</div>
				</div>
			</div>
			<div class="box-body">
				<div class="table-reponsive">
					<table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
						<thead>
						<tr id="mediaTemp" data-index="medi" data-num="${fn:length(media.mediaTempList)}">
							<th>标题</th>
							<th>图片素材id</th>
							<th>是否显示封面</th>
							<th>内容</th>
							<th>原文地址</th>
							<th><span data-type="hideBtn" class="close" title="新增" style="display:block;float: left;" onclick="addProduct(this);"><i class="fa fa-plus"></i></span></th>
						</tr>
						</thead>
						<tbody id="builderTbody">
						<tr id="whiteTr"></tr>
						<tr><td colspan="10"></td></tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<!-- 底部操作 -->
		<div class="box zf-box-mul-border">
			<div class="box-footer">
				<div class="pull-left box-tools">
					<button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
				</div>
				<div class="pull-right box-tools">
					<!-- <button type="button" class="btn bg-navy btn-sm" onclick="geneScanCode();"><i class="fa fa-plus">生成电子码</i></button> -->
					<button type="button" class="btn btn-info btn-sm" onclick="return submitForm();"><i class="fa fa-save">保存</i></button>
				</div>
			</div>
		</div>
		</form:form>
	</section>
</div>
<script type="text/javascript">
    //全局变量
    var editors =new Array();
    var rowspanNum = 0;
    // 添加货品
    function addProduct(obj){
        var tr = $(obj).parent().parent();
        var ppid = tr.prop("id");
        rowspanNum++
        // 插入tr
        var subTrHtmlTmpl ="<tr data-name='"+ppid+"_newTr'>"
            +"<td><input type=\"text\" data-name=\""+ppid+"_title\" name = \"mediaTempList["+(rowspanNum-1)+"].title\" value=\"\" title=\"标题\" placeholder=\"请输入标题，必填项\" class=\"form-control zf-input-readonly\" style=\"font-size:12px;\" maxlength=\"10\"/></td>"
            +"<td><input type=\"text\" data-name=\""+ppid+"_media_id\" name = \"mediaTempList["+(rowspanNum-1)+"].thumb_media_id\" value=\"\" title=\"图片素材id\" placeholder=\"请输入图片素材id，必填项\" class=\"form-control zf-input-readonly\" style=\"font-size:12px;\" maxlength=\"50\"/></td>"
            +"<td><select data-name=\""+ppid+"_rf\" name = \"mediaTempList["+(rowspanNum-1)+"].show_cover_pic\" class='form-control select2'><c:forEach items='${fns:getDictList("yes_no")}' var='d'><option value='${d.value}' ${d.value eq 1 ?'selected':''}>${d.label}</option></c:forEach></select></td>"
            +"<td><textarea  data-name=\""+ppid+"_content\" value=\"\" name = \"mediaTempList["+(rowspanNum-1)+"].content\"></textarea></td>"
            +"<td><input type=\"text\" data-name=\""+ppid+"_source_url\" name = \"mediaTempList["+(rowspanNum-1)+"].content_source_url\" value=\"\" title=\"content\" placeholder=\"请输入原文地址\" class=\"form-control zf-input-readonly\" style=\"font-size:12px;\" maxlength=\"50\"/></td>"
            +"<td><span data-type=\"hideBtn\" class=\"close pull-right\" title=\"删除\" style=\"display:block;float: left;\" onclick=\"delProduct(this,'"+ppid+"','"+(rowspanNum-1)+"');\"><i class=\"fa fa-minus\"></i></span></td>"
            +"</tr>";

        $("#whiteTr").before(subTrHtmlTmpl);
        // 重置行记录name值

        //resetTrNameIndex(ppid, parseInt(rowspanNum));
            if(!CKEDITOR.instances["mediaTempList["+(rowspanNum-1)+"].content"]){
                editors[(rowspanNum-1)] = CKEDITOR.replace( "mediaTempList["+(rowspanNum-1)+"].content", {
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
			}

    }
    // 删除货品
    function delProduct(obj,ppid,mediaTempListIndex){
        // 更新页面显示

        //var rowspanNum = $("#"+ppid).attr("data-num");
       // rowspanNum-- ;
        //$("#"+ppid).attr("data-num", parseInt(rowspanNum));	// 设置rowspan
        // 重置行记录name值
        //resetTrNameIndex(ppid, parseInt(rowspanNum));
        CKEDITOR.instances["mediaTempList["+mediaTempListIndex+"].content"].destroy(true);
        $(obj).parent().parent().remove();

    }

    // 重置页面某行货品记录的各隐藏域的name的序号(新增、删除记录时调用)
    function resetTrNameIndex(ppid, trNum){
        for(var i=0; i<trNum; i++){
            $($("input[data-name="+ppid+"_title]")[i]).prop("name","mediaTempList["+i+"].title");
            $($("input[data-name="+ppid+"_media_id]")[i]).prop("name","mediaTempList["+i+"].thumb_media_id");
            $($("select[data-name="+ppid+"_rf]")[i]).prop("name","mediaTempList["+i+"].show_cover_pic");
            $($("input[data-name="+ppid+"_source_url]")[i]).prop("name","mediaTempList["+i+"].content_source_url");
        }

    }
    function submitForm(){
		$("#inputForm").submit();
    }
</script>
</body>
</html>