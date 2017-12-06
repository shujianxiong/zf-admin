<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>图文消息详情</title>
	<meta name="decorator" content="adminLte"/>
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

       <section class="content-header content-header-menu">
            
       </section>
        
       <section class="invoice">
           <div class="table-responsive">
               <table class="table">
                   <tr>
                       <th width="10%">名称</th>
                       <td colspan="3">${articleMsg.name }</td>
                   </tr>
                   <tr>    
                       <th width="10%">标题</th>
                       <td colspan="3">${articleMsg.title }</td>
                   </tr>
                   <tr>
                       <th width="10%">描述</th>
                       <td colspan="3"><p class="text-muted well well-sm no-shadow">${articleMsg.description}</p></td>
                   </tr>
                   <tr>
                       <th width="10%">图片</th>
                       <td colspan="3"><img onerror="imgOnerror(this);" class="img-responsive"  src="${imgHost }${fn:replace(articleMsg.pic, '|', '')}" ></td>
                   </tr>
                   <tr>
                       <th width="10%">跳转链接</th>
                       <td>${articleMsg.linkUrl }</td>
                       <th width="10%">排序权重</th>
                       <td>${articleMsg.orderWeight }</td>
                   </tr>
                   <tr>
                       <th width="10%">创建者</th>
                       <td>${fns:getUserById(articleMsg.createBy.id).name}</td>
                       <th width="10%">创建时间</th>
                       <td><fmt:formatDate value="${articleMsg.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                   </tr>
                   <tr>
                       <th width="10%">更新者</th>
                       <td>${fns:getUserById(articleMsg.updateBy.id).name}</td>
                       <th width="10%">更新时间</th>
                       <td><fmt:formatDate value="${articleMsg.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                   </tr>
                   <tr>
                       <th width="10%">备注</th>
                       <td colspan="3"><p class="text-muted well well-sm no-shadow">${articleMsg.remarks }</p></td>
                   </tr>
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
</body>
</html>