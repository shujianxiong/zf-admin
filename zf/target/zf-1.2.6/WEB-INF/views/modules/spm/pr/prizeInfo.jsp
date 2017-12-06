<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>奖品详情</title>
	<meta name="decorator" content="adminLte"/>
	<script type="text/javascript" src="${ctxStatic}/ckeditor/ckeditor.js"></script>
	<script type="text/javascript">
		$(function() {
			editor = CKEDITOR.replace( 'introduce');
			var html = editor.getData();
			document.getElementById("introduceP").innerHTML = html;
		});
		
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

    <section class="content-header content-header-menu">
            
    </section>
    
    <section class="invoice">
        <p class="lead">基本信息</p>
        <div class="table-responsive">
            <table class="table">
                <tr>
                    <th width="10%">奖品编号</th>
                    <td>${prize.code }</td>
                    <th width="10%">奖品名称</th>
                    <td>${prize.name }</td>
                </tr>
                <tr>
                    <th width="10%">奖品类型</th>
                    <td><span class="label label-primary">${fns:getDictLabel(prize.type,'SPM_PR_PRIZE_TYPE','') }</span></td>
                    <th width="10%">奖品状态</th>
                    <td><span class="label label-primary">${fns:getDictLabel(prize.status,'SPM_PR_PRIZE_STATUS','') }</span></td>
                </tr>
                <tr>
                    <th width="10%">展示金额</th>
                    <td>${prize.displayPrice }</td>
                     <th width="10%">所需积分</th>
                    <td>${prize.costPoint }</td>
                </tr>
                <tr>
                    <th width="10%">奖品介绍</th>
                    <td colspan="3"><p class="text-muted well well-sm no-shadow"><textarea name="introduce">${prize.introduce }</textarea> </p></td>
                </tr>
                <tr>
                    <th width="10%">库存数量</th>
                    <td>${prize.stockNum }</td>
                    <th width="10%">可用库存数量</th>
                    <td>${prize.usableNum }</td>
                </tr>
                <tr>
                    <th width="10%">创建者</th>
                    <td>${fns:getUserById(prize.createBy.id).name}</td>
                    <th width="10%">创建时间</th>
                    <td><fmt:formatDate value="${prize.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                </tr>
                
                <tr>
                    <th width="10%">更新者</th>
                    <td>${fns:getUserById(prize.updateBy.id).name}</td>
                    <th width="10%">更新时间</th>
                    <td><fmt:formatDate value="${prize.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                </tr>
                
                <tr>
                    <th width="10%">备注</th>
                    <td colspan="3"><p class="text-muted well well-sm no-shadow">${prize.remarks }</p></td>
                </tr>
            </table>
        </div>
    </section>
	<section class="invoice">
        <p class="lead">预览图</p>
        <div class="carousel slide " data-ride="carousel">
           <div class="carousel-inner">
               <img onerror="imgOnerror(this);"  src="${imgHost }${fn:replace(prize.mainPhoto, '|', '')}" data-src="${imgHost }${fn:replace(prize.mainPhoto, '|', '')}"  class="img-responsive">
           </div>
        </div>
    </section> 
    <section class="invoice">
        <p class="lead">展示图片</p>
        <div class="carousel slide " data-ride="carousel">
           <div class="carousel-inner">
               <img onerror="imgOnerror(this);"  src="${imgHost }${fn:replace(prize.displayPhotos, '|', '')}" data-src="${imgHost }${fn:replace(prize.displayPhotos, '|', '')}" class="img-responsive">
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