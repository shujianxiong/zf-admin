<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>宣传推广文章详情</title>
	<meta name="decorator" content="adminLte"/>
	<script type="text/javascript" src="${ctxStatic}/ckeditor/ckeditor.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			editor = CKEDITOR.replace( 'arArticleContent');
			
			var html = editor.getData();
			
			document.getElementById("arArticleContentP").innerHTML = html;
			
			ZF.bigImg();
		});
	</script>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
	
	    <section class="content-header content-header-menu">
            
        </section>
        
        <section class="invoice">
            <p class="lead">基本设置</p>
            <div class="table-responsive">
                <table class="table">
                    <tr>
                        <th width="10%">文章名称</th>
                        <td colspan="3">${arArticle.name }</td>
                    </tr>
                    <tr>
                        <th width="10%">文章类别</th>
                        <td><span class="label label-primary">${fns:getDictLabel(arArticle.category, 'spm_ar_article_category', '')}</span></td>
                        <th width="10%">启用状态</th>
                        <td><span class="label label-primary">${fns:getDictLabel(arArticle.activeFlag, 'yes_no', '')}</span></td>
                        <th width="10%"></th>
                        <td></td>
                    </tr>
                    <tr>
                        <th width="10%">文章标题</th>
                        <td>${arArticle.title }</td>
                        <th width="10%">文章副标题</th>
                        <td>${arArticle.subtitle }</td>
                        <th width="10%"></th>
                        <td></td>
                    </tr>
                    <tr>
                        <th width="10%">文章标签</th>
                        <td>${arArticle.tags }</td>
                        <th width="10%">发布时间</th>
                        <td><fmt:formatDate value="${arArticle.publishTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                        <th width="10%"></th>
                        <td></td>
                    </tr>
                    <tr>
                        <th width="10%">简介</th>
                        <td colspan="5"><p  class="text-muted well well-sm no-shadow">${arArticle.summary }</p></td>
                    </tr>
                    <tr>
                        <th width="10%">内容</th>
                        <td colspan="5"><p class="text-muted well well-sm no-shadow"><textarea name="arArticleContent">${arArticle.content }</textarea></p></td>
                    </tr>
                    <tr>
                        <th width="10%">备注</th>
                        <td colspan="5"><p class="text-muted well well-sm no-shadow">${arArticle.remarks }</p></td>
                    </tr>
                    
                </table>
            </div>
        </section>
	    <section class="invoice">
             <p class="lead">分享小图</p>
             <div class="carousel slide " data-ride="carousel">
                <div class="carousel-inner">
                    <img onerror="imgOnerror(this);"  alt="Photo" data-big src="${imgHost }${arArticle.shareSPhoto }" data-src="${imgHost }${arArticle.shareSPhoto }" class="img-responsive" width="30px" height="30px">
                </div>
             </div>
         </section> 
         <section class="invoice">
             <p class="lead">分享中图</p>
             <div class="carousel slide " data-ride="carousel">
                <div class="carousel-inner">
                    <img onerror="imgOnerror(this);"  alt="Photo" data-big src="${imgHost }${arArticle.shareMPhoto }" data-src="${imgHost }${arArticle.shareMPhoto }" class="img-responsive" width="30px" height="30px">
                </div>
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