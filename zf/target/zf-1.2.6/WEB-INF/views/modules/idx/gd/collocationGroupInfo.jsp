<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>搭配分组管理</title>
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
         <p class="lead">搭配分组信息</p>
         <div class="table-responsive">
             <table class="table">
                 <tr>
                     <th width="10%">所属搭配</th>
                     <td width="40%;">${collocationGroup.collocation.name }</td>
                     <th width="10%">所属分类</th>
                     <td>${collocationGroup.category.categoryName }</td>
                 </tr>
                 <tr>
                     <th width="10%">搭配分组标题</th>
                     <td>${collocationGroup.title }</td>
                      <th width="10%">是否启用</th>
                     <td><span class="label label-primary">${fns:getDictLabel(collocationGroup.usableFlag, 'yes_no', '')}</span></td>
                 </tr>
                 <tr>
                     <th width="10%">展示图</th>
                     <td colspan="3"><img onerror="imgOnerror(this);"  class="img-responsive" src="${imgHost }${collocationGroup.photo }" alt="Photo"></td>
                 </tr>
                 <tr>
                     <th width="10%">展示视频</th>
                     <td colspan="3"><video width="320" height="240" controls="controls" style="object-fit:fill;">
                         <source src="http://img.chinazhoufan.com/${collocationGroup.video}" type="video/mp4">
                     </video></td>
                 </tr>
                 <tr>
                     <th width="10%">备注</th>
                     <td colspan="3"><p class="text-muted well well-sm no-shadow">${collocationGroup.remarks}</p></td>
                 </tr>
             </table>
         </div>
     </section>
     
     <section class="invoice">
         <p class="lead">关联分组商品信息</p>
         <div class="table-responsive">
             <table class="table">
                 <thead>
                     <tr>
                         <th>商品编码</th>
                         <th>商品名称</th>
                         <th>展示图</th>
                         <th>排列序号</th>
                     </tr>
                 </thead>
                 <tbody id="addGoodsBody">
                     <c:forEach items="${collocationGroup.ggList }" var="groupGoods">
                         <tr>
                             <td>${groupGoods.goods.code }</td>
                             <td>${groupGoods.goods.name }</td>
                             <td><img onerror="imgOnerror(this);"  src="${imgHost }${groupGoods.goods.icon }" data-big data-src="${imgHost }${groupGoods.goods.icon }" width="20px;" height="20px;"/></td>
                             <td>${groupGoods.orderNo }</td>
                         </tr>
                     </c:forEach>
                 </tbody>
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
<script type="text/javascript">
  $(function() {
	  ZF.bigImg();
  });
</script>
</body>
</html>