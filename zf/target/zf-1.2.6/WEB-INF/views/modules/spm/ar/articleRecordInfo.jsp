<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>宣传推广文章管理</title>
	<meta name="decorator" content="adminLte"/>
	<style type="text/css">
		tr{ 
		    cursor: pointer;    /*手形*/   
		} 
	</style>
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
		<section class="content">
			<div class="row">
				<div class="col-md-8">
					<div class="box box-primary">
						<div class="box-body box-profile">
						      
						     <ul class="list-group list-group-unbordered">
                                <li class="list-group-item">
                                    <b>阅读用户IP</b> 
                                    <a class="pull-right">${articleRecord.ip}</a>
                                </li>
                                <li class="list-group-item">
                                    <b>阅读人账号</b> 
                                    <a class="pull-right">${articleRecord.member.usercode}</a>
                                </li>
                                <li class="list-group-item">
                                    <b>阅读人姓名</b> 
                                    <a class="pull-right">${articleRecord.member.name}</a>
                                </li>
                                <li class="list-group-item">
                                    <b>文章名称</b> 
                                    <a class="pull-right">${articleRecord.article.name}</a>
                                </li>
                                <li class="list-group-item">
                                    <b>文章类别</b> 
                                    <a class="pull-right"><span class="label label-primary">${fns:getDictLabel(articleRecord.article.category,'spm_ar_article_category','')}</span></a>
                                </li>
                                <li class="list-group-item">
                                    <b>文章标题</b> 
                                    <a class="pull-right">${articleRecord.article.title}</a>
                                </li>
                                <li class="list-group-item">
                                    <b>阅读次数</b> 
                                    <a class="pull-right">${articleRecord.readCount}</a>
                                </li>
                                <li class="list-group-item">
                                    <b>备注</b> 
                                    <a class="pull-right">${articleRecord.remarks}</a>
                                </li>
                             </ul>
						</div>
						<div class="box-footer">
		    				<div class="pull-left box-tools">
				        		<button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
				        	</div>
			            </div>
					</div>
				</div>
			</div>
		</section>
	</div>
			
</body>
</html>